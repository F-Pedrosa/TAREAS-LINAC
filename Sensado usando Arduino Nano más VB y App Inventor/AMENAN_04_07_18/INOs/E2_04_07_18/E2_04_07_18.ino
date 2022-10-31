// Para probar todas las AMENANes
 
#include <SPI.h>
#include "RF24.h"
#include "SdFat.h"
#include "LowPower.h"
#include <Wire.h>
// librerías para usar el sensor de humedad
#include <TroykaDHT.h>
// librerías para usar el sensor de presión
#include <Adafruit_BMP085.h>

// file system
SdFat SD;
File file;

#define SSID "nodoE2"   // acá el nombre de la red wifi
const char CONSTANTE[3] = "E2";
#define PASS "pepepepe" // esta es la contraseña para la misma 
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9 
#define PULSADOR          2
#define BATA1             7
#define BATA2             6

Adafruit_BMP085 bmp;
DHT dht(A0, DHT22);

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

// Nombre de los archivos donde se dejarán las tramas y otros datos
const char str[] = "full.txt";
const char logfile[] = "bita.txt";
const char str2[] = "alim.txt";

volatile int contador = 0;    // cuenta de pulsados
unsigned long indice = 0;     // índice de tramas
unsigned int cuenta = 0;
unsigned int resto = 0;
byte inByte;
volatile int cantidad_segundos = 0;
const int wakeUpPin = 2;
boolean salir = false;

char receivedChars[28];
String mi_cadena = "    ";
unsigned int tiempo = 0;
boolean newData = false;
boolean recvInProgress = false;
byte ndx = 0;
char str3[] = "0000.txt";
const String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";
String encabezado3 = "HTTP/1.1 205 OK\r\nContent-Type: ";   // para enviar tiempo estimado de transmisión
const String cipSend = "AT+CIPSEND=0,2048";
String cipSend2 = "AT+CIPSEND=0,";
boolean primer_paquete = false;
boolean segundo_paquete = false;
boolean una_vez = true;
unsigned long tamanio = 0;
unsigned int cantidad_paquetes = 0;
unsigned int cuenta3 = 0;
unsigned int cuenta2 = 1; 
// constante que define cuantos segundos estará dormido antes de despertarse y medir
const int intervalo = 270;                    // 5 minutos, valor aleatorio elegido sin mayor implicancia
unsigned long currentMillis = 0;
unsigned long previousMillis = 0;
const unsigned long interval = 30000;                       // 30 segundos es el tiempo que le asignamos para esperar el pedido desde el cel.

char buffer1[3];
char buffer2[8];
boolean problema_rtc = false;
byte contador_alarma = 0;
boolean una_vez_alarma = true;
char inbuffer[18];
char OKrn[] = "OK\r\n";  

byte wait_for_esp_response(int timeout, char* term=OKrn) {  
  unsigned long t=millis();  
  bool found=false;  
  byte i=0;  
  int len=strlen(term);  
  // wait for at most timeout milliseconds or if OK\r\n is found  
  while(millis()<t+timeout) {  
     if(Serial.available()) {  
        inbuffer[i++]=Serial.read();  
        if(i>=len) {  
           if(strncmp(inbuffer+i-len, term, len)==0) {  
              found=true;  
              break;  
           }  
        }  
     }  
  }  
  inbuffer[i]=0;  
  return found;  
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
  
  file = SD.open(str, FILE_WRITE);
  obtenerFechaHora();
  file.println("");
  file.print(CONSTANTE);
  file.print(F(" "));  
  sprintf(buffer2, "%07d", indice);
  file.print(buffer2);
  indice = indice + 1;
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
  file.print(F(" "));
  
  dht.read();
  delay(2000);
  dht.read();  
  file.print(dht.getTemperatureC(),1);
  file.print(F(" "));
  delay(100);
  file.print(dht.getHumidity(),1);
  file.print(F(" "));
  //Leer sensor de presión y temperatura BMP180
  file.print(bmp.readTemperature(),1);
  file.print(F(" "));
  file.print((bmp.readPressure())/100);
  file.print(F(" "));
  resultado_contador = contador * CONSTANTE_PULSADO;  
  file.print(int(resultado_contador));  //parte entera
  file.print("."); // punto decimal
  unsigned int frac;
  frac = (resultado_contador - int(resultado_contador)) * 10;
  file.print(frac);                    // decimales
  contador = 0;
  // Cerrar archivo
  file.close();
  delay(500);
}

void grabar_mensual(void){
  char buffer1[3];
  char buffer2[8];
  String str_mes;
  char str4[] = "0000.txt";
  if (mes < 10 ){str_mes += "0";}
  str_mes += mes;
  str_mes += anio;
  str_mes += ".txt";     
  SD.chdir("mensual");
  str_mes.toCharArray(str4, 9);
  file = SD.open(str4, O_CREAT | O_APPEND | O_WRITE);
  file.print(CONSTANTE);
  file.print(F(" "));    
  sprintf(buffer2, "%07d", indice);
  file.print(buffer2);
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
  file.print(F(" "));
  file.print(dht.getTemperatureC(),1);
  file.print(F(" "));
  delay(100);
  file.print(dht.getHumidity(),1);
  file.print(F(" "));
  //Leer sensor de presión y temperatura BMP180
  file.print(bmp.readTemperature(),1);
  file.print(F(" "));  //file.print(F(" *C"));
  file.print((bmp.readPressure())/100);
  file.print(F(" "));  //file.print(F(" hPa - ")); 
  file.print(int(resultado_contador));  //parte entera
  file.print("."); // punto decimal
  unsigned int frac;
  frac = (resultado_contador - int(resultado_contador)) * 10;
  file.println(frac);                    // decimales
  // Cerrar archivo
  file.close();
  SD.chdir('/');
  delay(500);  
}

void grabar_alimentacion(void){
  char buffer1[3];
  char buffer2[8];
  SD.chdir('/');
  file = SD.open(str2, O_CREAT | O_APPEND | O_WRITE);
  file.print(CONSTANTE);
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
  file.print(F(" "));
  float valorV = 0;
  int val1 = 0;  
  val1 = analogRead(7);
  valorV = (val1 * 3.41)/896;
  file.print(valorV,2);    
  file.println(F(" V"));    
  // Cerrar archivo
  file.close();
  delay(500);
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
//

void recepcion_pedido_wifi(void){
  currentMillis = millis();
  if (currentMillis >= previousMillis + interval) {
    salir = true;
  }

  while (Serial.available() > 0) {
    inByte = Serial.read();
    if ((inByte == '+') && (newData == false)) {
      newData = true;    
    }
    if (newData){
        receivedChars[ndx] = inByte;
        ndx++;
        if (ndx >= 27){
            newData = false;
            ndx = 0;
            if (receivedChars[16] == '7'){
              if (una_vez){
                primer_paquete = true;
                una_vez = false;                
              }
            }
            if (!((primer_paquete == true) || (segundo_paquete == true))) {
                Serial.println(F("AT+CIPCLOSE=0"));
                delay(200);
                cuenta++;              
                mi_cadena+= receivedChars[16];
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
          previousMillis = millis();
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
          previousMillis = millis();                
     }
  }
  
  if (primer_paquete){
      digitalWrite(LED_ROJO,HIGH);
      delay(500);
      digitalWrite(LED_ROJO,LOW);
      primer_paquete = false;
      segundo_paquete = true;
      tiempo = tamanio/4400;   
      tiempo += 4;                  // para incluir un retardo al principio del próximo bloque IF THEN
      encabezado3 += encabezado3 + tiempo;
      encabezado3 += "  \r\n\r\n";
      cipSend2 += encabezado3.length();
      Serial.println(cipSend2);
      delay(500);
      Serial.print(encabezado3);
      Serial.println(""); Serial.println(""); Serial.println("");
      delay(500);
      Serial.println(F("AT+CIPCLOSE=0"));
      delay(500);
      previousMillis = millis();
  }

  if (segundo_paquete){
     delay(4000);
     segundo_paquete = false;
     file.open(str3, O_READ);    
      // 1er paquete del archivo, difiere de los otros paquetes en q al principio lleva el encabezado.
      Serial.println(cipSend);
      delay(500);
      Serial.print(encabezado);
      if (tamanio <= 2002) {
        for (int i=0; i <= tamanio; i++){
            Serial.write(file.read());
        }
        for (int i=0; i <= (2002-tamanio); i++){
            Serial.println("+");
        }
        goto salida;
      }else{
      for (int i=0; i <= 2002; i++){
            Serial.write(file.read());
        }
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
                resto = resto + encabezado.length() + 1;
                Serial.println(resto);                                 
                previousMillis = millis();
                wait_for_esp_response(600);  
            }
         }else{
                cuenta3 = cuenta3 + 1;            
              }       
      }
      salida:
      file.close();
      Serial.println("");
      delay(500);          
      Serial.println(F("AT+CIPCLOSE=0"));
      obtenerFechaHora();

      SD.chdir('/');
      file = SD.open(logfile, O_CREAT | O_APPEND | O_WRITE);
      file.print(str3);          // escribir nombre de archivo
      file.print(F("   "));         // seguido por fecha y hora (al momento de finalizarse la transmisión)
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
      file.println(buffer1);
      file.close();
      salir = true;
      //terminado = false;
      delay(500);
      resetFunc();  //call reset  
  }
}

void chequeo_rtc(void) {
    byte segundos = 0;
    obtenerFechaHora();
    if ((dia == 165) || (mes == 165) || (anio == 165) || (hora == 165) || (minuto == 165) || (segundo == 165)) {
      problema_rtc = true;
      return;  
    }
  
    if ((dia == 0) || (dia > 31)) {
      problema_rtc = true;
      return;  
    }
    if ((mes == 0) || (mes > 12)){
      problema_rtc = true;    
      return;  
    }
    if (anio == 0){
      problema_rtc = true;    
      return;  
    }
    
    if (hora > 23) {
      problema_rtc = true;
      return;  
    }
    if (minuto > 59){
      problema_rtc = true;    
      return;  
    }
    if (segundo > 59){
      problema_rtc = true;    
      return;  
    }
}


void alarma_rtc(void){
    for (byte i=0; i <= 9; i++){
        digitalWrite(LED_ROJO,HIGH);
        delay(100);    
        digitalWrite(LED_ROJO,LOW);          
        delay(200);            
    }   
}


// ------------------------- este código se ejecuta cdo se pulsa el pulsador, ES UNA INTERRUPCIÓN -------------------
void wakeUp(){contador = contador + 1;}
// ------------------------------------------------------------------------------------------------------------------

void setup(){
  analogReference(EXTERNAL);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO

  Serial.begin(115200);
  pinMode(5, OUTPUT);
  digitalWrite(5,LOW);  
  pinMode(PULSADOR,INPUT_PULLUP );
  pinMode(LED_ROJO, OUTPUT);
  // prender 2 segs el led rojo
  digitalWrite(LED_ROJO,HIGH);
  delay(2000);    
  digitalWrite(LED_ROJO,LOW);
  // setear al ESP8266 a 57600 (el arduino recibe mal a 115200)
  Serial.println(F("AT+UART_CUR=57600,8,1,0,0"));
  delay(500);
  Serial.end();
  Serial.begin(57600);
  Serial.println(F("AT+CWMODE_CUR=1"));
  delay(500);
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
  // si la carpeta mensual no existe, crearla
  if (SD.exists("mensual") == false){
    SD.mkdir("mensual"); 
  }
  attachInterrupt(0, wakeUp, FALLING);   // Habilitar la interrupción que se producirá al oprimirse el botón conectado al pin 2  
  Serial.println(F("AT+CWMODE_CUR=1"));
  delay(400);
  bmp.begin();
  dht.begin();
  delay(1000);
  dht.read();         // un par de lecturas dummy por cuestiones del sensor y la librería
  dht.getTemperatureC();
  delay(2000);
  dht.read();
  dht.getTemperatureC();    
}



void loop(void) {  
    for (cantidad_segundos = 0 ;  cantidad_segundos  <  intervalo ; cantidad_segundos++){
      conmutar_sd_nordic(false);
      LowPower.powerDown(SLEEP_1S, ADC_OFF, BOD_OFF); 
    }
    
    chequeo_rtc();
    if (problema_rtc){alarma_rtc();}
           
    conmutar_sd_nordic(true);
    grabar_datos_archivo(); 
    grabar_mensual();
    grabar_alimentacion();

    // SECCIÓN WIFI
    // inicializar nuevamente el módulo wifi  
    inicializar_wifi();
    while (Serial.available() > 0) {Serial.read();}   // limpiar buffer serial de los mensajes de inicio
    salir = false;   
    // esperar pedido de conexión desde el celular durante "intervalo" segundos (20 por el momento).
    previousMillis = millis();
    while (salir == false) {  
        recepcion_pedido_wifi();
    }
    
    Serial.println(F("AT+CWMODE_CUR=1"));
    delay(100);
}
