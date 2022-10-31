 // ----------------------------------------------------------------------------------------------------------------
//
//  Este firmware es para guardar en SD un archivo con tramas de datos (índice, fecha/hora, sensor T y H, pulsado),
//  saliendo de modo sleep al pulsar y esperar mientras se esté pulsando antes de dormirse (ver los comentarios para ajustar el intervalo).
//
// ----------------------------------------------------------------------------------------------------------------


// Librería bajo consumo (sleep)
#include "LowPower.h"

// Librería para acceder al bus I2C (RTC, ArduCam, BMP180)
#include <Wire.h>

// Para el sensor de presión
#include <Adafruit_BMP085.h>

Adafruit_BMP085 bmp;


// dirección en el bus I2C del RTC
const int DS3231 = 0x68;

// Pin 2 para despertar al micro
const int wakeUpPin = 2;

// constante que define cuantos segundos estará dormido antes de despertarse y medir
const int intervalo = 5;
volatile int cantidad_segundos = 0;

// constante que va en la primera columna de la trama grabada en la SD, desconozco su funcionalidad, pedida por SP.
//const byte CONSTANTE = 99;      // Número constante entre 00 y 99
const char CONSTANTE[3] = "0D";

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

#define BATA1             7
#define BATA2             6

DHT_Unified dht(DHTPIN, DHTTYPE);


// Inicializar variables de fecha y hora
byte segundo = 0;
byte minuto = 0;
byte hora = 0;
byte mes = 0;
byte anio = 0;
byte weekday = 0;
byte dia = 0;


// Nombre del archivo donde se dejarán las tramas
char str[] = "tramas.txt";
volatile int contador = 0;    // cuenta de pulsados
int indice = 0;               // índice de tramas

// ------------------------------------------------------ PROCEDIMIENTOS -----------------------------------------------------------------------
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

// --------------------------------------------

void crear_archivo()
{
  File outFile;
  // Abrir archivo
  outFile = SD.open(str, FILE_WRITE);
  if(!outFile){
    Serial.println(F("No se pudo abrir el archivo"));
    return;
  }   
  outFile.println(F("Encabezado archivo cuenta evento pines y sensor"));
  //outFile.println(F("   INDICE   FECHA      HORA       TEMP        HUM%  PULSADOS"));    

  // Para cuando esté el sensor de presión
  outFile.println(F("  INDICE    FECHA         HORA     TEMP        HUM%   TEMP2      PRESION  PULSADOS"));      
  
  
  // Cerrar archivo
  outFile.close();
}

// --------------------------------------------  

void grabar_datos_archivo()
{
  char buffer1[3];
  char buffer2[5];
  File outFile;
  outFile = SD.open(str, FILE_WRITE);
  if (!outFile) {
    Serial.println(F("No se pudo abrir el archivo"));
    return;
  }   
  obtenerFechaHora();
  //sprintf(buffer1, "%02d", CONSTANTE);
  //outFile.print(buffer1);
  outFile.print(CONSTANTE);
  outFile.print(F(" "));  
  sprintf(buffer2, "%04d", indice);
  outFile.print(buffer2);
  indice = indice + 1;
  outFile.print(F(" - "));
  outFile.print("20");
  outFile.print(anio);
  outFile.print(F("/"));
  sprintf(buffer1, "%02d", mes);
  outFile.print(buffer1);
  outFile.print(F("/"));
  sprintf(buffer1, "%02d", dia);
  outFile.print(buffer1);
  outFile.print(F(" - "));
  sprintf(buffer1, "%02d", hora);
  outFile.print(buffer1);
  outFile.print(F(":"));
  sprintf(buffer1, "%02d", minuto);
  outFile.print(buffer1);
  outFile.print(F(":"));
  sprintf(buffer1, "%02d", segundo);
  outFile.print(buffer1);
  outFile.print(F(" - "));

  
  // Leer sensor de humedad y temperatura AM2302
  sensors_event_t event;  
  // Temperatura
  dht.temperature().getEvent(&event);
  if (isnan(event.temperature)) {
    Serial.println(F("Error leyendo temperatura!"));
  }
  else {
    outFile.print(event.temperature);
    outFile.print(F(" *C"));
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
    outFile.print(F(" - "));
    }  
 

// Leer sensor de presión y temperatura BMP180
    outFile.print(bmp.readTemperature());
    outFile.print(F(" *C - "));
    outFile.print((bmp.readPressure())/100);
    outFile.print(F(" hPa - "));
    
    sprintf(buffer1, "%02d", contador);
    outFile.println(buffer1);

  // Cerrar archivo
  outFile.close();
}


void chequeoBata()
{
  int val = 0;
  val = analogRead(6);    // leer entrada analógica
  if (val <= 555){        // se está agotando, conmutar
    digitalWrite(BATA2,HIGH);     // esta línea hace entrar a la BATA2
    digitalWrite(BATA1,HIGH);     // y esta hace salir a la BATA1, a pesar de q las instrucciones son iguales, la electrónica NO LO ES.
  }

  
}


// =============================================================== CÓDIGO DE ARRANQUE ========================================================

void setup()
{
  analogReference(EXTERNAL);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
  
  // Inicializar I2C
  Wire.begin();
  // Configure wake up pin as input.
  // This will consumes few uA of current.
  pinMode(wakeUpPin, INPUT_PULLUP);   

  //iniciar la salida serial de debug
  Serial.begin(9600);

  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();

  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  
  pinMode(BATA1, OUTPUT);
  pinMode(BATA2, OUTPUT);

  
  pinMode(LED_ROJO, OUTPUT);
  // prender 2 segs el led rojo
  digitalWrite(LED_ROJO,HIGH);
  delay(2000);    //2 segs  
  digitalWrite(LED_ROJO,LOW);
  
  // inicializar sensor de humedad y temperatura
  dht.begin();            

  // inicializar sensor de presión y temperatura
  bmp.begin();

  //Inicializar SD
  while(!SD.begin(SD_CS)){
    Serial.println(F("¡Error de SD!"));delay(1000);
  }
  crear_archivo();  
  delay(1000);

  // Habilitar la interrupción que se producirá al oprimirse el botón conectado al pin 2
  attachInterrupt(0, wakeUp, FALLING);
}


// ------------------------- este código se ejecuta cdo se pulsa el pulsador, ES UNA INTERRUPCIÓN -------------------
void wakeUp()
{
    contador = contador + 1;
}
// -----------------------------------------------------------------------------------------------------------------


// ================================================== FOREVER LOOP ==================================================

void loop() 
{
  
    for (cantidad_segundos = 0 ;  cantidad_segundos  <  intervalo ; cantidad_segundos++){
      LowPower.idle(SLEEP_1S, ADC_OFF, TIMER2_OFF, TIMER1_OFF,TIMER0_OFF, SPI_OFF, USART0_OFF, TWI_OFF);
    }
    
    
    // Si se despertó, medir y grabar
    digitalWrite(LED_ROJO,HIGH);
    // Carga útil, grabar datos en el archivo de la SD
    grabar_datos_archivo();  
    delay(50);  
    digitalWrite(LED_ROJO,LOW);
    // limpiar cuenta de eventos en pin entrada
    contador = 0;
}

