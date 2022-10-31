/*
 Este firmware es para probar entradas, SD, RTC, sensores y Nordic en un Arduino de 3.3 V (se usará un DUE)
 */
// librerías para usar la SD
#include <SPI.h>
#include <SD.h>
// librerías para usar el sensor de humedad
#include "Adafruit_Sensor.h"
#include <DHT.h>
#include <DHT_U.h>
// librerías para usar el sensor de presión
#include <Wire.h>
#include <Adafruit_BMP085.h>
// librerías para usar el nRF24l01
#include "RF24.h"


#define DHTPIN            A0         // Pin de comunicación con el sensor.
#define DHTTYPE           DHT22     // DHT 22 (o el AM2302 que tenemos), define el tipo de sensor de humedad

DHT_Unified dht(DHTPIN, DHTTYPE);

#define SD_CS 9                     // alias del pin conectado a CS de la SD  
#define zumbador 6                  // alias del pin donde se ha conectado el zumbador

int j = 0;

Adafruit_BMP085 bmp;




void crear_archivo(){
File outFile;
char str[] = "registro.txt";
//strcat(str, ".txt");
// Abrir archivo
outFile = SD.open(str, FILE_WRITE);
if(!outFile){
  Serial.println(F("No se pudo abrir el archivo"));
  return;
}   
outFile.println(F("Encabezado archivo pines y sensores"));    
// Cerrar archivo
outFile.close();
}

void grabar_datos_archivo(int x){
File outFile;
char str[] = "registro.txt";
outFile = SD.open(str, FILE_WRITE);
if(!outFile){
  Serial.println(F("No se pudo abrir el archivo"));
  return;
}   
outFile.print(F("PIN activado!! : "));
outFile.print(x);    
outFile.println("");
// Cerrar archivo
outFile.close();
}





void setup() {
  //iniciar la salida serial de debug
  Serial.begin(9600);

  //pin CS a la SD puesto como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();
  
  //configurar pin 2,3,4 y 6 como entradas y habilitar los pull-ups internos
  pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  pinMode(5, INPUT_PULLUP);

  //pinMode(A0, INPUT_PULLUP);
  
  pinMode(13, OUTPUT);      // este es el Led amarillo soldado on-board de casi todo Arduino
  pinMode(zumbador, OUTPUT);
  digitalWrite(zumbador, LOW);  

  dht.begin();            // inicializar sensor de humedad

//  if (!bmp.begin()) {
//    Serial.println("Could not find a valid BMP085 sensor, check wiring!");
//  while (1) {}
//  }

  
  //Inicializar SD
  while(!SD.begin(SD_CS)){
    Serial.println(F("SD Card Error!"));delay(1000);
  }
  Serial.println(F("SD Card detected."));
  
  crear_archivo();
}

void loop() {
  //leer el estado de los pines a variables
  int valor2 = digitalRead(2);
  int valor3 = digitalRead(3);
  int valor4 = digitalRead(4);
  int valor5 = digitalRead(5);      

  // Leer sensor de humedad y temperatura AM2302 (también llamado DHT22)
  sensors_event_t event;  
  // Temperatura
  dht.temperature().getEvent(&event);
  if (isnan(event.temperature)) {
    Serial.println("Error leyendo temperatura!");
  }
  else {
    Serial.print("Temperatura: ");
    Serial.print(event.temperature);
    Serial.println(" ºC");
  }
  // Humedad
  dht.humidity().getEvent(&event);
  if (isnan(event.relative_humidity)) {
    Serial.println("Error leyendo humedad!");
  }
  else {
    Serial.print("Humedad: ");
    Serial.print(event.relative_humidity);
    Serial.println("%");
  }
  delay(10000);



  // Recordar que la lógica está invertida
  if (valor2 == LOW || valor3 == LOW || valor4 == LOW || valor5 == LOW){
    
    if (valor2 == LOW){
       j = 2;
    }
    if (valor3 == LOW){
       j = 3;
    }
    if (valor4 == LOW){
       j = 4;
    }
    if (valor5 == LOW){
       j = 5;
    }

    digitalWrite(zumbador, HIGH);
    //sensors_event_t event;            // define una estructura que recibe los datos devueltos por el sensor
    //dht.temperature().getEvent(&event); // invocar evento que llena dicha estructura

    //Serial.print("Pressure = ");
    //Serial.print(bmp.readPressure());
    //Serial.println(" Pa");
    //Serial.print("Temperature = ");
    //Serial.print(bmp.readTemperature());
    //Serial.println(" *C");

    
    grabar_datos_archivo(j);
    digitalWrite(zumbador, LOW);      
  } else{
    digitalWrite(zumbador, LOW);      
  }
}




