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
#include "RF24.h"


#include <Wire.h>
#include <Adafruit_BMP085.h>

Adafruit_BMP085 bmp;

#include "RTClib.h"

RTC_DS3231 rtc;

//#include <ArduCAM.h>
//#include "memorysaver.h"


#define ACTIVADO          LOW
#define DHTPIN            A0        // Pin de comunicación con el sensor.
#define DHTTYPE           DHT22     // DHT 22 (o el AM2302 que tenemos), define el tipo de sensor de humedad
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9         // alias del pin del led rojo

DHT_Unified dht(DHTPIN, DHTTYPE);


RF24 radio(7,8);
byte addresses[][6] = {"1Node","2Node"};
bool radioNumber = 0;

// Used to control whether this node is sending or receiving
bool role = 0;

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

////This demo can only work on OV2640_MINI_2MP or OV5642_MINI_5MP or OV5642_MINI_5MP_BIT_ROTATION_FIXED platform.
//#if !(defined OV5642_MINI_5MP || defined OV5642_MINI_5MP_BIT_ROTATION_FIXED || defined OV2640_MINI_2MP || defined OV3640_MINI_3MP)
//  #error Please select the hardware platform and camera module in the ../libraries/ArduCAM/memorysaver.h file
//#endif
#define SD_CS 9
//const int SPI_CS = 7;



//#if defined (OV2640_MINI_2MP)
//  ArduCAM myCAM( OV2640, SPI_CS );
//#elif defined (OV3640_MINI_3MP)
//  ArduCAM myCAM( OV3640, SPI_CS );
//#else
//  ArduCAM myCAM( OV5642, SPI_CS );
//#endif
//
//void myCAMSaveToSDFile(){
//char str[8];
//byte buf[256];
//static int i = 0;
//static int k = 0;
//uint8_t temp = 0,temp_last=0;
//uint32_t length = 0;
//bool is_header = false;
//File outFile;
////Flush the FIFO
//myCAM.flush_fifo();
////Clear the capture done flag
//myCAM.clear_fifo_flag();
////Start capture
//myCAM.start_capture();
//Serial.println(F("start Capture"));
//while(!myCAM.get_bit(ARDUCHIP_TRIG , CAP_DONE_MASK));
//Serial.println(F("Capture Done."));  
//length = myCAM.read_fifo_length();
//Serial.print(F("The fifo length is :"));
//Serial.println(length, DEC);
//if (length >= MAX_FIFO_SIZE) //384K
//{
//  Serial.println(F("Over size."));
//  return ;
//}
//if (length == 0 ) //0 kb
//{
//  Serial.println(F("Size is 0."));
//  return ;
//}
////Construct a file name
//k = k + 1;
//itoa(k, str, 10);
//strcat(str, ".jpg");
////Open the new file
//outFile = SD.open(str, O_WRITE | O_CREAT | O_TRUNC);
//if(!outFile){
//  Serial.println(F("File open faild"));
//  return;
//}
//myCAM.CS_LOW();
//myCAM.set_fifo_burst();
//while ( length-- )
//{
//  temp_last = temp;
//  temp =  SPI.transfer(0x00);
//  //Read JPEG data from FIFO
//  if ( (temp == 0xD9) && (temp_last == 0xFF) ) //If find the end ,break while,
//  {
//    buf[i++] = temp;  //save the last  0XD9     
//    //Write the remain bytes in the buffer
//    myCAM.CS_HIGH();
//    outFile.write(buf, i);    
//    //Close the file
//    outFile.close();
//    Serial.println(F("Image save OK."));
//    is_header = false;
//    i = 0;
//  }  
//  if (is_header == true)
//  { 
//    //Write image data to buffer if not full
//    if (i < 256)
//    buf[i++] = temp;
//    else
//    {
//      //Write 256 bytes image data to file
//      myCAM.CS_HIGH();
//      outFile.write(buf, 256);
//      i = 0;
//      buf[i++] = temp;
//      myCAM.CS_LOW();
//      myCAM.set_fifo_burst();
//    }        
//  }
//  else if ((temp == 0xD8) & (temp_last == 0xFF))
//  {
//    is_header = true;
//    buf[i++] = temp_last;
//    buf[i++] = temp;   
//  } 
//} 
//}




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

radio.begin();

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

  // Set the PA Level low to prevent power supply related issues since this is a
 // getting_started sketch, and the likelihood of close proximity of the devices. RF24_PA_MAX is default.
  radio.setPALevel(RF24_PA_LOW);
  
  // Open a writing and reading pipe on each radio, with opposite addresses
  if(radioNumber){
    radio.openWritingPipe(addresses[1]);
    radio.openReadingPipe(1,addresses[0]);
  }else{
    radio.openWritingPipe(addresses[0]);
    radio.openReadingPipe(1,addresses[1]);
  }
  
  // Start the radio listening for data
  radio.startListening();







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


    Serial.print(bmp.readTemperature());
    Serial.println(" *C");
  
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

    unsigned long start_time = micros();                             // Take the time, and send it.  This will block until complete
    radio.write( &start_time, sizeof(unsigned long));

}




