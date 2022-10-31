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
 A2 Control Nordic
 A3 Entrada Analógica Selector
 A4 BUS I2C
 A5 BUS I2C
 A6 entrada analógica medición alimentación
 A7 entrada analógica libre

 Nota: BUS SPI es usado por el ArduCam, la(s) SD(s) y el Nordic. BUS I2C es usado por el RTC, el sensor de presión y el ArduCam

 */

// -----------------------------------------------------------------------------------------------------------------------------------------------------------------
#include <SPI.h>
#include "SdFat.h"
#include "LowPower.h"
#include <Wire.h>
#include <Adafruit_BMP085.h>      // librerías para usar sensores de presión y humedad
#include "Adafruit_Sensor.h"
#include <DHT.h>
#include <YetAnotherPcInt.h>




// Alias de pines
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9 
#define PULSADOR          2
#define BATA1             7
#define BATA2             6
const int wakeUpPin = 2;
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

#define DHTPIN            A0        // Pin de comunicación con el sensor.
#define DHTTYPE           DHT22     // DHT 22 (o el AM2302 que tenemos), define el tipo de sensor de humedad
Adafruit_BMP085 bmp;
DHT dht(DHTPIN, DHTTYPE);

// dirección en el bus I2C del RTC
const int DS3231 = 0x68;
const float CONSTANTE_PULSADO = 0.3;
const char CONSTANTE[3] = "A1";

// --------------------------------------------
/*                Cosas Nordic
#include "RF24.h"

*/

/*                Cosas WiFi
#define SSID "nodoA1"   // acá el nombre de la red wifi
#define PASS "pepepepe" // esta es la contraseña para la misma 
// macro para simplificar escritura (y ver si de paso se achica el uso de memoria y programa)
#define cerrar {Serial.println(F("AT+CIPCLOSE=0"));}

const String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";
const String encabezado2 = "HTTP/1.1 208 OK\r\nContent-Type: text/html\r\n\r\n";
//String encabezado3 = "HTTP/1.1 205 OK\r\nContent-Type: ";   // para enviar tiempo estimado de transmisión
const String cipSend = "AT+CIPSEND=0,2048";
String cipSend2 = "AT+CIPSEND=0,";
boolean primer_paquete = false;
boolean segundo_paquete = false;
boolean una_vez = true;
unsigned long tamanio = 0;
unsigned int cantidad_paquetes = 0;
unsigned int cuenta3 = 0;
unsigned int cuenta2 = 1; 

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

void recepcion_pedido_wifi(void){
  currentMillis = millis();
  if (currentMillis >= previousMillis + interval) {
    salir = true;
  }

  while (Serial.available() > 0) {
    inByte = Serial.read();
            if (inByte == '@'){
                digitalWrite(LED_ROJO,HIGH);
                delay(200);
                digitalWrite(LED_ROJO,LOW);

                file.open("full.txt", O_READ);    
                tamanio = file.size();
                cantidad_paquetes = (tamanio - (2048 - encabezado.length())) / 2048;
                resto = tamanio - ((cantidad_paquetes+1) * 2048);                  
   
                  // 1er paquete del archivo, difiere de los otros paquetes en q al principio lleva el encabezado.
                  Serial.println(cipSend);
                  delay(500);
                  Serial.print(encabezado);
                  for (int i=0; i <= 2002; i++){
                        Serial.write(file.read());
                  }   
                  Serial.println("");     // necesaria línea extra, motivo desconocido        
                  delay(500);
                  previousMillis = millis();
                  // arranca los otros paquetes
                  Serial.println(cipSend);
                  delay(500);          
                  while (file.available()) {                      // mientras no se haya llegado al final
                     Serial.write(file.read());
                     if (cuenta3 == 2047){
                         cuenta3 = 0;
                         Serial.println("");
                         wait_for_esp_response(500);  
                         if (cuenta2 != cantidad_paquetes){
                            Serial.println(cipSend);
                            wait_for_esp_response(600);  
                            cuenta2 = cuenta2 + 1;
                            previousMillis = millis();               
                         }else{
                            cuenta2 = 1;
                            Serial.print(F("AT+CIPSEND=0,"));
                            resto = resto + encabezado.length();
                            Serial.println(resto);                                 
                            previousMillis = millis();
                            wait_for_esp_response(600);  
                        }
                     }else{
                            cuenta3 = cuenta3 + 1;            
                          }       
                  }                  
                  file.close();
                  Serial.println("");
                  delay(500);          
                  cerrar;
                  delay(1000); 
                  salir = true;         
                  Serial.println(F("AT+RST"));
                  delay(500);
                  resetFunc();  //call reset  
              }
              
              if (inByte == '~'){
                while (Serial.available() > 0) {Serial.read();}
                digitalWrite(LED_ROJO,HIGH);               
                SD.wipe();
                SD.begin(SD_CS);
                SD.chdir('/');
                SD.mkdir("mensual");
                SD.mkdir("respaldo");      
                delay(100); 
                Serial.print(F("AT+CIPSEND=0,"));
                resto = 0;
                resto = resto + encabezado2.length();
                Serial.println(resto);
                delay(500);
                Serial.println(encabezado2);              
                delay(500);
                cerrar;              
                file = SD.open("full.txt", O_CREAT | O_APPEND | O_WRITE);
                for (int ix=0; ix <= 5000; ix++){   
                  file.print(".");                  
                }
                file.close();
                delay(500);
                file = SD.open("alim.txt", O_CREAT | O_APPEND | O_WRITE);
                for (int ix=0; ix <= 5000; ix++){   
                  file.print(".");                  
                }
                file.close();
                delay(500);
                                // Deshabilitado temporariamente por mal funcionamiento en conjunto con las otras grabaciones
                // Una vez encontrado el error, habilitar este código.
//                file = SD.open("bita.txt", O_CREAT | O_APPEND | O_WRITE);
//                for (int ix=0; ix <= 5000; ix++){   
//                  file.print(".");                  
//                }
                file.close();
                digitalWrite(LED_ROJO,LOW);
                Serial.println(F("AT+RST"));
                delay(500);
                resetFunc();  //call reset  
              }
              if (inByte == '&'){
                while (Serial.available() > 0) {Serial.read();}
                digitalWrite(LED_ROJO,HIGH);
                SD.chdir('/');
                SD.remove("full.txt");
                SD.remove("alim.txt");
                //SD.remove("bita.txt");
                SD.chdir("mensual");   
                SD.vwd()->rmRfStar();
                SD.chdir('/');
                SD.mkdir("mensual");
                delay(100); 
                Serial.print(F("AT+CIPSEND=0,"));
                resto = 0;
                resto = resto + encabezado2.length();
                Serial.println(resto);
                delay(500);
                Serial.println(encabezado2);              
                delay(500);
                cerrar;
                
                file = SD.open("full.txt", O_CREAT | O_APPEND | O_WRITE);
                for (int ix=0; ix <= 5000; ix++){   
                  file.print(".");                  
                }
                file.close();
                delay(500);
                file = SD.open("alim.txt", O_CREAT | O_APPEND | O_WRITE);
                for (int ix=0; ix <= 5000; ix++){   
                  file.print(".");                  
                }
                file.close();
                delay(500);
                // Deshabilitado temporariamente por mal funcionamiento en conjunto con las otras grabaciones
                // Una vez encontrado el error, habilitar este código.
//                file = SD.open("bita.txt", O_CREAT | O_APPEND | O_WRITE);
//                for (int ix=0; ix <= 5000; ix++){   
//                  file.print(".");                  
//                }
                file.close();
                digitalWrite(LED_ROJO,LOW);
                Serial.println(F("AT+RST"));
                delay(500);
                resetFunc();  //call reset  
              }
              if (inByte == '$'){
                digitalWrite(LED_ROJO,HIGH);
                delay(200);
                digitalWrite(LED_ROJO,LOW);

                file.open("alim.txt", O_READ);    
                tamanio = file.size();
                cantidad_paquetes = (tamanio - (2048 - encabezado.length())) / 2048;
                resto = tamanio - ((cantidad_paquetes+1) * 2048);                  
   
                  // 1er paquete del archivo, difiere de los otros paquetes en q al principio lleva el encabezado.
                  Serial.println(cipSend);
                  delay(500);
                  Serial.print(encabezado);
                  for (int i=0; i <= 2002; i++){
                        Serial.write(file.read());
                  }   
                  Serial.println("");     // necesaria línea extra, motivo desconocido        
                  delay(500);
                  previousMillis = millis();
                  // arranca los otros paquetes
                  Serial.println(cipSend);
                  delay(500);          
                  while (file.available()) {                      // mientras no se haya llegado al final
                     Serial.write(file.read());
                     if (cuenta3 == 2047){
                         cuenta3 = 0;
                         Serial.println("");
                         wait_for_esp_response(500);  
                         if (cuenta2 != cantidad_paquetes){
                            Serial.println(cipSend);
                            wait_for_esp_response(600);  
                            cuenta2 = cuenta2 + 1;
                            previousMillis = millis();               
                         }else{
                            cuenta2 = 1;
                            Serial.print(F("AT+CIPSEND=0,"));
                            resto = resto + encabezado.length();
                            Serial.println(resto);                                 
                            previousMillis = millis();
                            wait_for_esp_response(600);  
                        }
                     }else{
                            cuenta3 = cuenta3 + 1;            
                          }       
                  }
                  
                  file.close();
                  Serial.println("");
                  delay(500);          
                  cerrar;
                  delay(1000); 
                  salir = true;         
                  Serial.println(F("AT+RST"));
                  delay(500);
                  resetFunc();  //call reset  
                
              }
//              if (inByte == '*'){
//                digitalWrite(LED_ROJO,HIGH);
//                delay(200);
//                digitalWrite(LED_ROJO,LOW);
//
//                file.open("bita.txt", O_READ);    
//                tamanio = file.size();
//                cantidad_paquetes = (tamanio - (2048 - encabezado.length())) / 2048;
//                resto = tamanio - ((cantidad_paquetes+1) * 2048);                  
//   
//                  // 1er paquete del archivo, difiere de los otros paquetes en q al principio lleva el encabezado.
//                  Serial.println(cipSend);
//                  delay(500);
//                  Serial.print(encabezado);
//                  for (int i=0; i <= 2002; i++){
//                        Serial.write(file.read());
//                  }   
//                  Serial.println("");     // necesaria línea extra, motivo desconocido        
//                  delay(500);
//                  previousMillis = millis();
//                  // arranca los otros paquetes
//                  Serial.println(cipSend);
//                  delay(500);          
//                  while (file.available()) {                      // mientras no se haya llegado al final
//                     Serial.write(file.read());
//                     if (cuenta3 == 2047){
//                         cuenta3 = 0;
//                         Serial.println("");
//                         wait_for_esp_response(500);  
//                         if (cuenta2 != cantidad_paquetes){
//                            Serial.println(cipSend);
//                            wait_for_esp_response(600);  
//                            cuenta2 = cuenta2 + 1;
//                            previousMillis = millis();               
//                         }else{
//                            cuenta2 = 1;
//                            Serial.print(F("AT+CIPSEND=0,"));
//                            resto = resto + encabezado.length();
//                            Serial.println(resto);                                 
//                            previousMillis = millis();
//                            wait_for_esp_response(600);  
//                        }
//                     }else{
//                            cuenta3 = cuenta3 + 1;            
//                          }       
//                  }
//                  
//                  file.close();
//                  Serial.println("");
//                  delay(500);          
//                  cerrar;
//                  delay(1000); 
//                  salir = true;                        
//                  Serial.println(F("AT+RST"));
//                  delay(500);
//                  resetFunc();  //call reset  
//              }                    
               if (inByte == '^'){
                digitalWrite(LED_ROJO,HIGH);
                delay(200);
                digitalWrite(LED_ROJO,LOW);
                SD.chdir("respaldo"); 
                file.open("alim.txt", O_READ);    
                tamanio = file.size();
                cantidad_paquetes = (tamanio - (2048 - encabezado.length())) / 2048;
                resto = tamanio - ((cantidad_paquetes+1) * 2048);                  
   
                  // 1er paquete del archivo, difiere de los otros paquetes en q al principio lleva el encabezado.
                  Serial.println(cipSend);
                  delay(500);
                  Serial.print(encabezado);
                  for (int i=0; i <= 2002; i++){
                        Serial.write(file.read());
                  }   
                  Serial.println("");     // necesaria línea extra, motivo desconocido        
                  delay(500);
                  previousMillis = millis();
                  // arranca los otros paquetes
                  Serial.println(cipSend);
                  delay(500);          
                  while (file.available()) {                      // mientras no se haya llegado al final
                     Serial.write(file.read());
                     if (cuenta3 == 2047){
                         cuenta3 = 0;
                         Serial.println("");
                         wait_for_esp_response(500);  
                         if (cuenta2 != cantidad_paquetes){
                            Serial.println(cipSend);
                            wait_for_esp_response(600);  
                            cuenta2 = cuenta2 + 1;
                            previousMillis = millis();               
                         }else{
                            cuenta2 = 1;
                            Serial.print(F("AT+CIPSEND=0,"));
                            resto = resto + encabezado.length();
                            Serial.println(resto);                                 
                            previousMillis = millis();
                            wait_for_esp_response(600);  
                        }
                     }else{
                            cuenta3 = cuenta3 + 1;            
                          }       
                  }
                  file.close();
                  Serial.println("");
                  delay(500);          
                  cerrar;
                  delay(1000); 
                  salir = true;         
                  Serial.println(F("AT+RST"));
                  delay(500);
                  resetFunc();  //call reset  
              }
                if (inByte == '_'){
                digitalWrite(LED_ROJO,HIGH);
                delay(200);
                digitalWrite(LED_ROJO,LOW);
                SD.chdir("respaldo"); 
                file.open("full.txt", O_READ);    
                tamanio = file.size();
                cantidad_paquetes = (tamanio - (2048 - encabezado.length())) / 2048;
                resto = tamanio - ((cantidad_paquetes+1) * 2048);                  
   
                  // 1er paquete del archivo, difiere de los otros paquetes en q al principio lleva el encabezado.
                  Serial.println(cipSend);
                  delay(500);
                  Serial.print(encabezado);
                  for (int i=0; i <= 2002; i++){
                        Serial.write(file.read());
                  }   
                  Serial.println("");     // necesaria línea extra, motivo desconocido        
                  delay(500);
                  previousMillis = millis();
                  // arranca los otros paquetes
                  Serial.println(cipSend);
                  delay(500);          
                  while (file.available()) {                      // mientras no se haya llegado al final
                     Serial.write(file.read());
                     if (cuenta3 == 2047){
                         cuenta3 = 0;
                         Serial.println("");
                         wait_for_esp_response(500);  
                         if (cuenta2 != cantidad_paquetes){
                            Serial.println(cipSend);
                            wait_for_esp_response(600);  
                            cuenta2 = cuenta2 + 1;
                            previousMillis = millis();               
                         }else{
                            cuenta2 = 1;
                            Serial.print(F("AT+CIPSEND=0,"));
                            resto = resto + encabezado.length();
                            Serial.println(resto);                                 
                            previousMillis = millis();
                            wait_for_esp_response(600);  
                        }
                     }else{
                            cuenta3 = cuenta3 + 1;            
                          }       
                  }
                  file.close();
                  Serial.println("");
                  delay(500);          
                  cerrar;
                  delay(1000); 
                  salir = true;         
                  Serial.println(F("AT+RST"));
                  delay(500);
                  resetFunc();  //call reset  
          }
  }
}


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

byte wait_for_esp_response(int timeout, char* term=OKrn) {  
  unsigned long t=millis();  
  bool found=false;  
  byte i=0;  
  int len=strlen(term);  
  // wait for at most timeout milliseconds or if OK\r\n is found  
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
  return found;  
}



------------------------------------------------------------------

El siguiente bloque iba en el loop()

    // SECCIÓN WIFI
    // inicializar nuevamente el módulo wifi  
    while (Serial.available() > 0) {Serial.read();}   // limpiar buffer serial de los mensajes de inicio
    salir = false;   
    // esperar pedido de conexión desde el celular durante "intervalo" segundos (20 por el momento).
    previousMillis = millis();
    while (salir == false) {  
        recepcion_pedido_wifi();
    }

------------------------------------------------------------------

El siguiente bloque iba en el setup()
  // setear al ESP8266 a 57600 (el arduino recibe mal a 115200)
  Serial.println(F("AT+UART_CUR=57600,8,1,0,0"));
  delay(500);
  Serial.end();
  Serial.begin(57600);
  delay(500);
  inicializar_wifi();
  // Inicializar I2C

------------------------------------------------------------------  
*/




float resultado_contador =0;
float t_h;
// Inicializar variables de fecha y hora
byte segundo = 0;
byte minuto = 0;
byte hora = 0;
byte mes = 0;
byte anio = 0;
byte weekday = 0;
byte dia = 0;
// Nombre del archivo donde se dejarán las tramas
const char str[] = "full.txt";
const char str2[] = "alim.txt";

volatile int contador = 0;    // cuenta de pulsados
unsigned long indice = 0;               // índice de tramas
String cadena=String(3);
boolean bandera_grabacion = true;
unsigned int cuenta = 0;
unsigned int resto = 0;
byte inByte;
volatile int cantidad_segundos = 0;

boolean salir = false;

char receivedChars[28];
String mi_cadena = "    ";
unsigned int tiempo = 0;
boolean newData = false;
boolean recvInProgress = false;
byte ndx = 0;
char str3[] = "0000.txt";
// constante que define cuantos segundos estará dormido antes de despertarse y medir
const int intervalo = 20;                    // 5 minutos, valor aleatorio elegido sin mayor implicancia
unsigned long currentMillis = 0;
unsigned long previousMillis = 0;
const unsigned long interval = 50000;                       // 50 segundos es el tiempo que le asignamos para esperar el pedido desde el cel.

unsigned long previo_milis = 0;
const unsigned long tiempo_grabacion = 275000;            // 2 minutos (70000 + 50000 ms) menos los 50 s del lazo de espera de llegada de pedido WiFi


char buffer1[3];
char buffer2[8];
boolean problema_rtc = false;
byte contador_alarma = 0;
boolean una_vez_alarma = true;
char buffer[18];
char OKrn[] = "OK\r\n";  



// función dummy en posición 0 de memoria para, al llamarla, simular un RESET del Arduino.
void(* resetFunc) (void) = 0;

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
  weekday = bcd2Dec(Wire.read());
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

  if (x == true){
    SD.chdir("respaldo");
  }else{
    SD.chdir("/");
  }
  
  file = SD.open(str, FILE_WRITE);
//  obtenerFechaHora();
  file.println("");
  file.print(CONSTANTE);
  file.print(F(" - "));  
  sprintf(buffer2, "%07d", indice);
  file.print(buffer2);
  
//  if (x == false){
//    indice = indice + 1;
//  }  
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
  //contador = 0;
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

// --------------------------------------------

// Procedimiento invocado cada vez que se produce un pulso en los pines predefinidos, incrementa los contadores
void pinChanged(Pin* pin, bool pinstate) {
  if (pin.number == 2){
      contador1++;    
  }
  if (pin.number == 3){
      contador2++;        
  }
}

// --------------------------------------------

// Procedimiento que espera la llegada de un caracter por le vía USB-TTL y reacciona en consecuencia
// enviando los archivos que corresponde en cada caso o limpiando la tarjeta.
void pedido_usb(){
    if (Serial.available() > 0) {
     inByte = Serial.read();
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
        Serial.print("%");
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
  digitalWrite(5,LOW);  
  pinMode(PULSADOR,INPUT_PULLUP );
  pinMode(LED_ROJO, OUTPUT);
  pinMode(wakeUpPin, INPUT_PULLUP);   
  pinMode(SD_CS,OUTPUT);

  // que bipee 2 veces
  digitalWrite(LED_ROJO,HIGH);
  delay(500);    
  digitalWrite(LED_ROJO,LOW);
  delay(100);    
  digitalWrite(LED_ROJO,HIGH);
  delay(500);    
  digitalWrite(LED_ROJO,LOW);
  delay(100);      

  // Inicialización de periféricos, SD y sensores
  Serial.begin(115200);
  Wire.begin();
  SPI.begin();
  if (!SD.begin(SD_CS)) {
      digitalWrite(LED_ROJO,HIGH);
  }
  // Bloque que inicializa los pines que funcionan como contadores de pulsos.
  for (int i=0; i<ARRAY_SIZE(monitored_pins); i++) {
    pinMode(monitored_pins[i].number, INPUT_PULLUP);
    PcInt::attachInterrupt(monitored_pins[i].number, pinChanged, &monitored_pins[i], FALLING);
  }  
  // Sensores
  bmp.begin();
  dht.begin();
  delay(1000);
  dht.read();           // una lectura dummy para establizar al sensor de humedad
}



void loop(void) {  

    unsigned long actual_milis = millis();
    if (actual_milis - previo_milis >= tiempo_grabacion) {      // lazo que determina los 5 minutos (250 s en realidad), entre grabación y grabación 
        previo_milis = actual_milis;

        digitalWrite(SD2_CS, HIGH);      
        while(!SD.begin(SD_CS)){
          Serial.println(F("Error de tarjeta SD1!"));
          delay(1000);
        }
        
        obtenerFechaHora();
        grabar_datos_archivo(false);        //grabar en el principal
        grabar_alimentacion(false);
        grabar_datos_archivo(true);         //grabar en \respaldo
        grabar_alimentacion(true);
        contador = 0;
        indice++;

        GrabarArchivoNormal();
        Serial.println(F("Archivo grabado en SD1"));
        delay(2000);      
        digitalWrite(SD_CS, HIGH);
        while(!SD.begin(SD2_CS)){
          Serial.println(F("Error de tarjeta SD2!"));
          delay(1000);
        }
        GrabarArchivoEncriptado();
        Serial.println(F("Archivo grabado en SD2"));
    }

    // Espera llegada de caracter por la USB-TTL serial.
    pedido_usb();       

    
}
