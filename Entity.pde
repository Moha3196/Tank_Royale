class Entity {
  PVector pos = new PVector(); 
  PVector vel = new PVector();
  boolean clearNextFrame = false;
  int size;

  World world;



  void Render() {
    noStroke();
    fill(#d1d1d3);
    circle(pos.x, pos.y, world.PlayerSize);
  }


  void Move() {
    pos.x += vel.x;
    pos.y += vel.y;
  }


  void CheckCollisions() {
    for (Entity e : world.Entities) {
    }
  }


  void Collide(Entity e) {
  }

  void Update() {
  }

  void Kill() {
    clearNextFrame = true;
  }
}
