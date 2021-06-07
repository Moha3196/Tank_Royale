import java.util.*;


// ---------- inputparameters ----------

// offline demo Set to false for online game  -  true/false
boolean demo = false;
// your displayname
String DisplayName = "test";
// Ip of the gameserver
String GameserverIP = "192.168.0.20";
// --------------------------------------


// instans af session som kun bliver brugt hvis det ikke er demo 
Session session;
// playerInput klasse til at holde på spillerens input 
PlayerInput playerInputs = new PlayerInput();
// instans af world - også en singlton
World world;


void setup() {
    println("demo? =", demo);
    playerInputs.bind(this);
    if (!demo) {
        session = new Session(this);
        world = new World(this,true);
        session.config(DisplayName, GameserverIP);
        session.init();
      } else {
            world = new World(this, false);
        }
        
        size(1280, 720);
        frameRate(120);
    }

void draw() {
  long start = System.nanoTime();
  //hvis det ikke er demo skal kommandoer sendes til server.
  if (!demo &&  session.status == Status.running) {
    session.sendPlayerCMDs();
  }
  if (demo || session.status == Status.running) {
    background(254);
    world.Run();
    playerInputs.setAimPos();
    world.exerciseCmds(playerInputs);
    fill(0, 90);
    text("FPS:" + int(1.0 / ((System.nanoTime() - start) / 1000000000.0)), width - 56, 15);
  }
}     
// event handler til udppackets til session
void receive(byte[] data, String ip, int port) {
    session.receive(data, ip, port);
}
    
  // funktioner til at sætte og unsætte inputs:
void mousePressed() {
      playerInputs.shoot = true;
    }
        
void mouseReleased() {
  playerInputs.shoot = false;
}
        
void keyPressed() {
switch(keyCode) {
  case 87:
  case UP:
      playerInputs.moveNorth = true;
        break;
    
  case 65:
  case LEFT:
      playerInputs.moveWest = true;
      break;
    
  case 83:
  case DOWN:
      playerInputs.moveSouth = true;
        break;
    
  case 68:
  case RIGHT:
      playerInputs.moveEast = true;
      break;
}
}
        
void keyReleased() {
switch(keyCode) {
  case 87:
  case UP:
      playerInputs.moveNorth = false;
        break;
        
      case 65:
      case LEFT:
        playerInputs.moveWest = false;
        break;
        
      case 83:
      case DOWN:
      playerInputs.moveSouth = false;
        break;
        
      case 68:
      case RIGHT:
        playerInputs.moveEast = false;
        break;
}
}
                                         
