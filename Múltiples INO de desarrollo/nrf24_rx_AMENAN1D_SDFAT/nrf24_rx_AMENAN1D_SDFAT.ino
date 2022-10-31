#include <SPI.h>
#include "RF24.h"
#include "SdFat.h"

// SD chip select pin
const uint8_t chipSelect = 10;

// file system
SdFat sd;

// test file
SdFile file;

#define LED             9   
#define PULSADOR        2

/****************** User Config ***************************/
/***      Set this radio as radio number 0 or 1         ***/
bool radioNumber = 1;

/* Hardware configuration: Set up nRF24L01 radio on SPI bus plus pins 7 & 8 */
RF24 radio(A1,A2);
/**********************************************************/
                                                                           // Topology
byte addresses[][6] = {"1Node","2Node"};              // Radio pipe addresses for the 2 nodes to communicate.

// Role management: Set up role.  This sketch uses the same software for all the nodes
// in this system.  Doing so greatly simplifies testing.  
typedef enum { role_ping_out = 1, role_pong_back } role_e;                 // The various roles supported by this sketch
const char* role_friendly_name[] = { "invalid", "Ping out", "Pong back"};  // The debug-friendly names of those roles
role_e role = role_pong_back;                                              // The role of the current running sketch

byte counter = 1;                                                          // A single byte to keep track of the data being sent back and forth

char data[32]; 
char str[] = "tramas.txt";
int val;

void setup(){

  pinMode(PULSADOR,INPUT_PULLUP );
  pinMode(LED,OUTPUT);

  // Initialize at the highest speed supported by the board that is
  // not over 50 MHz. Try a lower speed if SPI errors occur.
  if (!sd.begin(chipSelect, SD_SCK_MHZ(50))) {
    Serial.print(F("ERROR DE SD"));
  }

   
  // Setup and configure radio

  radio.begin();

  //radio.enableAckPayload();                     // Allow optional ack payloads
  //radio.enableDynamicPayloads();                // Ack payloads are dynamic payloads
  
  if(radioNumber){
    radio.openWritingPipe(addresses[1]);        // Both radios listen on the same pipes by default, but opposite addresses
    radio.openReadingPipe(1,addresses[0]);      // Open a reading pipe on address 0, pipe 1
  }else{
    radio.openWritingPipe(addresses[0]);
    radio.openReadingPipe(1,addresses[1]);
  }
  radio.writeAckPayload(1,&counter,1);          // Pre-load an ack-paylod into the FIFO buffer for pipe 1
  radio.startListening();                       // Start listening  
  //radio.printDetails();

    if (!file.open(str, O_CREAT | O_TRUNC | O_RDWR)) {
      Serial.print(F("ERROR DE ARCHIVO"));
    }
    file.close();

    digitalWrite(LED,HIGH);
    delay(1000);    //1 seg
    digitalWrite(LED,LOW);
  
  //radio.stopListening();
}

boolean bandera = false;

void loop(void) {

   byte gotByte;
   
   val = digitalRead(PULSADOR);
   if (val==LOW){
      radio.stopListening();
      delay(200);
      digitalWrite(LED,HIGH);
      //enviar comando via Nordic
      data[0] = '1';
      data[1] = '2';
      data[2] = '3';
      if (radio.write(&data,32) ){                         // Send the counter variable to the other radio 
           //if(!radio.available()){                             // If nothing in the buffer, we got an ack but it is blank
      }else{      
          //while(radio.available() ){                      // If an ack with payload was received
              //radio.read( &gotByte, 1 );                  // Read it, and display the response time
        //}
      }
     digitalWrite(LED,LOW);
     bandera = true;
     radio.startListening();
     delay(100);
   }

  //if (bandera == true){
     //bandera = false;
    byte pipeNo;                          // Declare variables for the pipe and the byte received  
    //radio.startListening();
    while( radio.available()){              // Read all available payloads
      //digitalWrite(LED,HIGH); 
      radio.read( &data, 32 );                   
      if (!file.open(str, O_RDWR | O_CREAT | O_AT_END)) {
         //Serial.print(F("ERROR DE ARCHIVO"));
        }
      file.print(data);
      file.close();                                                               
    }
   //digitalWrite(LED,LOW);              
  //}
}

