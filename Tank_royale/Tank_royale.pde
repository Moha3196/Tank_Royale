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
// instans af world - også en singlton
World world;


void setup() {
  println("demo? =", demo);
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
  // hvis det ikke er demo skal kommandoer sendes til server.
  if (!demo && session.status == Status.running) {
    session.sendPlayerCMDs();
  }
  if (demo || session.status == Status.running) {
    background(254);
    world.Run();
    fill(0, 90);
    text("FPS:" + int(1.0/((System.nanoTime() - start)/1000000000.0)), width -56, 15);
  }
}

// event handler til udp packets til session
void receive(byte[] data, String ip, int port) {
  session.receive(data, ip, port);
}

// funktioner til at sætte og unsætte inputs:
void mousePressed() {
  world.playerInputs[4] = true;
}

void mouseReleased() {
  world.playerInputs[4] = false;
}

void keyPressed() {
  switch (keyCode) {
  case 87:
  case UP:
    world.playerInputs[0] = true;
    break;

  case 65:
  case LEFT:
    world.playerInputs[1] = true;
    break;

  case 83:
  case DOWN:
    world.playerInputs[2] = true;
    break;

  case 68:
  case RIGHT:
    world.playerInputs[3] = true;
    break;
  }
}

void keyReleased() {
  switch (keyCode) {
  case 87:
  case UP:
    world.playerInputs[0] = false;
    break;

  case 65:
  case LEFT:
    world.playerInputs[1] = false;
    break;

  case 83:
  case DOWN:
    world.playerInputs[2] = false;
    break;

  case 68:
  case RIGHT:
    world.playerInputs[3] = false;
    break;
  }
}
