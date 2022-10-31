// Firmware para desencriptación
#include <SPI.h>
#include "SdFat.h"

#define SD_CS             8
#define LED_ROJO          9 
#define PULSADOR          2

SdFat SD;
File outFile;
unsigned long posicion2 = 0;
char nombre_decrip[13] = "decriptd.txt";
char buffer2[]="datos.dat";


void DecriptFile(){
  byte caracter;
  char decriptado;
  outFile = SD.open(buffer2, O_READ);
  if(!outFile){
    Serial.println(F("No se puede abrir el archivo"));
    return;
  }
  outFile.seek(posicion2);
  if (outFile.available()){
    caracter = outFile.read();
    if (caracter == 231){
      decriptado = 10;
    } else if (caracter == 232){
      decriptado = 13;
    } else if (caracter == 7){
      decriptado = 32;
    } else if (caracter == 4){
      decriptado = 45;
    } else if (caracter == 3){
      decriptado = 48;      
    } else {
      decriptado = caracter - 103;
    }
  }    
//  if (decriptado > 127){
//    decriptado = ' ';
//  }
  outFile.close();
  posicion2++;
  outFile = SD.open(nombre_decrip, O_WRITE | O_CREAT | O_APPEND);
  outFile.print(decriptado);
  outFile.close();    
}


void DecriptFile2Serial(){
  char caracter;
  char decriptado;
  outFile = SD.open(buffer2, O_READ);
  if(!outFile){
    return;
  }
  outFile.seek(posicion2);
  if (outFile.available()){
     caracter = outFile.read();
    if (caracter == 231){
      decriptado = 10;
    } else if (caracter == 232){
      decriptado = 13;
    } else if (caracter == 7){
      decriptado = 32;
    } else if (caracter == 4){
      decriptado = 45;
    } else if (caracter == 3){
      decriptado = 48;      
    } else {
      decriptado = caracter - 103;
    }
  }    
//  if (decriptado > 127){
//    decriptado = ' ';
//  }

  outFile.close();
  posicion2++;
  Serial.print(decriptado);
}

void beep(byte ct){
  for (byte i = 0; i < ct; i++){
      digitalWrite(LED_ROJO, HIGH);
      delay(100);
      digitalWrite(LED_ROJO, LOW);
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
digitalWrite(LED_ROJO, HIGH);
delay(500);
digitalWrite(LED_ROJO, LOW);
pinMode(PULSADOR, INPUT_PULLUP);
digitalWrite(PULSADOR, HIGH);

// initialize SPI:
SPI.begin();
//Initialize SD Card
while(!SD.begin(SD_CS)){
  //Serial.println(F("Error de tarjeta SD!"));
  digitalWrite(LED_ROJO, HIGH);
  delay(1000);
}
//Serial.println(F("Tarjeta SD detectada."));
//Serial.println(F("Listo"));
}

void loop(){
  byte dato;
  unsigned long tamanio=0;  

  if (Serial.available() > 0) {
      dato = Serial.read();
      if ( dato == 'a') {
          beep(1);
          outFile = SD.open(buffer2, O_READ);
          tamanio = outFile.size();
          outFile.close();
          while (posicion2 < tamanio){
            DecriptFile();
            Serial.print(F("*"));  
          }          
          posicion2 = 0;
          //Serial.println(F("Archivo desencriptado"));
          Serial.print(F("#"));
          beep(2);
      }
      if ( dato == 'b') {
          beep(1);
          outFile = SD.open(buffer2, O_READ);
          tamanio = outFile.size();
          outFile.close();         
          while (posicion2 < tamanio){
            DecriptFile2Serial();
          }          
          posicion2 = 0;
          beep(2);
          Serial.print(F("#")); 
      }
  }
}


