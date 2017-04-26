import java.io.*;
import java.net.*;
import java.util.*;

public class RDTServer {

    private final String TAG = "[" + RDTServer.class.getSimpleName() + "]";
    private DatagramSocket serverSocket;

    public RDTServer(int port) {
        try {
            serverSocket = new DatagramSocket(port);
        } catch (SocketException e) {
            e.printStackTrace();
        }
    }

    public void send(InetAddress recv, int port,byte[] message)
       throws IOException {
      
	//InetAddress recv = InetAddress.getByName(host);
       DatagramPacket packet = new DatagramPacket(message, message.length, recv, port);
       serverSocket.send(packet);
   }

    public void receiveFile() {
        ByteArrayOutputStream baos = null;


        try {
        byte[] buffer = new byte[1024];

        DatagramPacket initPacket = new DatagramPacket(buffer, buffer.length);
        serverSocket.receive(initPacket);

        String initString = "rec-"+new String(initPacket.getData(), 0, initPacket.getLength());
	    //System.out.println(initString);
        StringTokenizer t = new StringTokenizer(initString, "::");
	    String filename = t.nextToken();
        //System.out.println(filename);
	    int bytesToReceive = new Integer(t.nextToken()).intValue();
        int remain = bytesToReceive;

        send(initPacket.getAddress(), initPacket.getPort(), (new String("OK")).getBytes());


            baos = new ByteArrayOutputStream();

            int sequenceNum = 0;
            int previousSequenceNum = -1;
            boolean isLastPacket = false;

            while (!isLastPacket) {
                // create separate byte arrays for full packet bytes and file bytes (without header)
                byte[] packetBytes = new byte[1024];
                byte[] fileBytes = new byte[1021];

                // receive packet and retrieve file and header bytes from it
                DatagramPacket receivedPacket = new DatagramPacket(packetBytes, packetBytes.length);
                serverSocket.receive(receivedPacket);

                // retrieve sequence number from header
                sequenceNum = ((packetBytes[0] & 0xFF) << 8) + (packetBytes[1] & 0xFF);

                // retrieve last message flag
                isLastPacket = (packetBytes[2] & 0xFF) == 1;

                if (sequenceNum == (previousSequenceNum + 1)) 
                {
                    previousSequenceNum = sequenceNum;

                    for (int i=3; i<packetBytes.length; i++)
                     {
                        fileBytes[i-3] = packetBytes[i];
                    
                    }
                    
                    // write file bytes to file
                    baos.write(fileBytes, 0, Math.min(fileBytes.length, remain));
                    remain -= packetBytes.length - 3;
                    //System.out.println(fileBytes.length);

            //        System.out.println(TAG + " Received packet with sequence number: " + previousSequenceNum +" and flag: " + isLastPacket);
                } 
                else {
            //        System.out.println(TAG + " Expected sequence number: " + (previousSequenceNum + 1) + " but received " + sequenceNum);
                }

                // get port and address of sender and send acknowledgement (positive or negative, depending on the received packet)
                InetAddress senderIPAddress = receivedPacket.getAddress();
                int senderPort = receivedPacket.getPort();
                sendAcknowledgment(previousSequenceNum, senderIPAddress, senderPort);
            }   
            writeToFile(filename, baos.toByteArray());
            long endTime = System.currentTimeMillis();
            System.out.println("end time is " + endTime);
            System.out.println(TAG + " File received and saved successfully");

        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (serverSocket != null) {
                serverSocket.close();
            }
            if (baos != null) {
                try {
                    baos.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
            if (serverSocket != null) {
                serverSocket.close(); 
            }
        }
    }

    public void sendAcknowledgment(int sequenceNum, InetAddress address, int port) {
        byte[] acknowledgementPacketBytes = new byte[2];

        acknowledgementPacketBytes[0] = (byte) (sequenceNum >> 8);
        acknowledgementPacketBytes[1] = (byte) (sequenceNum);

        try {
            DatagramPacket acknowledgement = new  DatagramPacket(acknowledgementPacketBytes, acknowledgementPacketBytes.length, address, port);
            serverSocket.send(acknowledgement);
        } catch (IOException e) {
            e.printStackTrace();
        }
    //    System.out.println(TAG + " Sent acknowledgment with sequence number: " + sequenceNum);
    }
    
    private static void writeToFile(String filePath, byte[] bytes) {
        File file = new File(filePath);
        if (file.exists()) {
            file.delete();
        }

        FileOutputStream fos = null;

        try {
            fos = new FileOutputStream(file);
            fos.write(bytes);
            //System.out.println(bytes.length);

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if (fos != null) {
                    fos.close();
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static void main(final String[] args) {
        if(args.length != 1)
        {
            System.out.println("Input error!");
            System.exit(1);
        }
        RDTServer server = new RDTServer(Integer.parseInt(args[0]));
        server.receiveFile();        
    }
}
