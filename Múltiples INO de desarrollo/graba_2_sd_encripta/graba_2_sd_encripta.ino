// Firmware para la prueba de grabar en dos tarjetas SD, con el archivo en la SD2 conteniendo la misma info que 
// la SD1, pero encriptada con el xxTEA.


#include <SPI.h>
#include "SdFat.h"
#include <xxtea-iot-crypt.h>

#define SD_CS             10
#define SD2_CS            3
#define LED_ROJO          9 
#define PULSADOR          2

SdFat SD;
File outFile;

//char buffer2[13];
//byte k = 1;


char nombre[13] = "00000001.txt";
char nombre_encrip[13] = "00000001.tea";  


void GrabarArchivoNormal(){
  outFile = SD.open(nombre, O_WRITE | O_CREAT | O_APPEND);
  if(!outFile){
    Serial.println(F("No se puede abrir el archivo"));
    return;
  }
  outFile.print(F("0000 AA/MM/DD  HH:MM:SS  16.70 ºC  52.10%    6 ..................\r\n"));    
  outFile.close();  
}

void GrabarArchivoEncriptado(){
  String encriptado;
  outFile = SD.open(nombre_encrip, O_WRITE | O_CREAT | O_APPEND);
  if(!outFile){
    Serial.println(F("No se puede abrir el archivo"));
    return;
  }
  encriptado = "0000 AA/MM/DD  HH:MM:SS  16.70 ºC  52.10%    6 ..................\r\n";
  encriptado = xxtea.encrypt(encriptado);
  Serial.println(encriptado);
  outFile.print(encriptado);    
  outFile.close();    
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

//  sprintf(buffer2, "%07d", k);      // agregarle los ceros iniciales al nombre de archivo
//  strcat(buffer2, ".txt");

xxtea.setKey("mi contrasenia");   
Serial.println(F("Listo"));
}

void loop(){
  if (digitalRead(PULSADOR)==LOW){
      digitalWrite(LED_ROJO, HIGH);
      delay(100);
      digitalWrite(LED_ROJO, LOW);
      delay(100);
      digitalWrite(SD2_CS, HIGH);      
      while(!SD.begin(SD_CS)){
        Serial.println(F("Error de tarjeta SD1!"));
        delay(1000);
      }
      GrabarArchivoNormal();
      Serial.println(F("Archivo grabado en SD1"));
      delay(2000);      
      digitalWrite(SD_CS, HIGH);
      while(!SD.begin(SD2_CS)){
        Serial.println(F("Error de tarjeta SD2!"));
        delay(1000);
      }
      GrabarArchivoEncriptado();
      Serial.println(F("Archivo grabado en SD2"));             
  }
}


