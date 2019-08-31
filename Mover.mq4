//+------------------------------------------------------------------+

//|                                                      Mover.mq4 |

//|                                                   JOSEPH CABUSAS |

//|                                             https://www.mql5.com |

//+------------------------------------------------------------------+

#property copyright "JOSEPH CABUSAS"

#property link      "https://www.mql5.com"

#property version   "1.00"

#property strict

 

 

int Magic = 201201; 

double Lots          = 0.01;

 

 

 

void MaRecentValues(double& ma[], int maPeriod)

  {

   // i is the index of the price array to calculate the MA value for.

   // e.g. i=0 is the current price, i=1 is the previous bar's price.

   int numValues = 10;

   for (int i=0; i < numValues; i++)

     {

      ma[i] = iMA(NULL,0,maPeriod,0,MODE_SMA,PRICE_CLOSE,i);

     }

  }

 

 

/******************************************************/ 

void OnTick()

  {

 

      int signal = 0;

 

   // Execute only on the first tick of a new bar, to avoid repeatedly

   // opening orders when an open condition is satisfied.

   if (OrdersTotal() >= 1) return(0);

  

   //---- get Moving Average values

 

   double shortMa[3];

   MaRecentValues(shortMa, 50);

 

   double longMa[3];

   MaRecentValues(longMa, 200);

  

   //---- buy conditions

   if (shortMa[2] < longMa[2]

      && shortMa[1] > longMa[1])

     {

      signal = 1;

     }

 

   //---- sell conditions

   if (shortMa[2] > longMa[2]

      && shortMa[1] < longMa[1])

     {

      signal = -1;

     }

 

/*====================================================================*/

     

        if (signal == 1)

     {

      Print("Buy signal");

      OrderSend(Symbol(),OP_BUY,Lots,Bid,30,

         0, // Stop loss price.

         0, // Take profit price.

         NULL,Magic,0,Green);

     }

 

   else if (signal == -1)

     {

      Print("Sell signal");

      OrderSend(Symbol(),OP_SELL,Lots,Ask,30,

         0,  // Stop loss price.

         0, // Take profit price.

         NULL,Magic,0,Red);

     }

    

   /***************************************************************/

 

     for(int i = 0; i < OrdersTotal(); i++){

       if(OrderSelect(i,SELECT_BY_POS)){

       if(OrderType() == OP_BUY){

         if(Bid-OrderOpenPrice()>Point*75){

         if(OrderStopLoss() < Bid - ma15*Point || OrderStopLoss() == 0)

        {

           

            if(Bid > shortMa)

            bool res=OrderModify(OrderTicket(),OrderOpenPrice(),shortMa,OrderTakeProfit(),0,Blue);

            if(Bid < shortMa)

            bool res=OrderModify(OrderTicket(),OrderOpenPrice(),Bid-100*Point,OrderTakeProfit(),0,Blue);

           

            

 

        }

        }

       

          }else if(OrderType() == OP_SELL){

         if(OrderOpenPrice()-Ask>Point*75){

         if(OrderStopLoss() > shortMa - Ask*Point || OrderStopLoss() == 0)

       

            if(Ask < shortMa)

            bool res=OrderModify(OrderTicket(),OrderOpenPrice(),shortMa,OrderTakeProfit(),0,Blue);

            if(Ask > shortMa)

            bool res=OrderModify(OrderTicket(),OrderOpenPrice(),Ask+100*Point,OrderTakeProfit(),0,Blue);

       

        }

      }

      }

     }

           

      

 }    

 

 

   
