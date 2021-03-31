import processing.core.PApplet;
import processing.core.*;
import java.util.*;
import java.lang.Math.*;
import java.io.*;


class Player extends Entity {
  int Id;
  String DisplayName = "Player";

  float HP;
  //String CurrentPowerup;
  //int TimeSincePowerupObtained;
  int Kills;
  boolean isSelf = false;
  int lastTimeShot;
  boolean alive = true;
  //int[] CurrentChunk;


  Player(PApplet appp, World world_, int[] spawn, boolean self) {
    bind(appp);
    pos.x = spawn[0];
    pos.y = spawn[1];
    isSelf = self;
    world = world_;
    size = world.PlayerSize;
    HP = world.MaxHP;
  }

  Player(PApplet appp, World world_, int[] spawn) {
    bind(appp);
    pos.x = spawn[0];
    pos.y = spawn[1];
    world = world_;
    size = world.PlayerSize;
    HP = world.MaxHP;
  }


  void Render() {
    //Position text up left/right
    if (isSelf) {
      app.fill(0, 90);
      app.text("x: " + pos.x/1 + ", y: " + pos.y + "\nvel x y: " + vel.x + "  " + vel.y, 5, 15);
    }
    app.noStroke();
    // color pick for type of player
    if (isSelf) {
      app.fill(0, 0, 255);
    } 
    else if (!alive) {
      app.fill(0, 10);
    }
    else {
      app.fill(255, 0, 0);
    }

    float[] realPos = world.relPos(pos.x, pos.y);
    app.circle(realPos[0], realPos[1], size);
    //Damaged HP bar
    app.fill(255, 0, 0);
    app.rect(realPos[0]-size, realPos[1]-size, size*2, size/4);

    //Currnet HP bar
    app.fill(0, 255, 0);
    app.rect(realPos[0]-size, realPos[1]-size, size*2/world.MaxHP*HP, size/4);
    
    // DisplayName render
    app.fill(0, 90);
    app.text(DisplayName, realPos[0] - DisplayName.length() * (float)3.2, realPos[1] + 25);
  }

  void Shoot(boolean[] inputs) {
    if (inputs[4] && isSelf) {

      if ( app.millis() - lastTimeShot > 1.0/world.FireRate*1000) {
        float[] realPos = world.relPos(pos.x, pos.y);
        float[] diffVector = {realPos[0] - app.mouseX, realPos[1] - app.mouseY};
        PVector bulletVel = new PVector(-diffVector[0], -diffVector[1]).setMag(world.BulletSpeed);
        world.Entities.add(new Bullet(app, this, pos.copy(), bulletVel));
        //world.Entities.add(new Bullet(this, pos, bulletVel));
        lastTimeShot = app.millis();
      }
    }
  }

  void selfMove(boolean[] inputs){
        vel.x = 0;
        vel.y = 0;
        if (inputs[1]) { 
          vel.x = -1;
        } else if (inputs[3]) { 
          vel.x =  1;
        } else {
          vel.x = 0;
        }
        if (inputs[0]) { 
          vel.y = -1;
        } else if (inputs[2]) { 
          vel.y =  1;
        } else {
          vel.y = 0;
        }

      vel.setMag(world.MovementSpeed);

  }

  void Move() {
    pos.x += vel.x;
    pos.y += vel.y;

    PVector specPos = new PVector(pos.x + vel.x, pos.y + vel.y);
    if (specPos.x > world.MapSize[0] - size/2) {
      pos.x = world.MapSize[0] - size/2;
    }
    if (specPos.x < 0 + size/2) {
      pos.x = 0 + size/2;
    }
    if (specPos.y > world.MapSize[1] - size/2) {
      pos.y = world.MapSize[1] - size/2;
    }
    if (specPos.y < 0 + size/2) {
      pos.y = 0 + size/2;
    }
  }

  void Collide(Entity e) {
    if (e instanceof Bullet) {
      addHP(-((Bullet)e).dmg);
    }
  }

  void Collide(World w) {
  }

  void Collide(GameObject g) {
  }

  void CheckCollision(Entity e) {
    if (e instanceof Bullet) {
      if (!this.equals(((Bullet)e).owner) ) {
        if (pos.dist(e.pos) < (e.size + size)/2) {
          Collide(e);
          e.Collide(this);
        }
      }
    }
  }

  void CheckCollision(GameObject g) {
  }

  void CheckCollision(World w) {
    if (pos.x - size < 0 || pos.x + size > w.MapSize[0]) {
      vel.x = 0;
    }

    if (pos.y - size < 0 || pos.y + size > w.MapSize[1]) {
      vel.y = 0;
    }
  }

  void CheckCollisions() {
    for (Entity e : world.Entities) {
      //if (e instanceof Player) {

      //  continue;
      //}
      //if (e instanceof Bullet) {

      //  continue;
      //}
      CheckCollision(e);
    }
    CheckCollision(world);
    for (GameObject g : world.GameObjects) {
      CheckCollision(g);
    }
  }



  void addHP(int amount) {
    HP = amount + HP;
	// low clamp
    if (HP <= 0) {
      alive = false;
      HP = 0;
      return;
    }
	// high clamp
    else if(HP >= world.MaxHP){
      HP = world.MaxHP;
    }
  }
}
