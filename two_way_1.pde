/**************Two way half duplex radio link**************


 Station 1

achu@achuwilson.in
15/04/2012
*/

#include <SPI.h>
#include "nRF24L01.h"
#include "RF24.h"


// array to strore the data
byte my_string[100];
byte *stringptr=my_string;


// defines the pins other than the SPI bus ie,(CE,CSN)
RF24 radio(8,7);

// the transmitting pipe and receiving pipe
const uint64_t pipe1=0xF0F0F0F0E1LL;
const uint64_t pipe2=0xF0F0F0F0D2LL;

void setup(void)
{
  
  Serial.begin(57600);
  radio.begin();
     
     radio.openWritingPipe(pipe1);
    radio.openReadingPipe(1,pipe2);
    
  radio.startListening();
}

void loop(void)
{
    
  int i=0;
  int f=0;
  //RX section 
  if ( radio.available() )
    {
      bool done = false;
      while (!done)
      {
        // Fetch the payload, and see if this was the last one.
        done = radio.read( stringptr,sizeof(my_string));
      }
      
      while(!(my_string[i]=='\0'))
  {
    
  Serial.print(my_string[i]);
  i++;
  }
 i=0;
 while(i<100) // clear the buffer from previous data
{
 my_string[i]=0;
i++;
}
  
      
    }    
      
  //TX Section
  while(Serial.available() > 0) {
      
      my_string[i]=Serial.read();
      i++;
      f=1;
     }
       
       if(f==1)
       {
         radio.stopListening();
         bool ok = radio.write( stringptr, sizeof(my_string));
     /*    if (ok)
        Serial.println("ok\n\r");
      else
        Serial.println("failed\n\r");
       */ 
        i=0;
        while(i<100) // clear the buffer from previous data
{
 my_string[i]=0;
i++;
}

        
       radio.startListening(); 

       }
  
}
