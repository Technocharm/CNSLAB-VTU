import java.util.*;
import java.net.*;
import java.io.*;

public class tcpserver {

	public static void main(String[] args) {
		try {
			ServerSocket ss = new ServerSocket(1300);
			Socket s = ss.accept();
			Scanner sc = new Scanner(s.getInputStream());
			String fn = sc.nextLine().trim();
			PrintStream ps = new PrintStream(s.getOutputStream());
			File f = new File(fn);
			if(f.exists()) {
				Scanner fs = new Scanner(f);
				while(fs.hasNextLine()) {
					ps.println(fs.nextLine());
				}
				fs.close();
			}
			else {
				System.out.println("File doesn't exist");
			}
			System.in.read();
			s.close();
			ss.close();
			
		}catch(IOException e){
			System.out.println(e.getMessage());
		}
	}
}
