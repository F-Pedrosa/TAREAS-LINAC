#include <SPI.h>
#include "SdFat.h"
#include <Wire.h>

#define SSID "red de prueba"   // change this to match your WiFi SSID  
#define PASS "pepepepe" // change this to match your WiFi password  
#define PORT "80"      // using port 80 by default
//#define DEBUG true
#define LED             9   
#define PULSADOR1       2
#define BUFFER_SIZE 128

char str3[] = "0000.txt";
byte inByte;
byte datito;
String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";   // 50 caracteres, para caso finalizado
String encabezado3 = "HTTP/1.1 205 OK\r\nContent-Type: ";   // para enviar tiempo estimado de transmisión
String cipSend = "AT+CIPSEND=0,2048";

char buffer[BUFFER_SIZE];
char OKrn[] = "OK\r\n";  

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
  delay(100);    
  digitalWrite(LED,LOW); 
  Serial.println(F("AT+CWMODE=3"));
  wait_for_esp_response(100);
  Serial.println(F("AT+CWDHCP=2,1"));
  wait_for_esp_response(100);
  Serial.println(F("AT+CIPMUX=1"));
  wait_for_esp_response(100);
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
  wait_for_esp_response(500);
  Serial.println("AT+CIPSERVER=1,80"); // turn on server on port 80
  wait_for_esp_response(750);
  if (!SD.begin(chipSelect, SD_SCK_MHZ(50))) {
     digitalWrite(LED,HIGH);
  }
}


const byte numChars = 30;
char receivedChars[numChars];
String mi_cadena = "    ";

boolean newData = false;
boolean finalizado = false;
static boolean recvInProgress = false;
static byte ndx = 0;
byte cuenta = 0;

void loop(){
  while (Serial.available() > 0) {
    inByte = Serial.read();
    if ((inByte == 'i') && (newData == false)) {
      newData = true;
    }
    if (newData){
        receivedChars[ndx] = inByte;
        ndx++;
        if (ndx >= 28){
            newData = false;
            ndx = 0;
            Serial.println(F("AT+CIPCLOSE=0"));
            delay(200);
            cuenta++;
            mi_cadena+= receivedChars[22];
            if (primer_paquete) {
              
            }
        }  
    }      
  }
  if (cuenta >= 4){
     mi_cadena+= ".txt";
     mi_cadena.trim();            // SACARLE LOS ESPACIOS!!!!!!
     Serial.println(mi_cadena);
     //Serial.println(mi_cadena.length());
     cuenta = 0;
     SD.chdir("mensual");                      
     mi_cadena.toCharArray(str3, 9) ;
     file.open(str3, O_READ);    
     while (file.available()) {                      // mientras no se haya llegado al final
         datito = file.read();
         Serial.write(datito);
     }
     file.close();
  }
}

