import hypermedia.net.*;


class ServerClass {
  UDP udp;


  ServerClass() {
    udp = new UDP(this, 4206, "192.168.0.20");
    udp.listen(true);
    udp.setReceiveHandler("receive");
  }




  void receive( byte[] data, String IPaddress, int port ) {
    println(IPaddress, port);
    for (int i=0; i < data.length; i++) {
      print(char(data[i]));
    }
  }
}

interface Status {
  char
    awaitngUsers = '0', 
    running      = '1', 
    terminated   = '2';
}

interface PacketType {
  char
    connectionRequest = '0', 
    firstGameState    = '1', 
    playerCommand     = '2', 
    gameState         = '3', 
    terminate         = '4';
}

void setup () {
}
void draw() {
}


//void receive( byte[] data ) {    
// <-- default handler
void receive( byte[] data, String IPaddress, int port ) { // <-- extended handler
  println(IPaddress, port);
  for (int i=0; i < data.length; i++) {
    print(char(data[i]));
  }
}
