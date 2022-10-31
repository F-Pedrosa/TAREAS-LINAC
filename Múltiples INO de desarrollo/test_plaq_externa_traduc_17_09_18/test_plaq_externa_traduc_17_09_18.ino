// Para probar la sensores externos con plaq traductora
#include <Wire.h>
// librerías para usar el sensor de humedad
//#include <TroykaDHT.h>
// librerías para usar el sensor de presión
#include <Adafruit_BMP085.h>

#include "Adafruit_Sensor.h"
#include <DHT.h>
//#include <DHT_U.h>

#define DHTPIN            A0        // Pin de comunicación con el sensor.
#define DHTTYPE           DHT22     // DHT 22 (o el AM2302 que tenemos), define el tipo de sensor de humedad
#define LED_ROJO          9 

Adafruit_BMP085 bmp;
//DHT dht(A0, DHT22);

DHT dht(DHTPIN, DHTTYPE);


void setup(){
  analogReference(EXTERNAL);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
  pinMode(5, OUTPUT);
  digitalWrite(5,LOW);  
  pinMode(LED_ROJO, OUTPUT);
  // prender 2 segs el led rojo
  digitalWrite(LED_ROJO,HIGH);
  delay(2000);    
  digitalWrite(LED_ROJO,LOW);
  Serial.begin(57600);
  Serial.println(F("Iniciado"));
  // Inicializar I2C
  Wire.begin();
  Serial.println(F("wire begin"));
  bmp.begin();
  Serial.println(F("bmp begin"));
  dht.begin();
  Serial.println(F("dht begin"));  
  delay(1000);
  dht.read();         // un par de lecturas dummy por cuestiones del sensor y la librería
  delay(2500);
  dht.read();    
}



void loop(void) {  
  //Serial.print("**");
  //dht.read();  
  Serial.print(dht.readTemperature(),1);
  Serial.print(F(" - "));
  delay(100);
  Serial.print(dht.readHumidity(),1);
  Serial.print(F(" - "));
  //Leer sensor de presión y temperatura BMP180
  Serial.print(bmp.readTemperature(),1);
  Serial.print(F(" - "));
  Serial.println((bmp.readPressure())/100);
  delay(2500);
}
