import java.net.*;
import java.io.*;
import java.util.*;


public class TCPServer {
    int length;
    ServerSocket ss;
    Socket s;
    String receiveFilename, initString;
    byte[] buffer;
    FileOutputStream fileWriter;
    int bytesReceived, len, remain;
    InputStream theInstream;
    OutputStream theOutstream;

    public TCPServer(int port) throws Exception
    {
		ss = new ServerSocket(port);
		buffer = new byte[1024];	
	
		System.out.println("server start.. ready to receive file on port: "+port);
	
		s = ss.accept();	
		theInstream = s.getInputStream();
		theOutstream = s.getOutputStream();

		//get file name and length
		length = theInstream.read(buffer);
		initString = "rec-" + new String(buffer, 0, length); //define the result file name
		StringTokenizer t = new StringTokenizer(initString, "::");
		receiveFilename = t.nextToken();
		len = new Integer(t.nextToken()).intValue();
	
		System.out.println("The file will be saved as: " + receiveFilename);
		System.out.println("file length is: "+ len + " bytes");
	
		// send an reply to the client
		theOutstream.write((new String("OK")).getBytes());
	
	  	// receive the file
		fileWriter = new FileOutputStream(receiveFilename);
		remain = len; 
		while(bytesReceived < len)
	    {
			length = theInstream.read(buffer, 0, Math.min(buffer.length, remain));
			fileWriter.write(buffer, 0,  length);
			fileWriter.flush();
			bytesReceived = bytesReceived + length;
			remain -= length;
			//System.out.println(bytesReceived);
	    }
		long end = System.currentTimeMillis();
		System.out.println("end time is " + end);
	System.out.println("File transfer complete!");
    }   

	public static void main(String[] args) throws Exception
	{
		if(args.length != 1)
		{
			System.out.println("input error!");
			System.exit(1);
		}
		int port = Integer.parseInt(args[0]);
		new TCPServer(port);
	}
}