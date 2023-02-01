import java.util.*;
import java.math.BigInteger;
import java.security.*;

public class rsa {
	static BigInteger a,b,x,y,n,t;
	static int bitlength=64;
	
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		SecureRandom sr = new SecureRandom();
		
		a= BigInteger.probablePrime(bitlength,sr);
		b= BigInteger.probablePrime(bitlength,sr);
		n=a.multiply(b);
		t=a.subtract(BigInteger.ONE).multiply(b.subtract(BigInteger.ONE));
		
		x = BigInteger.probablePrime(bitlength/2, sr);
		
		while (x.gcd(t).compareTo(BigInteger.ONE)!=0 && x.compareTo(t)<0){
			x=x.add(BigInteger.ONE);
		}
		
		y= x.modInverse(t);
				
		System.out.println("a assigned as: " + a);
		System.out.println("b assigned as: " + b);
		System.out.println("x assigned as: " + x);
		System.out.println("y assigned as: " + y);
		
		System.out.println("Enter message: ");
		String msg = sc.next();
		
		String em = encrypt(msg);
		String dm = decrypt(em);
		System.out.println("Your encrypted message is : "+em);
		System.out.println("Your decrypted message is : "+dm);
	}
	
	static String encrypt(String msg) {
		return new BigInteger(msg.getBytes()).modPow(x,n).toString();
	}
	
	static String decrypt(String msg) {
		 BigInteger bi = new BigInteger(msg).modPow(y,n);
		 return new String(bi.toByteArray());
	}
}
