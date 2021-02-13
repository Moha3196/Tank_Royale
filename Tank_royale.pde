import java.util.LinkedList;
import java.util.*;


GameData gd = new GameData();
Session session = new Session("ole", "192.168.0.27");


void setup() {
  gd.load();
  gd.export();
}

void draw() {
}

void close(){
  Session.close();
}
