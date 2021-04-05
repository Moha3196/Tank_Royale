import processing.core.*;
import java.io.*;

// Entity klasse som repæsentere dynamiske ting i spillet, 
// er funktionelt en "primitiv klasse" og er Serializable 
class Entity implements Serializable{
  PVector pos = new PVector(); 
  PVector vel = new PVector();
  boolean clearNextFrame = false;
  int size;
  
  // "transient" betyder at dette data ikke skal serialiseres, 
  // da det ikke giver mening at sende en kopi af en papplet over internettet 
  transient PApplet app;
  transient PGraphics g; 

  World world;

  // render funktion der vil bliver overskrevet.
  void Render() {}
  
  // bind funktion der bnder objektet fast til app, for at kunne fx render.
  void bind (PApplet a) {
    app = a;
    g = app.g;
  }

  // generel move funktion der bliver brugt af alle Entities.
  void Move() { pos.add(vel); }

  // metoder der bliver overskrevet i nedarvede klasser:
  void Collide(World w) {}

  void Collide(Entity e) {}

  void Collide(GameObject g) {}

  void CheckCollision(World w) {}

  void CheckCollision(Entity e) {}
  
  void CheckCollision(GameObject g) {}

  void CheckCollisions() {}

  // pladsholder metode hvis en Entity skal gøre noget hver frame.
  void Update() {  }

  // genrel metode til at dræbe Entity.
  void Kill() { clearNextFrame = true; }
}
