import hypermedia.net.*;
import java.io.*;


class Session {  
  PApplet app;
  char status = Status.unConnected;
  String ServerIP;
  int ServerPort = 4206;
  String SelfIP;
  int SelfPort = 4206;
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
    udp.log(true);
    udp.listen(true);
  }

  void recive(byte[] data, String ip, int port) {
    println(data.length);
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

  void loadGamedata(byte[] data, int start, int end) {
    saveBytes("gamestate.json", data);
  }

  void receiveFirstGD(char packT, byte[] payload) {
    println("joining game...");

    world = (World) world.DeSerialize(subset(payload, 1));
    world.bind(app);
  }

  void sendPlayerCMDs() {
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
