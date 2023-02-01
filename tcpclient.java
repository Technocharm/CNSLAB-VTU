import java.util.*;
import java.io.*;
import java.net.*;

public class tcpclient {

	public static void main(String[] args) {
		try {
			Socket s = new Socket("localhost",1300);
			Scanner ss = new Scanner(s.getInputStream());
			Scanner cs = new Scanner(System.in);
			
			System.out.println("Enter the filename: ");
			String fn = cs.nextLine();
			PrintStream ps = new PrintStream(s.getOutputStream());
			ps.println(fn);
			while(ss.hasNextLine()) {
				System.out.println(ss.nextLine());
			}
			s.close();
			ss.close();
			cs.close();
		}
		catch(IOException e){
			System.out.println(e.getMessage());
		}

	}

}
