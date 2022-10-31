#include <SPI.h>
#include "SdFat.h"
#include <Wire.h>

#define SSID "red de prueba"   // change this to match your WiFi SSID  
#define PASS "pepepepe" // change this to match your WiFi password  
#define PORT "80"      // using port 80 by default
#define DEBUG true
#define BUFFER_SIZE 1024 
char buffer[BUFFER_SIZE];  

int resto = 0;
unsigned long cantidad_paquetes = 0; 
boolean enviar = false;
char str3[] = "archivo.txt";
int cuenta = 0;
int cuenta2 = 1;
byte inByte;



// SD chip select pin
const uint8_t chipSelect = 10;
// file system
SdFat SD;
// test file
SdFile file;

#define LED             9   
#define PULSADOR1       2

byte datito;

File webFile, CSS_file;
String webpage;
// By default we are looking for OK\r\n  
char OKrn[] = "OK\r\n";  
//byte wait_for_esp_response(int timeout, char* term=OKrn) {  
//  unsigned long t=millis();  
//  bool found=false;  
//  int i=0;  
//  int len=strlen(term);  
//  // wait for at most timeout milliseconds  
//  // or if OK\r\n is found  
//  while(millis()<t+timeout) {  
//    if(Serial2.available()) {  
//      buffer[i++]=Serial2.read();  
//      if(i>=len) {  
//        if(strncmp(buffer+i-len, term, len)==0) {  
//          found=true;  
//          break;  
//     }  
//    }  
//   }  
//  }  
//  buffer[i]=0;  
//  Serial.print(buffer);  
//  return found;  
//}  


void setup()
{
  Serial.begin(115200);

  pinMode(LED,OUTPUT);
  digitalWrite(LED,HIGH);
  delay(200);    
  digitalWrite(LED,LOW);

  Serial.println(F("AT+CWMODE=3"));
  delay(200);
  Serial.println(F("AT+CWDHCP=2,1"));
  delay(200);
  Serial.println(F("AT+CIPMUX=1"));
  delay(200);
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
  delay(1000);
  Serial.println("AT+CIPSERVER=1,80"); // turn on server on port 80
  delay(1000);
  //Serial.println(F("ATE0"));
  delay(500);
  if (!SD.begin(chipSelect, SD_SCK_MHZ(50))) {
     digitalWrite(LED,HIGH);
  }
}

void loop()


{
  while (Serial.available() > 0) {
  //if(Serial.available()) // check if the esp is sending a message {
    //if (Serial.find("+IPD,")) {
    datito = Serial.read();
    if ( datito == ':') {        
        digitalWrite(LED,HIGH);
        delay(1000);
        digitalWrite(LED,LOW);
        String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n ";   // 51 caracteres
        String encabezado2 = "HTTP/1.1 206 OK\r\nContent-Type: text/html\r\n\r\n ";   // 51 caracteres
        String cipSend = "AT+CIPSEND=";
        cipSend += "0";
        cipSend += ",";
//     cipSend +=(encabezado.length() + 2);
     //cipSend += "112";
     //cipSend +="\r\n";

//     sendData(cipSend,1000,DEBUG);
//     sendData(webpage,1000,DEBUG);

//     Serial.println(cipSend);
//     delay(1000);
//
//     Serial.println(encabezado);
//     delay(500);
      File file;
      file.open(str3, O_READ);    

//      Serial.print(F("AT+CIPSEND=0,"));
//      Serial.println(encabezado.length()+2); 
     // Serial.println(encabezado.length() + 2);
     int tamanio = file.size();
     if (tamanio <= 1997)  {                        // 2048 - 51 = 1997 
          cipSend +=(encabezado.length() + file.size());
          Serial.println(cipSend);
          delay(2500);
          Serial.print(encabezado);
     }
     else {
          Serial.println(cipSend);
          delay(2500);
          Serial.print(encabezado2);
          cipSend += 2048; 
     }
     int tamanio_1er_paquete = (2047 - (encabezado.length()));


//      while (file.available()) {                      // mientras no se haya llegado al final
//          datito = file.read();
//          Serial.write(datito);
//      }
//     Serial.println("");
//     Serial.println("");
//     Serial.println("");     
//     delay(1500);     

     for (int i=0; i <= tamanio_1er_paquete; i++) {
          datito = file.read();
          Serial.write(datito);      
     }
     Serial.println("");
     Serial.println("");
     Serial.println("");     
     delay(1500);    



//     delay(1000);
//     Serial.print(F("+++"));
//      cantidad_paquetes = (file.size()-tamanio_1er_paquete)/2048;   // si el cociente es entero la división es entera
//      //wait_for_esp_response(1000);
//      delay(500);      
//      // enviar archivo, en paquetes de 2048 bytes por exigencias del ESP8266, con esperas entre paquete y paquete
//      Serial.println(F("AT+CIPSEND=0,2048"));
//      delay(500);      
//      while (file.available()) {                      // mientras no se haya llegado al final
//          datito = file.read();
//          Serial.write(datito);
//          if (cuenta == 2047){
//             cuenta = 0;
             Serial.print(F("+++"));
//             //wait_for_esp_response(1000);
             delay(500);
//             if (cuenta2 != cantidad_paquetes){
//                Serial.println(F("AT+CIPSEND=0,2048"));
//                cuenta2 = cuenta2 + 1;               
//                //wait_for_esp_response(1000); 
//                delay(500);
//             }else{
//                cuenta2 = 1;
//                resto = file.size() - (cantidad_paquetes * 2048);
//                Serial.print(F("AT+CIPSEND=0,"));
//                Serial.println(resto);                                 
//                //wait_for_esp_response(1000); 
//                delay(500);
//             }
//          }else{
//            cuenta = cuenta + 1;            
//          }              
//      }              


     Serial.println(F("AT+CIPCLOSE=0"));
     //Serial.println(connectionId);
     delay(500);
     
     digitalWrite(LED,HIGH);
     delay(200);
     digitalWrite(LED,LOW);
     delay(500);
     digitalWrite(LED,HIGH);
     delay(200);
     digitalWrite(LED,LOW);  
    break;
    }
  }
}


//String sendData(String command, const int timeout, boolean debug)
//{
//    String response = "";
//
//    Serial2.print(command); // send the read character to the Serial2
//    long int time = millis();
//    while( (time+timeout) > millis())
//    {
//      while(Serial2.available())
//      {
//        // The esp has data so display its output to the serial window 
//        char c = Serial2.read(); // read the next character.
//        response+=c;
//      }  
//    }
//
//    if(debug)
//    {
//      Serial.print(response);
//    }
//
//    return response;
//}
