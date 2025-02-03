package techM;

import java.util.Scanner;

public class Week1_3 {

	public static void processInput()
	{
		Scanner sc=new Scanner(System.in);
		double num=Double.parseDouble(sc.nextLine());
		try {
		if(num==0)
		{
			throw new ArithmeticException();
		}
		double reciprocal=1/num;
		System.out.println("Reciprocal of the number "+num+": "+reciprocal);
		}
		
		catch(ArithmeticException ae)
		{
			System.out.println("Cannot divide by 0");
		}
		catch(NumberFormatException e)
		{
			System.out.println("Invalid input:Please Enter the valid Number");
		}
		finally
		{
			sc.close();
		}
		
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		processInput();

	}

}
