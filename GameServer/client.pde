// client klasse representere en klient der tilslutter sig til server
class Client {
  String IP;
  int port;
  String Nickname;
  Player player;
  World world;
  boolean[] commands = new boolean[5];
  int ID;
  // constructor. Konstruktion tager kun udgangspunkt i netværk detalier - har ikke repræsentering af spiller.
  Client(World w, String ip, int p, String nick, int id) {
    IP = ip;
    port = p; 
    Nickname = nick;
    Player player;
    world = w;
    ID = id;
  }

  // giver client klassen en reprsæntation af "player" klassen.
  void spawn(int[] spawnPoint) {
    player = new Player(new PApplet(), world, spawnPoint);
    player.DisplayName = Nickname;
    player.ID = ID;
    println(Nickname, "spawned at", spawnPoint[0], spawnPoint[1]);
    world.Entities.add(player);
  }
  
  // metode til at sende første gamestate til spilleren.
  void sendFirstGamestate() {
    player.isSelf = true;
    //Sætter player som første element for at clientens world ved hvilken Entity er sig selv.
    world.Entities.remove(player);
    world.Entities.addFirst(player);

    // klargører payload til at blive sendt over net
    byte[] payload = concat(
      new byte[] {PacketType.firstGameState}, 
      world.Serialize(world));
    // send
    server.udp.send(payload, IP, port);
    player.isSelf = false;
  }

  // hjælpemetode til at kunne lave et payload af kommandoer til boolean array.
  void loadCMDs(byte[] bs){
    // for hvert byte i payload er det true/false baseret på hvilken byte det er.
    for(int i = 0; i < commands.length; i++){
      commands[i] = bs[i] == (byte) 0 ? false : true; 
    }
  }

  // metode som vil gører alle player ting i spillet. dvs ud fra input skyde og bevæge sig.
  void DoPlayerCMDs(){
    player.Shoot(commands);
    player.selfMove(commands);
  }

  // sender clienten alt dynamisk data, dvs alle de ting den kan ændre.
  void sendGameState() {
    // klargører payload til at blive sendt over net
    byte[] payload = concat(
      new byte[] {PacketType.gameState}, 
      world.Serialize(world.Entities));
    // send
    server.udp.send(payload, IP, port);
  }

  
}
