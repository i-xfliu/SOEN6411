
public class main {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Server host = new Server("My Server");
		Client jack = new Client("Jack", "evil.net");
		Client jill = new Client("Jill", "evil.net");
		Client jekyll = new Client("Jekyll", "student.net");
		Client hyde = new Client("Hyde", "evil.net");
		jack.connect(host); // accommodate
		jill.connect(host); // accommodate
		jekyll.connect(host); // accommodate
		jekyll.disconnect(host); // accommodate
//		host.getClients();  // Testing if the host got blacklist
		jack.getAllClients(); // suspicious: Do not accommodate, blacklist and disconnect
		
//		
		jill.getAllClients(); // already blacklisted; Do not accommodate and disconnect
		jill.getAllClients(); // not accommodated
		jill.disconnect(host); // not accommodated
		jill.connect(host); // recorded, but not accommodated
		hyde.connect(host); // recorded, but not accommodated
		host.getClients();
		
	}

}
