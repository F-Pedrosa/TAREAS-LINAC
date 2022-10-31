/* 

 Uso de Pines (el número corresponde al modo de numeración de Arduino, que está impreso en el sikscreen):
 0 Rx Interfaz Serie
 1 Tx Interfaz Serie
 2 Entrada pulsador 1 (bornera verde más al borde)
 3 Entrada contador de pulsos (siguiente bornera verde)
 4 Entrada digital que puede contar (bornera verde más interna)
 5 Control alimentación Nordic
 6 Control entrada alim 2
 7 Control entrada alim 1
 8 Control Selección Arducam
 9 Control zumbador y led testigo
 10 Control Selección SD1
 11 BUS SPI
 12 BUS SPI
 13 BUS SPI
 A0 Control sensor de Humedad
 A1 Control Selección SD2 / Control Nordic
 A2 Control led testigo 2 / Control Nordic
 A4 BUS I2C
 A5 BUS I2C
 A6 entrada analógica medición alimentación
 A7 Entrada Analógica Selector

 Nota: BUS SPI es usado por el ArduCam, la(s) SD(s) y el Nordic. BUS I2C es usado por el RTC, el sensor de presión y el ArduCam

 */

// -----------------------------------------------------------------------------------------------------------------------------------------------------------------
#include <SPI.h>
#include "SdFat.h"
#include "LowPower.h"
#include <Wire.h>
#include <Adafruit_BMP085.h>      // librerías para usar sensores de presión y humedad
#include "SDHT.h"
#include <YetAnotherPcInt.h>
#include <xxtea-iot-crypt.h>

// Alias de pines
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define SD2_CS            A1
#define LED_ROJO          9 
#define ZUMBADOR          9 
#define TESTIGO           A2
#define BATA1             7
#define BATA2             6
//const int wakeUpPin = 2;
#define ARRAY_SIZE(X) (sizeof(X)/sizeof(*X))

struct Pin {
  int number;
  const char* name;
};

// Lista de pins que se controlarán
Pin monitored_pins[] = {
  {2,  "D2"},
  {3,  "D3"},
};

// Sistema de archivos
SdFat SD;
File file;

SDHT dht;
Adafruit_BMP085 bmp;


// dirección en el bus I2C del RTC
const int DS3231 = 0x68;
const float CONSTANTE_PULSADO_1 = 0.3;
const float CONSTANTE_PULSADO_2 = 1;          // IMPORTANTE!!! AJUSTAR ESTE VALOR A POSTERIORI
const char CONSTANTE[3] = "A2";
const int analog_pin = A7;

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
const char str3[] = "full.tea";

volatile int contador1 = 0;    // cuenta de pulsados
volatile int contador2 = 0;    // cuenta de pulsados
unsigned long indice = 0;               // índice de tramas

volatile int cantidad_segundos = 0;
const int intervalo = 29; 

unsigned long posicion = 0;
unsigned long tamanio;
  
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
  //weekday = bcd2Dec(Wire.read());
  dia = bcd2Dec(Wire.read());             // son necesarias 2 lecturas para pasar de weekday a dia
  dia = bcd2Dec(Wire.read());
  mes = bcd2Dec(Wire.read());
  anio = bcd2Dec(Wire.read());
}

byte bcd2Dec(byte val)
{
  return ((val/16*10) + (val%16));
}
// --------------------------------------------

void grabar_datos_archivo(bool x)
{
  char buffer1[3];
  char buffer2[8];
  unsigned int valor_analog = 0;
  float valor = 0;
  float valor2 = 0;
  float resultado_contador =0;

  if (x == true){
    SD.chdir("respaldo");
  }else{
    SD.chdir("/");
  }
  
  file = SD.open(str, FILE_WRITE);
  file.println("");
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
  file.print(F(" - "));  
  file.print(dht.celsius,1);
  file.print(F(" - "));
//  delay(100);
  file.print(dht.humidity,1);
  file.print(F(" - "));
  //Leer sensor de presión y temperatura BMP180
  file.print(bmp.readTemperature(),1);
  file.print(F(" - "));
  file.print((bmp.readPressure())/100);
  file.print(F(" - "));
  resultado_contador = contador1 * CONSTANTE_PULSADO_1;  
  file.print(int(resultado_contador));  //parte entera
  file.print("."); // punto decimal
  unsigned int frac;
  frac = (resultado_contador - int(resultado_contador)) * 10;
  file.print(frac);                    // decimales
  file.print(F(" - "));
  resultado_contador = contador2 * CONSTANTE_PULSADO_2;  
  file.print(int(resultado_contador));  //parte entera
  file.print("."); // punto decimal
  frac = (resultado_contador - int(resultado_contador)) * 10;
  file.print(frac);                    // decimales 
  file.print(F(" - "));
  valor_analog = analogRead(analog_pin);
  valor = float(valor_analog) / 1023;
  valor2 = valor * 47000;
  valor2 = (valor2/(1-valor));
  switch (valor_analog) {
    case 410 ... 430:
      file.print(long(valor2));                            
      break;
    case 140 ... 160:
      file.print(long(valor2));                            
      break;
    case 15 ... 30:
      file.print(long(valor2));                            
      break;
    case 40 ... 50:
      file.print(long(valor2));                            
      break;
    case 65 ... 90:
      file.print(long(valor2));                            
      break;
    case 245 ... 270:
      file.print(long(valor2));                            
      break;
    case 720 ... 740:
      file.print(long(valor2));                            
      break;
    case 580 ... 610:
      file.print(long(valor2));                            
      break;
    default:
      file.print(F("N/A"));
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
  valorV = ((val1 * 3.45)/512);
  file.print(valorV,2);    
  file.println(F(" V"));    
  // Cerrar archivo
  file.close();
  SD.chdir("/");
  delay(500);
}

// --------------------------------------------
void GrabarArchivoEncriptado(){
  String encriptado;
  char caracter;
  xxtea.setKey("mi contrasenia");
  
  while (posicion <= tamanio){
    file = SD.open(str, O_READ);    
    file.seek(posicion);
    for (int i = 0; i <= 66; i++){
      caracter = file.read();
      encriptado += caracter;
    }
    file.close();
    posicion += 67;
  
    file = SD.open(str3, O_WRITE | O_CREAT | O_APPEND);
    encriptado = xxtea.encrypt(encriptado);
    encriptado.toLowerCase();
    file.print(encriptado);    
    file.close();
    encriptado = "";      
  }
    posicion = 0;  
}

// --------------------------------------------

// Procedimiento invocado cada vez que se produce un pulso en los pines predefinidos, incrementa los contadores
void pinChanged(Pin* pin, bool pinstate) {
  if ((pin->number)==2){
      contador1++;    
  }
  if ((pin->number)==3){
      contador2++;        
  }
}

// --------------------------------------------

// Procedimiento que espera la llegada de un caracter por le vía USB-TTL y reacciona en consecuencia
// enviando los archivos que corresponde en cada caso o limpiando la tarjeta.
void pedido_usb(){
    byte datito;
    byte inByte;
    if (Serial.available() > 0) {
     inByte = Serial.read();
     digitalWrite(SD2_CS, HIGH);      
     while(!SD.begin(SD_CS)){
      digitalWrite(ZUMBADOR,HIGH);
      delay(1000);
     }     
     while (Serial.available() > 0) {Serial.read();}
     if (inByte=='a'){
      
        digitalWrite(LED_ROJO,HIGH);
        delay(200);
        digitalWrite(LED_ROJO,LOW);        
        file.open("full.txt", O_READ); 
        while (file.available()) {                      // mientras no se haya llegado al final
              datito = file.read();
              Serial.write(datito);              
        }
        file.close();
        Serial.println("#");
        Serial.println("");
        inByte=0;    
        }
     }
     else if (inByte=='b'){
        digitalWrite(LED_ROJO,HIGH);
        delay(200);
        digitalWrite(LED_ROJO,LOW);        
        file.open("bita.txt", O_READ);
        while (file.available()) {                      // mientras no se haya llegado al final
            datito = file.read();
            Serial.write(datito);
        }              
        file.close();
        Serial.print("#");
        Serial.println("");        
        inByte=0;
     }
     else if (inByte=='i'){
        digitalWrite(LED_ROJO,HIGH);
        delay(200);
        digitalWrite(LED_ROJO,LOW);
        file.open("alim.txt", O_READ);
        while (file.available()) {                      // mientras no se haya llegado al final
            datito = file.read();
            Serial.write(datito);
        }              
        file.close();
        Serial.print("@");
        Serial.println("");        
        inByte=0;    
     }
     else if (inByte=='z'){
        digitalWrite(LED_ROJO,HIGH);
        SD.remove("full.txt");
        SD.remove("alim.txt");
        Serial.print("$");
        digitalWrite(LED_ROJO,LOW);        
        inByte=0;    
     }
}


// =====================================================================================================================================================================

void setup(){
  // Inicialización de pines (entrada, salida, etc)
  analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
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

  // Inicialización de periféricos, SD y sensores
  Serial.begin(57600);
  Wire.begin();
  SPI.begin();
  // Bloque que inicializa los pines que funcionan como contadores de pulsos.
  for (int i=0; i<ARRAY_SIZE(monitored_pins); i++) {
    pinMode(monitored_pins[i].number, INPUT_PULLUP);
    PcInt::attachInterrupt(monitored_pins[i].number, pinChanged, &monitored_pins[i], FALLING);
  }  
  // Sensores
  bmp.begin();
  dht.broadcast(DHT22, A0);
  //Serial.println(F("Iniciado"));  
}



void loop(void) {  

    for (cantidad_segundos = 0 ;  cantidad_segundos  < intervalo ; cantidad_segundos++){
        LowPower.idle(SLEEP_1S, ADC_OFF, TIMER2_OFF, TIMER1_OFF, TIMER0_OFF, SPI_OFF, USART0_ON, TWI_OFF);  
    }

    digitalWrite(SD2_CS, HIGH);      
    while(!SD.begin(SD_CS)){
      //Serial.println(F("Error de tarjeta SD1!"));
      digitalWrite(ZUMBADOR,HIGH);
      delay(1000);
    }     
    obtenerFechaHora();
    grabar_datos_archivo(false);        //grabar en el principal
    grabar_alimentacion(false);
//        grabar_datos_archivo(true);         //grabar en \respaldo
//        grabar_alimentacion(true);
    contador1 = 0;
    contador2 = 0;        
    indice++;
    delay(100);      
    digitalWrite(SD_CS, HIGH);
    while(!SD.begin(SD2_CS)){
      //Serial.println(F("Error de tarjeta SD2!"));
      digitalWrite(ZUMBADOR,HIGH);
      delay(1000);
    }
    file = SD.open(str, O_READ);
    tamanio = file.size();
    file.close();       
    GrabarArchivoEncriptado();
    //Serial.println(F("**"));
    digitalWrite(TESTIGO,HIGH);
    delay(1000);    
    digitalWrite(TESTIGO,LOW);
    delay(100);


//    }
//
//    // Espera llegada de caracter por la USB-TTL serial.
    pedido_usb();       

    
}
