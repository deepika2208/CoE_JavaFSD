package techM;
class Node
{
	int data;
	Node next;
	Node(int data)
	{
		this.data=data;
		this.next=null;
	}	
}
class LinkedList
{
	 Node head;
	public void appendNode(int data)
	{
		Node newnode=new Node(data);
		if(head==null)
			head=newnode;
		else
		{
			Node current=head;
			while(current.next!=null)
			{
				current=current.next;
			}
			current.next=newnode;
		}
	}
	public Boolean hasCycle(Node head)
	{
		if(head==null||head.next==null)
		{
			return false;
		}
		else
		{
			Node fast=head;
			Node slow=head;
			while(fast.next!=null && fast.next.next != null)
			{
				fast=fast.next.next;
				slow=slow.next;
				if(fast==slow)
					return true;
			}
		}
		return false;
	}
}
public class Week1_6 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		LinkedList ll=new LinkedList();
		ll.appendNode(1);
		ll.appendNode(2);
		ll.appendNode(3);
		ll.appendNode(4);
		System.out.println(ll.hasCycle(ll.head));
		ll.head.next.next=ll.head;
		System.out.println(ll.hasCycle(ll.head));
	}

}
