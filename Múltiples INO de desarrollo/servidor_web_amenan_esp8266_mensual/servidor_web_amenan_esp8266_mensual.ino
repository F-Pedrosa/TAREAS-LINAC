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
String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";   // 50 caracteres, para caso finalizado
String encabezado3 = "HTTP/1.1 205 OK\r\nContent-Type: ";   // para enviar tiempo estimado de transmisión
String cipSend = "AT+CIPSEND=0,2048";

int resto = 0;
boolean primer_paquete = false;
boolean segundo_paquete = false;
boolean una_vez = true;
unsigned long tamanio = 0;
unsigned long posicion = 0; 
unsigned long cantidad_paquetes = 0;
int cuenta3 = 0;
int cuenta2 = 1; 

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
            if (receivedChars[22] == '9'){
              if (una_vez){
                primer_paquete = true;
                una_vez = false;
              }
            }
            if (!((primer_paquete == true) || (segundo_paquete == true))) {
                Serial.println(F("AT+CIPCLOSE=0"));
                delay(200);
                cuenta++;              
                mi_cadena+= receivedChars[22];
            }
        }  
    }      
  }
  
  if (cuenta == 4){
     mi_cadena+= ".txt";
     mi_cadena.trim();            // SACARLE LOS ESPACIOS, FUNDAMENTAL!!!!!!
     //Serial.println(mi_cadena);
     //Serial.println(mi_cadena.length());
     cuenta = 0;
     SD.chdir("mensual");                      
     mi_cadena.toCharArray(str3, 9) ;
     file.open(str3, O_READ);    
     tamanio = file.size();
     cantidad_paquetes = (tamanio - (2048 - encabezado.length())) / 2048;
     resto = tamanio - ((cantidad_paquetes+1) * 2048);     
     file.close();
  }
  
  if (primer_paquete){
      digitalWrite(LED,HIGH);
      delay(500);
      digitalWrite(LED,LOW);
      primer_paquete = false;
      segundo_paquete = true;
      String cipSend2 = "AT+CIPSEND=0,";
      int tiempo = tamanio/900;
      tiempo = tiempo + 3;
      encabezado3 += encabezado3 + tiempo;
      encabezado3 += "  \r\n\r\n";
      cipSend2 += encabezado3.length();
      Serial.println(cipSend2);
      wait_for_esp_response(2000);
      Serial.print(encabezado3);
      Serial.println("");
      Serial.println("");
      Serial.println("");
      wait_for_esp_response(1000);
      Serial.println(F("AT+CIPCLOSE=0"));
      wait_for_esp_response(500);
      delay(500);
  }

  if (segundo_paquete){
     delay(1700);
     segundo_paquete = false;
     file.open(str3, O_READ);    
      // 1er paquete del archivo, difiere de los otros paquetes en q al principio lleva el encabezado.
      Serial.println(cipSend);
      wait_for_esp_response(1100);
      Serial.print(encabezado);
      for (int i=0; i <= 2002; i++){
            Serial.write(file.read());
      }   
      Serial.println("");     // necesaria línea extra, motivo desconocido
      wait_for_esp_response(1100);
      // arranca los otros paquetes
      Serial.println(cipSend);
      wait_for_esp_response(1100);          
      while (file.available()) {                      // mientras no se haya llegado al final
         datito = file.read();
         Serial.write(datito);
         if (cuenta3 == 2047){
             cuenta3 = 0;
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
                cuenta3 = cuenta3 + 1;            
              }       
      }
      file.close();
      Serial.println("");
      wait_for_esp_response(1100);          
      Serial.println(F("AT+CIPCLOSE=0"));
      wait_for_esp_response(500);  
  }
}

