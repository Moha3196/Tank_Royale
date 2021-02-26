import java.io.Serializable;
import processing.core.PApplet;
import processing.core.*;
import java.util.*;


class World implements Serializable {
  int[] MapSize = {1024, 1024};
  ArrayList<int[]> SpawnPoints = new ArrayList<int[]>(3);
  int MaxHP = 50;
  float FireRate =(float) 3.0;
  int BulletDmg = 35;
  float BulletSpeed = 10;
  int BulletSize = 5;
  float MovementSpeed = (float) 3.5;
  int MaxPlayers = 3;
  int PlayerSize = 30;
  //boolean CheatsEnabled = true;
  //String[] EnabledPowurups;
  int UpdateRate = 30;
  //int Chunksize = 4;
  Player self;
  LinkedList<Entity> Entities = new LinkedList<Entity>();
  LinkedList<GameObject> GameObjects = new LinkedList<GameObject>();
  PApplet app;
  PGraphics g; 

  boolean[] playerInputs = new boolean[5];



  //Demo
  World(PApplet PApp) {
    app = PApp;
    g = app.g;
    SpawnPoints.add(new int[] {20, 30});
    SpawnPoints.add(new int[] {300, 400});
    SpawnPoints.add(new int[] {600, 30});
    Entities.add(new Player(app, this, SpawnPoints.get(0), true));
    Entities.add(new Player(app, this, SpawnPoints.get(1), false));
    GameObjects.add(new Wall(app, this, new PVector(333, 20), new PVector(300, 100), 120, 5));
    self = (Player)Entities.get(0);
  }

  void Render() {
    float[] leftCorner = relPos(0, 0);
    float[] rightCorner = relPos(MapSize[0], MapSize[1]);
    app.noFill();
    app.stroke(5);
    app.rect(leftCorner[0], leftCorner[1], rightCorner[0] - leftCorner[0], rightCorner[1] - leftCorner[1]);

    
    for (int x = 0; x < MapSize[0]; x += 64 ) {
      for (int y = 0; y < MapSize[1]; y  += 64 ) {
      float[] relPos = relPos(x,y);
      app.stroke(255);
      app.strokeWeight(1);
      app.fill(200);
      app.rect(relPos[0], relPos[1], 64, 64);
      }
    }
  }



  void Run() {
    Render();
    for (Entity e : Entities) {
      e.Render();
      e.Move();
      e.CheckCollisions(); 
      e.Update();
    }

    for (GameObject g : GameObjects) {
      g.Render();
      g.CheckCollisions();
    }
    self.Shoot();
    cleanEntites();
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
    return new float[]{x - self.pos.x + app.width/2, y - self.pos.y + app.height/2};
  }
}
