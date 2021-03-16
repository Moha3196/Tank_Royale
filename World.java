import processing.core.PApplet;
import processing.core.*;
import java.util.*;
import java.io.*;

class World implements Serializable {
  int[] MapSize = {256*8, 256*8};
  ArrayList<int[]> SpawnPoints = new ArrayList<int[]>(3);
  float MaxHP = (float) 50;
  float FireRate = (float) 3.0;
  int BulletDmg = 5;
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
  transient PApplet app;
  transient PGraphics g; 

  boolean[] playerInputs = new boolean[5];



  ////Demo
  //World(PApplet PApp) {
  //  bind(PApp);
  //  SpawnPoints.add(new int[] {20, 30});
  //  SpawnPoints.add(new int[] {300, 400});
  //  SpawnPoints.add(new int[] {600, 30});
  //  Entities.add(new Player(app, this, SpawnPoints.get(0), true));
  //  Entities.add(new Player(app, this, SpawnPoints.get(1), false));
  //  GameObjects.add(new Wall(app, this, new PVector(333, 20), new PVector(300, 100), 120, 5));
  //  self = (Player)Entities.get(0);
  //}



  //World
  World(PApplet PApp) {
    bind(PApp);
    SpawnPoints.add(new int[] {20, 30});
    SpawnPoints.add(new int[] {300, 400});
    SpawnPoints.add(new int[] {600, 30});
    Entities.add(new Player(app, this, SpawnPoints.get(0), true));
    Entities.add(new Player(app, this, SpawnPoints.get(1), false));
    //Box Top Left corner 
    GameObjects.add(new Wall(app, this, new PVector(462, 2), new PVector(462, 339), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(3, 395), new PVector(417, 395), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(440, 266), new PVector(331, 376), 120, 5));
    //Line Top Left
    GameObjects.add(new Wall(app, this, new PVector(0 + 64*3, MapSize[1]/2-64*2), new PVector(MapSize[0]/2-64*2, 0 + 64*3), 120, 5));
    //Big Triangle Bottom Left corner
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/4-384, MapSize[1]-256), new PVector(MapSize[0]/4, MapSize[1]/2+192), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/4, MapSize[1]/2+192), new PVector(MapSize[0]/4+384, MapSize[1]-256), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/4+384, MapSize[1]-256), new PVector(MapSize[0]/4-384, MapSize[1]-256), 120, 5));
    //Small Triangle Bottom Left corner
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/4-192, MapSize[1]-384), new PVector(MapSize[0]/4, MapSize[1]/2+384), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/4, MapSize[1]/2+384), new PVector(MapSize[0]/4+192, MapSize[1]-384), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/4+192, MapSize[1]-384), new PVector(MapSize[0]/4-192, MapSize[1]-384), 120, 5));
    //Rombe Top Right
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/4*3, 64*2), new PVector(MapSize[0]-64*2, MapSize[1]/4), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]-64*2, MapSize[1]/4), new PVector(MapSize[0]/4*3, MapSize[1]/2-64*2), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/4*3, MapSize[1]/2-64*2), new PVector(MapSize[0]/2+64*2, MapSize[1]/4), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/2+64*2, MapSize[1]/4), new PVector(MapSize[0]/4*3, 64*2), 120, 5));
    //Square in Rombe Top Right
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/4*3-64*2, MapSize[1]/4-64*2), new PVector(MapSize[0]/4*3+64*2, MapSize[1]/4-64*2), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/4*3+64*2, MapSize[1]/4-64*2), new PVector(MapSize[0]/4*3+64*2, MapSize[1]/4+64*2), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/4*3+64*2, MapSize[1]/4+64*2), new PVector(MapSize[0]/4*3-64*2, MapSize[1]/4+64*2), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/4*3-64*2, MapSize[1]/4+64*2), new PVector(MapSize[0]/4*3-64*2, MapSize[1]/4-64*2), 120, 5));
    //Walls from sides to Center
    GameObjects.add(new Wall(app, this, new PVector(0, MapSize[1]/2), new PVector(MapSize[0]/2 - 200, MapSize[1]/2), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/2, 0), new PVector(MapSize[0]/2, MapSize[1]/2 - 200), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0], MapSize[1]/2), new PVector(MapSize[0]/2 + 200, MapSize[1]/2), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/2, MapSize[1]), new PVector(MapSize[0]/2, MapSize[1]/2 + 200), 120, 5));
    //Rombe in Center
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/2 - 150, MapSize[1]/2), new PVector(MapSize[0]/2, MapSize[1]/2 - 150), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/2, MapSize[1]/2 - 150), new PVector(MapSize[0]/2 + 150, MapSize[1]/2), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/2 + 150, MapSize[1]/2), new PVector(MapSize[0]/2, MapSize[1]/2 + 150), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/2, MapSize[1]/2 + 150), new PVector(MapSize[0]/2 - 150, MapSize[1]/2), 120, 5));
    //X Bottom Right
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/2+64*2, MapSize[1]/2+64*2), new PVector(MapSize[0]-64*2, MapSize[1]-64*2), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]-64*2, MapSize[1]/2+64*2), new PVector(MapSize[0]/2+64*2, MapSize[1]-64*2), 120, 5));
    //Sides for X Bottom Right
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/2+64*4, MapSize[1]/2+64*2), new PVector(MapSize[0]-64*4, MapSize[1]/2+64*2), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]-64*2, MapSize[1]/2+64*4), new PVector(MapSize[0]-64*2, MapSize[1]-64*4), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/2+64*4, MapSize[1]-64*2), new PVector(MapSize[0]-64*4, MapSize[1]-64*2), 120, 5));
    GameObjects.add(new Wall(app, this, new PVector(MapSize[0]/2+64*2, MapSize[1]/2+64*4), new PVector(MapSize[0]/2+64*2, MapSize[1]-64*4), 120, 5));

    self = (Player)Entities.get(0);
  }

  void bind (PApplet a) {
    app = a;
    g = app.g;
    for (Entity e : Entities) {
      e.bind(app);
    }
    for (GameObject g : GameObjects) {
      g.bind(app);
    }
  }

  void Render() {
    float[] leftCorner = relPos(0, 0);
    float[] rightCorner = relPos(MapSize[0], MapSize[1]);
    app.noFill();
    app.stroke(5);
    app.rect(leftCorner[0], leftCorner[1], rightCorner[0] - leftCorner[0], rightCorner[1] - leftCorner[1]);

    app.fill(200);
    app.stroke(30,30);
    app.strokeWeight(1);
    for (int x = 0; x < MapSize[0]; x += 64 ) {
      float[] relPos1 = relPos(x, 0);
      float[] relPos2 = relPos(x, MapSize[1]);
      app.line(relPos1[0], relPos1[1], relPos2[0], relPos2[1]);
    }
    for (int y = 0; y < MapSize[1]; y += 64 ) {
      float[] relPos1 = relPos(0, y);
      float[] relPos2 = relPos(MapSize[0], y);
      app.line(relPos1[0], relPos1[1], relPos2[0], relPos2[1]);
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
    return new float[]{
      x - self.pos.x + app.width/2, 
      y - self.pos.y + app.height/2
    };
  }
  
  
  byte[] Serialize (Object obj) {
    try {
      ByteArrayOutputStream bout = new ByteArrayOutputStream();
      ObjectOutput oout = new ObjectOutputStream(bout);
      oout.writeObject(obj);
      oout.flush();
      oout.close();
      return bout.toByteArray();
    }
    catch(IOException e) {
      app.println("failed to start serializing");
      app.println(e);
      return new byte[] {};
    }
  }

  Object DeSerialize(byte[] bytes)
  {
    try {
      ObjectInputStream in = new ObjectInputStream(new ByteArrayInputStream(bytes));
      return in.readObject();
    }
    catch(Exception e) {
      app.println(e);
      app.println(1);
      return e;
    }
  }
}
