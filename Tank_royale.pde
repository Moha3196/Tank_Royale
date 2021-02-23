import java.util.LinkedList;
import java.util.*;

/* 
* Save the lord
* https://stackoverflow.com/questions/1931466/sending-an-object-over-the-internet
*/

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
