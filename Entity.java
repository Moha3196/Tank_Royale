import processing.core.*;


class Entity {
  PVector pos = new PVector(); 
  PVector vel = new PVector();
  boolean clearNextFrame = false;
  int size;
  
  PApplet app;
  PGraphics g; 

  World world;


  void Render() {
    g.noStroke();
    g.fill(0xd1d1d3);
    g.circle(pos.x, pos.y, world.PlayerSize);
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
