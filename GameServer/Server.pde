import hypermedia.net.*;
import java.util.*;


/// all files need to be synced class-hash dosent corrispond


class Server {
    UDP udp;
    PApplet app;
    Status status;
    ArrayList<Client> clients = new ArrayList<Client>();
    World world;
    
    
    Server(PApplet a) {
        app = a;
        udp = new UDP(app, 4206, "192.168.0.20");
        udp.listen(true);
        //udp.log(true);
        status = Status.awaitngUsers;
        world = new World(app);
    }
    
    
    void process(byte[] data, String IP, int port) {
        // println(IP, port, 1);
        // for (int i=0; i < data.length; i++) {
        //  print(char(data[i]));
    // }
        
        char packT = (char) data[0];
        byte[] payload = subset(data, 1);
        println(packT, "received");
        
        
        switch(status) {
            case awaitngUsers:
            processAwaitngUsers(packT, payload, IP, port);
            break;
            case running:
            processRunning(packT, payload, IP, port);
            break;
        }
    }
    
    void processAwaitngUsers(char packT, byte[] payload, String IP, int port) {
        if (packT == PacketType.connectionRequest) {
            clients.add(new  Client(world, IP, port, new String(payload)));
        }
        println(new String(payload) + " joined.");
    }
    
    void processRunning(char packT, byte[] payload, String IP, int port) {
    }
    
    void spawnPlayers() {
        if (status != Status.spawned) {
            int spawned = 0;
            for (int i = 0; i < clients.size(); i++) { 
                if (i >= world.SpawnPoints.size()) {
                    println((world.SpawnPoints.size() - i + 1) + " player(s) didnt spawn");
                    break;
                }
                int[] spawn = world.SpawnPoints.get(spawned);
                clients.get(i).spawn(spawn);
                spawned += 1;
            } 
            println(spawned, "spawned in total");
            status = Status.spawned;
        }
    }
    
    void sendFirstGamestates(){
        for(Client client : clients){
            client.sendFirstGamestate();
        }

    }
    
    void StartGame() {
        spawnPlayers();
        sendFirstGamestates();
    }
}
