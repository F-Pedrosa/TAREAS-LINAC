/* 
 Uso de Pines :
 
 */

// -----------------------------------------------------------------------------------------------------------------------------------------------------------------
#include <SPI.h>
#include "SdFat.h"
#include "LowPower.h"
#include <Wire.h>
#include <Adafruit_BMP085.h>      // librerÃ­as para usar sensores de presiÃ³n y humedad

#include "DHT.h"

#include <YetAnotherPcInt.h>

// Alias de pines
#define SD_CS             13        // alias del pin conectado a CS de la SD  
#define SD2_CS            14        // alias del pin conectado a CS de la SD2  
#define LED_ROJO          27 
#define ZUMBADOR          26 

#define DHTPIN 4
#define DHTTYPE DHT22

const int analog_pin = 35;

DHT dht(DHTPIN, DHTTYPE);

struct CuentaPulsos {
  const uint8_t PIN;
  uint32_t numberKeyPresses;
};


CuentaPulsos contador1 = {36, 0};
CuentaPulsos contador2 = {39, 0};
CuentaPulsos contador3 = {34, 0};

// Sistema de archivos
SdFat SD;
File file;

Adafruit_BMP085 bmp;

// direccion en el bus I2C del RTC
const int DS3231 = 0x68;
const float CONSTANTE_PULSADO_1 = 0.3;
//const float CONSTANTE_PULSADO_2 = 1;          // IMPORTANTE!!! AJUSTAR ESTE VALOR A POSTERIORI
const char CONSTANTE[6] = "ESP32";



// Inicializar variables de fecha y hora 
byte segundo = 0;
byte minuto = 0;
byte hora = 0;
byte mes = 0;
byte anio = 0;
byte dia = 0;
// Nombres de archivos
const char str[] = "full.txt";
const char str2[] = "alim.txt";
const char str3[] = "datos.dat";
const char str4[] = "tempo.txt";
const char str5[] = "tempo.enc";


volatile int cuenta1 = 0;    // cuenta de pulsados
volatile int cuenta2 = 0;    // cuenta de pulsados
unsigned int indice = 0;       // indice de tramas

volatile int cantidad_segundos = 0;
const int intervalo = 29; 

unsigned int posicion = 0;
unsigned int tamanio;


// --------------------------------------------
void obtenerFechaHora()
{
  Wire.beginTransmission(DS3231);
  Wire.write(byte(0));
  Wire.endTransmission();
  Wire.requestFrom(DS3231, 7);
  segundo = bcd2Dec(Wire.read());
  minuto = bcd2Dec(Wire.read());
  hora = bcd2Dec(Wire.read());
  dia = bcd2Dec(Wire.read());             // son necesarias 2 lecturas para pasar de weekday a dia
  dia = bcd2Dec(Wire.read());
  mes = bcd2Dec(Wire.read());
  anio = bcd2Dec(Wire.read());
}

byte bcd2Dec(byte val)
{
  return ((val/16*10) + (val%16));
}

void chequeo_rtc(void) {
    obtenerFechaHora();
    if ((dia == 165) || (mes == 165) || (anio == 165) || (hora == 165) || (minuto == 165) || (segundo == 165)) {
      alarma_rtc();
      return;  
    }
  
    if ((dia == 0) || (dia > 31)) {
      alarma_rtc();
      return;  
    }
    if ((mes == 0) || (mes > 12)){
      alarma_rtc();
      return;  
    }
    if (anio == 0){
      alarma_rtc();
      return;  
    }
    
    if (hora > 23) {
      alarma_rtc();
      return;  
    }
    if (minuto > 59){
      alarma_rtc();
      return;  
    }
    if (segundo > 59){
      alarma_rtc();
      return;  
    }
}

void alarma_rtc(void){
        digitalWrite(LED_ROJO,HIGH);
        delay(100);    
        digitalWrite(LED_ROJO,LOW);          
        delay(200);            

        digitalWrite(LED_ROJO,HIGH);
        delay(100);    
        digitalWrite(LED_ROJO,LOW);          
        delay(200);            

        digitalWrite(LED_ROJO,HIGH);
        delay(100);    
        digitalWrite(LED_ROJO,LOW);          
        delay(200);            

        digitalWrite(LED_ROJO,HIGH);
        delay(100);    
        digitalWrite(LED_ROJO,LOW);          
        delay(200);            

        digitalWrite(LED_ROJO,HIGH);
        delay(100);    
        digitalWrite(LED_ROJO,LOW);          
        delay(200);            

        digitalWrite(LED_ROJO,HIGH);
        delay(100);    
        digitalWrite(LED_ROJO,LOW);          
        delay(200);            

        digitalWrite(LED_ROJO,HIGH);
        delay(100);    
        digitalWrite(LED_ROJO,LOW);          
        delay(200);            

        digitalWrite(LED_ROJO,HIGH);
        delay(100);    
        digitalWrite(LED_ROJO,LOW);          
        delay(200);            
}

// --------------------------------------------

void grabar_datos_archivo(bool x, bool y)
{
  char buffer1[3];
  //char buffer2[8];
  unsigned int valor_analog = 0;
//  float valor = 0;
//  float valor2 = 0;
  float resultado_contador =0;

  if (x == true){
    SD.chdir("respaldo");
  }else{
    SD.chdir("/");
  }

  if (y == true){
    file = SD.open(str4, O_WRITE | O_CREAT | O_TRUNC);
  }else{
    file = SD.open(str, FILE_WRITE);
  }
  
//  file = SD.open(str, FILE_WRITE);
  file.println("");
  file.print(CONSTANTE);
//  file.print(F(" - "));  
  file.print(F(" "));  
//  sprintf(buffer2, "%07d", indice);
//  file.print(buffer2);
  file.print(indice);
  //file.print(F(" - "));
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
//  file.print(F(" - "));  
  file.print(F(" "));  
  file.print(dht.readTemperature(),1);
//  file.print(F(" - "));
  file.print(F(" "));  
  file.print(dht.readHumidity(),1);
//  file.print(F(" - "));
  file.print(F(" "));  
  //Leer sensor de presiÃ³n y temperatura BMP180
  file.print(bmp.readTemperature(),1);
//  file.print(F(" - "));
  file.print(F(" "));  
  file.print((bmp.readPressure())/100);
//  file.print(F(" - "));
  file.print(F(" "));  
  resultado_contador = contador1 * CONSTANTE_PULSADO_1;  
  file.print(int(resultado_contador));  //parte entera
  file.print("."); // punto decimal
  unsigned int frac;
  frac = (resultado_contador - int(resultado_contador)) * 10;
  file.print(frac);                    // decimales
//  file.print(F(" - "));
  file.print(F(" "));  
  file.print(contador2);
//  file.print(F(" - "));
  file.print(F(" "));  
  valor_analog = analogRead(analog_pin);
//  valor = float(valor_analog) / 1023;
//  valor2 = valor * 47000;
//  valor2 = (valor2/(1-valor));
  switch (valor_analog) {
    case 410 ... 430:
      file.print(F("1"));
      break;
    case 135 ... 165:
      file.print(F("2"));
      break;
    case 15 ... 35:
      file.print(F("3"));
      break;
    case 40 ... 55:
      file.print(F("4"));
      break;
    case 65 ... 90:
      file.print(F("5"));
      break;
    case 240 ... 280:
      file.print(F("6"));
      break;
    case 710 ... 750:
      file.print(F("7"));
      break;
    case 570 ... 620:
      file.print(F("8"));
      break;
    default:
//      file.print(F("--"));
      file.print(F("ND"));
      valor_analog = 0;
      break;                              
  }
  file.close();
  SD.chdir("/");
  delay(500);
}



void grabar_alimentacion(bool y){
  char buffer1[3];
  char buffer2[8];

  if (y == true){
    SD.chdir("respaldo");
  }else{
   SD.chdir("/");
  }
  
  file = SD.open(str2, O_CREAT | O_APPEND | O_WRITE);
  file.print(CONSTANTE);
  file.print(F(" - "));  
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
  file.print(F(" "));
  float valorV = 0;
  unsigned int val1 = 0;  
  val1 = analogRead(6);
  //valorV = ((val1 * 11.8)/813);
  valorV = ((val1 * 3.40)/512);
  file.print(valorV,2);    
  file.println(F(" V"));    
  // Cerrar archivo
  file.close();
  SD.chdir("/");
  delay(500);
}

void EncriptFile(){
  char caracter;
  char encriptado;
  file = SD.open(str4, O_READ);
  if(!file){
    Serial.println(F("No se puede abrir el archivo"));
    return;
  }
  file.seek(posicion);
  caracter = file.read();
  if (caracter == 10){
    encriptado = 231;
  } else if (caracter == 13){
    encriptado = 232;
  } else if (caracter == 32){        
    encriptado = 7;
  } else if (caracter == 45){                        
    encriptado = 4;
  } else if (caracter == 48){                                
    encriptado = 3;
  } else {
    encriptado = caracter + 103;
  }
  file.close();
  posicion++;
  file = SD.open(str5, O_WRITE | O_CREAT | O_APPEND);
  file.print(encriptado);      
  file.close();
}

// --------------------------------------------

// Procedimientos invocados cada vez que se produce un pulso en los pines predefinidos, incrementan los contadores
void IRAM_ATTR isr1() {
      contador1++;       
}
void IRAM_ATTR isr2() {
      contador2++;       
}
void IRAM_ATTR isr3() {
      contador3++;       
}
// --------------------------------------------




// =====================================================================================================================================================================

void setup(){
  // Inicializacion de pines (entrada, salida, etc)
  analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIoN POR CUESTIONES INTERNAS DEL MICRO
  pinMode(A6, INPUT);
  pinMode(5, OUTPUT);
  pinMode(TESTIGO, OUTPUT);  
  digitalWrite(TESTIGO,LOW);  
  digitalWrite(5,LOW);  
  pinMode(ZUMBADOR, OUTPUT);
  digitalWrite(ZUMBADOR,LOW);  
  pinMode(SD_CS,OUTPUT);
  pinMode(SD2_CS,OUTPUT);
  // que bipee 2 veces
  digitalWrite(ZUMBADOR,HIGH);
  digitalWrite(TESTIGO,HIGH);    
  delay(500);    
  digitalWrite(ZUMBADOR,LOW);
  delay(100);    
  digitalWrite(ZUMBADOR,HIGH);
  delay(500);    
  digitalWrite(ZUMBADOR,LOW);
  digitalWrite(TESTIGO,LOW);  
  delay(100);      

  // Inicializacion de perifericos, SD y sensores
  Serial.begin(115200);
  Wire.begin();
  SPI.begin();

  // Bloque que inicializa los pines que funcionan como contadores de pulsos.
  pinMode(contador1.PIN, INPUT);
  attachInterrupt(contador1.PIN, isr1, FALLING);
  
  pinMode(contador2.PIN, INPUT);
  attachInterrupt(contador2.PIN, isr2, FALLING);

  pinMode(contador3.PIN, INPUT);
  attachInterrupt(contador3.PIN, isr3, FALLING);

  // Sensores
  bmp.begin();
  dht.begin();
  chequeo_rtc();
  digitalWrite(SD2_CS, HIGH);      
  if (!SD.begin(SD_CS)){
    digitalWrite(ZUMBADOR,HIGH);
    delay(10000);
    digitalWrite(ZUMBADOR,LOW);
  }
  // Si no existen los directorios, crearlos
  if (!SD.exists("respaldo")){
    SD.mkdir("respaldo");
  }
}



void loop(void) {  
    char caracter;    
    
    for (cantidad_segundos = 0 ;  cantidad_segundos  < intervalo ; cantidad_segundos++){
        LowPower.idle(SLEEP_1S, ADC_OFF, TIMER2_OFF, TIMER1_OFF, TIMER0_OFF, SPI_OFF, USART0_ON, TWI_OFF);  
    }

    digitalWrite(SD2_CS, HIGH);      
    if (!SD.begin(SD_CS)){
      digitalWrite(ZUMBADOR,HIGH);
      delay(10000);
      digitalWrite(ZUMBADOR,LOW);      
    }
    
    obtenerFechaHora();
    grabar_datos_archivo(false, false);        //grabar en el principal
    grabar_alimentacion(false);
    grabar_datos_archivo(true, false);         //grabar en \respaldo
    grabar_alimentacion(true);
    grabar_datos_archivo(false, true);        // grabar tempo.txt
    contador1 = 0;
    contador2 = 0;        
    indice++;

    // encriptar a tempo.enc
    file = SD.open(str4, O_READ);
    tamanio = file.size();
    file.close();
    while (posicion < tamanio){
      EncriptFile();
    }
    posicion = 0;
    
    // append a SD2/datos.enc
    file = SD.open(str5, O_READ);
    tamanio = file.size();
    file.close();
    //Serial.println(tamanio);    
    while (posicion < tamanio){
      digitalWrite(SD2_CS, HIGH);      
      if (!SD.begin(SD_CS)){
        digitalWrite(ZUMBADOR,HIGH);
        delay(10000);
        digitalWrite(ZUMBADOR,LOW);        
      }
      file = SD.open(str5, O_READ);
      file.seek(posicion);
      caracter = file.read();
      posicion++;
      file.close();
      digitalWrite(SD_CS, HIGH);      
      if (!SD.begin(SD2_CS)){
        digitalWrite(ZUMBADOR,HIGH);
        delay(10000);
        digitalWrite(ZUMBADOR,LOW);        
      }
      file = SD.open(str3, FILE_WRITE);
      file.print(caracter);
      file.close();
      //Serial.println(posicion);      
    }
    posicion = 0;
    delay(100);
    
    digitalWrite(SD2_CS, HIGH);      
    if (!SD.begin(SD_CS)){
      digitalWrite(ZUMBADOR,HIGH);
      delay(10000);
      digitalWrite(ZUMBADOR,LOW);      
    }
    SD.remove(str4);
    SD.remove(str5);    

    digitalWrite(TESTIGO,HIGH);
    delay(1000);    
    digitalWrite(TESTIGO,LOW);
    delay(100);

    // Espera llegada de caracter por la USB-TTL serial.
//    pedido_usb();       

    
}

