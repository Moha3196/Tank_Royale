class Entity{
  PVector pos = new PVector(); 
  PVector vel = new PVector();
  
  //speculative position
  PVector specPos = new PVector();
  
  int HP;
  
  
  boolean clearNextFrame = false;
  
  World world = new World();
  
  
  void Render() {
    noStroke();
    fill(#d1d1d3);
    circle(pos.x, pos.y, 10);
  }
  
  
  void Move() {}
  
  
  void CheckCollisions() {
    for (Entity e : world.Entities) {
      
    }
  }
  
  
  void Collide(Entity e) {
  }

  void Update() {
  }
  
  
  void slow() {
    if (vel.mag() > 2.5) {
      vel.mult(0.993);
    }
  }
  
  
  void addHP(int amount){
    if(HP + amount <= 0) {return;}
    HP = amount + HP % world.gd.MaxHP;
    
    
  }
}
