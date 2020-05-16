/*Write the above script in 10 line of code only: HINT: Use For loop Batprogram 8*/
global class BatProgram10 implements Schedulable {
   global void execute(System.SchedulableContext sc)
   {
       BatProgram8 bc8 = new BatProgram8();
        for(Integer i=0;i<60;i=i+5){  
            BatProgram9 bc9 = new BatProgram9();
            String jobId = System.schedule('Count no of contact in account'+i,'0 0 0/1 1/'+i+' * ? *',bc9);
        }
   }
}
/*
Execute anan...
BatProgram9 bc9 = new BatProgram9();

bc9.execute(null);*/