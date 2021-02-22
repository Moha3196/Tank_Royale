class Player extends Entity {
  int Id;
  String DisplayName;
  int HP;
  //String CurrentPowerup;
  //int TimeSincePowerupObtained;
  int Kills;
  boolean isSelf;
  //int[] CurrentChunk;

  Player(World world_, int[] spawn, boolean self) {
    pos.x = spawn[0];
    pos.y = spawn[1];
    isSelf = self;
    world = world_;
  }

  void Render() {
    noStroke();
    fill(#FF0000);
    float[] realPos = world.relPos(pos.x, pos.y);
    circle(realPos[0], realPos[1], size);
  }


  void Move() {
    if (isSelf) {
      if (keyPressed) {
        //final int k = keyCode;
        printArray(keyInputs);
        println();
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
  }



  void addHP(int amount) {
    if (HP + amount <= 0) {
      return;
    }
    HP = amount + HP % world.MaxHP;
  }
}
