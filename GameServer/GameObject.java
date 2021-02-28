import java.util.*;
import processing.core.*;
import java.lang.Math.*;
import java.io.*;

class GameObject implements Serializable{
  PVector pos = new PVector();
  World world;

  transient PApplet app;
  transient PGraphics g;   

void bind (PApplet a) {
    app = a;
    g = app.g;
  }

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
  int Color;
  int thick;

  Wall(PApplet a, World w, PVector startPos, PVector EndPos, int Clr, int Thickness) {
    pos = startPos;
    endPos = EndPos;
    Color = Clr;
    thick = Thickness;
    world = w;
    app = a;
    g = app.g;      
    
  }

  void Render() {
    app.stroke(Color);
    app.strokeWeight(thick);
    float[] realStartPos = world.relPos(pos.x, pos.y);
    float[] realEndPos = world.relPos(endPos.x, endPos.y);
    app.line(realStartPos[0], realStartPos[1], realEndPos[0], realEndPos[1]);
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
      float up = (endPos.x - pos.x)*(pos.y - e.pos.y) - (pos.x - e.pos.x) * (endPos.y - pos.y);
      distance = Math.abs(up)/(float) Math.sqrt(Math.pow((endPos.x - pos.x), 2) + Math.pow(endPos.y - pos.y, 2));
    }

    if (distance < e.size/2 + thick/2) {
      e.Collide(this);
      Collide(e);
    }
  }

  void CheckCollisions() {

    //Iterator iter = Entities.iterator();
    //Entity e;
    //while (iter.hasNext()) {
    //  e = (Entity)iter.next();
    //  if (e.clearNextFrame) {
    //    iter.remove();
    //  }
    //}
    for (Entity e : world.Entities) {
      CheckCollision(e);
    }
  }
}
