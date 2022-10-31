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
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9 
#define PULSADOR          2
//#define BATA1             7
//#define BATA2             6

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

const char str[] = "full.txt";
const char logfile[] = "bita.txt";
const char str2[] = "alim.txt";

volatile int contador = 0;    // cuenta de pulsados
unsigned long indice = 0;               // índice de tramas
String cadena=String(3);
boolean bandera_grabacion = true;
unsigned int cuenta = 0;
unsigned int resto = 0;
volatile int cantidad_segundos = 0;
const int wakeUpPin = 2;


unsigned long currentMillis = 0;
unsigned long previousMillis = 0;

unsigned long previo_milis = 0;
const unsigned long tiempo_grabacion = 300000;            // 5 minutos (300 s) 


char buffer1[3];
char buffer2[8];

boolean problema_rtc = false;
byte contador_alarma = 0;
boolean una_vez_alarma = true;

void conmutar_sd_nordic(boolean x){
  if (x==true){
      digitalWrite(5,HIGH);
      delay(2);
      if (!SD.begin(SD_CS, SD_SCK_MHZ(50))) {
          //Serial.print(F("ERROR DE SD"));
      }   
  }else{
      digitalWrite(5,LOW);     
  }
}

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

void grabar_datos_archivo()
{
  char buffer1[3];
  char buffer2[8];
  
  file = SD.open(str, FILE_WRITE);
  obtenerFechaHora();
  file.println("");
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
  
  dht.read();
  delay(2000);
  dht.read();  
  file.print(dht.getTemperatureC(),1);
  file.print(F(" - "));
  delay(100);
  file.print(dht.getHumidity(),1);
  file.print(F(" - "));
  //Leer sensor de presión y temperatura BMP180
  file.print(bmp.readTemperature(),1);
  file.print(F(" - "));
  file.print((bmp.readPressure())/100);
  file.print(F(" - "));
  resultado_contador = contador * CONSTANTE_PULSADO;  
  file.print(int(resultado_contador));  //parte entera
  file.print("."); // punto decimal
  unsigned int frac;
  frac = (resultado_contador - int(resultado_contador)) * 10;
  file.print(frac);                    // decimales
  contador = 0;
  // Cerrar archivo
  file.close();
  delay(500);
}



void grabar_alimentacion(void){
  char buffer1[3];
  char buffer2[8];
  SD.chdir('/');
  file = SD.open(str2, O_CREAT | O_APPEND | O_WRITE);
  file.print(CONSTANTE);
  file.print(F(" "));  
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
  file.print(F(" "));
  float valorV = 0;
  unsigned int val1 = 0;  
  val1 = analogRead(6);
  valorV = ((val1 * 1.71)/513)*2;
  file.print(valorV,2);    
  file.println(F(" V"));    
  // Cerrar archivo
  file.close();
  delay(500);
}

// ------------------------- este código se ejecuta cdo se pulsa el pulsador, ES UNA INTERRUPCIÓN -------------------
void wakeUp(){contador = contador + 1;}
// 

void setup(){
  analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
  
  Serial.begin(115200);
  pinMode(5, OUTPUT);
  digitalWrite(5,LOW);  
  
  pinMode(PULSADOR,INPUT_PULLUP ); 
  pinMode(LED_ROJO,OUTPUT);

  digitalWrite(LED_ROJO,HIGH);
  delay(100);    
  digitalWrite(LED_ROJO,LOW);
  delay(500);    
  digitalWrite(LED_ROJO,HIGH);
  delay(100);    
  digitalWrite(LED_ROJO,LOW);

  // Inicializar I2C
  Wire.begin();
  pinMode(wakeUpPin, INPUT_PULLUP);   
  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();
//  if (!SD.begin(SD_CS, SD_SCK_MHZ(50))) {
//    //Serial.print(F("ERROR DE SD"));
//    digitalWrite(LED_ROJO,HIGH);  
//  }
  if (!SD.begin(SD_CS)) {
      Serial.print(F("ERROR DE SD"));
      //digitalWrite(LED_ROJO,HIGH);
  }
  
  bmp.begin();
  dht.begin();
  delay(1000);
  dht.read();
  delay(2500);
  dht.read();    
  // Habilitar la interrupción que se producirá al oprimirse el botón conectado al pin 2  
  attachInterrupt(0, wakeUp, FALLING); 
}

void loop(void) {
byte datito;

    unsigned long actual_milis = millis();
    if (actual_milis - previo_milis >= tiempo_grabacion) {      // lazo que determina los 5 minutos (250 s en realidad), entre grabación y grabación 
        previo_milis = actual_milis;
        grabar_datos_archivo();
        grabar_alimentacion();
    }

  if (Serial.available() > 0) {
     inByte = Serial.read();
     while (Serial.available() > 0) {Serial.read();}
     if (inByte=='a'){
        digitalWrite(LED_ROJO,HIGH);
        delay(200);
        digitalWrite(LED_ROJO,LOW);        
        //File file;
        file.open("full.txt", O_READ); 
        while (file.available()) {                      // mientras no se haya llegado al final
              datito = file.read();
              Serial.write(datito);              
        }
        file.close();
        Serial.println("#");
        Serial.println("");
        inByte=0;    
        obtenerFechaHora();
        SD.chdir('/');
        file = SD.open(logfile, O_CREAT | O_APPEND | O_WRITE);
        file.print("full.txt");          // escribir nombre de archivo
        file.print(F("   "));         // seguido por fecha y hora (al momento de finalizarse la transmisión)
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
        file.println(buffer1);
        file.close();
               
        }
     }
     else if (inByte=='b'){
        digitalWrite(LED_ROJO,HIGH);
        delay(200);
        digitalWrite(LED_ROJO,LOW);        
        obtenerFechaHora();
        SD.chdir('/');
        file = SD.open(logfile, O_CREAT | O_APPEND | O_WRITE);
        file.print("bita.txt");          // escribir nombre de archivo
        file.print(F("   "));         // seguido por fecha y hora (al momento de finalizarse la transmisión)
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
        file.println(buffer1);
        file.close();      
        delay(1000);    

        file.open("bita.txt", O_READ);
        while (file.available()) {                      // mientras no se haya llegado al final
            datito = file.read();
            Serial.write(datito);
        }              
        file.close();
        Serial.print("%");
        Serial.println("");        
        inByte=0;
     }
     else if (inByte=='i'){
        digitalWrite(LED_ROJO,HIGH);
        delay(200);
        digitalWrite(LED_ROJO,LOW);
        //File file;
        file.open("alim.txt", O_READ);
        while (file.available()) {                      // mientras no se haya llegado al final
            datito = file.read();
            Serial.write(datito);
        }              
        file.close();
        Serial.print("@");
        Serial.println("");        
        inByte=0;    
        obtenerFechaHora();
        SD.chdir('/');
        file = SD.open(logfile, O_CREAT | O_APPEND | O_WRITE);
        file.print("alim.txt");          // escribir nombre de archivo
        file.print(F("   "));         // seguido por fecha y hora (al momento de finalizarse la transmisión)
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
        file.println(buffer1);
        file.close();
        
     }
     else if (inByte=='z'){
        digitalWrite(LED_ROJO,HIGH);
        SD.remove("full.txt");
        SD.remove("alim.txt");
        SD.remove("bita.txt");
        Serial.print("$");
        digitalWrite(LED_ROJO,LOW);        
        inByte=0;    
     }
}

  
