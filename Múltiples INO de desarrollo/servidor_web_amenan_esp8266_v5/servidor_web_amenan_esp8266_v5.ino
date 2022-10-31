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


int resto = 0;
unsigned long cantidad_paquetes = 0; 
boolean primera_vez = false;
boolean segundo_paquete = false;
char buffer2[10];

int cuenta = 0;
int cuenta2 = 1;
byte datito;

char str2[] = "tramas.txt";
char str3[9];

// SD chip select pin
const uint8_t chipSelect = 10;
// file system
SdFat SD;
File file;

unsigned long tamanio = 0;
unsigned long posicion = 0; 


String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";   // 50 caracteres, para caso finalizado
String encabezado3 = "HTTP/1.1 205 OK\r\nContent-Type: ";   // para enviar tiempo estimado de transmisión
String cipSend = "AT+CIPSEND=0,2048";

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
  primera_vez = true;
}



const byte numChars = 10;
char receivedChars[numChars];
boolean newData = false;
boolean una_vez = true;


void recvWithStartEndMarkers() {
    static boolean recvInProgress = false;
    static byte ndx = 0;
    char startMarker = '/';
    char endMarker = ' ';
    char rc;
     while (Serial.available() > 0 && newData == false) {
        rc = Serial.read();
        if (recvInProgress == true) {
            if (rc != endMarker) {
                receivedChars[ndx] = rc;
                ndx++;
                if (ndx >= numChars) {
                    ndx = numChars - 1;
                }
            }
            else {
                //receivedChars[ndx] = '\0'; // terminate the string
                recvInProgress = false;
                ndx = 0;
                newData = true;
            }
        }
        else if (rc == startMarker) {
              recvInProgress = true;
        }
    }
}

//void showNewData() {
//    if (newData == true) {
//        digitalWrite(LED,HIGH);
//        String cipSend2 = "AT+CIPSEND=0,";
//        encabezado += encabezado + receivedChars;
//        encabezado += " \r\n\r\n";
//        cipSend2 += encabezado.length();
//        Serial.println(cipSend2);
//        wait_for_esp_response(2000);
//        Serial.print(encabezado);
//        Serial.println("");
//        wait_for_esp_response(1000);
//        Serial.println(F("AT+CIPCLOSE=0"));
//        while(Serial.available()){Serial.read();}
//        delay(500);
//        digitalWrite(LED,LOW);
//        una_vez = true;
//        newData = false;
//    }
//}

void loop() {
    if (newData == false){
        recvWithStartEndMarkers();
    }

    if ((primera_vez) && (newData)){             // para que haga un pitido largo SOLAMENTE al comenzar la transmisión del archivo        
      newData = false;
      primera_vez = false;      
      digitalWrite(LED,HIGH);
      delay(500);
      digitalWrite(LED,LOW);

//      str3[0] = receivedChars[0];
//      str3[1] = receivedChars[1];
//      str3[2] = receivedChars[2];
//      str3[3] = receivedChars[3];
//        Serial.print(receivedChars[0]);
//        Serial.print(receivedChars[1]);
//        Serial.print(receivedChars[2]);
//        Serial.println(receivedChars[3]);
      
//      if (str3 == "0000"){
//         //str2 = 
//      }else{
        // cambiarse al directorio mensual
        SD.chdir("mensual");
//        str3[4] = '.';
//        str3[5] = 't';
//        str3[6] = 'x';
//        str3[7] = 't';
//        // si no existe el archivo mensual pedido...
//        if (SD.exists(str3) == false){
//          // enviar contenido con código que indique que no existe el archivo
//        }else{
          String nombre = "0518.txt";
          nombre.toCharArray(str3, 9) ;
          file.open(str3, O_READ);    
          tamanio = file.size();
          file.close();
          cantidad_paquetes = (tamanio - (2048 - encabezado.length())) / 2048;
          resto = tamanio - ((cantidad_paquetes+1) * 2048);
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
    }

    if ((segundo_paquete) && (newData)){
      segundo_paquete = false;
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
      Serial.println("");     // necesaria línea extra, motivo desconocido
      wait_for_esp_response(1100);
      // arranca los otros paquetes
      cuenta = 0;
//      Serial.println(cipSend);
//      wait_for_esp_response(1100);          
//      while (file.available()) {                      // mientras no se haya llegado al final
//         datito = file.read();
//         Serial.write(datito);
//         if (cuenta == 2047){
//             cuenta = 0;
//             Serial.println("");
//             wait_for_esp_response(1000);
//             if (cuenta2 != cantidad_paquetes){
//                Serial.println(cipSend);
//                wait_for_esp_response(1100);
//                cuenta2 = cuenta2 + 1;               
//             }else{
//                cuenta2 = 1;
//                Serial.print(F("AT+CIPSEND=0,"));
//                resto = resto + encabezado.length();
//                Serial.println(resto);                                 
//                wait_for_esp_response(500);
//                  file.close();
//                  Serial.println("");
//                  wait_for_esp_response(1100);          
//                  //Serial.println(F("AT+CIPCLOSE=0"));
//                  wait_for_esp_response(500); 
//            }
//         }else{
//             cuenta = cuenta + 1;            
//             }       
//      }
      file.close();
//      Serial.println("");
//      wait_for_esp_response(1100);          
      Serial.println(F("AT+CIPCLOSE=0"));
      wait_for_esp_response(500);
    }
}

