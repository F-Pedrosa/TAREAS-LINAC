#include <SPI.h>
#include "SdFat.h"
#include <Wire.h>

#define SSID "red de prueba"   // change this to match your WiFi SSID  
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
  // pitido inicial
  pinMode(LED,OUTPUT);
  digitalWrite(LED,HIGH);
  delay(200);    
  digitalWrite(LED,LOW);
  // setear al ESP8266
  Serial.println("AT+IPR=57600");
  Serial.end();
  delay(1000);
  Serial.begin(57600);
  Serial.println(F("AT+CWMODE=3"));
  wait_for_esp_response(200);
  Serial.println(F("AT+CWDHCP=2,1"));
  wait_for_esp_response(200);
  Serial.println(F("AT+CIPMUX=1"));
  wait_for_esp_response(200);
  Serial.print(F("AT+CWSAP="));
  Serial.write(34);
  Serial.print(F("red de prueba"));
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
//  if (!SD.begin(chipSelect, SD_SCK_MHZ(50))) {
//     digitalWrite(LED,HIGH);
//  }
}



const byte numChars = 30;
char receivedChars[numChars];

boolean newData = false;
boolean finalizado = false;
static boolean recvInProgress = false;
static byte ndx = 0;
char rc;




void loop() {
//     while (Serial.available() > 0) {
//        rc = Serial.read();
//
//        if ((rc == 'i') && (newData == false)) {
//          newData = true;
//        }
//
//        if (newData){
//            receivedChars[ndx] = rc;
//            ndx++;
//            if (ndx >= 28){
//                newData = false;
//                ndx = 0;
//                Serial.print(receivedChars[22]);        // este está bien
//                Serial.print(' ');
////                switch (receivedChars[23]) {
////                  case 'M':
////                    Serial.print('5');
////                    break;
////                  case 'L':
////                    Serial.print('1');
////                    break;
////                  default:
////                    Serial.print('*');
////                }
//                Serial.print((uint8_t) receivedChars[23]);
//                Serial.print(' ');
////                switch (receivedChars[24]) {
////                  case 226:
////                    Serial.print('1');
////                    break;
////                  default:
////                    Serial.print('*');
////                    break;
////                }
//                Serial.print((uint8_t) receivedChars[24]);
//                Serial.print(' ');
//                
//                Serial.print((uint8_t) receivedChars[25]);
//                Serial.print(' ');
//
//                //Serial.println(receivedChars[25]);
//                receivedChars[26]='0';
//                receivedChars[27]='0';
//                receivedChars[28]='0';
//                receivedChars[29] = '\0';          
//                while(Serial.available()){Serial.read();}
//                Serial.println(F("AT+CIPCLOSE=0"));
//                while(Serial.available()){Serial.read();}
//                delay(2000);
//            }
//          }
//   }
//}









    //if (finalizado != true){
      recvWithStartEndMarkers();
      showNewData();
      //delay(3000);
      //finalizado = false;
    //}

//     if (finalizado == true) {
//            digitalWrite(LED,HIGH);                                   
//            Serial.print("Cadena: ");
//            //Serial.println(receivedChars);
//            Serial.print(receivedChars[23]);
//            Serial.print(receivedChars[24]);
//            Serial.print(receivedChars[25]);
//            Serial.println(receivedChars[26]);
//            delay(100);
//            digitalWrite(LED,LOW);                                   
//            Serial.println(F("AT+CIPCLOSE=0"));
//
//            while(Serial.available()){Serial.read();}
            
//            delay(500);            
//            Serial.println(F("AT+RST"));
//            Serial.println(F("AT+CWMODE=3"));
//            wait_for_esp_response(200);
//            Serial.println(F("AT+CWDHCP=2,1"));
//            wait_for_esp_response(200);
//            Serial.println(F("AT+CIPMUX=1"));
//            wait_for_esp_response(200);
//            Serial.print(F("AT+CWSAP="));
//            Serial.write(34);
//            Serial.print(F("red de prueba"));
//            Serial.write(34);    //comilla 
//            Serial.write(44);   //coma
//            Serial.write(34);    //comilla  
//            Serial.print(PASS);
//            Serial.write(34);    //comilla 
//            Serial.write(44);   //coma
//            Serial.println(F("5,3"));
//            wait_for_esp_response(1000);
//            Serial.println("AT+CIPSERVER=1,80"); // turn on server on port 80
//            wait_for_esp_response(1000);            
//            finalizado = false;
//     }                

}
    
void recvWithStartEndMarkers() { 
static boolean recvInProgress = false;
static byte ndx = 0;
char startMarker = ':';
char endMarker = '.';
char rc;
     while (Serial.available() > 0 && newData == false) {
        rc = Serial.read();
        if (recvInProgress == false) {
            if (rc != endMarker) {
                receivedChars[ndx] = rc;
                ndx++;
                if (ndx >= numChars) {
                    ndx = numChars - 1;
                }
            }
                  if (ndx== 184){
                    ndx = 0;
                    recvInProgress = true;
                  }
//            else {
//                //receivedChars[ndx] = '\0'; // terminate the string
//                recvInProgress = false;
//                ndx = 0;
//                newData = true;
//                finalizado = true;
            }
        }

//        else if (rc == startMarker) {
//            recvInProgress = true;
//        }
//    }
}

//void showNewData() {
//    if (newData == true) {
//        digitalWrite(LED,HIGH);                                   
//        Serial.print("Cadena: ");
//        //Serial.println(receivedChars);
//        if (receivedChars[3] = 63){
//          Serial.print('0');
//        }
//        if (receivedChars[4] = 13){
//          Serial.print('5');
//        }
//        if (receivedChars[5] = 84){
//          Serial.print('1');
//        }
//        if (receivedChars[6] = 67){
//          Serial.println('8');
//        }
//
////        Serial.print(receivedChars[28]);
////        Serial.print(receivedChars[29]);
////        Serial.print(receivedChars[30]);
////        Serial.println(receivedChars[31]);
//
//        Serial.println(receivedChars);
//
//                delay(500);
//        digitalWrite(LED,LOW);                                   
//        newData = false;
//        Serial.println(F("AT+CIPCLOSE=0"));
//    }
//}

while (Serial.available()>0) {
    inByte = Serial.read();
    if (inByte == ':') {
        inByte = Serial.read();
        if (inByte == 'G') {
          inByte = Serial.read();
          if (inByte == 'E') {
             inByte = Serial.read();
             if (inByte == 'T') {
                digitalWrite(LED,HIGH);                             
                }
             }
        }
    }
  }
}


