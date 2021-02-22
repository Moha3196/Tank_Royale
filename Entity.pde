class Entity {
  PVector pos = new PVector(); 
  PVector vel = new PVector();

  float size;


  boolean clearNextFrame = false;

  World world;

 

  void Render() {
    noStroke();
    fill(#d1d1d3);
    circle(pos.x, pos.y, size);
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



  
}
