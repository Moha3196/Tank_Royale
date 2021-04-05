# Tank_royale
Batte royale but for tanks



## How to:
### Client
In Tank_royale.pde you will find

    // ---------- inputparameters ----------
    // offline demo Set to false for online game  -  true/false
    boolean demo = false;
    // your displayname
    String DisplayName = "your player name";
    // Ip of the gameserver
    String GameserverIP = "192.168.0.20";
    // --------------------------------------
Just insert name into "your playername"  
Also insert gameserver ip-adress into GameserverIP default is 192.168.0.20  
Game only works over local ip

### Host
if you want to host a server you have to find local ip  
* windows: in commandprompt write >`ipconfig` get the IPv4 Address.
* mac/linux: in terminal write >`ifconfig | grep "inet " | grep -v 127.0.0.1` get the inet.

put this addres into here into server.pde into selfIP.

    // ------- inpout parameters -------
    // egen lokale ip
    String SelfIP = "192.168.0.20";
    // port til server.
    int SelfPort = 4206;
    // ---------------------------------
Once all players have joined click on the windows that server created to start the game.


### Demo
In Tank_royale.pde you will find and you have to change demo bool to true. 

    // ---------- inputparameters ----------
    // offline demo Set to false for online game  -  true/false
    boolean demo = false;
    // your displayname
    String DisplayName = "your player name";
    // Ip of the gameserver
    String GameserverIP = "192.168.0.20";
    // --------------------------------------




* tip: For Windows use RunClient.bat and RunServer.bat for ease of use!  
only works if u have processing in PATH, duh.


Links:  
[this](https://github.com/olekkr/Tank_royale)  
[testcode](https://github.com/olekkr/nettest)  
