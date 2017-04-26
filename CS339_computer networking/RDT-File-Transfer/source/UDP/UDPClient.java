import java.io.*;
import java.net.*;

public class UDPClient {

    private File theFile;
    private FileInputStream fileReader;
    private DatagramSocket s;
    private int fileLength, currentPos, bytesRead, toPort;
    private byte[]  msg, buffer;
    private String toHost,initReply;
    private InetAddress toAddress;
    static long start, end;
    public UDPClient(InetAddress address, int port) throws IOException
    {
	    toPort = port;
	    toAddress = address;
	    msg = new byte[4096];
	    buffer = new byte[1024];
	    s = new DatagramSocket();
        s.connect(toAddress, toPort);
    }

    public void sendFile(File theFile) throws Exception 
    {
        fileReader = new FileInputStream(theFile);
	    fileLength = fileReader.available();
        System.out.println(fileLength);

        DatagramPacket packet = new DatagramPacket((theFile.getName()+"::"+fileLength).getBytes(), ((theFile.getName()+"::"+fileLength).getBytes()).length);
        s.send(packet);

        DatagramPacket reply = new DatagramPacket(buffer, buffer.length);
	    s.receive(reply);

        if (new String(reply.getData(), 0, reply.getLength()).equals("OK"))
	    {
		    //System.out.println("  -- Got OK from receiver - sending the file ");
		
            start = System.currentTimeMillis();
            //System.out.println("start time is " + start);
		    while (currentPos<fileLength) {
		        bytesRead = fileReader.read(msg);
		        DatagramPacket sendPacket = new DatagramPacket(msg, msg.length);
                
                s.send(sendPacket);

		        currentPos = currentPos + bytesRead;
		}
            end = System.currentTimeMillis();
		    System.out.println("File transfer complete!");
	    }
	    else{System.out.println("Recieved something other than OK... exiting");}
    

    }
    public static void main(String[] args) throws Exception
    {
        File file = null;
        UDPClient client = null;
        if(args.length == 3) 
        {
            file = new File(args[2]);
            client = new UDPClient(InetAddress.getByName(args[0]), Integer.parseInt(args[1]));
        } 
        else {
            System.out.println("Input error!");
            System.exit(1);
        }

        //long startTime=System.currentTimeMillis();
	    // Send the file
	    client.sendFile(file);
	    //long endTime = System.currentTimeMillis();
	    long delayTime = end-start;
	    System.out.println("Total delay time is ");
	    System.out.println(delayTime);

    }
}