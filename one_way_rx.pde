/**********one way radio link************

 *********serial port receiver********
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

// the receiving pipe
const uint64_t pipe =0xF0F0F0F0E1LL;



void setup(void)
{
Serial.begin(57600);

  radio.begin();

 radio.openReadingPipe(1,pipe);
 radio.startListening();

}


void loop(void)
{



    if ( radio.available() )
    {
      bool done = false;
      while (!done)
      {
        // Fetch the payload, and see if this was the last one.
        done = radio.read( stringptr,sizeof(my_string));
      }
      int i=0;
      while(!(my_string[i]=='\0'))
  {
    
  Serial.print(my_string[i]);
  i++;
  }
 
}
}
