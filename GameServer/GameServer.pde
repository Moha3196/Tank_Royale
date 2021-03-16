Server server = new Server(this);


//UDP udp;
void setup () {
}
void draw() {
}

void receive( byte[] data, String IP, int port ) {
  server.process(data, IP, port);
<<<<<<< HEAD

}

void mousePressed(){
  server.StartGame();

=======
>>>>>>> 1f7908deba563eac0f227759f844dff8a497f021
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
<<<<<<< HEAD
    spawned,
=======
>>>>>>> 1f7908deba563eac0f227759f844dff8a497f021
    running, 
    terminated  ;
  }
