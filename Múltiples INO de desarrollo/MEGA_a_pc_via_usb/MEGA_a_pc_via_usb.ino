// Firm para leer los datos de la tarjeta, adquiridos de los sensores, a través de la conexión Serial/USB
// probando en una MEGA2560 con shield ethernet más SD

#include <SPI.h>
#include "RF24.h"
#include "SdFat.h"
//#include "LowPower.h"
#include <Wire.h>
// librerías para usar el sensor de humedad
#include <TroykaDHT.h>
#include <Adafruit_BMP085.h>

// file system
SdFat SD;
File file;

const char CONSTANTE[3] = "T1";
#define PASS "pepepepe" // esta es la contraseña para la misma 
#define SD_CS             4        // alias del pin conectado a CS de la SD  

#define SS_PIN             10

#define LED_ROJO          9 
#define PULSADOR          2
#define BATA1             7
#define BATA2             6

Adafruit_BMP085 bmp;
DHT dht(A0, DHT22);

const float CONSTANTE_PULSADO = 0.3;
// dirección en el bus I2C del RTC
const int DS3231 = 0x68;

// Inicializar variables de fecha y hora
byte segundo = 0;
byte minuto = 0;
byte hora = 0;
byte mes = 0;
byte anio = 0;
byte weekday = 0;
byte dia = 0;

byte inByte = 0;

float resultado_contador =0;
float t_h;

//void conmutar_sd_nordic(boolean x){
//  if (x==true){
//      digitalWrite(5,HIGH);
//      delay(2);
//      if (!SD.begin(SD_CS, SD_SCK_MHZ(50))) {
//          //Serial.print(F("ERROR DE SD"));
//      }   
//  }else{
//      digitalWrite(5,LOW);     
//  }
//}
//
//byte bcd2Dec(byte val)
//{
//  return ((val/16*10) + (val%16));
//}

//void obtenerFechaHora()
//{
//  Wire.beginTransmission(DS3231);
//  Wire.write(byte(0));
//  Wire.endTransmission();
//  Wire.requestFrom(DS3231, 7);
//  segundo = bcd2Dec(Wire.read());
//  minuto = bcd2Dec(Wire.read());
//  hora = bcd2Dec(Wire.read());
//  weekday = bcd2Dec(Wire.read());
//  dia = bcd2Dec(Wire.read());
//  mes = bcd2Dec(Wire.read());
//  anio = bcd2Dec(Wire.read());
//}

void setup(){
  Serial.begin(115200);

  pinMode(SS_PIN, OUTPUT);
  digitalWrite(SS_PIN, HIGH);
  
//  pinMode(5, OUTPUT);
//  digitalWrite(5,LOW);  
//  
//  pinMode(PULSADOR,INPUT_PULLUP ); 
//  pinMode(LED_ROJO,OUTPUT);

  // Initialize at the highest speed supported by the board that is
  // not over 50 MHz. Try a lower speed if SPI errors occur.
  if (!SD.begin(SD_CS, SD_SCK_MHZ(50))) {
    Serial.print(F("ERROR DE SD"));
    //digitalWrite(LED_ROJO,HIGH);  
  }

//  digitalWrite(LED_ROJO,HIGH);
//  delay(100);    
//  digitalWrite(LED_ROJO,LOW);
//  delay(500);    
//  digitalWrite(LED_ROJO,HIGH);
//  delay(100);    
//  digitalWrite(LED_ROJO,LOW);

    Serial.print(F("Iniciado..."));
}

void loop(void) {
byte datito;

  if (Serial.available() > 0) {
     inByte = Serial.read();  
     if (inByte=='a'){
        digitalWrite(LED_BUILTIN,HIGH);
        File file;
        file.open("full.txt", O_READ); 
        while (file.available()) {                      // mientras no se haya llegado al final
              datito = file.read();
              Serial.write(datito);              
        }
        file.close();
        Serial.println("#");
        Serial.println("");
        digitalWrite(LED_BUILTIN,LOW);        
        }
     }
     else if (inByte=='b'){
        digitalWrite(LED_BUILTIN,HIGH);
        File file;
        file.open("bita.txt", O_READ);
        while (file.available()) {                      // mientras no se haya llegado al final
            datito = file.read();
            Serial.write(datito);
        }              
        file.close();
        Serial.print("%");
        Serial.println("");        
        digitalWrite(LED_BUILTIN,LOW);
     }
     else if (inByte=='i'){
        digitalWrite(LED_BUILTIN,HIGH);
        File file;
        file.open("alim.txt", O_READ);
        while (file.available()) {                      // mientras no se haya llegado al final
            datito = file.read();
            Serial.write(datito);
        }              
        file.close();
        Serial.print("@");
        Serial.println("");        
        digitalWrite(LED_BUILTIN,LOW);
     }
     else if (inByte=='z'){
        digitalWrite(LED_BUILTIN,HIGH);
        SD.remove("full.txt");
        SD.remove("alim.txt");
        Serial.print("$");
        digitalWrite(LED_BUILTIN,LOW);        
     }
}

  
