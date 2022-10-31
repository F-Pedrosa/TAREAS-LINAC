// Firmware para la prueba de encriptación, más extensa, con vistas a usarse en el hardware de desencriptado específico

// Tamaño máximo de string a encriptar, 70 caracteres (máximo bloque a ser leído del archivo original),
// tamaño del string encriptado , 144 caracteres (máximo bloque a ser leído del archivo encriptado)


#include <SPI.h>
#include "SdFat.h"
#include <xxtea-iot-crypt.h>


#define SD_CS             10
#define LED_ROJO          9 
#define PULSADOR          2

SdFat SD;
File outFile;

char nombre[13] = "00000001.txt";
char nombre_encrip[13] = "00000001.tea";  
char nombre_decrip[13] = "decriptd.txt";
uint32_t posicion = 0;
uint32_t posicion2 = 0;



void EncriptFile(){
  char caracter;
  String encriptado;
  
  xxtea.setKey("mi contrasenia");      // Set the Password  
  outFile = SD.open(nombre, O_READ);
  if(!outFile){
    Serial.println(F("No se puede abrir el archivo"));
    return;
  }
  outFile.seek(posicion);
  for (int i = 0; i <= 69; i++){
    caracter = outFile.read();
    encriptado += caracter;
  }
  outFile.close();
  posicion += 70;
  encriptado = xxtea.encrypt(encriptado);
  outFile = SD.open(nombre_encrip, O_WRITE | O_CREAT | O_APPEND);
  outFile.print(encriptado);      
  outFile.close();
}

void DecriptFile(){
  char caracter;
  String encriptado;  
  String decriptado;
  xxtea.setKey("mi contrasenia");      // Set the Password  
  outFile = SD.open(nombre_encrip, O_READ);
  if(!outFile){
    Serial.println(F("No se puede abrir el archivo"));
    return;
  }
  outFile.seek(posicion2);
  for (int i = 0; i <= 143; i++){
    caracter = outFile.read();
    encriptado += caracter;
  }
  outFile.close();
  posicion2 += 144;
  decriptado = xxtea.decrypt(encriptado);      
  outFile = SD.open(nombre_decrip, O_WRITE | O_CREAT | O_APPEND);
  outFile.print(decriptado);
  outFile.close();    
}

// ---------------------------------------------------------------------------


void setup(){
analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO

Serial.begin(57600);
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
  Serial.println(F("Error de tarjeta SD!"));
  delay(1000);
}
Serial.println(F("Tarjeta SD detectada."));
Serial.println(F("Listo"));
}


// =====================================================================================================================================



void loop(){
  byte dato;
  unsigned long tamanio=0;

  if (Serial.available() > 0) {
      dato = Serial.read();
      if (dato == 'a') {
          digitalWrite(LED_ROJO, HIGH);
          delay(100);
          digitalWrite(LED_ROJO, LOW);
          delay(100);
          outFile = SD.open(nombre, O_READ);
          tamanio = outFile.size();
          //Serial.println(tamanio);
          outFile.close();
          Serial.println(millis());
          while (posicion <= tamanio){
            EncriptFile();
            Serial.println(F(".")); 
            //Serial.println(posicion); 
          }
          Serial.println(millis());
          posicion = 0;
          Serial.println(F("Grabado archivo encriptado"));
      }

      if ( dato == 'b') {
          digitalWrite(LED_ROJO, HIGH);
          delay(100);
          digitalWrite(LED_ROJO, LOW);
          delay(100);
          outFile = SD.open(nombre_encrip, O_READ);
          tamanio = outFile.size();
          outFile.close();          
          Serial.println(millis());
          while (posicion2 < tamanio){
            DecriptFile();
            Serial.print(F("*"));  
          }          
          Serial.println(millis());
          posicion2 = 0;
          Serial.print(F("Grabado archivo desencriptado."));
      }
  }
}


