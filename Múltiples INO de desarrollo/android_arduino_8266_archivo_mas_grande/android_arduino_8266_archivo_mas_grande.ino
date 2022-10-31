#include <SPI.h>
#include "SdFat.h"
#include <Wire.h>

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

byte bcd2Dec(byte val)
{
  return ((val/16*10) + (val%16));
}

void obtenerFechaHora()
{
  Wire.beginTransmission(DS3231);
  Wire.write(byte(0));
  Wire.endTransmission();
  Wire.requestFrom(DS3231, 7);
  segundo = bcd2Dec(Wire.read());
  minuto = bcd2Dec(Wire.read());
  hora = bcd2Dec(Wire.read());
  weekday = bcd2Dec(Wire.read());
  dia = bcd2Dec(Wire.read());
  mes = bcd2Dec(Wire.read());
  anio = bcd2Dec(Wire.read());
}



void setup() {
  Serial.begin(115200);
  Wire.begin();

  
//  pinMode(8, OUTPUT);
//  digitalWrite(8,HIGH);

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

//  obtenerFechaHora();
//  // adecuar la contraseña a la fecha
//  if ((anio>17) && (anio<19)){
//    if ((mes>3)&& (mes<5)){
//      if ((dia>1)&& (dia<18)){
//        for (count=0;count<8;count++) {
//         contrasenia[count] = pass1[count];
//        }    
//      }
//    }
//  }   
// if ((anio>17) && (anio<19)){
//    if ((mes>3)&& (mes<5)) {
//      if ((dia>18)&& (dia<30)) {
//        for (count=0;count<8;count++) {
//         contrasenia[count] = pass2[count];
//        }    
//      }
//    }
//  }   
// if ((anio > 17) && (anio < 19)){
//    if ((mes > 4)&& (mes < 6)){
//      if ((dia > 1)&& (dia < 18)){
//        for (count=0;count<8;count++) {
//         contrasenia[count] = pass3[count];
//        }    
//      }
//    }
//  }   

  
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
  
//  Serial.print(contrasenia);        // esta es una de las contraseñas (MÍNIMO 8 CARACTERES!!!!), declaradas al principio
  Serial.print(pass1);
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.println(F("5,3"));
  delay(1500);
  
  Serial.println(F("ATE0"));
  delay(100);


  // para probar consumo en modo deep-sleep
  // Serial.println(F("AT+GSLP=10000"));

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

      delay(6000);          // retardo largo para poder arrancar el servidor FTP en el celular
      
      enviar = false; 
      Serial.println(F("ATE1"));
      delay(500);    
      Serial.println(F("AT+CIPSERVER=1,1027"));    
      delay(500);    
      Serial.print(F("AT+CIPSTART=4,"));
      Serial.write(34);
      Serial.print(F("TCP"));
      Serial.write(34);
      Serial.print(F(","));
      Serial.write(34);
      Serial.print(F("192.168.4.2"));
      Serial.write(34);      
      Serial.println(F(",9090"));
      delay(5000);    
      Serial.println(F("AT+CIPSEND=4,11"));
      delay(1500);
      Serial.println(F("USER user"));
      delay(800);
      Serial.println(F("AT+CIPSEND=4,11"));      
      delay(800);
      Serial.println(F("PASS pass"));
      delay(1800);
      Serial.println(F("AT+CIPSEND=4,22"));
      delay(800);
      Serial.println(F("PORT 192,168,4,1,4,3"));      
      //Serial.println("");
      delay(4000);
//      Serial.println(F("AT+CIPSEND=4,31"));
      Serial.println(F("AT+CIPSEND=4,19"));
      delay(2000);
      Serial.print(F("STOR "));

      obtenerFechaHora();
      Serial.print(F("archivo.txt"));
      //Serial.print(F("archivo"));
      //char buf[6]; 
      //sprintf(buf, "%02d%02d%02d%02d%02d%02d",anio, mes, dia, hora, minuto,segundo); 
      //Serial.print(buf); 

//      char buf[12]; 
//      sprintf(buf, "%02d%02d%02d%02d%02d%02d",anio, mes, dia, hora, minuto,segundo); 
//      Serial.print(buf); 
//      
//      Serial.print(F(".txt"));    

      Serial.write(13);
      Serial.write(10);
      Serial.write(13);
      Serial.write(10);

      delay(1500);
    
      File file;
      file.open(str3, O_READ);
      
      //Serial.print(F("AT+CIPSEND=0,")); 
      //enviar tamaño archivo como ASCII, termina con CRLF
      //Serial.println(file.size());

      Serial.println(F("AT+CIPSEND=0,2048")); 
      
      cantidad_paquetes = file.size()/2048;   // si el cociente es entero la división es entera
      delay(25);
      
      // enviar archivo, en paquetes de 2048 bytes por exigencias del ESP8266, con esperas de 20 ms entre paquete y paquete
      while (file.available()) {                      // mientras no se haya llegado al final
          datito = file.read();
          Serial.write(datito);
          if (cuenta == 2047){
             cuenta = 0;
             Serial.print(F("+++"));
             delay(100); 
             if (cuenta2 != cantidad_paquetes){
                Serial.println(F("AT+CIPSEND=0,2048"));
                cuenta2 = cuenta2 + 1;               
                delay(60); 
             }else{
                cuenta2 = 1;
                resto = file.size() - (cantidad_paquetes * 2048);
                Serial.print(F("AT+CIPSEND=0,"));
                Serial.println(resto);                                 
                delay(25); 
             }
          }else{
            cuenta = cuenta + 1;            
          }              
      }              
      
      // cerrar todo
      file.close();
      Serial.print(F("+++"));     
      delay(300);      
      Serial.println(F("AT+CIPCLOSE=0"));
      delay(300);
      Serial.println(F("AT+CIPCLOSE=4"));
      delay(10000);

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
        delay(100);    
        digitalWrite(LED,LOW); 
        delay(400);    
      }
  }
  delay(2000);  
}
