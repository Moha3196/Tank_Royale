class Bullet extends Entity {
  int dmg;
  Player owner;

  Bullet(Player player, PVector position, PVector velocity) {
    pos = position;
    vel = velocity;
    owner = player;
    world = player.world;
    size = world.BulletSize;
  }

  void Render() {
    noStroke();
    fill(#000000);
    float[] relpos = world.relPos(pos.x, pos.y);
    circle(relpos[0], relpos[1], size);
  }

  void Collide(Entity e) {
    if(e instanceof Player){
    }
  }

  void Collide(GameObject g) {
  }

  void CheckCollision(Entity e) {
    if(e instanceof Player){
      if(pos.dist(e.pos) < e.size + size){
        Collide(e);
        e.Collide(this);
      }
    }
  }

  void CheckCollision(GameObject g) {
    //if(e instanceof Player){
    //  if(pos.dist(e.pos) < e.size + size){
    //    Collide(e);
    //    e.Collide(this);
    //  }
    //}
  }

  void CheckCollision(World w) {
    if(pos.x < 0 || pos.x > world.MapSize[0] || pos.y < 0 || pos.y > world.MapSize[1]){
      Kill();
    }
  }
}
