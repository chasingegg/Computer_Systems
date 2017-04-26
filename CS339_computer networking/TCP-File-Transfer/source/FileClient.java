import java.io.*;
import java.net.*;

public class FileClient{
  private Socket s;

  public FileClient(String host, String savepath, int port) {

    try {
      s = new Socket(host, port);
      receiveFile(savepath);
    } catch(Exception e) {
      e.printStackTrace();
    }
  }

  public void receiveFile(String savepath) throws IOException {
    BufferedReader inFromUser = new BufferedReader(new InputStreamReader(System.in));
    DataInputStream dis = null;
    DataOutputStream dos = null;
    String file;
    String original = savepath;

    while(true) {
      file = inFromUser.readLine(); //要接收的文件名
      //发送给server该文件名
      dos = new DataOutputStream(s.getOutputStream());
      dos.writeBytes(file + '\n');

      if(file.equals("esc")) break;
      System.out.println("request file...");

      //server发回文件
      dis = new DataInputStream(s.getInputStream());

      long len = dis.readLong();

      savepath = original;
      savepath += file;
      System.out.println("file length is " + len + "bytes  save file to " + savepath + '\n');
      FileOutputStream fileout = new FileOutputStream(savepath); 

      byte[] buf = new byte[4096];
      //int totalread = 0;
      //int remain = (int)len;
      int read = 0;
      int totalRead = 0;
      int remaining = (int)len;
      while((read = dis.read(buf, 0, Math.min(buf.length, remaining))) > 0) {
        totalRead += read;
        remaining -= read;
        System.out.println("read " + totalRead + " bytes.");
        fileout.write(buf, 0, read);
    }
      //fileout.flush();

      System.out.println("file transfer finish!\n");
     }
  }

  public static void main(String[] args) throws IOException{
    if(args.length == 1) {
      FileClient fs = new FileClient("localhost", args[0], 2680);
    }
    else {
      FileClient fc = new FileClient("localhost", "/Users/dimon/Desktop/", 2680);
    }


  }
}