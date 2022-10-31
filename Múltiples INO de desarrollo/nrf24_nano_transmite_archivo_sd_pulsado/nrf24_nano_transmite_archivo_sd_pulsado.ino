/*
   Dec 2014 - TMRh20 - Updated
   Derived from examples by J. Coliz <maniacbug@ymail.com>
*/
/**
 * Example for efficient call-response using ack-payloads 
 * 
 * This example continues to make use of all the normal functionality of the radios including 
 * the auto-ack and auto-retry features, but allows ack-payloads to be written optionlly as well. 
 * This allows very fast call-response communication, with the responding radio never having to 
 * switch out of Primary Receiver mode to send back a payload, but having the option to switch to 
 * primary transmitter if wanting to initiate communication instead of respond to a commmunication. 
 */
 
#include <SPI.h>
#include "RF24.h"
#include <SD.h>

#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9 
#define PULSADOR          2


/****************** User Config ***************************/
/***      Set this radio as radio number 0 or 1         ***/
bool radioNumber = 0;

/* Hardware configuration: Set up nRF24L01 radio on SPI bus plus pins A1 & A2 */
RF24 radio(A1,A2);
/**********************************************************/
                                                                           // Topology
byte addresses[][6] = {"1Node","2Node"};              // Radio pipe addresses for the 2 nodes to communicate.

// Role management: Set up role.  This sketch uses the same software for all the nodes
// in this system.  Doing so greatly simplifies testing.  
typedef enum { role_ping_out = 1, role_pong_back } role_e;                 // The various roles supported by this sketch
const char* role_friendly_name[] = { "invalid", "Ping out", "Pong back"};  // The debug-friendly names of those roles

//role_e role = role_pong_back;                                              // The role of the current running sketch
role_e role = role_ping_out;
byte counter = 1;                                                          // A single byte to keep track of the data being sent back and forth


//char data[32]= "abcdefghijklmnopqrstvwyz0123456"; 
char data[32];
int i;

byte gotByte;                                           // Initialize a variable for the incoming response
int val;


void setup(){

  pinMode(PULSADOR,INPUT_PULLUP );

  pinMode(LED_ROJO, OUTPUT);
  // prender 2 segs el led rojo
  digitalWrite(LED_ROJO,HIGH);
  delay(2000);    //2 segs  
  digitalWrite(LED_ROJO,LOW);


  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();

  //Inicializar SD
  if (!SD.begin(SD_CS)) {
    //Serial.println("Card failed, or not present");
      digitalWrite(LED_ROJO,HIGH);
    // don't do anything more:
    return;
  }

 
  // Setup and configure radio

  radio.begin();

  //radio.setPALevel(RF24_PA_LOW);
  radio.setPALevel(RF24_PA_MAX);
  radio.enableAckPayload();                     // Allow optional ack payloads
  radio.enableDynamicPayloads();                // Ack payloads are dynamic payloads
  
  if(radioNumber){
    radio.openWritingPipe(addresses[1]);        // Both radios listen on the same pipes by default, but opposite addresses
    radio.openReadingPipe(1,addresses[0]);      // Open a reading pipe on address 0, pipe 1
  }else{
    radio.openWritingPipe(addresses[0]);
    radio.openReadingPipe(1,addresses[1]);
  }
  radio.startListening();                       // Start listening  
  
  radio.writeAckPayload(1,&counter,1);          // Pre-load an ack-paylod into the FIFO buffer for pipe 1
  //radio.printDetails();     // <--- para que esto funcione hay que declarar un include extra, ....
  radio.stopListening();
}


void loop(void) {

   val = digitalRead(PULSADOR);
   if (val==LOW){
      delay(200);
      // abrir archivo
      File dataFile = SD.open("TRAMAS.txt");                 
      if (dataFile) {                                        // si se pudo abrir el archivo
         while (dataFile.available()) {                      // mientras no se haya llegado al final
            for (i = 0; i < 31; i = i + 1) {
                data[i] = dataFile.read();                   // cargar arreglo de 32 bytes a enviar
                }
    
            //enviarlo via Nordic
            if (radio.write(&data,32) ){                         // Send the counter variable to the other radio 
                 if(!radio.available()){                             // If nothing in the buffer, we got an ack but it is blank
            }else{      
                while(radio.available() ){                      // If an ack with payload was received
                    radio.read( &gotByte, 1 );                  // Read it, and display the response time
                }
            }
        
        }else{// Serial.println(F("Sending failed."));
             }          // If no ack response, sending failed
        delay(8);
        }
      dataFile.close();
      }
   }

}
