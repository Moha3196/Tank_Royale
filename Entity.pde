class Entity{
  PVector pos = new PVector(); 
  PVector vel = new PVector();
  
  int HP;
  
  
  boolean clearNextFrame = false;
  
  
  void Render() {
    noStroke();
    fill(#d1d1d3);
    circle(pos.x, pos.y, 10);
  }
  
}
