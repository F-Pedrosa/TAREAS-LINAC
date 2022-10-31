#include <SPI.h>
#include "SdFat.h"
#include <Wire.h>

#define SSID "nodoA1"   // change this to match your WiFi SSID  
#define PASS "pepepepe" // change this to match your WiFi password  
#define PORT "80"      // using port 80 by default
//#define DEBUG true
#define LED             9   
#define PULSADOR1       2

char buffer[128];
char OKrn[] = "OK\r\n";  
byte inByte;
String cipSend = "AT+CIPSEND=0,2048";

char buffer2[10];

// SD chip select pin
const uint8_t chipSelect = 10;
// file system
SdFat SD;
File file;


byte wait_for_esp_response(int timeout, char* term=OKrn) {  
  unsigned long t=millis();  
  bool found=false;  
  int i=0;  
  int len=strlen(term);  
  // wait for at most timeout milliseconds or if OK\r\n is found  
  while(millis()<t+timeout) {  
     if(Serial.available()) {  
        buffer[i++]=Serial.read();  
        if(i>=len) {  
           if(strncmp(buffer+i-len, term, len)==0) {  
              found=true;  
              break;  
           }  
        }  
     }  
  }  
  buffer[i]=0;  
  return found;  
}   

void setup()
{
  Serial.begin(115200);
  //Serial.begin(57600);
  // pitido inicial
  pinMode(LED,OUTPUT);
  digitalWrite(LED,HIGH);
  delay(200);    
  digitalWrite(LED,LOW);
  // setear al ESP8266

// setear al ESP8266 a 57600 (el arduino recibe mal a 115200)
  Serial.println(F("AT+UART_CUR=57600,8,1,0,0"));
  delay(500);
  Serial.end();
  Serial.begin(57600);
  delay(500);
  
  
  
  
  
  Serial.println(F("AT+CWMODE=3"));
  wait_for_esp_response(200);
  Serial.println(F("AT+CWDHCP=2,1"));
  wait_for_esp_response(200);
  Serial.println(F("AT+CIPMUX=1"));
  wait_for_esp_response(200);
  Serial.print(F("AT+CWSAP="));
  Serial.write(34);
  Serial.print(F("nodoA1"));
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.write(34);    //comilla  
  Serial.print(PASS);
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.println(F("5,3"));
  wait_for_esp_response(1000);
  Serial.println("AT+CIPSERVER=1,80"); // turn on server on port 80
  wait_for_esp_response(1000);
  if (!SD.begin(chipSelect, SD_SCK_MHZ(50))) {
     digitalWrite(LED,HIGH);
  }
}



const byte numChars = 150;
char receivedChars[numChars];

char cadenita[6];

boolean newData = false;
boolean finalizado = false;
static boolean recvInProgress = false;
static byte ndx = 0;
static byte indice = 0;
char rc;
boolean bandera = false;
//File outFile;


void loop() {
     File outFile;
     outFile = SD.open("test1.txt", FILE_WRITE);

     while (Serial.available() > 0) {
        rc = Serial.read();

//        if ((rc == 'i') && (newData == false)) {
//          newData = true;
//        }

//        if (newData){

            receivedChars[ndx] = rc;
            ndx++;
            if (ndx >= 149){
                newData = false;
                ndx = 0;

//                if (rc == '/'){
//                  bandera = true;
//                }
//
//                if (rc == ' ') {
//                  bandera = false;
//                }
//                
//                if (bandera == true){
//                  cadenita[indice] = rc;
//                  indice++;  
//                }
//
//                if (indice == 5){
//                  indice = 0;
//                }
              
                outFile.print(receivedChars);
                //outFile.print(cadenita);
                Serial.println(F("AT+CIPCLOSE=0"));
                while(Serial.available()){Serial.read();}
                delay(2000);
                digitalWrite(LED,HIGH);
                delay(200);
                digitalWrite(LED,LOW);
                outFile.close();
           // }
          }
   }
}

