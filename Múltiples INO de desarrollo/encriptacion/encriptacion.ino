// Firmware para la prueba de encriptación

#include <SPI.h>
#include "SdFat.h"
#include <xxtea-iot-crypt.h>



#define SD_CS             10
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
//  sprintf(buffer2, "%07d", k);      // agregarle los ceros iniciales al nombre de archivo
//  strcat(buffer2, ".txt");
  sprintf(buffer2, "%07d", k);      // agregarle los ceros iniciales al nombre de archivo
  strcat(buffer2, ".tea");
  xxtea.setKey("mi contrasenia");      // Set the Password

  outFile = SD.open(buffer2, O_WRITE | O_CREAT | O_APPEND);
  if(!outFile){
    Serial.println(F("No se puede abrir el archivo"));
    return;
  }
//  outFile.println(F("ESTO ES SOLO UN STRING PARA PROBAR LA Encriptacion en arduino 1234567890"));    
  //String plaintext = F("Hi There we can work with this");
  String plaintext = F("Esto es solo un string para probar la encriptacion XXTEA en arduino...");
  String result = xxtea.encrypt(plaintext);
  result.toLowerCase(); // (Optional)
  outFile.print(result);    
  outFile.close();
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
  Serial.println(F("Error de tarjeta SD!"));
  //digitalWrite(LED_ROJO, HIGH);
  delay(1000);
}
Serial.println(F("Tarjeta SD detectada."));
Serial.println(F("Listo"));
}

void loop(){
byte dato;
char datillo;  
  if (Serial.available() > 0) {
      dato = Serial.read();
      if (dato == 'a') {
          digitalWrite(LED_ROJO, HIGH);
          delay(100);
          digitalWrite(LED_ROJO, LOW);
          delay(100);
          SaveToSDFile();
          Serial.println(F("Grabado archivo"));
      }
      if ( dato == 'b') {
          digitalWrite(LED_ROJO, HIGH);
          delay(100);
          digitalWrite(LED_ROJO, LOW);
          delay(100);
          String resultado;
          sprintf(buffer2, "%07d", k);      // agregarle los ceros iniciales al nombre de archivo
          strcat(buffer2, ".tea");
          xxtea.setKey("mi contrasenia");
          outFile.open(buffer2, O_READ);    
          while (outFile.available()) {                      // mientras no se haya llegado al final
             datillo = outFile.read();
             resultado += datillo;
          }   
          outFile.close();
          Serial.print(F("Encriptado: "));
          Serial.println(resultado);
          resultado = xxtea.decrypt(resultado);
          Serial.print(F("Desencriptado: "));
          Serial.println(resultado);
      }
  }
}


