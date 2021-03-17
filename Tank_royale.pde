import java.util.LinkedList;
import java.util.*;



//Entity ent = new Entity
long start;


Session session = new Session(this);
World world = new World(this);


void setup() {
  session.config("ole", "192.168.0.20");
  session.init();
  size(800, 600);
  frameRate(60);
}
/* 
 * Save the lord
 * https://stackoverflow.com/questions/1931466/sending-an-object-over-the-internet
 */



void draw() {
  start = System.nanoTime();
  background(254);
  world.Run();
  fill(0, 90);
  text("FPS:" + int(1.0/((System.nanoTime()- start)/1000000000.0)), width -56, 15);
}


void receive(byte[] data) {
  println(session.status,12);
  char PackT = char(data[0]);
  byte[] payload = subset(data, 1);
  switch(session.status) {
    case(Status.connected):
    println(11);
    session.receiveFirstGD(PackT, payload);

    break;
    case(Status.running):

    break;
  default:
    return;
  }
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
