/*
 Este firmware es para guardar en SD un archivo con tramas de datos (índice, fecha/hora dummy, sensor T y H), periódicamente saliendo de modo sleep
 */
#include "LowPower.h"

// librerías para usar la SD
#include <SPI.h>
#include <SD.h>
// librerías para usar el sensor de humedad
#include "Adafruit_Sensor.h"
#include <DHT.h>
#include <DHT_U.h>

#define DHTPIN            A0        // Pin de comunicación con el sensor.
#define DHTTYPE           DHT22     // DHT 22 (o el AM2302 que tenemos), define el tipo de sensor de humedad
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9         // alias del pin del led rojo

DHT_Unified dht(DHTPIN, DHTTYPE);


char str[] = "tramas.txt";

void crear_archivo(){
File outFile;
// Abrir archivo
outFile = SD.open(str, FILE_WRITE);
if(!outFile){
  Serial.println(F("No se pudo abrir el archivo"));
  return;
}   
outFile.println(F("Encabezado archivo cuenta evento pines y sensor"));
outFile.println(F("INDICE   FECHA      HORA   TEMP       HUM%   PULSADOS"));    
// Cerrar archivo
outFile.close();
}

void grabar_datos_archivo(){
File outFile;
outFile = SD.open(str, FILE_WRITE);
if(!outFile){
  Serial.println(F("No se pudo abrir el archivo"));
  return;
}   
outFile.print(indice);
indice = indice + 1;
outFile.print(F(" - AA/MM/DD - HH:MM:SS - "));    
// Leer sensor de humedad y temperatura AM2302
sensors_event_t event;  
// Temperatura
dht.temperature().getEvent(&event);
if (isnan(event.temperature)) {
  Serial.println(F("Error leyendo temperatura!"));
}
else {
  outFile.print(event.temperature);
  outFile.print(F(" ºC"));
}
// Humedad
dht.humidity().getEvent(&event);
if (isnan(event.relative_humidity)) {
  Serial.println(F("Error leyendo humedad!"));
}
else {
  outFile.print(F(" - "));
  outFile.print(event.relative_humidity);
  outFile.print(F("%"));
}  
// Cerrar archivo
outFile.close();
}



// ========================================================================================================================================================


void setup()
{
  //iniciar la salida serial de debug
  Serial.begin(9600);

  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();
  
  pinMode(LED_ROJO, OUTPUT);
  // prender 2 segs el led rojo
  digitalWrite(LED_ROJO,HIGH);
  delay(2000);    //2 segs  
  digitalWrite(LED_ROJO,LOW);
  
  // inicializar sensor de humedad
  dht.begin();            

  //Inicializar SD
  while(!SD.begin(SD_CS)){
    Serial.println(F("¡Error de SD!"));delay(1000);
  }
  crear_archivo();  
}

void loop() 
{
  // Enter idle state for 8 s with the rest of peripherals turned off
  // Each microcontroller comes with different number of peripherals
  // Comment off line of code where necessary

  // ATmega328P, ATmega168
  LowPower.idle(SLEEP_8S, ADC_OFF, TIMER2_OFF, TIMER1_OFF, TIMER0_OFF, 
                SPI_OFF, USART0_OFF, TWI_OFF);
  // Do something here
  // Example: Read sensor, data logging, data transmission.


}

