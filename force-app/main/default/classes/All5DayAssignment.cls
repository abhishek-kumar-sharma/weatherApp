/*All five day assignment */
public class All5DayAssignment {
    
    public static void questionOne(Integer no_of_terms)
    {
        /*Print the series 1 , 4 , 8 , 32 , 64 , 256 , 512 , ....*/
        Integer a=1;
        System.debug('---------------> '+a);
        for(Integer i=1 ;i <= no_of_terms; i++ )
        {
            if(Math.mod(i,2) == 0)
            {
                a = a*2;
                System.debug('-------------> '+a);
            }
            else
            {
                a = a*4;
                System.debug('-------------> '+a);
            }
            
        }
    }
    
    public static void questionTwo(Integer no_of_terms )
    {
        /*1.3 , 1.31 , 1.313 , 1.3131 , 1.31313 , .....*/
        
        Decimal no = 1.0;
        System.debug('-----------> '+no);
        for(Integer i = 1; i <= no_Of_Terms ; i++)
        {
            if(Math.mod(i,2) == 0 )
            {
                no = no+(Math.pow(10,-i));
            }
            else
            {
                no = no+(3*(Math.pow(10,-i)));
            }
            System.debug('-----------> '+no);
        }
        
    }
    
    public static void questionThree()
    {
        /*522 , 502 , 492 , 472 , 462 , 442 , ...*/
        Integer no = 522;
        System.debug('--------->'+no);
        for(Integer i=20;i>1;i--)
        {
            if(Math.mod(i,2) == 0 )
            {
                no = no - 20;
                System.debug('--------->'+no);
            }
            else
            {
                no = no - 10;
                System.debug('--------->'+no);
            }
        }
    }
    
    public static void questionFour(Integer no)
    {
        /*"Print Factors of all the numbers. 
Example Input: 84
Output: Factors 2 , 3 , 4 , 6, 7, 12 , 21, 42  "*/
        
        if(no != 0 || no > 0)
        {
            for(Integer i=1;i<no ; i++)
            {
                if(Math.mod(no,i) == 0) 
                    System.debug('-----> ' +i);
            }
        }
        
    }
    
    public static void questionFive()//completed it
    {
        /*"Print all possible combinations of the digits as a number. Make sure it also runs for number with duplicate digits. 
Example Input: 7832
Output: [8732,3782,2873,... all possible combinations]"*/
        
        
    }
    
    public static void questionSix(Integer num)
    {
        /*"Take any number and Print its Units, Tens, hundreds, thousand etc. 
Example Input: 293,023
Output: 200,000    90,000     3,000    20    3"*/
        
        if(num != 0 )
        {
            Integer rem=0,temp=0,placeV = 1;
            while(num > 0 )
            {
                rem = Math.mod(num,10);
                temp = rem*placeV;
                System.debug('-----------> '+temp);
                placeV *= 10;
                num /= 10;
            }
        }
        
    }
    
    public static void questionSeven(Decimal num)
    {
        /*"Take any number and Print its Units, Tens, hundreds, thousand etc both in decimal and integer part. 
Example Input: 293.023
Output: 200  ,  90  ,   3  ,  .0  ,  .02  ,   .003"*/
        if(num != 0 )
        {
            Integer rem=0,rev=0;
            Integer numIntPart = Integer.valueOf(num);
            Decimal numDecPart = num - numIntPart;
           	questionSix(numIntPart);
           
        } 
    }
    
}