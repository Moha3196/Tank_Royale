import hypermedia.net.*;
import java.io.*;

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

class Session {  


  char status = Status.unConnected;
  String ServerIP;
  int ServerPort = 4206;
  String SelfIP;
  int SelfPort = 4206;
  UDP udp;
  String nickName;


  Session(String _nickName, String _IP, int _port) {
    nickName = _nickName;
    ServerIP = _IP;
    ServerPort = _port;
    connect();
  }
  Session(String _nickName, String _IP) {
    nickName = _nickName;
    ServerIP = _IP;
    connect();
  }
  
  byte[] Serialize (Object obj) {
    try {
      ByteArrayOutputStream bout = new ByteArrayOutputStream();
      ObjectOutput oout = new ObjectOutputStream(bout);
      oout.writeObject(obj);
      oout.flush();
      oout.close();
      return bout.toByteArray();
    }
    catch(IOException e) {
      app.println("failed to start serializing");
      app.println(e);
      return new byte[] {};
    }
  }

  Object deSerialize(byte[] bytes)
  {
    try {
      ObjectInputStream in = new ObjectInputStream(new ByteArrayInputStream(bytes));
      return in.readObject();
    }
    catch(Exception e) {
      app.println(e);
      app.println(1);
      return e;
    }
  }
  

  void connect() {
    println("binding UDP socket");
    udp = new UDP(this, SelfPort, SelfIP);
    println("sending connectionRequest");
    udp.send(PacketType.connectionRequest + nickName, ServerIP, ServerPort);
    status = Status.connected;
  }

  void receive(byte[] data) {
    char PType = char(data[0]);
    switch(status) {
      case(Status.connected):
        if(PType == PacketType.firstGameState){
          receiveFirstGD(data);
        }
      break;
      case(Status.running):
        
      break;
    default:
      return;
    }
  }
  
  void loadGamedata(byte[] data, int start, int end){
    saveBytes("gamestate.json", data);
    
  }
  
  void receiveFirstGD(byte[] data){
    
  }

  void sendPlayerCMDs() {
  }
  
}
