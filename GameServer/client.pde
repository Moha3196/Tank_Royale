class Client {
  String IP;
  int port;
  String Nickname;
  Player player;
  World world;
  
  Client(World w, String ip, int p, String nick) {
    IP = ip;
    port = p; 
    Nickname = nick;
    Player player; //= new Player();
    world = w;
  }
  
  void sendFirstGamestate(){
    println(3);
    world.self = player;
    player.isSelf = true;
    byte[] payload = concat(
        new byte[] {PacketType.firstGameState},
        world.Serialize(world));
    server.udp.send(payload, IP, port);
    println(payload);
    
    player.isSelf = false;
  }
  
  void sendGameState(){}
  
  void spawn(int[] spawnPoint){
    player = new Player(new PApplet(), world, spawnPoint);
  }
}
