/*
Create a dataList that has 200 records and shows 10 records per page
Page Name -> VFProgram5
*/
public class PaginateContactControllerExt {
    
    public List<Contact> conList{get;set;}
    public Integer offset = 0;
    
    public PaginateContactControllerExt()
    {
        fetchData();
    }
    
    public void fetchData()
    {
        conList = [Select Name,Account.Name,MobilePhone,CreatedBy.name from Contact limit 10 OFFSET : offset];
        
        if(conList.size() > 0 )
        {
            System.debug('-------------------------------------->  Unable to load data');
        } 
        else
        {
            System.debug('------------------------>  Data loaded');
        } 
    }
    
    public PageReference next()
    {
        if(offset < 200)
        {
            offset+=10;
            conList = [Select Name,Account.Name,MobilePhone,CreatedBy.name from Contact limit 10 OFFSET : offset];
            if(offset>200)
            {
            offset=0;
            }
        }
       
        return null;
    }
    
    public PageReference previous()
    {
        if(offset > 0)
        { 
            offset-=10;
            conList = [Select Name,Account.Name,MobilePhone,CreatedBy.name from Contact limit 10 OFFSET : offset];
        }
        return null;
    }
    
    
    
}