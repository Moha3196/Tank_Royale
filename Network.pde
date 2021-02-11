import hypermedia.net.*;

static class Session {
  
  static enum Status{
    unConnected,
    connected,
    running,
    terminated
  }
  static enum PacketType{
    connectionRequest,
    firstGameState,
    playerCommand,
    gameState,
    terminate
  }
  
  Status status = Status.unConnected;
  static String IP;
  static String nickName;
  static int port = 4206;
  static UDP udp;
  
  Session(String _nickName, String _IP, int _port) {
    nickName = _nickName;
    IP = _IP;
    port = _port;
    connect();
  }
  Session(String _nickName, String _IP) {
    nickName = _nickName;
    IP = _IP;
    connect();
  }
  
  void connect(){
    println(1);
    udp = new UDP(this, 4206, IP);
    udp.send(PacketType.connectionRequest + nickName);
  }
  
  static void sendPlayerCommand(){
    
  }
  
  static void end(){
    udp.close();
  }
}
