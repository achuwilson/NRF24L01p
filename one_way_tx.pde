/**********one way radio link************

 *********serial port transmitter********
achu@achuwilson.in
14/04/2012
*/

#include <SPI.h>
#include "nRF24L01.h"
#include "RF24.h"

// array to strore the serial data
byte my_string[100];
byte *stringptr=my_string;

// defines the pins other than the SPI bus ie,(CE,CSN)
RF24 radio(8,7);

//the transmittng pipe address 
const uint64_t pipe1=0xF0F0F0F0E1LL;

void setup(void)
{
  
  Serial.begin(57600);
  radio.begin();
     
     radio.openWritingPipe(pipe1);
    
  }

void loop(void)
{
  int i=0;
  int f=0;
//while serial data is available, read it into the buffer array
  while(Serial.available() > 0) {
      
      my_string[i]=Serial.read();
      i++;
      f=1;
     }
       

//now transmit the data
       if(f==1)
       {
         bool ok = radio.write( stringptr, sizeof(my_string));
         if (ok)
        Serial.println(" ok\n\r");
      else
        Serial.println("failed\n\r");
        
        int i=0;
while(i<100) // clear the buffer from previous data
{
 my_string[i]=0;
i++;
}
        
        

       }
  
}
