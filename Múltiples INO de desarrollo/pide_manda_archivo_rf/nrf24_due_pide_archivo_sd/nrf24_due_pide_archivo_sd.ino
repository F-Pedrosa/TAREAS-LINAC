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


// Este firm pedirá via RF a otra plaqueta un archivo con tramas que está en la SD de la misma

#include <SPI.h>
#include "RF24.h"
#include <SD.h>

#include <printf.h>

#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define PULSADOR          8        //

// Nombre del archivo donde se dejarán las tramas
char str[] = "tramas.txt";


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


char data[32]= "abcdefghijklmnopqrstvwyz0123456"; 

void setup(){

  pinMode(PULSADOR, INPUT_PULLUP);
  
  Serial.begin(9600);
  Serial.println(F("DUE pide y graba archivo"));

printf_begin();
 
  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();

  //Inicializar SD
  if (!SD.begin(SD_CS)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    return;
  }

Serial.println(F("conf nRF"));
  // Setup and configure radio

  radio.begin();

  radio.setPALevel(RF24_PA_LOW);  //SOLO POR LAS PRUEBAS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

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
  radio.printDetails();


Serial.println(F("terminó conf nRF"));

    
}

void loop(void) {

  int entrada = digitalRead(PULSADOR);
  byte pipeNo;  
/****************** Ping Out Role ***************************/

if (entrada == LOW) {
  delay(200);  // debounce
  Serial.println(F("PULSADO!!!!"));

  if (role == role_ping_out){                               // Radio is in ping mode

    radio.stopListening();                                  // First, stop listening so we can talk.      
    //if ( radio.write(&counter,1) ){                         // Send the counter variable to the other radio 
    data[2] = 220;   // cargar comando
    if (radio.write(&data,32) ){                         // enviar comando
//        if(!radio.available()){                             // If nothing in the buffer, we got an ack but it is blank
//        }else{      
//            while(radio.available() ){                      // If an ack with payload was received
//                //radio.read( &gotByte, 1 );                  // Read it, and display the response time
//            }
//        }
    
    }else{Serial.println(F("Sending failed.")); }          // If no ack response, sending failed
    //delay(1000);  // Try again later
  }
Serial.println(F("fin send"));
}

  

  radio.startListening();
  while( radio.available(&pipeNo)){              // Read all available payloads
     radio.read( &data, 32 );
     File outFile;
     outFile = SD.open(str, FILE_WRITE);
     if (!outFile) {
        Serial.println(F("No se pudo abrir el archivo"));
     return;
     }
     outFile.print(data);
     Serial.println(F("se escribió en SD"));
     // Cerrar archivo
     outFile.close();           
  }

}

