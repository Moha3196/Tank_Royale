import java.util.*;
import processing.core.*;
import java.lang.Math.*;
import java.io.*;

// Gameobject klasse som repræsentere de statiske ting i spillet, dvs murer osv. Er Serializable, er primitiv, dvs vil adrig blive brugt, kun nedarvnenger bliver brugt.
class GameObject implements Serializable{
  PVector pos = new PVector();
  World world;

  // "transient" betyder at dette data ikke skal serialiseres, da det ikke giver mening at sende en kopi af en papplet over internettet 
  transient PApplet app;
  transient PGraphics g;   

// bind funktion der bnder objektet fast til app, for at kunne fx render.
void bind (PApplet a) {
    app = a;
    g = app.g;
  }

  // tomme metoder for polymorfisme:
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

// Nedarvning af GameObject - en væg i spillet, ting skal kunne kollidere med denne.
class Wall extends GameObject {
  // pos bliver brugt sammen med endPos for at bestemme start og slut af væg
  PVector endPos = new PVector();
  int Color;
  int Thickness;

  Wall(PApplet a, World w, PVector startPos, PVector EndPos, int Clr, int thickness) {
    pos = startPos;
    endPos = EndPos;
    Color = Clr;
    Thickness = thickness;
    world = w;
    app = a;
    g = app.g;      
  }

  // render funktion
  void Render() {
    app.stroke(Color);
    app.strokeWeight(Thickness);
    float[] realStartPos = world.relPos(pos.x, pos.y);
    float[] realEndPos = world.relPos(endPos.x, endPos.y);
    app.line(realStartPos[0], realStartPos[1], realEndPos[0], realEndPos[1]);
  }

  // checker om En entity er i kontakt med væggen
  void CheckCollision(Entity e) {
    // AB er start og slut af væg E er Entity

    // disse er vektorer mellem de forskellige punkter
    PVector AB = pos.copy().sub(endPos);
    PVector BE = endPos.copy().sub(e.pos).mult(-1);
    PVector AE = pos.copy().sub(e.pos);

    float distance;
    
    if (AB.dot(BE) < 0) {
      // B er nermeste punkt af væg
      distance = BE.mag();
    } else if (AB.dot(AE) < 0) {
      // A er nermeste punkt af væg
      distance = AB.mag();
    } else {
      // distance til linje er distancen.
      float up = (endPos.x - pos.x)*(pos.y - e.pos.y) - (pos.x - e.pos.x) * (endPos.y - pos.y);
      distance = Math.abs(up)/(float) Math.sqrt(Math.pow((endPos.x - pos.x), 2) + Math.pow(endPos.y - pos.y, 2));
    }

    // collision sker kun hvis at distancen er mindre en tykkelse af væg samt entity.
    if (distance < e.size/2 + Thickness/2) {
      e.Collide(this);
      Collide(e);
    }
  }

// wrapper-metode til at checke alle collisioner.
  void CheckCollisions() {
    for (Entity e : world.Entities) {
      CheckCollision(e);
    }
  }
}
