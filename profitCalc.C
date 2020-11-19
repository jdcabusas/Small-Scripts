/******************************************************************************

                            Online C Compiler.
                Code, Compile, Run and Debug C program online.
Write your code in this editor and press "Run" button to compile and execute it.

*******************************************************************************/

#include <stdio.h>
#include <iostream>

int main()
{
    int initial = 5000;
    
    int years = 15;
    int monthlyAdd;
    int balance = initial;
    int contributions = initial;
    double percent;
    int count = 1;
    while(years > 0)
    {
        for(int i = 0; i < 12; i++)
        {
        balance = (balance*1.04) + 800;
        std::cout << balance;
        std::cout << "\n";
        contributions += 800;
        }
        
        years--;
        count++;
        
        std::cout << "\nYEAR:" << count - 1 << "\n";
        std::cout << "\nFINAL END YEAR BALANCE: " << balance << "\n"; 
        std::cout << "TOTAL CONTRIBUTION: " << contributions << "\n";
        percent = balance - contributions;
        percent = percent/contributions;
        percent = percent*100;
        printf("TOTAL GAIN: %g%\n\n", percent);
        //std::cout << "RETURN ON YEAR: " << percent << "% \n\n";
    
    }

    return 0;
}
