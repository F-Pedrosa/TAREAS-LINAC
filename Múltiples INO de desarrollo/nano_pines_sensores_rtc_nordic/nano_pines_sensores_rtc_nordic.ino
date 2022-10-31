/*
 Este firmware es para guardar en SD un archivo con tramas de datos (índice, fecha/hora dummy, sensor T y H, y cuenta de eventos
 */
 
// librerías para usar la SD
#include <SPI.h>
#include <SD.h>
// librerías para usar el sensor de humedad
#include "Adafruit_Sensor.h"
#include <DHT.h>
#include <DHT_U.h>
//// librerías para usar el nRF24l01
//#include "RF24.h"

#define ACTIVADO          LOW
#define DHTPIN            A0        // Pin de comunicación con el sensor.
#define DHTTYPE           DHT22     // DHT 22 (o el AM2302 que tenemos), define el tipo de sensor de humedad
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9         // alias del pin del led rojo

DHT_Unified dht(DHTPIN, DHTTYPE);

unsigned long previoMilis = 0;      // valor anterior del contador de milisegundos
//const long intervalo = 60000;       // 1 minuto = 60000 milisegundos
const long intervalo = 10000;       
int contador = 0;    
int indice = 0;    

//int estadoPulsador;               // lectura actual del pulsador
//int ultimoEstado = HIGH;          // lectura previa del pulsador
//unsigned long ultimoTiempo = 0;   // ultima vez que se oprmió el pulsador
//unsigned long debounceDelay = 100; // tiempo anti-rebote

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
outFile.print(F(" - "));
outFile.println(contador);
// Cerrar archivo
outFile.close();
}

// ========================================================================================================================================================

void setup() {
  //iniciar la salida serial de debug
  Serial.begin(9600);

  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();
  
  //configurar pin 2,3 y 4 como entradas y habilitar los pull-ups internos (que les define el estado a HIGH, hasta que se pulse el pulsador)
  pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);

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



void loop() {

//----------------------------------------------------
  //leer el estado de los pines a variables
  int valor2 = digitalRead(2);
  if (valor2 == LOW){
      delay(400);
      contador = contador + 1;
  }
//----------------------------------------------------
  
//----------------------------------------------------  
  unsigned long actualMilis = millis();

  // si ya transcurrieron los 60 segundos, leer sensor, cuenta de eventos y grabar en archivo SD...
  if (actualMilis - previoMilis >= intervalo) {
    // guardar vez anterior
    previoMilis = actualMilis;
    // grabar trama con índice, fecha y hora dummy, datos sensor y cantidad de eventos de entrada
    grabar_datos_archivo();
    Serial.println(F("Se grabó trama"));
    // limpiar cuenta de evento en pin entrada
    contador = 0;
  }
//----------------------------------------------------   

}




