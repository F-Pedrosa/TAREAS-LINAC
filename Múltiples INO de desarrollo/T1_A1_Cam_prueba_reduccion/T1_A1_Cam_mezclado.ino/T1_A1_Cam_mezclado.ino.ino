// 
 
#include <SPI.h>
#include "SdFat.h"
#include "LowPower.h"
#include <Wire.h>
// librerías para usar el sensor de humedad
#include <Adafruit_BMP085.h>
#include "Adafruit_Sensor.h"
#include <DHT.h>
#include <ArduCAM.h>

// file system
SdFat SD;
File file;

#define DHTPIN            A0        // Pin de comunicación con el sensor.
#define DHTTYPE           DHT22     // DHT 22 (o el AM2302 que tenemos), define el tipo de sensor de humedad
//#define SSID "nodoA1"   // acá el nombre de la red wifi
const char CONSTANTE[3] = "A1";
//#define PASS "pepepepe" // esta es la contraseña para la misma 
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9 
#define PULSADOR          2
//#define BATA1             7
//#define BATA2             6

const int SPI_CS = 8;

ArduCAM myCAM( OV2640, SPI_CS );

// macro para simplificar escritura (y ver si de paso se achica el uso de memoria y programa)
//#define cerrar {Serial.println(F("AT+CIPCLOSE=0"));}

Adafruit_BMP085 bmp;
DHT dht(DHTPIN, DHTTYPE);

// dirección en el bus I2C del RTC
const int DS3231 = 0x68;

const float CONSTANTE_PULSADO = 0.3;

// Inicializar variables de fecha y hora
byte segundo = 0;
byte minuto = 0;
byte hora = 0;
byte mes = 0;
byte anio = 0;
byte weekday = 0;
byte dia = 0;

float resultado_contador =0;
float t_h;

// Nombre del archivo donde se dejarán las tramas
const char str[] = "full.txt";
//const char logfile[] = "bita.txt";
const char str2[] = "alim.txt";

volatile int contador = 0;    // cuenta de pulsados
unsigned long indice = 0;               // índice de tramas
String cadena=String(3);
boolean bandera_grabacion = true;
unsigned int cuenta = 0;
unsigned int resto = 0;
byte inByte;
volatile int cantidad_segundos = 0;
const int wakeUpPin = 2;
boolean salir = false;

//char receivedChars[28];
//String mi_cadena = "    ";
//unsigned int tiempo = 0;
//boolean newData = false;
//boolean recvInProgress = false;
//byte ndx = 0;
//char str3[] = "0000.txt";
//const String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";
//const String encabezado2 = "HTTP/1.1 208 OK\r\nContent-Type: text/html\r\n\r\n";
////String encabezado3 = "HTTP/1.1 205 OK\r\nContent-Type: ";   // para enviar tiempo estimado de transmisión
//const String cipSend = "AT+CIPSEND=0,2048";
//String cipSend2 = "AT+CIPSEND=0,";
//boolean primer_paquete = false;
//boolean segundo_paquete = false;
//boolean una_vez = true;
//unsigned long tamanio = 0;
//unsigned int cantidad_paquetes = 0;
//unsigned int cuenta3 = 0;
//unsigned int cuenta2 = 1; 
// constante que define cuantos segundos estará dormido antes de despertarse y medir
const int intervalo = 20;                    // 5 minutos, valor aleatorio elegido sin mayor implicancia
unsigned long currentMillis = 0;
unsigned long previousMillis = 0;
const unsigned long interval = 50000;                       // 50 segundos es el tiempo que le asignamos para esperar el pedido desde el cel.

unsigned long previo_milis = 0;
//const unsigned long tiempo_grabacion = 275000;            // 2 minutos (70000 + 50000 ms) menos los 50 s del lazo de espera de llegada de pedido WiFi
const unsigned long tiempo_grabacion = 10000;      // para probar con la ArduCAM, graba cada 10 segs sensores y JPG

//char buffer1[3];
//char buffer2[8];
//boolean problema_rtc = false;
//byte contador_alarma = 0;
//boolean una_vez_alarma = true;
//char buffer[18];
//char OKrn[] = "OK\r\n";  

void myCAMSaveToSDFile(){
char str[8];
byte buf[256];
static int i = 0;
static int k = 0;
uint8_t temp = 0,temp_last=0;
uint32_t length = 0;
bool is_header = false;
File outFile;
myCAM.flush_fifo();
myCAM.clear_fifo_flag();
myCAM.start_capture();
Serial.println(F("Comienza captura"));
while(!myCAM.get_bit(ARDUCHIP_TRIG , CAP_DONE_MASK));
Serial.println(F("Captura hecha."));  
length = myCAM.read_fifo_length();
if (length == 0 ) //0 kb
{
  //Serial.println(F("Size is 0."));
  return ;
}
//Construct a file name
k = k + 1;
itoa(k, str, 10);
strcat(str, ".jpg");
//Open the new file
outFile = SD.open(str, O_WRITE | O_CREAT | O_TRUNC);
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
    Serial.println(F("Imagen grabada"));
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


void grabar_datos_archivo(bool x)
{
  char buffer1[3];
  char buffer2[8];

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
  
  dht.read();
  delay(2000);
  //dht.read();  
  file.print(dht.readTemperature(),1);
  file.print(F(" - "));
  delay(100);
  file.print(dht.readHumidity(),1);
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
  // Cerrar archivo
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
  valorV = ((val1 * 11.8)/813);
  file.print(valorV,2);    
  file.println(F(" V"));    
  // Cerrar archivo
  file.close();
  SD.chdir("/");
  delay(500);
}


// ------------------------- este código se ejecuta cdo se pulsa el pulsador, ES UNA INTERRUPCIÓN -------------------
void wakeUp(){contador = contador + 1;}
// 

void setup(){
  analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO

  Serial.begin(115200);
  pinMode(A6, INPUT);
  pinMode(5, OUTPUT);
  digitalWrite(5,LOW);  
  pinMode(PULSADOR,INPUT_PULLUP );
  pinMode(LED_ROJO, OUTPUT);
  // que bipee 2 veces
  digitalWrite(LED_ROJO,HIGH);
  delay(500);    
  digitalWrite(LED_ROJO,LOW);
  delay(100);    
  digitalWrite(LED_ROJO,HIGH);
  delay(500);    
  digitalWrite(LED_ROJO,LOW);
  delay(100);      
  // Inicializar I2C
  Wire.begin();
  pinMode(wakeUpPin, INPUT_PULLUP);   
  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // el CS de la ArduCAM como salida
  pinMode(SPI_CS,OUTPUT);
  // initializar SPI
  SPI.begin();
  //Inicializar SD, si falla, pitea ininterrumpidamente
  if (!SD.begin(SD_CS)) {
      digitalWrite(LED_ROJO,HIGH);
  }
  Serial.println(F("ArduCAM iniciado"));
  myCAM.set_format(JPEG);     //le dice a ArduCAM que use formato JPEG
  myCAM.InitCAM();
  myCAM.OV2640_set_JPEG_size(OV2640_1280x1024);     // le dice que la resolución del JPEG sea de 1280x960 (el valor 1280x1024 es inexacto)
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

    unsigned long actual_milis = millis();
    if (actual_milis - previo_milis >= tiempo_grabacion) {      // lazo que determina los 5 minutos (250 s en realidad), entre grabación y grabación 
        previo_milis = actual_milis;
        
        obtenerFechaHora();
        grabar_datos_archivo(false);        //grabar en el principal
        grabar_alimentacion(false);
        grabar_datos_archivo(true);         //grabar en \respaldo
        grabar_alimentacion(true);
        contador = 0;
        indice++;
        Serial.println(F("Grabados datos sensores"));
        myCAMSaveToSDFile();      
        digitalWrite(LED_ROJO,HIGH);
        delay(100);    
        digitalWrite(LED_ROJO,LOW);       
    }
    
}
