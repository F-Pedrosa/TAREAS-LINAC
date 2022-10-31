// 
 
#include <SPI.h>
#include "SdFat.h"
#include <Wire.h>

// file system
SdFat SD;
File file;

#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9

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

// Nombre del archivo donde se dejarán las tramas
const char str[] = "archivo.txt";
volatile int contador = 0;    // cuenta de pulsados
unsigned long indice = 0;               // índice de tramas
boolean bandera_grabacion = true;
const int wakeUpPin = 2;

const int intervalo = 20;                    // intervalo de medición de pulsos
unsigned long actual_milis = 0;
unsigned long previo_milis = 0;

//---------------------------------------------------------------------------------------------------------------------------------------

// función dummy en posición 0 de memoria para, al llamarla, simular un RESET del Arduino.
void(* resetFunc) (void) = 0;


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

// --------------------------------------------

byte bcd2Dec(byte val)
{
  return ((val/16*10) + (val%16));
}


void grabar_datos_archivo()
{
  char buffer1[3];
  char buffer2[8];

  SD.chdir("/");
  file = SD.open(str, O_WRITE | O_CREAT | O_APPEND);
  sprintf(buffer2, "%07d", indice);
  file.print(buffer2);  
  file.print(F(" - "));
  sprintf(buffer1, "%02d", dia);
  file.print(buffer1);
  file.print(F("/"));  
  sprintf(buffer1, "%02d", mes);
  file.print(buffer1);
  file.print(F("/"));  
  file.print("20");
  file.print(anio);
  file.print(F(" "));
  sprintf(buffer1, "%02d", hora);
  file.print(buffer1);
  file.print(F(":"));
  sprintf(buffer1, "%02d", minuto);
  file.print(buffer1);
  file.print(F(":"));
  sprintf(buffer1, "%02d", segundo);
  file.print(buffer1);
  file.print(F(" - "));
  
//  dht.read();
//  delay(2000);
//  //dht.read();  
//  file.print(dht.readTemperature(),1);
//  file.print(F(" - "));
//  delay(100);
//  file.print(dht.readHumidity(),1);
//  file.print(F(" - "));
//  //Leer sensor de presión y temperatura BMP180
//  file.print(bmp.readTemperature(),1);
//  file.print(F(" - "));
//  file.print((bmp.readPressure())/100);
//  file.print(F(" - "));
//  resultado_contador = contador * CONSTANTE_PULSADO;  
//  file.print(int(resultado_contador));  //parte entera
//  file.print("."); // punto decimal
//  unsigned int frac;
//  frac = (resultado_contador - int(resultado_contador)) * 10;
//  file.print(frac);                    // decimales
  file.println(contador);
  contador = 0;
  // Cerrar archivo
  file.close();
  //delay(500);
}

// ------------------------- este código se ejecuta cdo se pulsa el pulsador, ES UNA INTERRUPCIÓN -------------------
void wakeUp(){
  contador = contador + 1;
  if (bandera_grabacion=false){
      bandera_grabacion = true;    
  }
}
// 

void setup(){
  analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
  Serial.begin(115200);
  pinMode(A6, INPUT);
  pinMode(5, OUTPUT);
  digitalWrite(5,LOW);  
  pinMode(LED_ROJO, OUTPUT);
  // que bipee 2 veces
  digitalWrite(LED_ROJO,HIGH);
  delay(500);    
  digitalWrite(LED_ROJO,LOW);
  delay(100);    
  digitalWrite(LED_ROJO,HIGH);
  delay(500);    
  digitalWrite(LED_ROJO,LOW);
  delay(100);      
  Wire.begin();
  pinMode(wakeUpPin, INPUT_PULLUP);   
  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();
  //Inicializar SD
  if (!SD.begin(SD_CS)) {
      //digitalWrite(LED_ROJO,HIGH);
      Serial.println(F("Problema SD"));        
  }
  // Habilitar la interrupción que se producirá al oprimirse el botón conectado al pin 2  
  attachInterrupt(0, wakeUp, FALLING); 
  Serial.println(F("Listo"));        
}



void loop(void) {  
  unsigned int inter;
  if (bandera_grabacion = true){
    unsigned long actual_milis = millis();
    inter = intervalo * 1000;
    if (actual_milis - previo_milis >= inter) {      
      previo_milis = actual_milis;        
      obtenerFechaHora();
      grabar_datos_archivo();
      Serial.println(F("Archivo grabado"));        
      indice++;        
    }       
  }     

}
