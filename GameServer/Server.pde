import hypermedia.net.*;
import java.util.*;



class Server {
  UDP udp;
  PApplet app;
  Status status;
  LinkedList<Client> clients = new LinkedList<Client>();
  World world;


  Server(PApplet a) {
    app = a;
    udp = new UDP(app, 4206, "192.168.0.20");
    udp.listen(true);
    status = Status.awaitngUsers;
    world = new World(app);
  }


  void process( byte[] data, String IP, int port) {
    println(IP, port, 1);
    for (int i=0; i < data.length; i++) {
      print(char(data[i]));
    }
    char packT = (char) data[0];
    byte[] payload = subset(data, 1);
    println();

    println(status, payload.length);

    switch(status) {
    case awaitngUsers:
      processAwaitngUsers(packT, payload, IP, port);
      break;
    case running:
      processRunning(packT, payload, IP, port);
      break;
    }
  }

  void processAwaitngUsers(char packT, byte[] payload, String IP, int port) {
    if (packT == PacketType.connectionRequest) {
      clients.add(new Client(IP, port, new String(payload)));
    }
    println(clients);
  }

  void processRunning(char packT, byte[] payload, String IP, int port) {
  }
  
  void spawnPlayers(){
    for(int i = 0; i< world.SpawnPoints.length; i++){
      for(Client client : clients){
        World.Entity.add(new Player(new PVector
      }
          
    } 
  }
  
  void StartGame(){
    //udp.send(concat(PacketType.firstGameState, world.Serialize(world)));
  
  }
}

class Client {
  String IP;
  int Port;
  String Nickname;
  Player player;
  boolean spawned = false;
  
  Client(String ip, int port, String nick) {
    IP = ip;
    Port = port; 
    Nickname = nick;
  }
}
