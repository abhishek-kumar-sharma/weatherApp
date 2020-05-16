public class NewWrapper {

    public class myWrap
    {
        String name{get;set;}
        String clg{get;set;}
        Integer roll {get;set;}
        
        //imp 
        Account ac{get;set;}
        
    }
    
    public myWrap fun()
    {
        myWrap obj = new myWrap();
        obj.name ='abhishek';
        obj.clg='kiet';
        obj.roll=1212;
        return obj;
    }
    
}