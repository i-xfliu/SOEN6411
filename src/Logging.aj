public privileged aspect Logging {
	declare precedence: Logging, Authentication;
	//check log in information
	 pointcut connection (Client client, Server server):
	         call(void Server.attach(..)) &&
	         this(client)
	         && target(server);
	
	 pointcut disconnection (Client client, Server server):
	         call(void Server.detach(..)) &&
	                 this(client)
	                 && target(server);
	
	 before(Client client, Server server): connection (client, server) {
	     System.out.println("CONNECTION REQUEST >>> " + client.toString() + " requests connection to " + server.toString() +".\n");
	 }
	 after(Client client, Server server): connection (client, server) {
	     System.out.println("Connection established between " + client.toString() + " and " + server.toString() + ".");
	     System.out.println("Client logged in: " + server.clients);
	     //server.getClients();
	     System.out.println("\n");
	 }
	
	 after(Client client, Server server): disconnection (client, server) {
	     System.out.println("Connection broken between " + client.toString() + " and " + server.toString() + ".");
	     //server.getClients();
	     System.out.println("Client logged in: " + server.clients);
	     System.out.println("\n");
	 }
}
