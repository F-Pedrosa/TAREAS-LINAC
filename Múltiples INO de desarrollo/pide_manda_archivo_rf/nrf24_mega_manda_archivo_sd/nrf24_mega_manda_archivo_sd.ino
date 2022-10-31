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



// este firm va a esperar un pedido desde la otra plaqueta y al llegar el mismo, lee un archivo desde la SD y lo transmite

 
#include <SPI.h>
#include <SD.h>
#include "RF24.h"

#include <printf.h>



//const int chipSelect = 10;
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define ZUMBADOR          2


/****************** User Config ***************************/
/***      Set this radio as radio number 0 or 1         ***/
bool radioNumber = 1;

/* Hardware configuration: Set up nRF24L01 radio on SPI bus plus pins 7 & 8 */
RF24 radio(7,8);
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

void setup(){

// esta línea por recomendaciones leídas en la web
  pinMode(53,OUTPUT);

  // testigo de arranque
  pinMode(ZUMBADOR, OUTPUT);
  digitalWrite(ZUMBADOR,HIGH);
  delay(100);
  digitalWrite(ZUMBADOR,LOW);  

  Serial.begin(9600);
  Serial.println(F("Enviador de archivo via nRF"));

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


  // Setup and configure radio

Serial.println(F("conf nRF"));

  radio.begin();

  radio.setPALevel(RF24_PA_LOW);                //SOLO POR LAS PRUEBAS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
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


/****************** Pong Back Role ***************************/

  if ( role == role_pong_back ) {
    byte pipeNo, gotByte;                          // Declare variables for the pipe and the byte received
    while( radio.available(&pipeNo)){              // Read all available payloads
      //radio.read( &gotByte, 1 );                   

      radio.read( &data, 32 );                   
      //Serial.println(gotByte);                                                   
      //Serial.println(data);
      radio.writeAckPayload(pipeNo,&gotByte, 1 );

      Serial.println(F("llego paquete RF"));

      if (data[2] == 220) {
          digitalWrite(ZUMBADOR,HIGH);        
          delay(200);
          digitalWrite(ZUMBADOR,LOW);              
          // si llegó comando desde la DUE, leer archivo y mandar
          radio.stopListening();                                  // First, stop listening so we can talk.      
          // abrir archivo
          File dataFile = SD.open("TRAMAS.txt");                 
          if (dataFile) {                                         // si se pudo abrir el archivo
              while (dataFile.available()) {                      // mientras no se haya llegado al final  
                int i;
                for (i = 0; i < 32; i = i + 1) {
                    data[i] = dataFile.read();                    // cargar arreglo de 32 bytes a enviar
                    }
                if (radio.write(&data,32) ){                         
                    if(!radio.available()){                             // If nothing in the buffer, we got an ack but it is blank
                    }else{      
                        while(radio.available() ){                      // If an ack with payload was received
                        radio.read( &gotByte, 1 );                      // Read it
                        }
                    }
                }else{Serial.println(F("Sending failed.")); }          // If no ack response, sending failed
              }
              dataFile.close();
        }

      // por lo que entiendo, devuelve en el AckPayload el byte recibido + 1                                                   
                                                   // Since this is a call-response. Respond directly with an ack payload.
      //gotByte += 1;                                // Ack payloads are much more efficient than switching to transmit mode to respond to a call
      //radio.writeAckPayload(pipeNo,&gotByte, 1 );  // This can be commented out to send empty payloads.
      

   }
 }

}
}
