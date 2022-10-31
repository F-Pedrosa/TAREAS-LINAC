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
  delay(200);    
  digitalWrite(LED,LOW);
  // setear al ESP8266
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
  if (!SD.begin(chipSelect, SD_SCK_MHZ(50))) {
     digitalWrite(LED,HIGH);
  }
  file.open(str3, O_READ);    
  tamanio = file.size();
  file.close();
  cantidad_paquetes = (tamanio - (2048 - encabezado.length())) / 2048;
  resto = tamanio - ((cantidad_paquetes+1) * 2048);
  primera_vez = true;
}


void loop(){
  while (Serial.available() > 0) {
    inByte = Serial.read();
    if ( inByte == ':') {        
        
        if (primera_vez){             // para que haga un pitido largo SOLAMENTE al comenzar la transmisión del archivo        
          digitalWrite(LED,HIGH);
          delay(500);
          digitalWrite(LED,LOW);
          primera_vez = false;
          segundo_paquete = true;
          String cipSend2 = "AT+CIPSEND=0,";
          int tiempo = tamanio/900;
          encabezado3 += encabezado3 + tiempo;
          encabezado3 += "  \r\n\r\n";
          cipSend2 += encabezado3.length();
          Serial.println(cipSend2);
          wait_for_esp_response(2000);
          Serial.print(encabezado3);
          Serial.println("");
          wait_for_esp_response(1000);
          Serial.println(F("AT+CIPCLOSE=0"));
          wait_for_esp_response(500);
          delay(500);
          break;        
        }
          file.open(str3, O_READ);    
          // 1er paquete del archivo, difiere de los otros paquetes en q al principio lleva el encabezado.
          Serial.println(cipSend);
          wait_for_esp_response(1100);
          Serial.print(encabezado);
          while (cuenta <= 2002){
                datito = file.read();
                Serial.write(datito);
                cuenta = cuenta + 1;
          }
          for (int i=0; i <= 2048; i++){
            Serial.print(" ");     // necesaria línea extra, motivo desconocido
          }
          wait_for_esp_response(1100);
          // arranca los otros paquetes
          cuenta = 0;
          Serial.println(cipSend);
          wait_for_esp_response(1100);          
          while (file.available()) {                      // mientras no se haya llegado al final
             datito = file.read();
             Serial.write(datito);
             if (cuenta == 2047){
                 cuenta = 0;
                 Serial.println("");
                 wait_for_esp_response(1000);
                 if (cuenta2 != cantidad_paquetes){
                    Serial.println(cipSend);
                    wait_for_esp_response(1100);
                    cuenta2 = cuenta2 + 1;               
                 }else{
                    cuenta2 = 1;
                    Serial.print(F("AT+CIPSEND=0,"));
                    resto = resto + encabezado.length();
                    Serial.println(resto);                                 
                    wait_for_esp_response(500); 
                }
             }else{
                    cuenta = cuenta + 1;            
                  }       
          }
          file.close();
          Serial.println("");
          wait_for_esp_response(1100);          
          Serial.println(F("AT+CIPCLOSE=0"));
          wait_for_esp_response(500);
        }
  }
}
