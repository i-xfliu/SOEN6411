public aspect Logging {
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
	     System.out.println("CONNECTION REQUEST >>> " + client.toString() + " requests connection to My Server.");
	 }
	 after(Client client, Server server): connection (client, server) {
	     System.out.println("Connection established between" + client.toString() + " and My Server.");
	     server.getClients();
	 }
	
	 after(Client client, Server server): disconnection (client, server) {
	     System.out.println("Connection broken between " + client.toString() + " and My Server.");
	     server.getClients();
	 }
}
