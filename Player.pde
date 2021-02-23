class Player extends Entity {
  int Id;
  String DisplayName;
  int HP;
  //String CurrentPowerup;
  //int TimeSincePowerupObtained;
  int Kills;
  boolean isSelf;
  int lastTimeShot;
  //int[] CurrentChunk;


  Player(World world_, int[] spawn, boolean self) {
    pos.x = spawn[0];
    pos.y = spawn[1];
    isSelf = self;
    world = world_;
    size = world.PlayerSize;
    HP = world.MaxHP;
  }

  void Render() {
    noStroke();
    if (isSelf) {
      fill(#0000FF);
    } else {
      fill(#FF0000);
    }

    float[] realPos = world.relPos(pos.x, pos.y);
    circle(realPos[0], realPos[1], size);
  }

  void Shoot() {
    if (isSelf) {
      if (keyInputs[4] && millis()-lastTimeShot > 1.0/world.FireRate*1000) {
        float[] realPos = world.relPos(pos.x, pos.y);
        float[] diffVector = {realPos[0] - mouseX, realPos[1] - mouseY};
        PVector bulletVel = new PVector(-diffVector[0], -diffVector[1]).setMag(world.BulletSpeed);
        world.Entities.add(new Bullet(this, pos.copy(), bulletVel));
        //world.Entities.add(new Bullet(this, pos, bulletVel));
        lastTimeShot = millis();
      }
    }
  }

  void Move() {
    if (isSelf) {
      if (keyPressed) {
        if (keyInputs[1]) { 
          vel.x = -world.MovementSpeed;
        } else if (keyInputs[3]) { 
          vel.x =  world.MovementSpeed;
        } else {
          vel.x = 0;
        }
        if (keyInputs[0]) { 
          vel.y = -world.MovementSpeed;
        } else if (keyInputs[2]) { 
          vel.y =  world.MovementSpeed;
        } else {
          vel.y = 0;
        }
      } else {
        vel.x = 0;
        vel.y = 0;
      }
    }
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

  @Override
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
    if (HP + amount <= 0) {
      Kill();
      return;
    }
    HP = amount + HP % world.MaxHP;
  }
}
