// Firm para probar la rutina de adquisición de tensión de alimentación
#include "SdFat.h"

#define LED_ROJO          9
#define SD_CS             10        // alias del pin conectado a CS de la SD  

// file system
SdFat SD;

char str2[] = "alim.txt";

void grabar_datos_archivo(){
  char buffer1[3];
  char buffer2[8];
  File outFile;
//  obtenerFechaHora();
//
  outFile = SD.open(str2, FILE_WRITE);
//  sprintf(buffer1, "%02d", dia);
//  outFile.print(buffer1);
//  outFile.print(F("/"));  
//  sprintf(buffer1, "%02d", mes);
//  outFile.print(buffer1);
//  outFile.print(F("/"));  
//  outFile.print("20");
//  outFile.print(anio);
//  outFile.print(F(" "));
//  sprintf(buffer1, "%02d", hora);
//  outFile.print(buffer1);
//  outFile.print(F(":"));
//  sprintf(buffer1, "%02d", minuto);
//  outFile.print(buffer1);
//  outFile.print(F(":"));
//  sprintf(buffer1, "%02d", segundo);
//  outFile.print(buffer1);
//  outFile.print(F(" - "));

    int val1 = 0;
    float val = 0;

    val1 = analogRead(7);
    val = (val1 * 3.41)/896;

    outFile.print(val1);
    outFile.print("   ");
    outFile.println(val,2);
 
    // Cerrar archivo
    outFile.close();

}




void setup() {
  analogReference(EXTERNAL);
  pinMode(5, OUTPUT);
  digitalWrite(5,LOW);
  Serial.begin(57600);
  pinMode(LED_ROJO, OUTPUT);
  digitalWrite(LED_ROJO,HIGH);
  delay(300);    
  digitalWrite(LED_ROJO,LOW);

    //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();

  //Inicializar SD
  if (!SD.begin(SD_CS)) {
      digitalWrite(LED_ROJO,HIGH);
  }

}


void loop(void) {  
    delay(3000);  
    grabar_datos_archivo();
}

