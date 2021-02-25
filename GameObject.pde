class GameObject {
  PVector pos = new PVector();
  World world;

  void Render() {
  }


  void Collide() {
  }

  void Collide(Entity e) {
  }

  void Collide(World w) {
  }

  void CheckCollisions() {
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
    float[] realStartPos = world.relPos(pos.x, pos.y);
    float[] realEndPos = world.relPos(endPos.x, endPos.y);
    line(realStartPos[0], realStartPos[1], realEndPos[0], realEndPos[1]);
  }


  void Collide(Entity e) {
  }

  void Collide(World w) {
  }

  void Collide(GameObject g) {
  }


  void CheckCollision(Entity e) {
    PVector AB = pos.copy().sub(endPos);
    PVector BE = endPos.copy().sub(e.pos).mult(-1);
    PVector AE = pos.copy().sub(e.pos);

    float distance;

    if (AB.dot(BE) < 0) {
      distance = BE.mag();
    } else if (AB.dot(AE) < 0) {
      distance = AB.mag();
    } else {
      distance = abs((endPos.x - pos.x)*(pos.y - e.pos.y) - (pos.x - e.pos.x)*(endPos.y - pos.y))/
        sqrt(sq(endPos.x - pos.x) + sq(endPos.y - pos.y));
    }
    println(distance);

    if (distance < e.size/2 + thick/2) {
      e.Collide(this);
      Collide(e);
    }
  }

  void CheckCollisions() {
    for (Entity e : world.Entities) {
      CheckCollision(e);
    }
  }
}
