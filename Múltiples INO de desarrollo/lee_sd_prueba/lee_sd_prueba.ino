#include <SPI.h>
#include <SD.h>

const int chipSelect = 10;
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9         // alias del pin del led rojo
char inByte = 0;         // incoming serial byte


void setup() {
  pinMode(5, OUTPUT);
  digitalWrite(5,LOW);  

  
  Serial.begin(9600);
  pinMode(9,OUTPUT);
  digitalWrite(9,HIGH);  
  delay(50);
  digitalWrite(9,LOW);  



  
  // see if the card is present and can be initialized:
  if (!SD.begin(chipSelect)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    return;
  }
  Serial.println("Arrancó.");
  //Serial.println("");
  //Serial.println("");
    //digitalWrite(9,LOW);  
}

void loop() {
  
  if (Serial.available() > 0) {
    //digitalWrite(9,HIGH);  
      // get incoming byte:
      //inByte = Serial.read();
      //if (inByte=="b"){
      //    digitalWrite(9,HIGH);  
      //}
      //if (inByte=='a'){
        File dataFile = SD.open("TRAMAS#1.txt");                 
        if (dataFile) {                                        // si se pudo abrir el archivo
           while (dataFile.available()) {                      // mientras no se haya llegado al final
               Serial.write(dataFile.read());
               }
           }
        dataFile.close();
        while(1);     // lazo infinito
      //}
  }
}
