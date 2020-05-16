public class checkCloseDate {
	public static void pastCheck(List<Opportunity> oppList)
	{
				
		if(oppList.size()>0)
		{
						
			for(Opportunity op : oppList)
			{
				
				if(op.CloseDate < date.today())
				{
					op.addError(' Please enter a future closed date ');
				}
				else
				{
					System.debug('All right');
				}
			} 
		}
	}
    
}