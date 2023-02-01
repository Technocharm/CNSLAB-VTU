import java.util.*;

public class bellman {

	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		System.out.println("Enter the no of verices: ");
		int n = sc.nextInt();
		int a [][] = new int [n][n];
		System.out.println("Enter the adjacency matrix: ");
		for(int i=0;i<n;i++) {
			for(int j=0;j<n;j++) {
				a[i][j]=sc.nextInt();
			}
		}
		System.out.println("Enter the value of source: ");
		int s = sc.nextInt();
		int d[] = new int[n];
		for(int i=0;i<n;i++) {
			d[i]=999;
		}
		d[s]=0;
		for(int i=0;i<n;i++) {
			for(int j=0;j<n;j++) {
				for(int k=0;k<n;k++) {
					if (d[k]>d[j]+a[j][k]) {
						d[k]=d[j]+a[j][k];
					}
				}
			}
		}
		System.out.println("The distance from source to that vertex is : ");
		for(int i=0;i<n;i++) {
			System.out.printf("The distance from %d to %d is %d\n",s,i,d[i]);
		}
	}

}
