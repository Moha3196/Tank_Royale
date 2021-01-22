mapfileData  
***********
`
meta
-----
* mapzies = int[2]
* spawnpoints [[int[2]],...] [[x,y],[x,y],[x,y]]
* MaxHP int[2]
* BulletRate 
* BulletDmg
* BaseBulletSpeed
* BaseMovementspeed
* MaxPlayers
* PlayerRadius
* CheatsEnabled=True
* *EnabledPowurups:[...]
* UpdateRate  
* Chunksize  
`

objekt
-------
`
* shape *rect, circl, image *, *polygons  
* shapeArguments (xywh) (xyr) (xy"location",xscalar,yscalar)  
* collidable  
* bulletPentration  
`

JavaObject Data  
***************
Player  
-----------
`
* Id  
* Pos  
* DisplayName  
* HP  
* CurrentPowerup  
* TimeSincePowerupObtained  
* Kills  
* _Velocity (xyvector)  
* _CurrentChunk  


`