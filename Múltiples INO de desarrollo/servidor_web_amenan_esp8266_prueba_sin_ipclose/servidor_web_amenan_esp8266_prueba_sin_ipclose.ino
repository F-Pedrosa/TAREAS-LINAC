#include <SPI.h>
#include "SdFat.h"
#include <Wire.h>

#define SSID "red de prueba"   // change this to match your WiFi SSID  
#define PASS "pepepepe" // change this to match your WiFi password  
#define PORT "80"      // using port 80 by default
#define DEBUG true

int resto = 0;
unsigned long cantidad_paquetes = 0; 
boolean primera_vez = true;
boolean segundo_paquete = false;
char str3[] = "archivo.txt";
int cuenta = 0;
int cuenta2 = 1;
byte inByte;
byte datito;
unsigned long tamanio = 0;
unsigned long posicion = 0; 

String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";   // 50 caracteres, para caso finalizado
String encabezado2 = "HTTP/1.1 206 OK\r\nContent-Type: text/html\r\n\r\n";   // 50 caracteres, para cdo hay q mandar varios paquetes
String encabezado3 = "HTTP/1.1 205 OK\r\nContent-Type: ";   // para enviar tiempo estimado de transmisión

// SD chip select pin
const uint8_t chipSelect = 10;
// file system
SdFat SD;
// test file
//SdFile file;

File file;

#define LED             9   
#define PULSADOR1       2

#define BUFFER_SIZE 128
char buffer[BUFFER_SIZE];
char OKrn[] = "OK\r\n";  
byte wait_for_esp_response(int timeout, char* term=OKrn) {  
  unsigned long t=millis();  
  bool found=false;  
  int i=0;  
  int len=strlen(term);  
  // wait for at most timeout milliseconds  
  // or if OK\r\n is found  
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
  //Serial.print(buffer);  
  return found;  
}   

void setup()
{
  Serial.begin(115200);



  pinMode(LED,OUTPUT);
  digitalWrite(LED,HIGH);
  delay(200);    
  digitalWrite(LED,LOW);

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
  //Serial.println(F("ATE0"));
  //delay(500);
  if (!SD.begin(chipSelect, SD_SCK_MHZ(50))) {
     digitalWrite(LED,HIGH);
  }
}


void loop(){
  while (Serial.available() > 0) {
    inByte = Serial.read();
    if ( inByte == ':') {        
          String cipSend = "AT+CIPSEND=0,2048";
          file.open(str3, O_READ);    
          tamanio = file.size();
          Serial.println(cipSend);
          wait_for_esp_response(2000);
          Serial.print(encabezado);
          while (cuenta <= 2002){
                datito = file.read();
                Serial.write(datito);
                cuenta = cuenta + 1;
          }
          Serial.println("");     // necesaria línea extra, motivo desconocido
          wait_for_esp_response(1500);
          Serial.println(cipSend);
          wait_for_esp_response(1500);
          cuenta=0;       
          while (cuenta <= 2047){
                datito = file.read();
                Serial.write(datito);
                cuenta = cuenta + 1;
          }
          Serial.println("");
          wait_for_esp_response(1500);
          Serial.println(cipSend);
          wait_for_esp_response(1500);
          cuenta=0;       
          while (cuenta <= 2047){
                datito = file.read();
                Serial.write(datito);
                cuenta = cuenta + 1;
          }
          file.close();
          Serial.println("");
          wait_for_esp_response(1500);          
          Serial.println(F("AT+CIPCLOSE=0"));
          wait_for_esp_response(500);
        }
  }
}
