#include <SPI.h>
#include "RF24.h"
#include "SdFat.h"
#include "LowPower.h"

// SD chip select pin
const uint8_t chipSelect = 10;

// file system
SdFat SD;

// test file
SdFile file;

#define LED             9   


char str[] = "tramas.txt";
char str1[] = "tramas#1.txt";
char str2[] = "tramas#2.txt";


byte inByte;

void setup(){

  Serial.begin(57600);
  
  pinMode(5, OUTPUT);
  digitalWrite(5,LOW);  

  pinMode(LED,OUTPUT);

  // Initialize at the highest speed supported by the board that is
  // not over 50 MHz. Try a lower speed if SPI errors occur.
  if (!SD.begin(chipSelect, SD_SCK_MHZ(50))) {
    //Serial.print(F("ERROR DE SD"));
    digitalWrite(LED,HIGH);  
  }
  
  digitalWrite(LED,HIGH);
  delay(100);    //1 seg
  digitalWrite(LED,LOW);

}

void loop(void) {

  if (Serial.available() > 0) {
     inByte = Serial.read();  
     if (inByte=='a'){
         File file;
//         file = SD.open(str1, FILE_READ);
//         while (file.available()) {                      // mientras no se haya llegado al final
//              Serial.write(file.read());
//              }
//         file.close();

        // open next file in root.  The volume working directory, vwd, is root
        while (file.openNext(SD.vwd(), O_READ)) {
              file.printName(&Serial);
              Serial.println("");              
              while (file.available()) {                      // mientras no se haya llegado al final
                  Serial.write(file.read());
                  }
              file.close();
              Serial.println("");
              Serial.println(F("==================================================================================================================="));
            }
     }
  }



}

