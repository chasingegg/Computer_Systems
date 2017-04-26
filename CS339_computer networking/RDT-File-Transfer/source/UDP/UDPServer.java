import java.io.*;
import java.net.*;
import java.util.*;

public class UDPServer {
    private DatagramSocket s;
    private String filename, initString;
    private byte[] buffer;
    private DatagramPacket initPacket, receivedPacket;
    private FileOutputStream fileWriter;
    
    int bytesReceived, bytesToReceive;

    public UDPServer(int port) throws Exception 
    {
        s = new DatagramSocket(port);
        buffer = new byte[4096];
    }


    public void send(InetAddress recv, int port,byte[] message)
       throws IOException {
      
	//InetAddress recv = InetAddress.getByName(host);
       DatagramPacket packet = new DatagramPacket(message, message.length, recv, port);
       s.send(packet);
   }	



    public void receiveFile() throws Exception
    {
        initPacket = new DatagramPacket(buffer, buffer.length);
        s.receive(initPacket);

        initString = "rec-"+new String(initPacket.getData(), 0, initPacket.getLength());
	    //System.out.println(initString);
        StringTokenizer t = new StringTokenizer(initString, "::");
	    filename = t.nextToken();
        //System.out.println(filename);
	    bytesToReceive = new Integer(t.nextToken()).intValue();
        System.out.println("file length " + bytesToReceive + "Bytes");
        send(initPacket.getAddress(), initPacket.getPort(), (new String("OK")).getBytes());
        
        fileWriter = new FileOutputStream(filename);
        //int count = 0;
	    while(bytesReceived < bytesToReceive)
	    {
		    receivedPacket = new DatagramPacket(buffer, buffer.length);
            s.receive(receivedPacket);
            //long cur = System.currentTimeMillis();
            //System.out.println("current time" + cur);
            //++count;
            //System.out.println(count);
            //System.out.println(receivedPacket.getLength());
		    fileWriter.write(receivedPacket.getData(), 0,  receivedPacket.getLength());
            fileWriter.flush();
		    bytesReceived = bytesReceived + receivedPacket.getLength();
	    }
	    System.out.println("File transfer complete!");
    
    }
    public static void main(String[] args) throws Exception 
    {
        if(args.length != 1)
        {
            System.out.println("input error!");
            System.exit(1);
        }
        UDPServer s = new UDPServer(Integer.parseInt(args[0]));
        s.receiveFile();
    }
}