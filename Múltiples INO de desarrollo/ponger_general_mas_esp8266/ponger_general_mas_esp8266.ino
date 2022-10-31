// Firm que espera la llegada del pedido desde la AMENAN1D para a continuación enviar el archivo TRAMAS.TXT
// Incluye las rutinas para esperar el pedido de archivo desde un celular android
 
#include <SPI.h>
#include "RF24.h"
//#include <SD.h>
#include "SdFat.h"
#include "LowPower.h"
#include <Wire.h>
// librerías para usar el sensor de humedad
#include "Adafruit_Sensor.h"
#include <DHT.h>
#include <DHT_U.h>
#include <Adafruit_BMP085.h>

// file system
SdFat SD;
// test file
SdFile file;

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

float resultado_contador =0;

// Nombre del archivo donde se dejarán las tramas
char str[] = "tramas.txt";
volatile int contador = 0;    // cuenta de pulsados
int indice = 0;               // índice de tramas
String cadena=String(3);

const char CONSTANTE[3] = "E2";
const float CONSTANTE_PULSADO = 0.3;

boolean bandera_grabacion = true;

unsigned long cantidad_paquetes = 0; 
boolean enviar = false;
char str3[] = "archivo.txt";
int cuenta = 0;
int cuenta2 = 1;
int resto = 0;
byte inByte;

const int wakeUpPin = 2;

byte gotByte;

boolean transmitir = false;
boolean primer_paquete = true;

int i;
// constante que define cuantos segundos estará dormido antes de despertarse y medir
const int intervalo = 10;
volatile int cantidad_segundos = 0;

#define BUFFER_SIZE 128
char buffer[BUFFER_SIZE];
char OKrn[] = "OK\r\n";  

byte wait_for_esp_response(int timeout, char* term=OKrn) {  
  unsigned long t=millis();  
  bool found=false;  
  int i=0;  
  int len=strlen(term);  

  // wait for at most timeout milliseconds  
  // or if OK\r\n is found  
  while(millis()<t+timeout) {  
     if(Serial.available()) {  
        buffer[i++]=Serial.read();  
        if(i>=len) {  
           if(strncmp(buffer+i-len, term, len)==0) {  
              found=true;  
              break;  
           }  
        }  
     }  
  }  
  buffer[i]=0;  
  //Serial.print(buffer);  
  return found;  
}   

void inicializar_wifi(void){
  // establecer seteos del módulo   
  Serial.println(F("AT+CWMODE=3"));
  wait_for_esp_response(1000);
  Serial.println(F("AT+CWDHCP=2,1"));
  wait_for_esp_response(1000);
  Serial.println(F("AT+CIPMUX=1"));
  wait_for_esp_response(1000);
  Serial.print(F("AT+CWSAP="));
  Serial.write(34);
  Serial.print(F("red de prueba"));
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.write(34);    //comilla 
  Serial.print("pepepepe");
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.println(F("5,3"));
  wait_for_esp_response(1500);
  Serial.println(F("ATE0"));
  wait_for_esp_response(1000);
}

void envia_archivo_wifi(void){
      enviar = false; 
      Serial.println(F("ATE1"));
      wait_for_esp_response(1000);
                  
      delay(20000);          // retardo largo para poder arrancar servidores FTP y TCP en el celular

      // mensaje de inicio
      Serial.print(F("AT+CIPSTART=4,"));
      Serial.write(34);
      Serial.print(F("TCP"));
      Serial.write(34);
      Serial.print(F(","));
      Serial.write(34);
      Serial.print(F("192.168.4.2"));
      Serial.write(34);      
      Serial.println(F(",9999"));
      wait_for_esp_response(5000);
      Serial.println(F("AT+CIPSEND=4,19"));
      wait_for_esp_response(1500);
      Serial.println(F("INICIO DE PROCESO"));
      wait_for_esp_response(1000);
      Serial.println(F("AT+CIPCLOSE=4"));
      wait_for_esp_response(1000);

      delay(2000);          
      // comienza proceso de transmisión del archivo
      Serial.println(F("AT+CIPSERVER=1,1027"));    
      wait_for_esp_response(1000);
      Serial.print(F("AT+CIPSTART=4,"));
      Serial.write(34);
      Serial.print(F("TCP"));
      Serial.write(34);
      Serial.print(F(","));
      Serial.write(34);
      Serial.print(F("192.168.4.2")); 
      Serial.write(34);      
      Serial.println(F(",9090"));
      wait_for_esp_response(5000);
      Serial.println(F("AT+CIPSEND=4,11"));
      wait_for_esp_response(1500);
      Serial.println(F("USER user"));
      wait_for_esp_response(1000);
      Serial.println(F("AT+CIPSEND=4,11"));      
      wait_for_esp_response(1000);
      Serial.println(F("PASS pass"));
      wait_for_esp_response(1000);
      Serial.println(F("AT+CIPSEND=4,22"));
      wait_for_esp_response(1000);
      Serial.println(F("PORT 192,168,4,1,4,3"));      
      //Serial.println("");
      wait_for_esp_response(4000);
      Serial.println(F("AT+CIPSEND=4,31"));
      //Serial.println(F("AT+CIPSEND=4,19"));
      wait_for_esp_response(1000);
      Serial.print(F("STOR "));
      obtenerFechaHora();
      //Serial.print(F("archivo.txt"));
      Serial.print(F("archivo"));
      char buf[12]; 
      sprintf(buf, "%02d%02d%02d%02d%02d%02d",anio, mes, dia, hora, minuto,segundo); 
      Serial.print(buf); 
      Serial.print(F(".txt"));    
      Serial.write(13);
      Serial.write(10);
      Serial.write(13);
      Serial.write(10);
      wait_for_esp_response(1500);
    
      File file;
      file.open(str3, O_READ);    
      Serial.println(F("AT+CIPSEND=0,2048")); 
      cantidad_paquetes = file.size()/2048;   // si el cociente es entero la división es entera
      wait_for_esp_response(1000);
      // enviar archivo, en paquetes de 2048 bytes por exigencias del ESP8266, con esperas de 20 ms entre paquete y paquete
      while (file.available()) {                      // mientras no se haya llegado al final
          inByte = file.read();
          Serial.write(inByte);
          if (cuenta == 2047){
             cuenta = 0;
             Serial.print(F("+++"));
             wait_for_esp_response(1000);
             if (cuenta2 != cantidad_paquetes){
                Serial.println(F("AT+CIPSEND=0,2048"));
                cuenta2 = cuenta2 + 1;               
                wait_for_esp_response(1000); 
             }else{
                cuenta2 = 1;
                resto = file.size() - (cantidad_paquetes * 2048);
                Serial.print(F("AT+CIPSEND=0,"));
                Serial.println(resto);                                 
                wait_for_esp_response(1000); 
             }
          }else{
            cuenta = cuenta + 1;            
          }              
      }              
      
      // cerrar todo
      file.close();
      Serial.print(F("+++"));     
      wait_for_esp_response(1000);      
      Serial.println(F("AT+CIPCLOSE=0"));
      wait_for_esp_response(1000);
      Serial.println(F("AT+CIPCLOSE=4"));
      wait_for_esp_response(1000);      
      
      delay(2000);           // esperar  segs antes de mandar msje de terminación

      Serial.print(F("AT+CIPSTART=4,"));
      Serial.write(34);
      Serial.print(F("TCP"));
      Serial.write(34);
      Serial.print(F(","));
      Serial.write(34);
      Serial.print(F("192.168.4.2"));
      Serial.write(34);      
      Serial.println(F(",9999"));
      wait_for_esp_response(5000);
      Serial.println(F("AT+CIPSEND=4,16"));
      wait_for_esp_response(1500);
      Serial.println(F("FIN DE PROCESO"));
      wait_for_esp_response(1000);
      Serial.println(F("AT+CIPCLOSE=4"));
      wait_for_esp_response(1000);
          
      for (int i=0; i <= 4; i++){               // 4 pitidos como marca de fin de transmisión
        digitalWrite(LED_ROJO,HIGH);
        delay(100);    
        digitalWrite(LED_ROJO,LOW); 
        delay(400);    
      }        
}


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
role_e role = role_ping_out;
byte counter = 1;                                                          // A single byte to keep track of the data being sent back and forth
char data[32];
/****************** *** ***************************/

void conmutar_sd_nordic(boolean x){
  if (x==true){
      digitalWrite(5,LOW);
      //pin CS a la SD definido como salida
      pinMode(SD_CS,OUTPUT);
      // initializar SPI
      SPI.begin();
      delay(2);
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

void enviar_via_nordic(void) {
       transmitir = false;
       radio.stopListening();
       // hacer 3 pitidos
       digitalWrite(LED_ROJO,HIGH); 
       delay(60);
       digitalWrite(LED_ROJO,LOW); 
       delay(60);              
       digitalWrite(LED_ROJO,HIGH); 
       delay(60);
       digitalWrite(LED_ROJO,LOW); 
       delay(60);                      
       digitalWrite(LED_ROJO,HIGH); 
       delay(60);
       digitalWrite(LED_ROJO,LOW); 
       delay(60);                           
       // enviar identificador
       if (primer_paquete == true){                    
           primer_paquete = false;
           for (int x=0; x <= 4; x++){
             for (i = 0; i < 31; i = i + 1) {
                data[i] = '9';                // <--- un número de 0 a 9 según sean A1, A2, B1, B2 .... E1, E2
             }
           radio.write(&data,32);
           delay(12);
           }               
       }    
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
                //delay(400);               
              }
          delay(12);       // delay para NO ATOSIGAR AL pinger
          }
       dataFile.close();
       for (int i=0; i < 31; i++){
          data[i] = ' ';
          } 
       // mandar un paquete de cierre de archivo (usamos el 1er elemento nomás por ahora)
       data[0] = '@';
       data[1] = '@';
       data[2] = '@';       
       if (radio.write(&data,32) ){                     
             if(!radio.available()){                     // If nothing in the buffer, we got an ack but it is blank
        }}
        radio.startListening();
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


// --------------------------------------------
void grabar_datos_archivo()
{
  char buffer1[3];
  char buffer2[8];
  File outFile;
  outFile = SD.open(str, FILE_WRITE);
  if (!outFile) {
    //Serial.println(F("No se pudo abrir el archivo"));
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
    //Serial.println(F("Error leyendo temperatura!"));
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
    //Serial.println(F("Error leyendo humedad!"));
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
    
    //sprintf(buffer1, "%02d", (contador * CONSTANTE_PULSADO ));
    //sprintf(buffer1, "%02d", (contador));
    //outFile.print(buffer1);

    resultado_contador = contador * CONSTANTE_PULSADO;
    outFile.print(int(resultado_contador));  //prints the int part
    outFile.print("."); // print the decimal point
    unsigned int frac;
    if(resultado_contador >= 0)
       frac = (resultado_contador - int(resultado_contador)) * 10;
    else
       frac = (int(resultado_contador)- resultado_contador ) * 10;
    outFile.print(frac);
    contador = 0;
    // Cerrar archivo
    outFile.close();
}

// ------------------------- este código se ejecuta cdo se pulsa el pulsador, ES UNA INTERRUPCIÓN -------------------
void wakeUp()
{
    contador = contador + 1;
}
// 




void setup(){
  Serial.begin(115200);
  
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
  radio.startListening();
  
  // Habilitar la interrupción que se producirá al oprimirse el botón conectado al pin 2
  attachInterrupt(0, wakeUp, FALLING);
  
}



void loop(void) {

    for (cantidad_segundos = 0 ;  cantidad_segundos  <  intervalo ; cantidad_segundos++){
      conmutar_sd_nordic(false);
      //LowPower.idle(SLEEP_1S, ADC_OFF, TIMER2_OFF, TIMER1_OFF,TIMER0_OFF, SPI_OFF, USART0_OFF, TWI_OFF);
      LowPower.powerDown(SLEEP_1S, ADC_OFF, BOD_OFF); 
    }

    // SECCIÓN WIFI
    // alimentar módulo wifi
    // inicializar nuevamente el módulo wifi  
    inicializar_wifi();

    // preguntar periódicamente cada 2 segs durante 20 segs si hay algún dispositivo conectado al esp8266 como access point
    for (int x=0; x <= 5; x++){
      Serial.println(F("AT+CWLIF"));
      while (Serial.available() > 0){
        inByte = Serial.read();
        if (inByte == '1') {           // "1" por la IP del celular (que arranca en 192)
            // pitido inicio proceso de transmisión
            digitalWrite(LED_ROJO,HIGH);
            delay(200);    
            digitalWrite(LED_ROJO,LOW);     
            enviar = true;
            break; 
        }
      }
      delay(2000);
    }
    // si en el bloque previo hubo respuesta, enviar archivo y mensajes de inicio y finalización
    if (enviar == true){
        envia_archivo_wifi();
    }

    // SECCIÓN NORDIC
    conmutar_sd_nordic(true);
    delay(50);
    grabar_datos_archivo(); 

    // si llegó paquete RF
    while(radio.available()){        
        radio.read( &data, 32 );
        if (data[0] == '2'){              // <-- este número identifica al PONGER, si el valor 1, se llama al Ponger #1 y así siguiendo
           transmitir = true;            
           }
        if (data[0] == 'a'){              // caracter que solicita el borrado
           //SD.wipe();    // borra SD (ojo, hay fenómenos raros)
           SD.remove(str);      //borra archivo TRAMAS.TXT en ponger
           radio.stopListening(); 
           data[0]=255;
           radio.write(&data,32);
           delay(1000);
           radio.startListening();                     
        }       
    }

    // si en el bloque previo hubo respuesta, enviar archivo
    if (transmitir == true){
      enviar_via_nordic();
     }
}
