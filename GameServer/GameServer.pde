// ------- inpout parameters -------
// egen lokale ip
String SelfIP = "192.168.0.20";
// port til server.
int SelfPort = 4206;
// ---------------------------------

// en instans af server bliver skabt.
Server server = new Server(this, SelfIP, SelfPort);

void setup () {
  frameRate(120);
  println("Server ready.");
}
void draw() {
    server.Run();
}

// Event der bliver kaldt når der bliver modtaget en pakke
void receive( byte[] data, String IP, int port ) {
  server.process(data, IP, port);
}

// mousePressed bliver brugt som en knap til at bringe status af server fremad.
void mousePressed(){
  switch (server.status){
    case Status.awaitngUsers:
      server.StartGame();
    break;

    case Status.running:
      // debug code.
      for(Client c : server.clients){
        println(c.player.pos.x);
      }
    break;
  }
}

// Using interface, becuase enums suck in java:
// Packet type - alle packets har forskellige typer for at håndtere dem forskelligt. 
interface PacketType {
  char
    connectionRequest = '0', 
    firstGameState    = '1', 
    playerCommand     = '2', 
    gameState         = '3', 
    terminate         = '4';
}
// serverstatus
interface Status {
  char
    awaitngUsers = '0', 
    spawned      = '1', 
    running      = '2', 
    terminated   = '3';
  }
