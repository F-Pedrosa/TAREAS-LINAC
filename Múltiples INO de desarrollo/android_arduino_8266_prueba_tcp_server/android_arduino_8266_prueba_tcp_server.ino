#include <SPI.h>
#include "SdFat.h"

// SD chip select pin
const uint8_t chipSelect = 10;
// file system
SdFat SD;
// test file
SdFile file;

#define LED             9   
#define PULSADOR1       2

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

byte val1;
char str3[] = "archivo.txt";
unsigned long previousMillis = 0; 

unsigned long cantidad_paquetes = 0; 

boolean enviar = false;

int cuenta = 0;
int cuenta2 = 1;
int resto = 0;
byte inByte;
int count = 0;

char pass1[]="pepepepe";
char pass2[]="titotito";
char pass3[]="juanjuan";

char contrasenia[] = "        ";

void setup() {
  Serial.begin(115200);

  pinMode(LED,OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(PULSADOR1,INPUT_PULLUP );

  digitalWrite(LED,HIGH);
  delay(200);    
  digitalWrite(LED,LOW);
  
  digitalWrite(5,HIGH);
  delay(2);
  if (!SD.begin(chipSelect, SD_SCK_MHZ(50))) {
     digitalWrite(LED,HIGH);
  }
  
  // establecer seteos del módulo   
  Serial.println(F("AT+CWMODE=3"));
  delay(100);
  Serial.println(F("AT+CWDHCP=2,1"));
  delay(100);
  Serial.println(F("AT+CIPMUX=1"));
  delay(100);

  Serial.print(F("AT+CWSAP="));
  Serial.write(34);
  Serial.print(F("red de prueba"));
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.write(34);    //comilla 
  
  Serial.print(pass1);
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.println(F("5,3"));
  delay(1500);
  
  Serial.println(F("ATE0"));
  delay(100);

}

void loop() {
byte datito;


  // preguntar periódicamente si hay algún dispositivo conectado al esp8266 como access point
  Serial.println(F("AT+CWLIF"));
  delay(100);
  while (Serial.available() > 0)
  //if (Serial.available() > 0)
  {
   inByte = Serial.read();
   if (inByte == '1') {           // "1" por la IP del celular (que arranca en 192)
      digitalWrite(LED,HIGH);
      delay(200);    
      digitalWrite(LED,LOW); 
      
      enviar = true;
      break; 
   }
  }


  if (enviar == true ){

      delay(6000);          // retardo largo para poder arrancar el servidor TCP en el celular
      
      enviar = false; 
      Serial.println(F("ATE1"));
      delay(500);    
      Serial.print(F("AT+CIPSTART=4,"));
      Serial.write(34);
      Serial.print(F("TCP"));
      Serial.write(34);
      Serial.print(F(","));
      Serial.write(34);
      Serial.print(F("192.168.4.2"));
      Serial.write(34);      
      Serial.println(F(",9999"));
      delay(5000);    
      Serial.println(F("AT+CIPSEND=4,16"));
      delay(1500);
      Serial.println(F("FIN DE PROCESO"));
      delay(800);
      Serial.println(F("AT+CIPCLOSE=4"));
      delay(300);
      while(1){
        digitalWrite(LED,HIGH);
        delay(70);    
        digitalWrite(LED,LOW); 
        delay(400);    
      }
  }
  delay(2000);  
}
