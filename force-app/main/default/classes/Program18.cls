public with sharing class Program18 {
	public static void addBin(){
	string str1='100101';
        string str2='0101101';
        integer binary1,binary2;
        binary1=integer.valueof(str1);
        binary2=integer.valueof(str2);
        integer i=0,remainder = 0;
        integer[] sum=new integer[20];

    while(binary1!=0||binary2!=0){
         sum[i++] =  Math.mod((Math.mod(binary1,10) +Math.mod(binary2,10) + remainder ),2);
         remainder = (Math.mod(binary1,10) + Math.mod(binary2,10) + remainder ) / 2;
         binary1 = binary1/10;
         binary2 = binary2/10;
    }

    if(remainder!=0)
         sum[i++] = remainder;

    --i;
    System.debug('Sum of two binary numbers: ');
    while(i>=0)
         System.debug(sum[i--]);
	
	}
}