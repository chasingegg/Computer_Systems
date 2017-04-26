import java.net.*;
import java.io.*;


public class TCPClient {
    private File theFile;
    private FileInputStream fileReader;
    private Socket s;
    private int fileLength, currentPos, bytesRead, toPort, length;
    private byte[]  msg, buffer;
    private String toHost,initReply;
    private InetAddress toAddress;
    private OutputStream theOutstream; 
    private InputStream theInstream;

   
    public TCPClient(InetAddress address, int port) throws Exception
	{
		toPort = port;
		toAddress = address;
		msg = new byte[1024];
		buffer = new byte[1024];
		s = new Socket(toAddress, toPort);
		theOutstream = s.getOutputStream();
		theInstream = s.getInputStream();
    }
    

    public void sendFile(File theFile) throws Exception
	{

		fileReader = new FileInputStream(theFile);
		fileLength = fileReader.available();
	
		System.out.println("Filename: "+theFile.getName());
		System.out.println("Bytes to send: "+fileLength);

		long start = System.currentTimeMillis();
		System.out.println("start time is " + start);
		// 1. Send the filename and length to the receiver
		theOutstream.write((theFile.getName()+"::"+fileLength).getBytes());
		theOutstream.flush();

		//System.out.println(" -- Waiting for OK from the receiver");
		length = 0;
		while (length <= 0)
		{
	    	length = theInstream.read(buffer);
	    	if (length>0) initReply = (new String(buffer, 0, length));
		}
	
		currentPos = 0;

		//send file
		if (initReply.equals("OK"))
	    {
			//System.out.println("  -- Got OK from receiver - sending the file ");

			
			while (currentPos<fileLength)
			{
		   		bytesRead = fileReader.read(msg);
		    	theOutstream.write(msg);
		    	theOutstream.flush();
		    //System.out.println("Bytes read: "+bytesRead);
		    	currentPos = currentPos + bytesRead;
		    	//System.out.println(currentPos);
			}	
			System.out.println("File transfer complete!");
	    }
		else
			{System.out.println("  -- Recieved something other than OK... exiting");}
    }

	public static void main(String[] args) throws Exception
	{
		if(args.length != 3) 
		{
			System.out.println("input error!");
			System.exit(1);
		}
		InetAddress address = InetAddress.getByName(args[0]);
		int port = Integer.parseInt(args[1]);
		File file = new File(args[2]);
		TCPClient client = new TCPClient(address, port);
		
		//long start = System.currentTimeMillis();
		client.sendFile(file);
		//long end = System.currentTimeMillis();
		//long delay = end - start;

		//System.out.println("The total delay time is");
		//System.out.println(delay);
	}
}