// Firmware para la prueba de grabar en dos tarjetas SD

#include <SPI.h>
#include "SdFat.h"

#define SD_CS             10
#define SD2_CS            3
#define LED_ROJO          9 
#define PULSADOR          2

SdFat SD;
File outFile;

char buffer2[13];
byte k = 1;
  
void SaveToSDFile(){
//  //Construct a file name
//  //k = k + 1;
//  k = 1;
  sprintf(buffer2, "%07d", k);      // agregarle los ceros iniciales al nombre de archivo
  strcat(buffer2, ".txt");
  outFile = SD.open(buffer2, O_WRITE | O_CREAT );
  if(!outFile){
    Serial.println(F("No se puede abrir el archivo"));
    return;
  }
  outFile.println(F("ESTO ES SOLO UN STRING PARA PROBAR LA ESCRITURA EN DOS SDs"));    
  outFile.close();
  k += 1;
}

// ---------------------------------------------------------------------------


void setup(){
analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO

Serial.begin(115200);
//set the CS as an output:
pinMode(SD2_CS,OUTPUT);
pinMode(SD_CS,OUTPUT);
pinMode(LED_ROJO, OUTPUT);
digitalWrite(LED_ROJO, HIGH);
delay(500);
digitalWrite(LED_ROJO, LOW);
pinMode(PULSADOR, INPUT_PULLUP);
digitalWrite(PULSADOR, HIGH);

// initialize SPI:
SPI.begin();
////Initialize SD Card
//while(!SD.begin(SD_CS)){
//  //Serial.println(F("Error de tarjeta SD!"));
//  digitalWrite(LED_ROJO, HIGH);
//  delay(1000);
//}
//Serial.println(F("Tarjeta SD detectada."));

//  sprintf(buffer2, "%07d", k);      // agregarle los ceros iniciales al nombre de archivo
//  strcat(buffer2, ".txt");


Serial.println(F("Listo"));
}

void loop(){
  if (digitalRead(PULSADOR)==LOW){
      delay(400);      
      digitalWrite(LED_ROJO, HIGH);
      delay(100);
      digitalWrite(LED_ROJO, LOW);
      delay(100);
      digitalWrite(SD2_CS, HIGH);      
//      while(!SD.begin(SD_CS)){
//        Serial.println(F("Error de tarjeta SD1!"));
//        delay(1000);
//      }
//      SaveToSDFile();
//      Serial.println(F("Archivo grabado en SD1?"));
//      delay(2000);      
      digitalWrite(SD_CS, HIGH);
      while(!SD.begin(SD2_CS)){
        Serial.println(F("Error de tarjeta SD2!"));
        delay(1000);
      }
      SaveToSDFile();
      Serial.println(F("Archivo grabado en SD2?"));             
  }
}


