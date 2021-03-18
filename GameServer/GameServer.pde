Server server = new Server(this);


//UDP udp;
void setup () {
  frameRate(60);
}
void draw() {
    server.tickGame();
}

void receive( byte[] data, String IP, int port ) {
  server.process(data, IP, port);
}

void mousePressed(){
  switch (server.status){
    case Status.awaitngUsers:
      server.StartGame();
      server.status = Status.running;
    break;

    case Status.running:
      for(Client client : server.clients){
        println("x:", client.player.pos.x, " y:", client.player.pos.y);
      }
    break;
  }
}


interface PacketType {
  char
    connectionRequest = '0', 
    firstGameState    = '1', 
    playerCommand     = '2', 
    gameState         = '3', 
    terminate         = '4';
}

interface Status {
  char
    awaitngUsers = '0', 
    spawned      = '1', 
    running      = '2', 
    terminated   = '3';
  }
