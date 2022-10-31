// Firm que espera la llegada del pedido desde la AMENAN1D para a continuación enviar el archivo TRAMAS.TXT
// Incluye las rutinas para esperar el pedido de archivo desde un celular android, esta es la versión que se
// entiende con DATOS.APK
 
#include <SPI.h>
#include "RF24.h"
#include "SdFat.h"
#include "LowPower.h"
#include <Wire.h>
// librerías para usar el sensor de humedad
#include "Adafruit_Sensor.h"
#include <DHT.h>
#include <DHT_U.h>
//#include <Adafruit_BMP085.h>

// file system
SdFat SD;
// test file
File file;

#define SSID "nodoA1"   // acá el nombre de la red wifi
#define PASS "pepepepe" // esta es la contraseña para la misma 
#define LED             9   
#define PULSADOR1       2

#define DHTPIN            A0        // Pin de comunicación con el sensor.
#define DHTTYPE           DHT22     // DHT 22 (o el AM2302 que tenemos), define el tipo de sensor de humedad
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9 
#define PULSADOR          2
#define BATA1             7
#define BATA2             6

// macro para simplificar escritura (y ver si de paso se achica el uso de memoria y programa)
#define cerrar {Serial.println(F("AT+CIPCLOSE=0"));}

const char CONSTANTE[3] = "A1";
const float CONSTANTE_PULSADO = 0.3;


DHT_Unified dht(DHTPIN, DHTTYPE);
//Adafruit_BMP085 bmp;
// dirección en el bus I2C del RTC
const int DS3231 = 0x68;

// Inicializar variables de fecha y hora
byte segundo = 0;
byte minuto = 0;
byte hora = 0;
byte mes = 0;
byte anio = 0;
byte dia = 0;

float resultado_contador =0;

// Nombre del archivo donde se dejarán las tramas
const char str[] = "full.txt";
const char logfile[] = "bita.txt";
volatile byte contador = 0;    // cuenta de pulsados
unsigned long indice = 0;               // índice de tramas
//int indice = 0;               // índice de tramas
String cadena=String(3);

boolean bandera_grabacion = true;
boolean escuchar = false;
int cuenta = 0;
int resto = 0;
byte inByte;
const byte wakeUpPin = 2;

boolean transmitir = false;
boolean salir = false;

const byte numChars = 30;
char receivedChars[numChars];
String mi_cadena = "    ";

int tiempo = 0;

boolean newData = false;
static boolean recvInProgress = false;
static byte ndx = 0;
char str3[] = "0000.txt";
const String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";
String encabezado3 = "HTTP/1.1 205 OK\r\nContent-Type: ";   // para enviar tiempo estimado de transmisión
const String cipSend = "AT+CIPSEND=0,2048";
String cipSend2 = "AT+CIPSEND=0,";

boolean primer_paquete = false;
boolean segundo_paquete = false;
boolean una_vez = true;
unsigned long tamanio = 0;
//unsigned long posicion = 0; 
//unsigned long cantidad_paquetes = 0;
int cantidad_paquetes = 0;
int cuenta3 = 0;
int cuenta2 = 1; 
// constante que define cuantos segundos estará dormido antes de despertarse y medir
const int intervalo = 10;                    // 5 minutos, valor aleatorio elegido sin mayor implicancia
volatile int cantidad_segundos = 0;

unsigned long currentMillis = 0;
long previousMillis = 0;
int interval = 30000;                       // 10 segundos es el tiempo que le asignamos para esperar el pedido desde el cel.

char buffer1[3];
char buffer2[8];

boolean terminado = false;

///****************** User Config ***************************/
///***      Set this radio as radio number 0 or 1         ***/
//bool radioNumber = 0;
///* Hardware configuration: Set up nRF24L01 radio on SPI bus plus pins A1 & A2 */
//RF24 radio(A1,A2);
///**********************************************************/
//// Topology
//const byte addresses[][6] = {"1Node","2Node"};              // Radio pipe addresses for the 2 nodes to communicate.
//// Role management: Set up role.  This sketch uses the same software for all the nodes
//// in this system.  Doing so greatly simplifies testing.  
//typedef enum { role_ping_out = 1, role_pong_back } role_e;                 // The various roles supported by this sketch
//const char* role_friendly_name[] = { "invalid", "Ping out", "Pong back"};  // The debug-friendly names of those roles
//role_e role = role_ping_out;
//char data[32];
///****************** *** ***************************/

//void conmutar_sd_nordic(boolean x){
//  if (x==true){
//      digitalWrite(5,LOW);
//      //pin CS a la SD definido como salida
//      pinMode(SD_CS,OUTPUT);
//      // initializar SPI
//      SPI.begin();
//      delay(2);
//      SD.begin(SD_CS);
//      radio.begin();
//      radio.setPALevel(RF24_PA_LOW);
//      if(radioNumber){
//          radio.openWritingPipe(addresses[1]);        // Both radios listen on the same pipes by default, but opposite addresses
//          radio.openReadingPipe(1,addresses[0]);      // Open a reading pipe on address 0, pipe 1
//      }else{
//          radio.openWritingPipe(addresses[0]);
//          radio.openReadingPipe(1,addresses[1]);
//      }
//      radio.startListening();                       // Start listening  
//  }else{
//      digitalWrite(5,HIGH);
//      pinMode(SD_CS,INPUT);
//      // initializar SPI
//      SPI.end();
//      pinMode(SCK, INPUT);
//      pinMode(MOSI, INPUT);
//      pinMode(SS, INPUT);  }
//}

//void enviar_via_nordic(void) {
//       transmitir = false;
//       radio.stopListening();
//       // hacer 3 pitidos
//       digitalWrite(LED_ROJO,HIGH); 
//       delay(60);
//       digitalWrite(LED_ROJO,LOW); 
//       delay(60);              
//       digitalWrite(LED_ROJO,HIGH); 
//       delay(60);
//       digitalWrite(LED_ROJO,LOW); 
//       delay(60);                      
//       digitalWrite(LED_ROJO,HIGH); 
//       delay(60);
//       digitalWrite(LED_ROJO,LOW); 
//       delay(60);                           
//       // enviar identificador
//       if (primer_paquete == true){                    
//           primer_paquete = false;
//           for (byte x=0; x <= 4; x++){
//             for (byte i = 0; i < 31; i = i + 1) {
//                data[i] = '9';                // <--- un número de 0 a 9 según sean A1, A2, B1, B2 .... E1, E2
//             }
//           radio.write(&data,32);
//           delay(12);
//           }               
//       }    
//        // abrir archivo
//        File dataFile = SD.open("full.txt");                 
//        if (dataFile) {                                        // si se pudo abrir el archivo
//           while (dataFile.available()) {                      // mientras no se haya llegado al final
//              for (byte i = 0; i < 31; i = i + 1) {
//                  data[i] = dataFile.read();                   // cargar arreglo de 32 bytes a enviar
//                  }
//              //enviarlo via Nordic
//              if (radio.write(&data,32) ){                     
//                   if(!radio.available()){                     // If nothing in the buffer, we got an ack but it is blank
//              }}
//              if (primer_paquete == true){                    // bloque para darle tiempo al pinger de bipear 3 veces luego del primer paquete
//                primer_paquete = false;
//                //delay(400);               
//              }
//          delay(12);       // delay para NO ATOSIGAR AL pinger
//          }
//       dataFile.close();
//       for (byte i=0; i < 31; i++){
//          data[i] = ' ';
//          } 
//       // mandar un paquete de cierre de archivo (usamos el 1er elemento nomás por ahora)
//       data[0] = '@';
//       data[1] = '@';
//       data[2] = '@';       
//       if (radio.write(&data,32) ){                     
//             if(!radio.available()){                     // If nothing in the buffer, we got an ack but it is blank
//        }}
//        radio.startListening();
//        }  
//}

void obtenerFechaHora()
{
  Wire.beginTransmission(DS3231);
  Wire.write(byte(0));
  Wire.endTransmission();
  Wire.requestFrom(DS3231, 7);
  segundo = bcd2Dec(Wire.read());
  minuto = bcd2Dec(Wire.read());
  hora = bcd2Dec(Wire.read());
  dia = bcd2Dec(Wire.read());           // descartar este dato, se hace para ahorrar memoria, O SEA, NO ES UN ERROR QUE ESTÉ DOS VECES
  dia = bcd2Dec(Wire.read());
  mes = bcd2Dec(Wire.read());
  anio = bcd2Dec(Wire.read());
}
// --------------------------------------------
byte bcd2Dec(byte val) {return ((val/16*10) + (val%16));}

// --------------------------------------------
void grabar_datos_archivo()
{
//  char buffer1[3];
//  char buffer2[8];
  File outFile;
  outFile = SD.open("full.txt", O_WRITE | O_APPEND);
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
  cadena = String(event.temperature);
  cadena.replace('.',',');
  outFile.print(cadena);
  // Humedad
  dht.humidity().getEvent(&event);
  outFile.print(F(" - "));
  cadena = String(event.relative_humidity);
  cadena.replace('.',',');
  outFile.print(cadena);
  outFile.print(F(" -               "));

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


void inicializar_wifi(void){
  // establecer seteos del módulo   
  Serial.println(F("AT+CWMODE=3"));
  delay(100);
  Serial.println(F("AT+CWDHCP=2,1"));
  delay(100);
  Serial.println(F("AT+CIPMUX=1"));
  delay(100);
  Serial.print(F("AT+CWSAP="));
  Serial.write(34);
  Serial.print(SSID);
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.write(34);    //comilla 
  Serial.print("pepepepe");
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.println(F("5,3"));
  delay(500);
  Serial.println(F("AT+CIPSERVER=1,80")); // iniciar servidor en puerto 80 (HTTP)
  delay(250);
}

// función dummy en posición 0 de memoria para, al llamarla, simular un RESET del Arduino.
void(* resetFunc) (void) = 0;


void recepcion_pedido_wifi(void){
  currentMillis = millis();
  if (currentMillis >= previousMillis + interval) {
    salir = true;
  }
  while (Serial.available() > 0) {
    inByte = Serial.read();
    if ((inByte == 'i') && (newData == false)) {
      newData = true;    
    }
    if (newData){
        receivedChars[ndx] = inByte;
        ndx++;
        if (ndx >= 28){
            newData = false;
            ndx = 0;
            if (receivedChars[22] == '7'){
              if (una_vez){
                primer_paquete = true;
                una_vez = false;                
              }
            }
            if (!((primer_paquete == true) || (segundo_paquete == true))) {
                cerrar;
                delay(200);
                cuenta++;              
                mi_cadena+= receivedChars[22];
                previousMillis = millis();
            }
        }  
    }      
  }
  
  if (cuenta == 4){
     mi_cadena+= ".txt";
     mi_cadena.trim();            // SACARLE LOS ESPACIOS, FUNDAMENTAL!!!!!!
     cuenta = 0;
     if (mi_cadena == "0000.txt"){      // mandar completo
          file.open("full.txt", O_READ);    
          tamanio = file.size();
          cantidad_paquetes = (tamanio - (2048 - encabezado.length())) / 2048;
          resto = tamanio - ((cantidad_paquetes+1) * 2048);     
          file.close();
          mi_cadena = "full.txt";      
          mi_cadena.toCharArray(str3, 9);
     }else if (mi_cadena == "9999.txt"){      // mandar bitácora
          file.open("bita.txt", O_READ);    
          tamanio = file.size();
          cantidad_paquetes = (tamanio - (2048 - encabezado.length())) / 2048;
          resto = tamanio - ((cantidad_paquetes+1) * 2048);     
          file.close();
          mi_cadena = "bita.txt";      
          mi_cadena.toCharArray(str3, 9);
     }else if (mi_cadena == "8888.txt"){    // borrar archivos
            SD.wipe();
            SD.begin(SD_CS);            
            SD.mkdir("mensual");
            salir = true;
      }else {
          SD.chdir("mensual");                      
          mi_cadena.toCharArray(str3, 9) ;
          file.open(str3, O_READ);    
          tamanio = file.size();
          cantidad_paquetes = (tamanio - (2048 - encabezado.length())) / 2048;
          resto = tamanio - ((cantidad_paquetes+1) * 2048);     
          file.close();      
     }
  }
  
  if (primer_paquete){
      digitalWrite(LED,HIGH);
      delay(500);
      digitalWrite(LED,LOW);
      primer_paquete = false;
      segundo_paquete = true;
      tiempo = tamanio/900;
      tiempo = tiempo + 2;
      encabezado3 += encabezado3 + tiempo;
      encabezado3 += "  \r\n\r\n";
      cipSend2 += encabezado3.length();
      Serial.println(cipSend2);
      delay(1500);
      Serial.print(encabezado3);
      Serial.println(""); Serial.println(""); Serial.println("");
      delay(1000);
      cerrar;
      delay(1000);
      previousMillis = millis();
  }

  if (segundo_paquete){
     delay(2500);
     segundo_paquete = false;
     file.open(str3, O_READ);    
      // 1er paquete del archivo, difiere de los otros paquetes en q al principio lleva el encabezado.
      Serial.println(cipSend);
      delay(1100);
      Serial.print(encabezado);
      for (int i=0; i <= 2002; i++){
            Serial.write(file.read());
      }   
      Serial.println("");     // necesaria línea extra, motivo desconocido        
      delay(1000);
      // arranca los otros paquetes
      Serial.println(cipSend);
      delay(1000);          
      while (file.available()) {                      // mientras no se haya llegado al final
         Serial.write(file.read());
         if (cuenta3 == 2047){
             cuenta3 = 0;
             Serial.println("");
             delay(700);
             if (cuenta2 != cantidad_paquetes){
                Serial.println(cipSend);
                delay(700);
                cuenta2 = cuenta2 + 1;               
             }else{
                cuenta2 = 1;
                Serial.print(F("AT+CIPSEND=0,"));
                resto = resto + encabezado.length();
                Serial.println(resto);                                 
                delay(500); 
            }
         }else{
                cuenta3 = cuenta3 + 1;            
              }       
      }
      file.close();
      Serial.println("");
      delay(1100);          
      cerrar;
      obtenerFechaHora();
      File outFile;
      SD.chdir('/');
      outFile = SD.open(logfile, O_CREAT | O_APPEND | O_WRITE);
      outFile.print(str3);          // escribir nombre de archivo
      outFile.print(F("   "));         // seguido por fecha y hora (al momento de finalizarse la transmisión)
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
      outFile.println(buffer1);
      outFile.close();
      salir = true;
      terminado = false;
      delay(500);
      resetFunc();  //call reset  
  }
}

// ------------------------- este código se ejecuta cdo se pulsa el pulsador, ES UNA INTERRUPCIÓN -------------------
void wakeUp() {contador = contador + 1;}
// ------------------------------------------------------------------------------------------------------------------


void setup(){
  Serial.begin(115200);
  pinMode(5, OUTPUT);
  //digitalWrite(5,HIGH);  
  digitalWrite(5,LOW);  
  pinMode(PULSADOR,INPUT_PULLUP );
  pinMode(LED_ROJO, OUTPUT);
  digitalWrite(LED_ROJO,HIGH);
  delay(300);    
  digitalWrite(LED_ROJO,LOW);

  // Inicializar I2C
  Wire.begin();
  pinMode(wakeUpPin, INPUT_PULLUP);   

  // inicializar sensor de humedad y temperatura
  dht.begin();            

  // inicializar sensor de presión y temperatura
  //bmp.begin();

  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();
  //Inicializar SD
  if (!SD.begin(SD_CS)) {
      digitalWrite(LED_ROJO,HIGH);      // si no hay SD, queda pitiando como alarma
      return;
  }

  // si la carpeta mensual no existe, crearla
  if (SD.exists("mensual") == false){
    SD.mkdir("mensual"); 
  }


//  // Setup and configure radio
//  radio.begin();
//  radio.setPALevel(RF24_PA_LOW);
//  
//  if(radioNumber){
//    radio.openWritingPipe(addresses[1]);        // Both radios listen on the same pipes by default, but opposite addresses
//    radio.openReadingPipe(1,addresses[0]);      // Open a reading pipe on address 0, pipe 1
//  }else{
//    radio.openWritingPipe(addresses[0]);
//    radio.openReadingPipe(1,addresses[1]);
//  }
//  radio.startListening();
  
  // Habilitar la interrupción que se producirá al oprimirse el botón conectado al pin 2
  attachInterrupt(0, wakeUp, FALLING);
}



void loop(void) {

//    Serial.println(F("AT+CWMODE_CUR=1"));
//    delay(100);
//    //Serial.println(F("AT+CIPSERVER=0"));
//    delay(100);
//    for (cantidad_segundos = 0 ;  cantidad_segundos  <  intervalo ; cantidad_segundos++){
//      //conmutar_sd_nordic(false);
//      LowPower.powerDown(SLEEP_1S, ADC_OFF, BOD_OFF); 
//    }

    // SECCIÓN WIFI
    // alimentar módulo wifi
    // inicializar nuevamente el módulo wifi  
    inicializar_wifi();
    while (Serial.available() > 0) {Serial.read();}   // limpiar buffer serial de los mensajes de inicio
    salir = false;   
    // esperar pedido de conexión desde el celular durante "intervalo" segundos (30 por el momento).
    previousMillis = millis();
    while (salir == false) {  
        recepcion_pedido_wifi();
    }


//    // SECCIÓN NORDIC
////    conmutar_sd_nordic(true);
//    delay(50);
//    grabar_datos_archivo(); 
//
//    // si llegó paquete RF
//    while(radio.available()){        
//        radio.read( &data, 32 );
//        if (data[0] == '2'){              // <-- este número identifica al PONGER, si el valor 1, se llama al Ponger #1 y así siguiendo
//           transmitir = true;            
//           }
//        if (data[0] == 'a'){              // caracter que solicita el borrado
//           //SD.wipe();    // borra SD (ojo, hay fenómenos raros)
//           SD.remove("full.txt");      //borra archivo full.TXT en ponger
//           radio.stopListening(); 
//           data[0]=255;
//           radio.write(&data,32);
//           delay(1000);
//           radio.startListening();                     
//        }       
//    }
//
//    // si en el bloque previo hubo respuesta, enviar archivo
//    if (transmitir == true){
//      enviar_via_nordic();
//     }
}
