public class Program22
{
 public static void oppClone()
 {
  List<OpportunityLineItem> oliList = [SELECT ID,OpportunityId,PricebookentryId FROM OpportunityLineItem WHERE OpportunityId!=null];
  system.debug(oliList); 
  List<ID>idList = new List<ID>();
  for(OpportunityLineItem oli :oliList )
  {
   idList.add(oli.OpportunityId);
  }
  
  Opportunity oppl = [SELECT ID,Name,CloseDate,StageName FROM Opportunity WHERE ID IN : idList and Name like 'krapy'];
  system.debug(oppl);
  
  List <OpportunityLineItem> OlClon= [SELECT ID,OpportunityId,UnitPrice,Quantity,PricebookentryId FROM OpportunityLineItem WHERE OpportunityId= :oppl.Id];//--use for get the opportunity that will be Copy

  Opportunity opp = new Opportunity();
  opp.Name=oppl.Name+'Clone';
  opp.CloseDate=oppl.CloseDate.addDays(30);
  opp.StageName=oppl.StageName;
  insert opp;
  
  system.debug(opp);
  List<OpportunityLineItem> Optln=new List<OpportunityLineItem>();
  for(OpportunityLineItem otl:Olclon)
  {
    OpportunityLineItem olie = new OpportunityLineItem();
    olie.PricebookEntryId=oliList[0].PricebookentryId; 
    olie.OpportunityId=opp.Id;
    olie.Quantity=otl.Quantity;
    olie.UnitPrice=otl.UnitPrice;
    Optln.add(olie);
  }
  insert Optln;
 }

}