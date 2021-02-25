import java.util.LinkedList;
import java.util.*;

//Entity ent = new Entity();
World world = new World();
boolean[] keyInputs = {false, false, false, false, false};
long start;

Session session = new Session("ole", "192.168.0.27");


void setup() {
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
  keyInputs[4] = true;
}

void mouseReleased() {
  keyInputs[4] = false;
}

void keyPressed() {
  switch (keyCode) {
  case 87:
  case UP:
    keyInputs[0] = true;
    break;

  case 65:
  case LEFT:
    keyInputs[1] = true;
    break;

  case 83:
  case DOWN:
    keyInputs[2] = true;
    break;

  case 68:
  case RIGHT:
    keyInputs[3] = true;
    break;
  }
}



void keyReleased() {
  switch (keyCode) {
  case 87:
  case UP:
    keyInputs[0] = false;
    break;

  case 65:
  case LEFT:
    keyInputs[1] = false;
    break;

  case 83:
  case DOWN:
    keyInputs[2] = false;
    break;

  case 68:
  case RIGHT:
    keyInputs[3] = false;
    break;
  }
}
