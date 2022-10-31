// firm que espera la llegada del pedido desde la AMENAN1D para a continuación enviar el archivo TRAMAS.TXT
 
#include <SPI.h>
#include "RF24.h"
#include <SD.h>
#include "LowPower.h"
#include <Wire.h>
// librerías para usar el sensor de humedad
#include "Adafruit_Sensor.h"
#include <DHT.h>
#include <DHT_U.h>
#include <Adafruit_BMP085.h>


#define DHTPIN            A0        // Pin de comunicación con el sensor.
#define DHTTYPE           DHT22     // DHT 22 (o el AM2302 que tenemos), define el tipo de sensor de humedad
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9 
#define PULSADOR          2
#define BATA1             7
#define BATA2             6

DHT_Unified dht(DHTPIN, DHTTYPE);

Adafruit_BMP085 bmp;

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


// Nombre del archivo donde se dejarán las tramas
char str[] = "tramas.txt";
volatile int contador = 0;    // cuenta de pulsados
int indice = 0;               // índice de tramas
String cadena=String(3);

const char CONSTANTE[3] = "C1";
const int CONSTANTE_PULSADO = .3;

boolean bandera_grabacion = true;

/****************** User Config ***************************/
/***      Set this radio as radio number 0 or 1         ***/
bool radioNumber = 0;

/* Hardware configuration: Set up nRF24L01 radio on SPI bus plus pins A1 & A2 */
RF24 radio(A1,A2);
/**********************************************************/
                                                                           // Topology
byte addresses[][6] = {"1Node","2Node"};              // Radio pipe addresses for the 2 nodes to communicate.

// Role management: Set up role.  This sketch uses the same software for all the nodes
// in this system.  Doing so greatly simplifies testing.  
typedef enum { role_ping_out = 1, role_pong_back } role_e;                 // The various roles supported by this sketch
const char* role_friendly_name[] = { "invalid", "Ping out", "Pong back"};  // The debug-friendly names of those roles

//role_e role = role_pong_back;                                              // The role of the current running sketch
role_e role = role_ping_out;
byte counter = 1;                                                          // A single byte to keep track of the data being sent back and forth
char data[32];
int i;
// constante que define cuantos segundos estará dormido antes de despertarse y medir
const int intervalo = 10;
volatile int cantidad_segundos = 0;

const int wakeUpPin = 2;

byte gotByte;

boolean transmitir = false;
boolean primer_paquete = true;


void conmutar_sd_nordic(boolean x){
  if (x==true){
      digitalWrite(5,LOW);
      //pin CS a la SD definido como salida
      pinMode(SD_CS,OUTPUT);
      // initializar SPI
      SPI.begin();
      delay(2);
//      if (!SD.begin(SD_CS)) {
//          //digitalWrite(LED_ROJO,HIGH);
//        return;
//      }           
      SD.begin(SD_CS);
      radio.begin();
      radio.setPALevel(RF24_PA_LOW);
      if(radioNumber){
          radio.openWritingPipe(addresses[1]);        // Both radios listen on the same pipes by default, but opposite addresses
          radio.openReadingPipe(1,addresses[0]);      // Open a reading pipe on address 0, pipe 1
      }else{
          radio.openWritingPipe(addresses[0]);
          radio.openReadingPipe(1,addresses[1]);
      }
      radio.startListening();                       // Start listening  
  }else{
      digitalWrite(5,HIGH);
      pinMode(SD_CS,INPUT);
      // initializar SPI
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

// --------------------------------------------
void grabar_datos_archivo_ascii()
{
  char buffer1[3];
  char buffer2[8];
  File outFile;
  outFile = SD.open(str, FILE_WRITE);
  if (!outFile) {
    Serial.println(F("No se pudo abrir el archivo"));
    return;
  }     
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
    outFile.print(cadena);
//    outFile.print(event.temperature);
    //outFile.print(F(" *C"));
  }
  // Humedad
  dht.humidity().getEvent(&event);
  if (isnan(event.relative_humidity)) {
    Serial.println(F("Error leyendo humedad!"));
  }
  else {
    outFile.print(F(" - "));
    cadena = String(event.relative_humidity);
    cadena.replace('.',',');
    outFile.print(cadena);
    //outFile.print(event.relative_humidity);
    //outFile.print(F("%"));
    outFile.print(F(" -               "));
    }  
 

// Leer sensor de presión y temperatura BMP180
//    cadena = String(bmp.readTemperature());
//    cadena.replace('.',',');
//    outFile.print(cadena);
//    outFile.print(F(" - "));
//    //outFile.print(F(" *C"));
//    cadena = String((bmp.readPressure())/100);
//    outFile.print(cadena);
//    outFile.print(F(" - "));
//    //outFile.print(F(" hPa - "));
    
    sprintf(buffer1, "%02d", (contador * CONSTANTE_PULSADO ));
    outFile.print(buffer1);

  // Cerrar archivo
  outFile.close();
}


//void grabar_datos_archivo_binario()
//{
//  char buffer1[3];
//  char buffer2[8];
//  File outFile;
//
//  byte ESPACIO = 32;
//  outFile = SD.open(str, FILE_WRITE);
//  if (!outFile) {
//    Serial.println(F("No se pudo abrir el archivo"));
//    return;
//  }     
//  obtenerFechaHora();
//  outFile.write(CONSTANTE,sizeof(CONSTANTE));
//  outFile.write(ESPACIO);  
//  outFile.write(highByte(indice));
//  outFile.write(lowByte(indice));  
//  indice = indice + 1;
//  outFile.write(ESPACIO);    
//  outFile.write(dia);
//  outFile.write(mes);
//  outFile.write(anio);
//  outFile.write(ESPACIO);  
//  outFile.write(hora);
//  outFile.write(minuto);
//  outFile.write(segundo);
//  outFile.write(ESPACIO);  
//
//  // Leer sensor de humedad y temperatura AM2302
////  sensors_event_t event;  
////  // Temperatura
////  dht.temperature().getEvent(&event);
////  if (isnan(event.temperature)) {
////    Serial.println(F("Error leyendo temperatura!"));
////  }
////  else {
////    cadena = String(event.temperature);
////    cadena.replace('.',',');
////    outFile.print(cadena);
//////    outFile.print(event.temperature);
////    //outFile.print(F(" *C"));
////  }
////  // Humedad
////  dht.humidity().getEvent(&event);
////  if (isnan(event.relative_humidity)) {
////    Serial.println(F("Error leyendo humedad!"));
////  }
////  else {
////    outFile.print(F(" - "));
////    cadena = String(event.relative_humidity);
////    cadena.replace('.',',');
////    outFile.print(cadena);
////    //outFile.print(event.relative_humidity);
////    //outFile.print(F("%"));
////    outFile.print(F(" - "));
////    }  
// 
//
//// Leer sensor de presión y temperatura BMP180
////    cadena = String(bmp.readTemperature());
////    cadena.replace('.',',');
////    outFile.print(cadena);
////    outFile.print(F(" - "));
////    //outFile.print(F(" *C"));
////    cadena = String((bmp.readPressure())/100);
////    outFile.print(cadena);
////    outFile.print(F(" - "));
////    //outFile.print(F(" hPa - "));
//
//  floatAsBytes.fval = contador * CONSTANTE_PULSADO;
//  outFile.write(floatAsBytes.bval[3]);
//  outFile.write(floatAsBytes.bval[2]);
//  outFile.write(floatAsBytes.bval[1]);
//  outFile.write(floatAsBytes.bval[0]);
//
//  // Cerrar archivo
//  outFile.close();
//}


void setup(){
  pinMode(5, OUTPUT);
  //digitalWrite(5,HIGH);  

  digitalWrite(5,LOW);  
  
  pinMode(PULSADOR,INPUT_PULLUP );

  pinMode(LED_ROJO, OUTPUT);
  // prender 2 segs el led rojo
  digitalWrite(LED_ROJO,HIGH);
  delay(2000);    //2 segs  
  digitalWrite(LED_ROJO,LOW);

  // Inicializar I2C
  Wire.begin();
  // Configure wake up pin as input.
  // This will consumes few uA of current.
  pinMode(wakeUpPin, INPUT_PULLUP);   

  // inicializar sensor de humedad y temperatura
  dht.begin();            

  // inicializar sensor de presión y temperatura
  bmp.begin();

  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();

  //Inicializar SD
  if (!SD.begin(SD_CS)) {
    //Serial.println("Card failed, or not present");
      digitalWrite(LED_ROJO,HIGH);
    // don't do anything more:
    return;
  }

//  File dataFile = SD.open("TRAMAS.txt"); 
//  if (!outFile) {
//    Serial.println(F("No se pudo abrir el archivo"));
//    return;
//  }     
  //dataFile.println(F("   INDICE   FECHA      HORA       TEMP        HUM%  PULSADOS"));
//  dataFile.close();
//  delay(10);
  
  // Setup and configure radio
  radio.begin();
  radio.setPALevel(RF24_PA_LOW);
  //radio.setPALevel(RF24_PA_MAX);
  //radio.enableAckPayload();                     // Allow optional ack payloads
  //radio.enableDynamicPayloads();                // Ack payloads are dynamic payloads
  
  if(radioNumber){
    radio.openWritingPipe(addresses[1]);        // Both radios listen on the same pipes by default, but opposite addresses
    radio.openReadingPipe(1,addresses[0]);      // Open a reading pipe on address 0, pipe 1
  }else{
    radio.openWritingPipe(addresses[0]);
    radio.openReadingPipe(1,addresses[1]);
  }
  radio.startListening();                       // Start listening  
  
  //radio.writeAckPayload(1,&counter,1);          // Pre-load an ack-paylod into the FIFO buffer for pipe 1
  //radio.printDetails();     // <--- para que esto funcione hay que declarar un include extra, ....
}


void loop(void) {

    for (cantidad_segundos = 0 ;  cantidad_segundos  <  intervalo ; cantidad_segundos++){
      conmutar_sd_nordic(false);
      //LowPower.idle(SLEEP_1S, ADC_OFF, TIMER2_OFF, TIMER1_OFF,TIMER0_OFF, SPI_OFF, USART0_OFF, TWI_OFF);
      LowPower.powerDown(SLEEP_1S, ADC_OFF, BOD_OFF); 
    }

    conmutar_sd_nordic(true);
    delay(50);
    grabar_datos_archivo(); 

    // si llegó paquete RF
    while(radio.available()){        
        radio.read( &data, 32 );
        if (data[0] == '1'){              // <-- este número identifica al PONGER, si el valor 1, se llama al Ponger #1 y así siguiendo
           transmitir = true;
           digitalWrite(LED_ROJO,HIGH);   //mientras transmite el archivo el led rojo está prendido
        }       
    }

          
    if (transmitir == true){
        radio.stopListening();
        transmitir = false;      
        // abrir archivo
        File dataFile = SD.open("TRAMAS.txt");                 
        if (dataFile) {                                        // si se pudo abrir el archivo
           while (dataFile.available()) {                      // mientras no se haya llegado al final
              for (i = 0; i < 31; i = i + 1) {
                  data[i] = dataFile.read();                   // cargar arreglo de 32 bytes a enviar
                  }
              //enviarlo via Nordic
              if (radio.write(&data,32) ){                     
                   if(!radio.available()){                     // If nothing in the buffer, we got an ack but it is blank
              }}
              if (primer_paquete == true){                    // bloque para darle tiempo al pinger de bipear 3 veces luego del primer paquete
                primer_paquete = false;
                
                
                delay(400);        // para que pitee el pinger avisando que empezó el archivo        
              
              
              }
          delay(12);       // delay para NO ATOSIGAR AL pinger
          }
       dataFile.close();
       // flushing necesario????
//       if (radio.write(&data,32) ){                     
//           if(!radio.available()){                     // If nothing in the buffer, we got an ack but it is blank
//       }}
       for (int i=0; i <= 31; i++){
          data[i] = ' ';
          } 
       // mandar un paquete de cierre de archivo (usamos el 1er elemento nomás por ahora)
       data[0] = '@';
       data[1] = '@';
       data[2] = '@';       
       if (radio.write(&data,32) ){                     
             if(!radio.available()){                     // If nothing in the buffer, we got an ack but it is blank
        }}
        digitalWrite(LED_ROJO,LOW);           // apagar led al terminar
        radio.startListening();
        }      
     }
}
