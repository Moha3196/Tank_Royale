import java.util.LinkedList;
import java.util.*;

//Entity ent = new Entity();
World world = new World();

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
