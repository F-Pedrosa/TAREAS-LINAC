// Firmware para desencriptación
#include <SPI.h>
#include "SdFat.h"

#define SD_CS             8
#define LED_ROJO          3 
#define PULSADOR          2
#define ZUMBADOR          9

SdFat SD;
File outFile;
char buffer2[]="datos.dat";

void beep(byte ct){
  for (byte i = 0; i < ct; i++){
      digitalWrite(ZUMBADOR, HIGH);
      delay(100);
      digitalWrite(ZUMBADOR, LOW);
      delay(100);
  }
}


// ---------------------------------------------------------------------------


void setup(){
analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO

Serial.begin(115200);
//set the CS as an output:
pinMode(SD_CS,OUTPUT);
pinMode(LED_ROJO, OUTPUT);
pinMode(ZUMBADOR, OUTPUT);
digitalWrite(ZUMBADOR, HIGH);
delay(500);
digitalWrite(ZUMBADOR, LOW);
// initialize SPI:
SPI.begin();
//Initialize SD Card
if (!SD.begin(SD_CS)){
  //Serial.println(F("Error de tarjeta SD!"));
  digitalWrite(ZUMBADOR, HIGH);
  delay(5000);
  digitalWrite(ZUMBADOR, LOW);  
}
//Serial.println(F("Tarjeta SD detectada."));
//Serial.println(F("Listo"));
}

void loop(){
  byte dato;
  char caracter;
  
  if (Serial.available() > 0) {
      dato = Serial.read();
      if ( dato == 'c') {
          beep(1);
          outFile = SD.open(buffer2, O_READ);
          while (outFile.available()){
            digitalWrite(LED_ROJO, HIGH);            
            caracter = outFile.read();
            Serial.print(caracter);
            digitalWrite(LED_ROJO, LOW);            
          }          
          outFile.close();
          beep(2);
          beep(2);          
          Serial.print(F("#")); 
          Serial.print(F("#")); 
          Serial.print(F("#")); 
      }
  }
}


