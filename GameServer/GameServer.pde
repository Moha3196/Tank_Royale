Server server = new Server(this);


//UDP udp;
void setup () {
}
void draw() {
}

void  receive( byte[] data, String IP, int port ) {
  server.process(data, IP, port);
}

void mousePressed(){
  server.StartGame();
}


interface PacketType {
  char
    connectionRequest = '0', 
    firstGameState    = '1', 
    playerCommand     = '2', 
    gameState         = '3', 
    terminate         = '4';
}

enum Status {
    awaitngUsers, 
    spawned,
    running, 
    terminated  ;
  }
