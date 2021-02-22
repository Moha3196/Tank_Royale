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
        final int k = keyCode;
        if (k == LEFT  | k == 'A') vel.x = -world.MovementSpeed;
        if (k == RIGHT | k == 'D') vel.x =  world.MovementSpeed;
        if (k == UP    | k == 'W') vel.y = -world.MovementSpeed;
        if (k == DOWN  | k == 'S') vel.y =  world.MovementSpeed;
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
