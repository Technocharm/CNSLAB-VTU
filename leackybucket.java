import java.util.*;

public class leackybucket {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.println("Enter the size of bucket: ");
		int s = sc.nextInt();
		System.out.println("Enter the output rate: ");
		int o = sc.nextInt();
		System.out.println("Enter the no of packets: ");
		int n = sc.nextInt();
		System.out.println("Enter the size of packets: ");
		int p[]= new int[n];
		
		for (int i=0;i<n;i++) {
			p[i]=sc.nextInt();
		}
		
		int i=0;
		int c=0;
		System.out.println("SizeOfPacketTaken"+" "+"CapacityOccupied"+"\t"+"Status"+"\t\t"+"RemainingInBuffer");
		while(i<n || c>0) {
			if (i<n && c+p[i]<s) {
				c+=p[i];
				System.out.println(p[i]+"\t\t\t"+c+"\t\t"+"Accepted"+"\t\t"+(c-o));
				c-=o;
			}
			else if(i<n && c+p[i]>s) {
				System.out.println(p[i]+"\t\t\t"+c+"\t\t"+"Rejected"+"\t\t"+Math.max((c-o),0));
				c=Math.max((c-o),0);
			}
			else {
				System.out.println("-"+"\t\t\t"+c+"\t\t"+"Nothing  "+"\t\t"+Math.max((c-o),0));
				c=Math.max((c-o),0);
			}
			i+=1;
		}
	}

}
