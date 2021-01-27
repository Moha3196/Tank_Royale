

JSONObject json;
JSONObject metaJson;
JSONObject contentJson;


void setup() {
  json = new JSONObject();
  metaJson = new JSONObject();
  contentJson = new JSONObject();
  //contentjson
  //  mapsize
  JSONArray mapsize = new JSONArray();
  mapsize.append(1024);
  mapsize.append(1024);
  metaJson.setJSONArray("MapSize", mapsize);
  
  //MaxPlayers
  metaJson.setInt("MaxPlayers", 2);
  
  // spawns
  JSONArray spawnP = new JSONArray();
  JSONArray spawnPs = new JSONArray();
  spawnP.append(0); //x
  spawnP.append(0); //y
  spawnPs.append(spawnP);
  
  spawnP = new JSONArray();
  spawnP.append(30); //x
  spawnP.append(30); //y
  spawnPs.append(spawnP);
  metaJson.setJSONArray("SpawnPoints", spawnPs);

  //maxHP
  metaJson.setInt("MaxHP", 50);
  
  //FireRate
  metaJson.setFloat("FireRate", 0.75);
  
  //Bulletdmg
  metaJson.setInt("BulletDMG", 35);
  
  //BulletSpeed
  metaJson.setFloat("BulletSpeed", 1.7);
  
  //MovementSpeed
  metaJson.setFloat("MovementSpeed", 1.0);
  
  //PlayerRadius
  metaJson.setInt("PlayerRadius", 30);
  
  //CheatsEnabled
  metaJson.setBoolean("CheatsEnabled", false);
  
  //EnabledPowerups
  JSONArray PowerUps = new JSONArray();
  metaJson.setJSONArray("EnabledPowurups", PowerUps);
  
  //ChunkSize
  metaJson.setInt("ChunkSize", 4); 
  //means 4x4
  
  
  json.setJSONObject("meta",metaJson);
  saveJSONObject(json, "new.json");
}

void draw() {
  
}
