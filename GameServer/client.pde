class Client {
  String IP;
  int port;
  String Nickname;
  Player player;
  World world;
  boolean[] commands = new boolean[5];

  Client(World w, String ip, int p, String nick) {
    IP = ip;
    port = p; 
    Nickname = nick;
    Player player; //= new Player();
    world = w;
  }

  void sendFirstGamestate() {
    //Set player as first entity in Entitylist due to object references not working when serialized
    player.isSelf = true;
    world.Entities.remove(player);
    world.Entities.addFirst(player);
    byte[] payload = concat(
    new byte[] {PacketType.firstGameState}, 
    world.Serialize(world));
    server.udp.send(payload, IP, port);
    //println(payload);
    player.isSelf = false;
  }

  void loadCMDs(byte[] bs){
    for(int i = 0; i < commands.length; i++){
      commands[i] = bs[i] == (byte) 0 ? false : true; 
    }
  }

  void DoPlayerCMDs(){
    player.Shoot(commands);
    player.selfMove(commands);
  }

  void sendGameState() {
  }

  void spawn(int[] spawnPoint) {
    player = new Player(new PApplet(), world, spawnPoint);
    player.DisplayName = Nickname;
    println(Nickname, "spawned at", spawnPoint[0], spawnPoint[1]);
    world.Entities.add(player);
  }
}
