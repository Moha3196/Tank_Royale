import java.util.LinkedList;
import java.util.*;



//Entity ent = new Entity
long start;

PApplet app = this;

Session session = new Session("ole", "192.168.0.27");
World world = new World(app);


void setup() {
  println();
  size(800, 600);
  frameRate(144);
}
/* 
* Save the lord
* https://stackoverflow.com/questions/1931466/sending-an-object-over-the-internet
*/



void draw() {
  start = System.nanoTime();
  background(254);
  world.Run();
  println("frame took : " + (System.nanoTime()- start)/1000000.0 + "ms \tPot Framerate: " + 1.0/((System.nanoTime()- start)/1000000000.0));
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
