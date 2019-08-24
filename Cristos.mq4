//+------------------------------------------------------------------+
//|                                                         Cristos.mq4 |
//|                                                   JOSEPH CABUSAS |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "JOSEPH CABUSAS"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


int Magic = 201201;  
double Lots          = 0.04;

//Better returns at fixed values
/*int TakeProfitb       = 150; 
int TakeProfits       = 150;
int StopLossb         = 200;
int StopLosss         = 200;
*/

int flag1 = 0;





int OnInit()
  {

   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason)
  {

   
  }

void OnTick()
  {

  //This is NYC Time based from time on my broker's server. Yours may vary
  if(Hour() == 8){
  
  if(flag1 == 0)
  { 
  int orderRes =  OrderSend(Symbol(), OP_BUYSTOP, Lots, Bid+75*Point, 20, Bid-125*Point, /*Bid+TakeProfitb*Point*/0, "Buy Order", Magic, 0, clrGreen); 
  int orderRes2 =  OrderSend(Symbol(), OP_SELLSTOP, Lots, Ask-75*Point, 20, Ask+125*Point,/* Ask-TakeProfits*Point*/0, "Buy Order", Magic, 0, clrGreen); 
  flag1 = 1;
  }
   
  

 

      trailingStop();
 
  
      }
      
  if(Hour() == 7)
  {
   flag1 = 0;
 
  }

     
  }
 
//Trailing sop function. Essential give that system has no TP
void trailingStop(){  
   int TrailingStop=  150;

     for(int i = 0; i < OrdersTotal(); i++){
       if(OrderSelect(i,SELECT_BY_POS)){
       if(OrderType() == OP_BUY){
         if(Bid-OrderOpenPrice()>Point*100)
         if(OrderStopLoss() < Bid - TrailingStop*Point)
        {
            bool res=OrderModify(OrderTicket(),OrderOpenPrice(),Bid-TrailingStop*Point,OrderTakeProfit(),0,Blue);
        } 
          }else if(OrderType() == OP_SELL){
         if(OrderOpenPrice()-Ask>Point*100)
         if(OrderStopLoss() > Ask + TrailingStop*Point)
        {
            bool res=OrderModify(OrderTicket(),OrderOpenPrice(),Ask+TrailingStop*Point,OrderTakeProfit(),0,Blue);
        } 
       }
      }
     }
   }
