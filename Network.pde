import hypermedia.net.*;
import java.io.*;


class Session {  
  PApplet app;
  char status = Status.unConnected;
  String ServerIP;
  int ServerPort = 4206;
  String SelfIP;
  int SelfPort = 6969;
  UDP udp;
  String nickName;

  Session(PApplet app) {
    bind(app);
  }

  void config(String _nickName, String _IP, int _port) {
    nickName = _nickName;
    ServerIP = _IP;
    ServerPort = _port;
  }
  void config(String _nickName, String _IP) {
    nickName = _nickName;
    ServerIP = _IP;
  }

  void init () {
    println("binding UDP socket");
    udp = new UDP(app, SelfPort, SelfIP);
    connect();
    udp.setReceiveHandler("receive");
    udp.log(false);
    udp.listen(true);
  }

  void receive(byte[] data, String ip, int port) {
    println(status, 12);
    char PackT = char(data[0]);
    byte[] payload = subset(data, 1);
    switch(status) {
      case(Status.connected):
      receiveFirstGD(PackT, payload);
      break;

      case(Status.running):
      // load dynamic data...

      break;
      default:
    return;
  }
  }


  void bind(PApplet app_) {
    app = app_;
  }

  void connect() {
    println("sending connectionRequest");
    udp.send(PacketType.connectionRequest + nickName, ServerIP, ServerPort);
    status = Status.connected;
  }

  void process() {
  }

  void receiveFirstGD(char packT, byte[] payload) {
    println("joining game...");
    world = (World) world.DeSerialize(payload);
    world.self = (Player) world.Entities.get(0);
    world.bind(app);
    status = Status.running;
    println("loaded");
  }

  void sendPlayerCMDs() {
    byte[] payload = new byte[world.playerInputs.length + 1];
    for (int i = 1; i < world.playerInputs.length; i++) {
      payload[i] = world.playerInputs[i-1] ? (byte) 1: (byte) 0;
    }
    payload[0] = PacketType.playerCommand;
    udp.send(payload, ServerIP, ServerPort);
  }
}


interface Status {
  char
    unConnected= '0', 
    connected  = '1', 
    running    = '2', 
    terminated = '3';
}

interface PacketType {
  char
    connectionRequest = '0', 
    firstGameState    = '1', 
    playerCommand     = '2', 
    gameState         = '3', 
    terminate         = '4';
}
