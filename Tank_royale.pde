import java.util.*;


// ---------- inputparameters ----------

// offline demo Set to false for online game
boolean demo = false;
// your displayname
String DisplayName = "player Name";
// Ip of the gameserver
String GameserverIP = "192.168.0.20";

// --------------------------------------


long start;
Session session;
World world;


void setup() {
  println("demo? =", demo);
  //demo = args.length == 0;
  if (!demo) {
    session = new Session(this);
    world = new World(this);


    session.config(DisplayName, GameserverIP);
    session.init();
  } else {
    world = new World(this, false);
  }

  size(800, 600);
  frameRate(60);
}


void draw() {
  if (demo || session.status == Status.running) {
    start = System.nanoTime();
    background(254);
    world.Run();
    fill(0, 90);
    text("FPS:" + int(1.0/((System.nanoTime()- start)/1000000000.0)), width -56, 15);
  }
  if (!demo && session.status == Status.running) {
    session.sendPlayerCMDs();
  }
}


void receive(byte[] data, String ip, int port) {
  session.receive(data, ip, port);
}

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
