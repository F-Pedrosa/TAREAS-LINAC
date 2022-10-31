#include <SPI.h>
#include "SdFat.h"

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
  Serial.println(F("ATE0"));  //deshabilita el eco local
  delay(500);


  // para probar consumo en modo deep-sleep
  Serial.println(F("AT+GSLP=10000"));


//while(1)
//  {
//    Serial.println(F("AT+CWLIF"));
//    delay(2000);
//  }

}

void loop() {


}
