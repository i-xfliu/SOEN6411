import java.util.ArrayList;

/*
 * This AJ class is for checking client Authentication. If the client invoke getAllClients, 
 * it will disconnect from the server and blacklist its domain
 */
public privileged aspect Authentication {
	private ArrayList<String> blackList = new ArrayList<String>();
	
	pointcut suspicious(Server server, Client client): call(* Server.getClients(..)) && this(client) && target(server);
	
	pointcut blacklistConnection(Server server, Client client):
        call(void Server.attach(Client)) &&
        this(client)
        && target(server);
	
	void around(Server server, Client client): suspicious(server, client){
//	System.out.println("PRINTING: " + blackList.toString());
		
//If the domain is in the blacklist, just disconnect the client. 
//Otherwise, add the domain into the black and then disconnect
//If there is a connected client from blacklist domain try to getAllClients, detach this client
		if(blackList.contains(client.getAddress())){
			if(server.clients.contains(client)) {
				server.detach(client);
			}
			
		}
		else {
			System.out.println("WARNING >>> Suspicious call from " + client.getAddress() + " : " + thisJoinPoint);
			blackList.add(client.getAddress());
			client.disconnect(server);
		}		
	}
	
	void around (Server server, Client client): blacklistConnection(server, client){
		if(blackList.contains(client.getAddress())) {
			System.out.println("blackListed");

		}
		else {
			proceed(server,client);
		}
	}
}
