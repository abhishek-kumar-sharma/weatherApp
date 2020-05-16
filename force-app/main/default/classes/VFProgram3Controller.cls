/* controller of vf page
 Page Name - VFProgram3
*/
public class VFProgram3Controller {
    public String keyword = null;
    public List<Account> accList{set;get;}
    
    public String getkeyword() 
    {
        return keyword;
    }
    public void setkeyword(String str)
    {
       keyword = str;
    }
    
    public PageReference searchCustom()
    {
        System.debug('--------------> ' +keyword);
        String newStr = '%'+keyword+'%';
        if(keyword !=null)
        {
            accList = [Select Name,Phone,BillingPostalCode,BillingCity,AnnualRevenue from Account where Name like : newStr];
        }
        System.debug('Account loaded------------> '+accList);
        return null;
    }
    
    
    
    
}