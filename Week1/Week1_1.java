package techM;

import java.util.HashMap;
import java.util.PriorityQueue;

class Task
{
	String id;
	String description;
	int priority;
	public Task(String id, String description, int priority) {
		super();
		this.id = id;
		this.description = description;
		this.priority = priority;
	}
	public String toString()
	{
		return "ID :"+id+" Description :"+description+" Priority :"+priority;
	}
}
class TaskManager
{
	PriorityQueue<Task> pq;
	HashMap<String,Task> hm;
	public TaskManager()
	{
		pq=new PriorityQueue<>((a,b)->Integer.compare(b.priority, a.priority));
		hm=new HashMap();
	}
	public void addTask(String id, String description, int priority)
	{
		if(hm.containsKey(id))
		{
			System.out.println("Task with id :"+id+" already exists");
			return;
		}
		Task task=new Task(id,description,priority);
		pq.add(task);
		hm.put(id,task);
	}
	public void removeTask(String id)
	{
		Task task=hm.get(id);
		if(!(task==null))
		hm.remove(task);
		pq.remove(task);
	}
	public Task getHighestPriorityTask()
	{
		return pq.peek();
	}
	
}
public class Week1_1 {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		TaskManager mg=new TaskManager();
		mg.addTask("1","testing",6);
		mg.addTask("2","developing",3);
		
		System.out.println(mg.getHighestPriorityTask());
		
	}

}
