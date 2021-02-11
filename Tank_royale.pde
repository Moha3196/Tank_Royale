import java.util.LinkedList;
import java.util.*;


GameData gd = new GameData();
Session session = new Session("ole", "192.168.0.27");


void setup() {
  long startT = System.nanoTime();
  for (int i = 0; i < 1000; i++) {
    gd.load();
    gd.export();
  }
  long elapsedT = System.nanoTime() - startT; 
  println("elapsedtime:" + elapsedT/1000000000.0 + " ms");
}

void draw() {
}

void close(){
  Session.end();
}
