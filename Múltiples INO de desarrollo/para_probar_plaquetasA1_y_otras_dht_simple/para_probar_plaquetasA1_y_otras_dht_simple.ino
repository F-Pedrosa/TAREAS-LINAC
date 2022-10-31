// Para probar la A1(y las otras)
 
#include <SPI.h>
#include "RF24.h"
#include "SdFat.h"
#include "LowPower.h"
#include <Wire.h>
// librerías para usar el sensor de humedad
#include <SimpleDHT.h>
int pinDHT22 = A0;
SimpleDHT22 dht22;

//#include <Adafruit_BMP085.h>

// file system
SdFat SD;

#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9 
#define PULSADOR          2
#define BATA1             7
#define BATA2             6

//Adafruit_BMP085 bmp;
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
float resultado_contador =0;

// Nombre del archivo donde se dejarán las tramas
char str[] = "full.txt";
char str2[] = "alim.txt";
volatile int contador = 0;    // cuenta de pulsados
int indice = 0;               // índice de tramas
String cadena=String(3);

const char CONSTANTE[3] = "E1";
const float CONSTANTE_PULSADO = 0.3;

boolean bandera_grabacion = true;

// constante que define cuantos segundos estará dormido antes de despertarse y medir
const int intervalo = 10;
volatile int cantidad_segundos = 0;

const int wakeUpPin = 2;

byte gotByte;

boolean transmitir = false;
boolean primer_paquete = true;

boolean problema_rtc = false;
byte contador_alarma = 0;
boolean una_vez_alarma = true;

void conmutar_sd_nordic(boolean x){
  if (x==true){
      digitalWrite(5,LOW);
      //pin CS a la SD definido como salida
      pinMode(SD_CS,OUTPUT);
      // initializar SPI
      SPI.begin();
      delay(2);
      SD.begin(SD_CS);
  }else{
      digitalWrite(5,HIGH);
      pinMode(SD_CS,INPUT);
      //deshabilitar SPI
      SPI.end();
      pinMode(SCK, INPUT);
      pinMode(MOSI, INPUT);
      pinMode(SS, INPUT);  }
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

// --------------------------------------------

byte bcd2Dec(byte val)
{
  return ((val/16*10) + (val%16));
}


void grabar_datos_archivo()
{
  char buffer1[3];
  char buffer2[8];
  File outFile;
  outFile = SD.open(str, FILE_WRITE);
  obtenerFechaHora();
  outFile.println("");
  outFile.print(CONSTANTE);
  outFile.print(F(" "));  
  sprintf(buffer2, "%07d", indice);
  outFile.print(buffer2);
  indice = indice + 1;
 
  outFile.print(F(" - "));
  sprintf(buffer1, "%02d", dia);
  outFile.print(buffer1);
  outFile.print(F("/"));  
  sprintf(buffer1, "%02d", mes);
  outFile.print(buffer1);
  outFile.print(F("/"));  
  outFile.print("20");
  outFile.print(anio);
  outFile.print(F(" "));
  sprintf(buffer1, "%02d", hora);
  outFile.print(buffer1);
  outFile.print(F(":"));
  sprintf(buffer1, "%02d", minuto);
  outFile.print(buffer1);
  outFile.print(F(":"));
  sprintf(buffer1, "%02d", segundo);
  outFile.print(buffer1);
  outFile.print(F(" - "));
  float temperature = 0;
  float humidity = 0;
  dht22.read2(pinDHT22, &temperature, &humidity, NULL);
  outFile.print((float)temperature); //outFile.print(F(" *C, "));
  outFile.print(F(" - "));
  outFile.print((float)humidity); //outFile.print(F(" RH%"));
  outFile.print(F(" -               "));
//    //Leer sensor de presión y temperatura BMP180
//    cadena = String(bmp.readTemperature());
//    cadena.replace('.',',');
//    outFile.print(cadena);
//    outFile.print(F(" - "));
//    //outFile.print(F(" *C"));
//    cadena = String((bmp.readPressure())/100);
//    outFile.print(cadena);
//    outFile.print(F(" - "));
//    //outFile.print(F(" hPa - ")); 
  resultado_contador = contador * CONSTANTE_PULSADO;  
  outFile.print(int(resultado_contador));  //parte entera
  outFile.print("."); // punto decimal
  unsigned int frac;
  if(resultado_contador >= 0)
     frac = (resultado_contador - int(resultado_contador)) * 10;
  else
     frac = (int(resultado_contador)- resultado_contador ) * 10;
  outFile.print(frac);                    // decimales
  contador = 0;
  // Cerrar archivo
  outFile.close();


  outFile = SD.open(str2, FILE_WRITE);
  int val = 0;
  sprintf(buffer1, "%02d", dia);
  outFile.print(buffer1);
  outFile.print(F("/"));  
  sprintf(buffer1, "%02d", mes);
  outFile.print(buffer1);
  outFile.print(F("/"));  
  outFile.print("20");
  outFile.print(anio);
  outFile.print(F(" "));
  sprintf(buffer1, "%02d", hora);
  outFile.print(buffer1);
  outFile.print(F(":"));
  sprintf(buffer1, "%02d", minuto);
  outFile.print(buffer1);
  outFile.print(F(":"));
  sprintf(buffer1, "%02d", segundo);
  outFile.print(buffer1);
  outFile.print(F(" - "));
  float valorV = 0;
  int val1 = 0;  
  val1 = analogRead(7);
  valorV = (val1 * 3.41)/896;
  outFile.print(valorV,2);    
  outFile.println(F(" V"));    
  // Cerrar archivo
  outFile.close();

}

// ------------------------- este código se ejecuta cdo se pulsa el pulsador, ES UNA INTERRUPCIÓN -------------------
void wakeUp()
{
    contador = contador + 1;
}
// 

//void chequeo_rtc(void) {
//    byte segundos = 0;
//    obtenerFechaHora();
//    if ((dia == 165) || (mes == 165) || (anio == 165) || (hora == 165) || (minuto == 165) || (segundo == 165)) {
//      problema_rtc = true;
//      return;  
//    }
//  
//    if ((dia == 0) || (dia > 31)) {
//      problema_rtc = true;
//      return;  
//    }
//    if ((mes == 0) || (mes > 12)){
//      problema_rtc = true;    
//      return;  
//    }
//    if (anio == 0){
//      problema_rtc = true;    
//      return;  
//    }
//    
//    if (hora > 23) {
//      problema_rtc = true;
//      return;  
//    }
//    if (minuto > 59){
//      problema_rtc = true;    
//      return;  
//    }
//    if (segundo > 59){
//      problema_rtc = true;    
//      return;  
//    }
//  
//    // caso RTC detenido
//    delay(1500);
//    Wire.beginTransmission(DS3231);
//    Wire.write(byte(0));
//    Wire.endTransmission();
//    Wire.requestFrom(DS3231, 1);
//    segundos = bcd2Dec(Wire.read());
//    if (segundos < 58){
//      if (segundos <= segundo){
//         problema_rtc = true;
//         return;        
//      }
//    }else{
//      if (segundos >= segundo){
//         problema_rtc = true;        
//      }
//    }
//}
//
//void alarma_rtc(void){
//    for (byte i=0; i <= 9; i++){
//        digitalWrite(LED_ROJO,HIGH);
//        delay(100);    
//        digitalWrite(LED_ROJO,LOW);          
//        delay(200);            
//    }   
//}



void setup(){

  analogReference(EXTERNAL);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
  
  pinMode(5, OUTPUT);
  digitalWrite(5,LOW);  
  
  pinMode(PULSADOR,INPUT_PULLUP );

  pinMode(LED_ROJO, OUTPUT);
  // prender 2 segs el led rojo
  digitalWrite(LED_ROJO,HIGH);
  delay(2000);    //2 segs  
  digitalWrite(LED_ROJO,LOW);

  // Inicializar I2C
  Wire.begin();

  pinMode(wakeUpPin, INPUT_PULLUP);   

  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();
  //Inicializar SD
  if (!SD.begin(SD_CS)) {
      digitalWrite(LED_ROJO,HIGH);
  }
  attachInterrupt(0, wakeUp, FALLING); 
}


void loop(void) {
    for (cantidad_segundos = 0 ;  cantidad_segundos  <  intervalo ; cantidad_segundos++){
      conmutar_sd_nordic(false);
      //LowPower.idle(SLEEP_1S, ADC_OFF, TIMER2_OFF, TIMER1_OFF,TIMER0_OFF, SPI_OFF, USART0_OFF, TWI_OFF);
      LowPower.powerDown(SLEEP_1S, ADC_OFF, BOD_OFF); 
    }
    conmutar_sd_nordic(true);
    grabar_datos_archivo(); 
}
