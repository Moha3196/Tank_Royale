class World {
  int[] MapSize = {1024, 1024};
  ArrayList<int[]> SpawnPoints = new ArrayList<int[]>(3);
  int MaxHP = 50;
  float FireRate = 10000;
  int BulletDmg = 35;
  float BulletSpeed = 10;
  int BulletSize = 5;
  float MovementSpeed = 3.5;
  int MaxPlayers = 3;
  int PlayerSize = 30;
  //boolean CheatsEnabled = true;
  //String[] EnabledPowurups;
  int UpdateRate = 30;
  //int Chunksize = 4;
  Player self;
  LinkedList<Entity> Entities = new LinkedList<Entity>();
  LinkedList<GameObject> GameObjects = new LinkedList<GameObject>();


  //Demo
  World() {
    SpawnPoints.add(new int[] {20, 30});
    SpawnPoints.add(new int[] {300, 400});
    SpawnPoints.add(new int[] {600, 30});
    Entities.add(new Player(this, SpawnPoints.get(0), true));
    Entities.add(new Player(this, SpawnPoints.get(1), false));
    self = (Player)Entities.get(0);
  }

  void Render() {
    float[] leftCorner = relPos(0, 0);
    float[] rightCorner = relPos(MapSize[0], MapSize[1]);
    noFill();
    stroke(5);
    rect(leftCorner[0], leftCorner[1], rightCorner[0] - leftCorner[0], rightCorner[1] - leftCorner[1]);
  }



  void Run() {
    Render();
    for (Entity e : Entities) {
      e.Render();
      e.Move();
      //e.CheckCollisions(); 
      //e.Update();
    }
    self.Shoot();
    //cleanEntites();
  }


  void cleanEntites() {
    Iterator iter = Entities.iterator();
    Entity e;
    while (iter.hasNext()) {
      e = (Entity)iter.next();
      if (e.clearNextFrame) {
        iter.remove();
      }
    }
  }

  float[] relPos(float x, float y) {
    return new float[]{x - self.pos.x + width/2, y - self.pos.y + height/2};
  }
}
