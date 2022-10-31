//  Este firmware es para guardar en SD un archivo con tramas de datos (índice, fecha/hora dummy, sensor T y H, pulsado), saliendo de modo sleep al pulsar, y 
// grabado de imágenes capturadas por arducam
// **** INCLUDES *****
#include "LowPower.h"

// Use pin 2 as wake up pin
const int wakeUpPin = 2;

// librerías para usar la SD
#include <SPI.h>
#include <SD.h>
// librerías para usar el sensor de humedad
#include "Adafruit_Sensor.h"
#include <DHT.h>
#include <DHT_U.h>
#include <ArduCAM.h>
#include <Wire.h>
//#include "memorysaver.h"

#define DHTPIN            A0        // Pin de comunicación con el sensor.
#define DHTTYPE           DHT22     // DHT 22 (o el AM2302 que tenemos), define el tipo de sensor de humedad
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9         // alias del pin del led rojo

DHT_Unified dht(DHTPIN, DHTTYPE);

char str[] = "tramas.txt";
volatile int contador = 0;        // guarda la cantidad de pulsados en el pin que despierta al micro
int indice = 0;                   // número de orden de trama

//This demo can only work on OV2640_MINI_2MP or OV5642_MINI_5MP or OV5642_MINI_5MP_BIT_ROTATION_FIXED platform.
#if !(defined OV5642_MINI_5MP || defined OV5642_MINI_5MP_BIT_ROTATION_FIXED || defined OV2640_MINI_2MP || defined OV3640_MINI_3MP)
  #error Please select the hardware platform and camera module in the ../libraries/ArduCAM/memorysaver.h file
#endif
const int SPI_CS = 8;

#if defined (OV2640_MINI_2MP)
  ArduCAM myCAM( OV2640, SPI_CS );
#elif defined (OV3640_MINI_3MP)
  ArduCAM myCAM( OV3640, SPI_CS );
#else
  ArduCAM myCAM( OV5642, SPI_CS );
#endif

void myCAMSaveToSDFile(){
char str[8];
byte buf[256];
static int i = 0;
static int k = 0;
uint8_t temp = 0,temp_last=0;
uint32_t length = 0;
bool is_header = false;
File outFile;
//Flush the FIFO
myCAM.flush_fifo();
//Clear the capture done flag
myCAM.clear_fifo_flag();
//Start capture
myCAM.start_capture();
Serial.println(F("start Capture"));
while(!myCAM.get_bit(ARDUCHIP_TRIG , CAP_DONE_MASK));
Serial.println(F("Capture Done."));  
length = myCAM.read_fifo_length();
Serial.print(F("The fifo length is :"));
Serial.println(length, DEC);
if (length >= MAX_FIFO_SIZE) //384K
{
  Serial.println(F("Over size."));
  return ;
}
if (length == 0 ) //0 kb
{
  Serial.println(F("Size is 0."));
  return ;
}
//Construct a file name
k = k + 1;
itoa(k, str, 10);
strcat(str, ".jpg");
//Open the new file
outFile = SD.open(str, O_WRITE | O_CREAT | O_TRUNC);
if(!outFile){
  Serial.println(F("JPG File open failed"));
  return;
}
myCAM.CS_LOW();
myCAM.set_fifo_burst();
while ( length-- )
{
  temp_last = temp;
  temp =  SPI.transfer(0x00);
  //Read JPEG data from FIFO
  if ( (temp == 0xD9) && (temp_last == 0xFF) ) //If find the end ,break while,
  {
    buf[i++] = temp;  //save the last  0XD9     
    //Write the remain bytes in the buffer
    myCAM.CS_HIGH();
    outFile.write(buf, i);    
    //Close the file
    outFile.close();
    Serial.println(F("Image save OK."));
    is_header = false;
    i = 0;
  }  
  if (is_header == true)
  { 
    //Write image data to buffer if not full
    if (i < 256)
    buf[i++] = temp;
    else
    {
      //Write 256 bytes image data to file
      myCAM.CS_HIGH();
      outFile.write(buf, 256);
      i = 0;
      buf[i++] = temp;
      myCAM.CS_LOW();
      myCAM.set_fifo_burst();
    }        
  }
  else if ((temp == 0xD8) & (temp_last == 0xFF))
  {
    is_header = true;
    buf[i++] = temp_last;
    buf[i++] = temp;   
  } 
} 
}


void crear_archivo(){
File FileSalida;
// Abrir archivo
FileSalida = SD.open(str, FILE_WRITE);
if(!FileSalida){
  Serial.println(F("No se pudo abrir el archivo TXT"));
  return;
}   
FileSalida.println(F("Encabezado archivo cuenta evento pines y sensor"));
FileSalida.println(F("INDICE   FECHA      HORA   TEMP       HUM%   PULSADOS"));    
// Cerrar archivo
FileSalida.close();
}

void grabar_datos_archivo(){
File FileSalida;
FileSalida = SD.open(str, FILE_WRITE);
if(!FileSalida){
  Serial.println(F("No se pudo abrir el archivo TXT para agregar trama"));
  return;
}   
FileSalida.print(indice);
indice = indice + 1;
FileSalida.print(F(" - AA/MM/DD - HH:MM:SS - "));    
// Leer sensor de humedad y temperatura AM2302
sensors_event_t event;  
// Temperatura
dht.temperature().getEvent(&event);
if (isnan(event.temperature)) {
  Serial.println(F("Error leyendo temperatura!"));
}
else {
  FileSalida.print(event.temperature);
  FileSalida.print(F(" ºC"));
}
// Humedad
dht.humidity().getEvent(&event);
if (isnan(event.relative_humidity)) {
  Serial.println(F("Error leyendo humedad!"));
}
else {
  FileSalida.print(F(" - "));
  FileSalida.print(event.relative_humidity);
  FileSalida.print(F("%"));
  FileSalida.print(F(" - "));
  FileSalida.println(contador);
}  
// Cerrar archivo
FileSalida.close();

}


void wakeUp()
{
    // el código (si hay alguno) de la interrupción.
    contador = contador + 1;
}


// ========================================================================================================================================================

void setup()
{
    // Configure wake up pin as input.
    // This will consumes few uA of current.
    pinMode(wakeUpPin, INPUT_PULLUP);   

  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);

  //iniciar la salida serial de debug
  Serial.begin(9600);

  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);

  pinMode(LED_ROJO, OUTPUT);
  // prender 2 segs el led rojo
  digitalWrite(LED_ROJO,HIGH);
  delay(2000);    //2 segs  
  digitalWrite(LED_ROJO,LOW);

  uint8_t vid, pid;
  uint8_t temp;
  Wire.begin();
  Serial.println(F("ArduCAM Start!"));
  
  pinMode(SPI_CS,OUTPUT);
  // initialize SPI:
  SPI.begin();

  while(1){
    //Check if the ArduCAM SPI bus is OK
    myCAM.write_reg(ARDUCHIP_TEST1, 0x55);
    temp = myCAM.read_reg(ARDUCHIP_TEST1);
    
    if (temp != 0x55){
      Serial.println(F("SPI interface Error!"));
      delay(1000);continue;
    }else{
      Serial.println(F("SPI interface OK."));break;
    }
  }


  //Initialize SD Card
  while(!SD.begin(SD_CS)){
    Serial.println(F("SD Card Error!"));
    digitalWrite(LED_ROJO,HIGH);
    delay(100);
    digitalWrite(LED_ROJO,LOW);  
    delay(1000);
  }

  #if defined (OV2640_MINI_2MP)     // esta definición está hecha en un archivo EXTERNO
    while(1){
      //Check if the camera module type is OV2640
      myCAM.wrSensorReg8_8(0xff, 0x01);
      myCAM.rdSensorReg8_8(OV2640_CHIPID_HIGH, &vid);
      myCAM.rdSensorReg8_8(OV2640_CHIPID_LOW, &pid);
      if ((vid != 0x26 ) && (( pid != 0x41 ) || ( pid != 0x42 ))){
        Serial.println(F("Can't find OV2640 module!"));
        delay(1000);continue;
      }
      else{
        Serial.println(F("OV2640 detected."));break;
      } 
    } 
  #endif

  myCAM.set_format(JPEG);     //le dice a ArduCAM que use formato JPEG
  myCAM.InitCAM();
  myCAM.OV2640_set_JPEG_size(OV2640_1280x1024);     // le dice que la resolución del JPEG sea de 1280x960 (el valor 1280x1024 es inexacto)
 
  // inicializar sensor de humedad
  dht.begin();            

  crear_archivo();  
  
  Serial.println(F("Arrancando"));
  delay(1000);
}


void loop() 
{
    // Habilitar la interrupción que se producirá al oprimirse el botón conectado al pin 2
    //attachInterrupt(0, wakeUp, FALLING);
    
    // para despertarse periódicamente cada 10 ( 5 x 2 s)    
    for (int i = 0 ;  i  <  6 ; i++){
             LowPower.powerDown(SLEEP_2S, ADC_OFF, BOD_OFF);      
    }   
    
    // Deshabilitar momentáneamente la interrupción para evitar molestias durante el procesado
    detachInterrupt(0);     
    // Carga útil, grabar datos en el archivo de la SD
    grabar_datos_archivo();  
    Serial.println(F("Se grabó trama"));
    delay(100);
    digitalWrite(LED_ROJO,HIGH);
    delay(50);  
    digitalWrite(LED_ROJO,LOW);    
    // limpiar cuenta de eventos en pin entrada
    contador = 0;
    // capturar y guardar imagen
    myCAMSaveToSDFile();
    delay(1000);
}
