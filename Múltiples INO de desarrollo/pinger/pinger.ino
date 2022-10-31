#include <SPI.h>
#include "RF24.h"
#include "SdFat.h"
#include "LowPower.h"

// SD chip select pin
const uint8_t chipSelect = 10;

// file system
SdFat SD;

// test file
SdFile file;

#define LED             9   
#define PULSADOR1       2
#define PULSADOR2       3

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
char str1[] = "lecturas_ponger1.txt";
char str2[] = "lecturas_ponger2.txt";
byte val1;
byte val2;

byte inByte;

byte cual_ponger = 1;
boolean bandera = true;
boolean primer_paquete = true;
boolean finalizado = false;

void conmutar_sd_nordic(boolean x){
  if (x==true){
      digitalWrite(5,HIGH);
      delay(2);
      if (!SD.begin(chipSelect, SD_SCK_MHZ(50))) {
          //Serial.print(F("ERROR DE SD"));
      }   
      radio.begin();
      radio.setPALevel(RF24_PA_LOW);
      if(radioNumber){
          radio.openWritingPipe(addresses[1]);        // Both radios listen on the same pipes by default, but opposite addresses
          radio.openReadingPipe(1,addresses[0]);      // Open a reading pipe on address 0, pipe 1
      }else{
          radio.openWritingPipe(addresses[0]);
          radio.openReadingPipe(1,addresses[1]);
      }
      radio.startListening();                       // Start listening  
  }else{
      digitalWrite(5,LOW);     
  }
}

void setup(){

  digitalWrite(4,HIGH);  
  pinMode(4, OUTPUT);

  //Serial.begin(9600);

  Serial.begin(115200);
  
  pinMode(5, OUTPUT);
  digitalWrite(5,LOW);  
  //delay(500);    //1 seg
  
  pinMode(PULSADOR1,INPUT_PULLUP );
  pinMode(PULSADOR2,INPUT_PULLUP );
  pinMode(LED,OUTPUT);

  // Initialize at the highest speed supported by the board that is
  // not over 50 MHz. Try a lower speed if SPI errors occur.
  if (!SD.begin(chipSelect, SD_SCK_MHZ(50))) {
    //Serial.print(F("ERROR DE SD"));
    digitalWrite(LED,HIGH);  
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

  digitalWrite(LED,HIGH);
  delay(500);    
  digitalWrite(LED,LOW);

}

void loop(void) {
byte datito;

  if (Serial.available() > 0) {
     inByte = Serial.read();  
     if (inByte=='a'){
       File file;
       Serial.println(F("=============================================================================="));       
         
       while (file.openNext(SD.vwd(), O_READ)) {
              while (file.available()) {                      // mientras no se haya llegado al final
                  datito = file.read();
                  if (datito != '@'){
                      Serial.write(datito);
                  }              
              }
              file.close();
              Serial.println("");
              Serial.println(F("=============================================================================="));       
              
     }
     Serial.println("@");
    }
  }


  val1 = digitalRead(2);
  val2 = digitalRead(3);
  if (val1 == LOW) {
      digitalWrite(LED,HIGH); 
      delay(100);
      digitalWrite(LED,LOW); 
      delay(200);              
      cual_ponger = 1;
      bandera = false;
      finalizado = false;
    }
  if (val2 == LOW) {
      digitalWrite(LED,HIGH); 
      delay(100);
      digitalWrite(LED,LOW); 
      delay(200);              
      cual_ponger = 2;
      bandera = false;     
      finalizado = false;
    }



  if (bandera== false){
      radio.stopListening();
      //enviar comando via Nordic
      if (cual_ponger == 1){
          data[0] = '1';    
      }
      else if (cual_ponger == 2){
          data[0] = '2';
      } 
      radio.write(&data,32);
      radio.startListening();
      delay(1);  
  }

  
  while( radio.available()){              // Read all available payloads
      bandera = true;
      radio.read(&data,32);
      if (primer_paquete == true){
        primer_paquete = false;
        if (cual_ponger == 1){
            digitalWrite(LED,HIGH); 
            delay(60);
            digitalWrite(LED,LOW); 
            delay(60);              
            digitalWrite(LED,HIGH); 
            delay(60);
            digitalWrite(LED,LOW); 
            delay(60);                      
            digitalWrite(LED,HIGH); 
            delay(60);
            digitalWrite(LED,LOW); 
            delay(60);                      
        }
        if (cual_ponger == 2){
            digitalWrite(LED,HIGH); 
            delay(350);
            digitalWrite(LED,LOW);          
        }
      }
      
     for (int i=0; i <= 31 ; i++){
          if ((data[i] == '@') && (finalizado == false)) {
              if (cual_ponger == 1){
              digitalWrite(LED,HIGH); 
              delay(60);
              digitalWrite(LED,LOW); 
              delay(60);              
              digitalWrite(LED,HIGH); 
              delay(60);
              digitalWrite(LED,LOW); 
              delay(60);                      
              digitalWrite(LED,HIGH); 
              delay(60);
              digitalWrite(LED,LOW); 
              delay(60);         
              finalizado = true;
              primer_paquete = true;            
              digitalWrite(4,LOW);
              digitalWrite(4,HIGH);                                            
              }
              if (cual_ponger == 2){
              digitalWrite(LED,HIGH); 
              delay(350);
              digitalWrite(LED,LOW); 
              finalizado = true;
              primer_paquete = true;
              digitalWrite(4,LOW);                                            
              digitalWrite(4,HIGH);
              }            
          }             
      }
      
      if (cual_ponger == 1){
          file.open(str1, O_RDWR | O_CREAT | O_AT_END);
            file.print(data);
            file.close();                                                                                         
      }
      else if (cual_ponger == 2){
               file.open(str2, O_RDWR | O_CREAT | O_AT_END);
            file.print(data);
            file.close();              
     }
    }


}

