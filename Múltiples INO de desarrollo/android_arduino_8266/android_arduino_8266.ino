#include <SPI.h>
#include "SdFat.h"

//#include <SoftwareSerial.h>

//SoftwareSerial mySerial(3,4); // RX, TX

// SD chip select pin
const uint8_t chipSelect = 10;
// file system
SdFat SD;
// test file
SdFile file;

#define LED             9   
#define PULSADOR1       2

byte val1;
char str3[] = "archivo.txt";
unsigned long previousMillis = 0; 

boolean enviar = false;

int cuenta = 0;
byte inByte;

char pass1[]="pepepepe";
char pass2[]="titotito";
char pass3[]="juanjuan";

void setup() {
  Serial.begin(115200);

  //mySerial.begin(57600);

  pinMode(LED,OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(PULSADOR1,INPUT_PULLUP );

  digitalWrite(LED,HIGH);
  delay(200);    
  digitalWrite(LED,LOW);
  
  digitalWrite(5,HIGH);
  delay(2);
  if (!SD.begin(chipSelect, SD_SCK_MHZ(50))) {
     digitalWrite(LED,HIGH);
  }

  //mySerial.println(F("Encendido"));

  // establecer seteos del módulo   
  Serial.println(F("AT+CWMODE=3"));
  delay(500);
  Serial.println(F("AT+CWDHCP=2,1"));
  delay(500);
  Serial.println(F("AT+CIPMUX=1"));
  delay(500);

  Serial.print(F("AT+CWSAP="));
  Serial.write(34);
  Serial.print(F("linac"));
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.write(34);    //comilla 
  
  Serial.print(pass1);        // esta es una de las contraseñas (MÍNIMO 8 CARACTERES!!!!), declaradas al principio
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.println(F("5,3"));
  delay(2000);
  
  Serial.println(F("ATE0"));
  delay(500);


  // para probar consumo en modo deep-sleep
  // Serial.println(F("AT+GSLP=10000"));


//while(1)
//  {
//    Serial.println(F("AT+CWLIF"));
//    delay(2000);
//  }

}

void loop() {
byte datito;


  // preguntar periódicamente si hay algún dispositivo conectado al esp8266 como access point
  Serial.println(F("AT+CWLIF"));
  delay(100);
  while (Serial.available() > 0)
  //if (Serial.available() > 0)
  {
   inByte = Serial.read();
   if (inByte == '1') {           // "1" por la IP del celular (que arranca en 192)
      digitalWrite(LED,HIGH);
      delay(200);    
      digitalWrite(LED,LOW); 
      
      enviar = true;
      break; 
   }
  }

//  val1 = digitalRead(2);
//  if (val1 == LOW) {


  if (enviar == true ){

      delay(6000);          // retardo largo para poder arrancar el servidor FTP en el celular
      
      enviar = false; 
      Serial.println(F("ATE1"));
      delay(500);    
      Serial.println(F("AT+CIPSERVER=1,1027"));    
      delay(500);    
      Serial.print(F("AT+CIPSTART=4,"));
      Serial.write(34);
      Serial.print(F("TCP"));
      Serial.write(34);
      Serial.print(F(","));
      Serial.write(34);
      Serial.print(F("192.168.4.2"));
      Serial.write(34);      
      Serial.println(F(",9090"));
      delay(5000);    
      Serial.println(F("AT+CIPSEND=4,11"));
      delay(1500);
      Serial.println(F("USER user"));
      delay(800);
      Serial.println(F("AT+CIPSEND=4,11"));      
      delay(800);
      Serial.println(F("PASS pass"));
      delay(800);
      Serial.println(F("AT+CIPSEND=4,22"));
      delay(800);
      Serial.println(F("PORT 192,168,4,1,4,3"));      
      //Serial.println("");
      delay(4000);
      Serial.println(F("AT+CIPSEND=4,19"));
      delay(2000);
      Serial.print(F("STOR "));
      Serial.print(F("archivo.txt"));    
      Serial.write(13);
      Serial.write(10);
      Serial.write(13);
      Serial.write(10);

      delay(1000);
      
      File file;
      file.open(str3, O_READ);
      Serial.print(F("AT+CIPSEND=0,")); 
      //Serial.println(F("AT+CIPSEND=0,2048")); 
      //enviar tamaño archivo como ASCII, termina con CRLF
      Serial.println(file.size());
              
      //delay(3000);
      delay(2000);
      
      // enviar archivo, en paquetes de 2048 bytes por exigencias del ESP8266, con esperas de 20 ms entre paquete y paquete
      while (file.available()) {                      // mientras no se haya llegado al final
          datito = file.read();
          Serial.write(datito);
//          cuenta = cuenta + 1;
//          if (cuenta == 2047){
//             cuenta = 0;
//             //delay(20);
//             Serial.println(F("AT+CIPSEND=0,2048"));
//             delay(1000); 
//          }
      }              
      
      // cerrar todo
      file.close();
     
      delay(500);      
      Serial.println(F("AT+CIPCLOSE=0"));
      delay(500);
      Serial.println(F("AT+CIPCLOSE=4"));
      delay(500);
      while(1){
        digitalWrite(LED,HIGH);
        delay(100);    
        digitalWrite(LED,LOW); 
        delay(400);    
      }
  }
  delay(2000);  
}
