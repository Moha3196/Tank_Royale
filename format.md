mapfileData  
***********

meta
-----
* mapzies = int[2]
* spawnpoints [[int[2]],...] [[x,y],[x,y],[x,y]]
* MaxHP int
* FireRate float 
* BulletDmg int
* BulletSpeed float
* Movementspeed float
* MaxPlayers int
* PlayerRadius float
* CheatsEnabled = True
* *EnabledPowurups: [...]
* UpdateRate  int 
* Chunksize  int 
`

object
-------

* shape *rect, circl, image *, *polygons  [str]
* shapeArguments (xywh) (xyr) (xy"location",xscalar,yscalar)  
* collidable  [bool]
* bulletPentration  bool


JavaObject Data  
***************
Player  
-----------
* self boolean
* Id  int
* Pos  int[2]
* DisplayName str  
* HP  int
* CurrentPowerup string   
* TimeSincePowerupObtained int 
* Kills  int
* _Velocity (xyvector) float[2]  
* _CurrentChunk  int[2]


