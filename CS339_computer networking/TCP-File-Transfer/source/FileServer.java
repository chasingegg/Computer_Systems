import java.io.*;
import java.net.*;

public class FileServer{

	public static void main(String[] args) {
		try {
			final ServerSocket ss = new ServerSocket(2680);
			
			try {
				//Socket connectSocket = ss.accept();
				//System.out.println("connect ok...");		
				System.out.println("server start...");
				Socket socket = ss.accept();
				System.out.println("connect ok"); 
				BufferedReader inFromClient = new BufferedReader(new InputStreamReader(socket.getInputStream()));
				
				
				Thread th = new Thread(new Runnable() {
					public void run() {
						while(true) {
							
							try {							
								String fileName = inFromClient.readLine();
								//System.out.println("fuck");
								if(fileName != null) {
									System.out.println("client request: " + fileName);
								}
								//System.out.println(fileName);
								if(fileName.equals("esc")) { break;}
				
								File file = new File(fileName);
								FileInputStream dis = new FileInputStream(file);
								//System.out.println(file.length());
								byte[] buf = new byte[4096];
								int len = 0;
								DataOutputStream dos = new DataOutputStream(socket.getOutputStream());
								dos.writeLong((long) file.length());
								dos.flush();
								while(true) {
								int read = 0;
								if(dis != null) {
									read = dis.read(buf);
								}
								if(read == -1) {
									break;
								}
								dos.write(buf, 0, read);
							}
							System.out.println("tranfer success");
				//sendFile(connectSocket);
					} catch(IOException e) {
				e.printStackTrace();
			}
		}
		}
	}); 
		th.run();
		} catch(Exception e) {}
	}catch(IOException e) {
	e.printStackTrace();
} 
}
	
}