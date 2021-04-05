import hypermedia.net.*;
import java.util.*;


class Server {
    UDP udp;
    PApplet app;
    char status;
    ArrayList<Client> clients = new ArrayList<Client>();
    World world;
    
    
    Server(PApplet a, String IP, int PORT) {
        app = a;
        udp = new UDP(app, PORT, IP);
        udp.listen(true);
        //udp.log(true);
        status = Status.awaitngUsers;
        world = new World(app);
    }
    
    // generic processing of incoming packet
    void process(byte[] data, String IP, int port) {
        // println(IP, port, 1);
        // for (int i=0; i < data.length; i++) {
        //  print(char(data[i]));
    // }
        // cut the packet into packetType/payload
        char packT = (char) data[0];
        byte[] payload = subset(data, 1);
        
        
        switch(status) {
            case Status.awaitngUsers:
            processAwaitngUsers(packT, payload, IP, port);
            break;
            
            case Status.running:
            processRunning(packT, payload, IP, port);
            break;
            
            default:
            break;
        }
    }
    
    // process packet when in "awaiting users" state 
    void processAwaitngUsers(char packT, byte[] payload, String IP, int port) {
        if (packT == PacketType.connectionRequest) {
            clients.add(new  Client(world, IP, port, new String(payload)));
            println(new String(payload) + " joined.");
        }
    }

    // process packet when in running state
    void processRunning(char packT, byte[] payload, String IP, int port) {
        if(packT == PacketType.playerCommand){
            for(Client client : clients){
                if(client.IP.equals(IP)){
                    client.loadCMDs(payload);
                }
            }
        }
    }
    
    // Wrapper til spawning af alle clienters spiller
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
            status = Status.spawned;
        }
    }
    
    // metode til at sende første spil data.
    void sendFirstGamestates(){
        for(Client client : clients){
            client.sendFirstGamestate();
        }
    }
    
    // wrapepr til at gøre alt hvad der skal til for at starte spil.
    void StartGame() {
        spawnPlayers();
        sendFirstGamestates();
        status = Status.running;
    }

    //Gør alle de ting der skal til for at kører server.
    void Run(){
        tickGame();
        prepData();
    }

    // bevæger spillet 1 step fremad.
    void tickGame(){
        if(server.status == Status.running){
             for(Client client : clients){
                 client.DoPlayerCMDs();
             }
            world.Run();
        }
    }

    // Preps data before being sent.
    // to fix : object refrences dont work, when sent over the net.
    void prepData(){

    }

}
