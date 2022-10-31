// **** INCLUDES *****
#include "LowPower.h"
#include <SPI.h>
#include "SdFat.h"
//#include <Wire.h>

// file system
SdFat SD;
File file;

#define SD_CS         10              // #define SD_CS         4    PARA LA MEGA CON SU SHIELD       
#define LED_ROJO      9 
//#define SS_PIN             10       // ESTO ES SOLO NECESARIO EN LA MEGA CON EL SHIELD ETHERNET!!!!!
#define PULSADOR          2

// Use pin 3 as wake up pin
const int wakeUpPin = 3;

void wakeUp()
{
    // Just a handler for the pin interrupt.
}

void setup(){
    //analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
    Serial.begin(115200);
    pinMode(5, OUTPUT);
    digitalWrite(5,LOW);  
    pinMode(PULSADOR,INPUT_PULLUP ); 
    pinMode(LED_ROJO,OUTPUT);

//          // ESTO ES SOLO NECESARIO PARA LA MEGAR CON SHIELD ETHERNET
//          pinMode(SS_PIN, OUTPUT);
//          digitalWrite(SS_PIN, HIGH);
            //pinMode(LED_BUILTIN,OUTPUT);                  // sólo necesario en la MEGA!!!! OJO!!!
    
    digitalWrite(LED_ROJO,HIGH);
    delay(1000);    
    digitalWrite(LED_ROJO,LOW);
    
    //digitalWrite(LED_BUILTIN,LOW);                // sólo necesario en la MEGA!!!! OJO!!!
    
    // Configure wake up pin as input.
    // This will consumes few uA of current.
    pinMode(wakeUpPin, INPUT);
    digitalWrite(wakeUpPin,HIGH);
    
    pinMode(SD_CS,OUTPUT);
    // initializar SPI
    SPI.begin();
    if (!SD.begin(SD_CS)) {
       digitalWrite(LED_ROJO,HIGH);
    }
    //Serial.println(F("Iniciado"));
}

void loop() {
char inByte;
byte datito;

    // Allow wake up pin to trigger interrupt on low.
   attachInterrupt(1, wakeUp, LOW);
    
    LowPower.idle(SLEEP_FOREVER, ADC_OFF, TIMER2_OFF, TIMER1_OFF, TIMER0_OFF, SPI_OFF, USART0_ON, TWI_OFF);

    // Disable external pin interrupt on wake up pin.
    detachInterrupt(1); 
    delay(500);
    while (Serial.available() > 0) {Serial.read();}
    while (Serial.available() == 0) {Serial.read();}
    if (Serial.available() > 0) {
         inByte = Serial.read();
         while (Serial.available() > 0) {Serial.read();}
         if (inByte=='a'){
            file.open("full.txt", O_READ);
            while (file.available()) {                      // mientras no se haya llegado al final
                datito = file.read();
                Serial.write(datito);
            }
            file.close();
            Serial.print("#");
            Serial.println("");                         
            
            digitalWrite(LED_ROJO,HIGH);
            delay(100);    
            digitalWrite(LED_ROJO,LOW);
            delay(500);    
            digitalWrite(LED_ROJO,HIGH);
            delay(100);    
            digitalWrite(LED_ROJO,LOW);
            inByte=0;
         } else if (inByte=='i'){
            file.open("alim.txt", O_READ);
            while (file.available()) {                      // mientras no se haya llegado al final
                datito = file.read();
                Serial.write(datito);
            }
            file.close();
            Serial.print("@");
            Serial.println("");                         
            
            digitalWrite(LED_ROJO,HIGH);
            delay(100);    
            digitalWrite(LED_ROJO,LOW);
            delay(500);    
            digitalWrite(LED_ROJO,HIGH);
            delay(100);    
            digitalWrite(LED_ROJO,LOW);
            inByte=0;
         } else if (inByte=='b'){
            file.open("bita.txt", O_READ);
            while (file.available()) {                      // mientras no se haya llegado al final
                datito = file.read();
                Serial.write(datito);
            }
            file.close();
            Serial.print("%");
            Serial.println("");                         
            
            digitalWrite(LED_ROJO,HIGH);
            delay(100);    
            digitalWrite(LED_ROJO,LOW);
            delay(500);    
            digitalWrite(LED_ROJO,HIGH);
            delay(100);    
            digitalWrite(LED_ROJO,LOW);
            inByte=0;            
        } else if (inByte=='z'){
            digitalWrite(LED_ROJO,HIGH);
            SD.remove("full.txt");
            SD.remove("alim.txt");
            SD.remove("bita.txt");
            Serial.print("$");
            Serial.println("");                                     
            digitalWrite(LED_ROJO,LOW);
            inByte=0;
         }
    }    
}
