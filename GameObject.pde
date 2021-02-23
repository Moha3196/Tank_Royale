class GameObject {
  PVector pos = new PVector();
  World world;

  void Render() {
  }


  void Collide() {
  }
}

class Wall extends GameObject {
  PVector endPos = new PVector();
  color Color;
  int thick;

  Wall(World w, PVector startPos, PVector EndPos, color Clr, int Thickness) {
    pos = startPos;
    endPos = EndPos;
    Color = Clr;
    thick = Thickness;
    world = w;
  }

  void Render() {
    stroke(Color);
    strokeWeight(thick);
    line(pos.x, pos.y, endPos.x, endPos.y);
  }


  void Collide() {
    
  }
}
