import processing.core.*;

import java.io.*;

class Entity implements Serializable{
  PVector pos = new PVector(); 
  PVector vel = new PVector();
  boolean clearNextFrame = false;
  int size;
  
  transient PApplet app;
  transient PGraphics g; 

  World world;


  void Render() {
    g.noStroke();
    g.fill(0xd1d1d3);
    g.circle(pos.x, pos.y, world.PlayerSize);
  }
  
  void bind (PApplet a) {
    app = a;
    g = app.g;
  }

  void Move() {
    pos.x += vel.x;
    pos.y += vel.y;
    //println(vel);
  }

  void Collide(World w) {
  }

  void Collide(Entity e) {
  }

  void Collide(GameObject g) {
  }

  void CheckCollision(World w) {
  }

  void CheckCollision(Entity e) {
  }

  void CheckCollisions() {
  }




  void Update() {
  }

  void Kill() {
    clearNextFrame = true;
  }
}
