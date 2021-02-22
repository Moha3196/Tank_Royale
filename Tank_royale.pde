import java.util.LinkedList;
import java.util.*;

//Entity ent = new Entity();
World world = new World();
boolean[] keyInputs = {false, false, false, false};

void setup() {
  size(1024, 1024);
  frameRate(120);
  long startT = System.nanoTime();
  long elapsedT = System.nanoTime() - startT; 
  println("elapsedtime:" + elapsedT/1000000000+ " ms");
}

void draw() {
  background(254);
  world.Run();
  //ent.Render();
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
