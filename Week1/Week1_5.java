package techM;

public class Week1_5 {
	public static String revString(String str)
	{
		StringBuffer sb=new StringBuffer();
		for(int i=str.length()-1;i>=0;i--)
		{
			sb.append(str.charAt(i));
		}
		return sb.toString();
	}
	public static int countOccurences(String text,String sub)
	{
		int count=0;
		int j=0;
		while((j=text.indexOf(sub,j))!=-1)
		{
			count++;
			j+=sub.length();
		}
		return count;
	}
	public static String splitAndCapitalize(String s)
	{
		String[] str=s.split(" ");
		StringBuffer sb=new StringBuffer();
		for(int i=0;i<str.length;i++)
		{
			sb.append(Character.toUpperCase(str[i].charAt(0))+str[i].substring(1).toLowerCase());
			sb.append(" ");
		}
		return sb.toString();		
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String s="Rev the string";
		System.out.println(revString(s));
		System.out.println(countOccurences(s,"t"));
		System.out.println(splitAndCapitalize(s));
		
	}

}
