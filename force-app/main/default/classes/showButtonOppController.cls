/*"Develop the logic which shows/ hides the custom button (Test),if the stage is won on opportunity button is 
shown and if not then not shown"

Program Name - VFProgram10*/

public class showButtonOppController {
    public List<Opportunity> oppList{set;get;}
    
    public showButtonOppController()
    {
        oppList = new List<Opportunity>();
        oppList = [select Name,StageName,CloseDate from Opportunity];
    }
    
}