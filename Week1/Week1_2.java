package techM;
class BankAccount
{
	double bal;
	BankAccount(double bal)
	{
		this.bal=bal;
	}
	public synchronized void deposit(double amt)
	{
		if(amt>0)
			bal+=amt;
		System.out.println(Thread.currentThread().getName()+" "+"Deposited:"+amt+" "+"Balance:"+bal);

	}
	public synchronized void withdraw(double amt)
	{
		if(amt>0 & amt<bal)
		{
			bal-=amt;
			System.out.println(Thread.currentThread().getName()+" "+"Withdrew:"+amt+" "+"Balance:"+bal);
		}
	}
}
public class Week1_2 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		BankAccount account=new BankAccount(10000);
		Thread user1=new Thread(()->
	    {
			account.deposit(2000);
			account.withdraw(1000);
	    },"user1");
		Thread user2=new Thread(()->
		{
			account.withdraw(1000);
			account.deposit(2000);
		},"user2");
		
		user1.start();
		user2.start();
		
		try {
			user1.join();
			user2.join();
		}
		catch(InterruptedException e)
		{
		e.printStackTrace();
		}
		System.out.println("FinalBalance:"+account.bal);
				
	}

}
