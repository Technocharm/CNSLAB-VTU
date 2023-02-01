import java.util.*;

public class crc {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.println("Sender Side: ");
		System.out.println("Enter the length of generator: ");
		int ng=sc.nextInt();
		int g[] = new int[ng];
		System.out.println("Enter the generator: ");
		for(int i=0;i<ng;i++) {
			g[i]=sc.nextInt();
		}
		System.out.println("Enter the length of dataword: ");
		int n=sc.nextInt();
		int d[]= new int[n+ng-1];
		System.out.println("Enter the dataword: ");
		for(int i=0;i<n;i++) {
			d[i]=sc.nextInt();
		}
		int c[]=new int[n+ng-1];
		for(int i=0;i<n+ng-1;i++) {
			c[i]=d[i];
		}
		int t,j;
		for (int i=0;i<n;i++) {
			t=d[i];
			for (j=0;j<ng;j++) {
				d[i+j]=(g[j]*t)^d[i+j];
			}
		}
		for(int i=n-1;i<n+ng-1;i++) {
			c[i]=d[i];
		}
		System.out.println("The Codeword is: ");
		for(int i=0;i<n+ng-1;i++) {
			System.out.print(c[i]);
		}
		System.out.println();
		
		System.out.println("Reciever Side: ");
		System.out.println("Enter the Received data: ");
		for(int i=0;i<n+ng-1;i++) {
			d[i]=sc.nextInt();
		}
		for(int i=0;i<n;i++) {
			t=d[i];
			for(j=0;j<ng;j++) {
				d[i+j]=(g[j]*t)^d[i+j];
			}
		}
		t=0;
		for(int i=0;i<n+ng-1;i++) {
			t+=d[i];
		}
		if(t>0) {
			System.out.println("There is an Error!!!");
		}
		else {
			System.out.println("There is no Error :)");
		}
	}

}
