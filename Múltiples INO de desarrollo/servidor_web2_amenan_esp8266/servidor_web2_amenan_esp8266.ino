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
        if (primera_vez){             // para que haga un pitido largo SOLAMENTE al comenzar la transmisión del archivo        
          digitalWrite(LED,HIGH);
          delay(1000);
          digitalWrite(LED,LOW);
          primera_vez = false;
          segundo_paquete = true;
          String cipSend = "AT+CIPSEND=0,";
          file.open(str3, O_READ);    
          tamanio = file.size();
          file.close();
          int tiempo = tamanio/690;
          encabezado3 += encabezado3 + tiempo;
          encabezado3 += "  \r\n\r\n";
          cipSend += encabezado3.length();
          Serial.println(cipSend);
          wait_for_esp_response(2000);
          Serial.print(encabezado3);
          Serial.println("");
          Serial.println("");
          Serial.println("");
          wait_for_esp_response(1000);
          Serial.println(F("AT+CIPCLOSE=0"));
          wait_for_esp_response(500);
          delay(500);
          
          break;        
        }
        if (segundo_paquete = true){
          String cipSend = "AT+CIPSEND=0,";
          int tamanio_1er_paquete = (2047 - (encabezado.length()));   // ambos encabezados tiene el mismo tamaño
          file.open(str3, O_READ);    
          tamanio = file.size();
          file.close();
          if (tamanio <= 1999)  {                                     // 2048 - 50 = 1999 , archivo entra en un sólo paquete
              cipSend +=(encabezado.length() + tamanio);
              Serial.println(cipSend);
              wait_for_esp_response(2000);
              //delay(2500);
              Serial.print(encabezado);
              for (int i=0; i <= tamanio_1er_paquete; i++) {            // enviar archivo en un solo paquete
                  datito = file.read();
                  Serial.write(datito);      
              }
              Serial.println("");
              Serial.println("");
              Serial.println("");     
              wait_for_esp_response(1000);
              Serial.println(F("AT+CIPCLOSE=0"));
              wait_for_esp_response(500);
              // pitidos
              digitalWrite(LED,HIGH);
              delay(200);
              digitalWrite(LED,LOW);
              delay(500);
              digitalWrite(LED,HIGH);
              delay(200);
              digitalWrite(LED,LOW);          
              break;
          }
          else {          // archivo necesitará varios paquetes
              cantidad_paquetes = ((tamanio - tamanio_1er_paquete)/1999)+1;   // si el cociente es entero la división es entera        
              // enviar archivo, en paquetes por exigencias del ESP8266, con esperas entre paquete y paquete         
              if (cuenta2 <= cantidad_paquetes){
                  cuenta2 = cuenta2 + 1;               
                  cipSend += 2048;
                  Serial.println(cipSend);
                  wait_for_esp_response(1000);
                  Serial.print(encabezado2);
                  file.open(str3, O_READ);                                    
                  file.seekSet(posicion);
                  while (cuenta <= 1999){
                        datito = file.read();
                        Serial.write(datito);
                        cuenta = cuenta + 1;
                  }
                  cuenta = 0;
                  posicion = file.position();
                  file.close();
                  // por algún motivo, el envío de estos 2 CRLF se ha demostrado necesario.
                  Serial.println("");
                  Serial.println("");
                  wait_for_esp_response(700);
                  Serial.println(F("AT+CIPCLOSE=0"));        
                  wait_for_esp_response(500);
                  break;
              }else{
                  // este bloque es para el ÚLTIMO paquete del archivo
                  segundo_paquete = false;
                  cuenta2 = 1;
                  resto = ((tamanio - (cantidad_paquetes * 1999)) + encabezado.length()+ 2) ;
                  cipSend += resto;                
                  Serial.println(cipSend);
                  wait_for_esp_response(1000);
                  Serial.print(encabezado);
                  file.open(str3, O_READ);                                    
                  file.seekSet(posicion);
                  while (file.available()) {                      // mientras no se haya llegado al final
                        datito = file.read();
                        Serial.write(datito);
                  }
                  file.close();
                  posicion = 0;
                  // por algún motivo, el envío de estos 2 CRLF se ha demostrado necesario.
                  Serial.println("");
                  Serial.println("");
                  Serial.println("");
                  delay(1500);
                  Serial.println(F("AT+CIPCLOSE=0"));        
                  wait_for_esp_response(500);
                  // pitidos
                  digitalWrite(LED,HIGH);
                  delay(200);
                  digitalWrite(LED,LOW);
                  delay(500);
                  digitalWrite(LED,HIGH);
                  delay(200);
                  digitalWrite(LED,LOW);                                      
              }
              cuenta = 0;
          }     
      }
    }
  }
}
