import hypermedia.net.*;
import java.io.*;


class Session {  
  // status af server
  char status = Status.unConnected;

// netværk indstillinger
  // lokale IP af sig selv.
  String ServerIP;
  // port som bliver send TIL
  int ServerPort = 4206;
  // port som bliver send fra
  int SelfPort = 6969;
  // navn på spiller
  String nickName;
  int ID;

  PApplet app;
  // udp objekt som bliver brugt til at sende og modtage data. 
  UDP udp;
  
  Session(PApplet app) {
    bind(app);
  }

  // indstiller sessions netværkindstillinger 
  void config(String _nickName, String _IP, int _port) {
    nickName = _nickName;
    ServerIP = _IP;
    ServerPort = _port;
  }
  void config(String _nickName, String _IP) {
    nickName = _nickName;
    ServerIP = _IP;
  }

  // bruger session indstillinger til at connect til server
  void init() {
    println("binding UDP socket");
    udp = new UDP(app, SelfPort);
    // prøver at tilslutte sig til server
    connect();
    //setter receive event til void receive i Tank_royale.pde.
    udp.setReceiveHandler("receive");
    udp.listen(true);
  }

  // denne metode bliver kaldt fra void receive fra Tank_royale.pde og håndterer data baseret på packet type
  void receive(byte[] data, String ip, int port) {
    println(status, 12);
    // besked bliver splitet i packettype og nyttelast
    char PackT = char(data[0]);
    byte[] payload = subset(data, 1);
    //bliver processed baseret på session status.
    switch(status) {
      case(Status.connected):
      receiveFirstGD(PackT, payload);
      break;

      case(Status.running):
        receiveNewGS(PackT, payload);
      break;

      default:
      return;
    }
  }

  void bind(PApplet app_) {
    app = app_;
  }

  // Sender først connection request
  void connect() {
    println("sending connectionRequest");
    udp.send(PacketType.connectionRequest + nickName, ServerIP, ServerPort);
    status = Status.connected;
  }

  // metode der bliver brugt til at behandle start gamedata.
  void receiveFirstGD(char packT, byte[] payload) {
    if(packT == PacketType.firstGameState){
      println("joining game...");
      world = (World) world.DeSerialize(payload);
      world.self = (Player) world.Entities.get(0);
      world.bind(app);
      status = Status.running;
      ID = world.self.ID;
      println("loaded");
    }
  }

  // metode til at sende kommandoer til server 
  void sendPlayerCMDs() {
    byte[] payload = new byte[world.playerInputs.length + 1];
    for (int i = 1; i < world.playerInputs.length; i++) {
      payload[i] = world.playerInputs[i-1] ? (byte) 1: (byte) 0;
    }
    payload[0] = PacketType.playerCommand;
    udp.send(payload, ServerIP, ServerPort);
  }
  void receiveNewGS(char packT, byte[] payload){
  if(packT == PacketType.gameState){
    world.Entities = (LinkedList<Entity>)world.DeSerialize(payload);
    // find yourself based on ID, replace dynamic data
    // set self up
    for(Entity e : world.Entities){
      e.world = world;
      e.bind(app);
    }

    for(Entity e : world.Entities){
      if(e instanceof Player && ID == ((Player)e).ID){
        Player p = ((Player) e);
        p.isSelf = true;
        world.self = p;
      }
    }
  }
}

}
// forskellige interfaces bliver brugt som enums, da enums ikke er særlig gode i processing.
interface Status {
  char
    unConnected = '0', 
    connected   = '1', 
    running     = '2', 
    terminated  = '3';
}

interface PacketType {
  char
    connectionRequest = '0', 
    firstGameState    = '1', 
    playerCommand     = '2', 
    gameState         = '3', 
    terminate         = '4';
}
