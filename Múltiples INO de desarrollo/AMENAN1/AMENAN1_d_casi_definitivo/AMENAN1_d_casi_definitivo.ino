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
// librerías para usar la SD
#include <SPI.h>
#include "SdFat.h"
// librerías para usar el sensor de humedad
#include "Adafruit_Sensor.h"
#include <DHT.h>
#include <DHT_U.h>


// file system
SdFat sd;
// test file
SdFile file;

#define DHTPIN            A0        // Pin de comunicación con el sensor.
#define DHTTYPE           DHT22     // DHT 22 (o el AM2302 que tenemos), define el tipo de sensor de humedad
#define LED_ROJO          9         // alias del pin del led rojo
const uint8_t chipSelect = 10;    // alias del pin conectado a CS de la SD  

#define BATA1             7
#define BATA2             6
#define MOSFET_SD_NORDIC  5

DHT_Unified dht(DHTPIN, DHTTYPE);

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

  if (!file.open(str, O_CREAT | O_TRUNC | O_RDWR)) {
    Serial.print(F("ERROR DE ARCHIVO"));
  }
  file.println(F("00000000000000000000000000"));     
  // Cerrar archivo
  file.close();
}

// --------------------------------------------  

void grabar_datos_archivo()
{
  char buffer1[3];
  char buffer2[5];
  if (!file.open(str, O_RDWR | O_CREAT | O_AT_END)) {
    Serial.println(F("No se pudo abrir el archivo"));
    return;
  }   
  obtenerFechaHora();
  file.print(CONSTANTE);
  file.print(F(" "));  
  sprintf(buffer2, "%07d", indice);
  file.print(buffer2);
  indice = indice + 1;
  
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
  
  // Leer sensor de humedad y temperatura AM2302
  sensors_event_t event;  
  // Temperatura
  dht.temperature().getEvent(&event);
  if (isnan(event.temperature)) {
    Serial.println(F("Error leyendo temperatura!"));
  }
  else {
    cadena = String(event.temperature);
    cadena.replace('.',',');
    file.print(cadena);
  }
  // Humedad
  dht.humidity().getEvent(&event);
  if (isnan(event.relative_humidity)) {
    Serial.println(F("Error leyendo humedad!"));
  }
  else {
    file.print(F(" - "));
    cadena = String(event.relative_humidity);
    cadena.replace('.',',');
    file.print(cadena);
    file.print(F(" - "));
    }  

// Leer sensor de presión y temperatura BMP180
//    cadena = String(bmp.readTemperature());
//    cadena.replace('.',',');
//    file.print(cadena);
//    file.print(F(" - "));
//    //file.print(F(" *C"));
//    cadena = String((bmp.readPressure())/100);
//    file.print(cadena);
//    file.print(F(" - "));
//    //file.print(F(" hPa - "));
    
    sprintf(buffer1, "%02d", (contador * CONSTANTE_PULSADO ));
    file.println(buffer1);
  // Cerrar archivo
  file.close();
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


void control_mosfet_sd_nordic(boolean estado)
{
  if (estado){
    digitalWrite(MOSFET_SD_NORDIC,HIGH);
    delay(100);
    sd.begin(chipSelect, SD_SCK_MHZ(50)
    radio.begin();
    if(radioNumber){
      radio.openWritingPipe(addresses[1]);        // Both radios listen on the same pipes by default, but opposite addresses
      radio.openReadingPipe(1,addresses[0]);      // Open a reading pipe on address 0, pipe 1
    }else{
      radio.openWritingPipe(addresses[0]);
      radio.openReadingPipe(1,addresses[1]);
    }
    radio.startListening();                      
  }else{
    digitalWrite(MOSFET_SD_NORDIC,LOW);          
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

  SPI.begin();

  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  pinMode(MOSFET_SD_NORDIC, OUTPUT);  
  pinMode(BATA1, OUTPUT);
  pinMode(BATA2, OUTPUT);
  pinMode(LED_ROJO, OUTPUT); 
  
  digitalWrite(MOSFET_SD_NORDIC,LOW);
  // prender 2 segs el led rojo
  digitalWrite(LED_ROJO,HIGH);
  delay(2000);    //2 segs  
  digitalWrite(LED_ROJO,LOW);
  
  // inicializar sensor de humedad y temperatura
  dht.begin();            

  // inicializar sensor de presión y temperatura
  bmp.begin();

  // Initialize at the highest speed supported by the board that is
  // not over 50 MHz. Try a lower speed if SPI errors occur.
  if (!sd.begin(chipSelect, SD_SCK_MHZ(50))) {
    Serial.print(F("ERROR DE SD"));
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
    

    // rutina que cada vez que el micro sale de modo sleep, lee los sensores y guarda en archivo
    // Si se despertó, medir y grabar
    digitalWrite(LED_ROJO,HIGH);
    // Carga útil, grabar datos en el archivo de la SD
    grabar_datos_archivo();  
    delay(50);  
    digitalWrite(LED_ROJO,LOW);
    // limpiar cuenta de eventos en pin entrada
    contador = 0;



    // rutina que espera la llegada de un caracter por el serial y luego lee y envía archivo
    if (Serial.available() > 0) {
        //if (inByte=="a"){
          File dataFile = SD.open("TRAMAS.txt");                 
          if (dataFile) {                                        // si se pudo abrir el archivo
             while (dataFile.available()) {                      // mientras no se haya llegado al final
                 Serial.write(dataFile.read());                  // enviar contenido
                 }
             }
          dataFile.close();
        }    


    // rutina para poner en hora el RTC via serial/USB

    

}

