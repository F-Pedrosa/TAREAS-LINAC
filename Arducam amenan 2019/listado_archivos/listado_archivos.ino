// Firmware para prueba listado archivos
#include <SPI.h>
#include "SdFat.h"
#include "memorysaver.h"

#define SD_CS             10
#define LED_ROJO          9 
const int SPI_CS = 8;
#define PULSADOR          2
#define SSID "nodoT1"   // acá el nombre de la red wifi

SdFat SD;
File outFile;

char buffer2[13];
  
String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: image/jpeg\r\nContent-Length: ";
const String cipSend = "AT+CIPSEND=0,2048";

// macro para simplificar escritura (y ver si de paso se achica el uso de memoria y programa)
#define cerrar {Serial.println(F("AT+CIPCLOSE=0"));}


// ---------------------------------------------------------------------------


void setup(){
analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
Serial.begin(115200);
pinMode(SPI_CS,OUTPUT);
pinMode(LED_ROJO, OUTPUT);
digitalWrite(LED_ROJO, HIGH);
delay(500);
digitalWrite(LED_ROJO, LOW);
pinMode(PULSADOR, INPUT_PULLUP);
pinMode(SD_CS,OUTPUT);
Serial.println(F("Inicio"));
// initialize SPI:
SPI.begin();
//Initialize SD Card
while(!SD.begin(SD_CS)){
  Serial.println(F("Error de tarjeta SD!"));
  //digitalWrite(LED_ROJO, HIGH);
  delay(1000);
  }
Serial.println(F("Tarjeta SD detectada."));
}

void loop(){
  SD.chdir("imgs");
  if (Serial.available() > 0) {
    SD.ls("/imgs", LS_R);
    while (Serial.available() > 0) {Serial.read();} 
  }
}


