// Firm que espera la llegada del pedido desde la AMENAN1D para a continuación enviar el archivo TRAMAS.TXT
// Incluye las rutinas para esperar el pedido de archivo desde un celular android, esta es la versión que se
// entiende con DATOS.APK
 
#include <SPI.h>
//#include "RF24.h"
#include "SdFat.h"
#include "LowPower.h"
#include <Wire.h>

//#include <SimpleDHT.h>
//int pinDHT22 = A0;
//SimpleDHT22 dht22;

// file system
SdFat SD;
File file;

#define SSID "nodoA1"   // acá el nombre de la red wifi
#define PASS "pepepepe" // esta es la contraseña para la misma 
#define LED             9   
#define PULSADOR1       2

#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9 
#define PULSADOR          2
#define BATA1             7
#define BATA2             6

// macro para simplificar escritura (y ver si de paso se achica el uso de memoria y programa)
#define cerrar {Serial.println(F("AT+CIPCLOSE=0"));}

const char CONSTANTE[3] = "A1";
const float CONSTANTE_PULSADO = 0.3;

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
const char str2[] = "alim.txt";
volatile byte contador = 0;    // cuenta de pulsados
unsigned long indice = 0;               // índice de tramas
String cadena=String(3);

boolean bandera_grabacion = true;
boolean escuchar = false;
unsigned int cuenta = 0;
unsigned int resto = 0;
byte inByte;
const byte wakeUpPin = 2;

boolean transmitir = false;
boolean salir = false;

char receivedChars[18];
String mi_cadena = "    ";

unsigned int tiempo = 0;

boolean newData = false;
boolean recvInProgress = false;
byte ndx = 0;

char str3[] = "0618.txt";
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
const int intervalo = 10;                    // en segundos
volatile int cantidad_segundos = 0;
unsigned long currentMillis = 0;
unsigned long previousMillis = 0;
const unsigned long interval = 60000;                       // xx segundos es el tiempo que le asignamos para esperar el pedido desde el cel.

char buffer1[3];
char buffer2[8];
//boolean terminado = false;
boolean problema_rtc = false;
byte contador_alarma = 0;
boolean una_vez_alarma = true;
char buffer[18];
char OKrn[] = "OK\r\n";  


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
//  float temperature = 0;
//  float humidity = 0;
//  dht22.read2(pinDHT22, &temperature, &humidity, NULL);
//  outFile.print((float)temperature); outFile.print(F(" *C, "));
//  outFile.print((float)humidity); outFile.print(F(" RH%"));

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

//    //float valorV = 0;
//    //int val1 = 0; 
//    
////    val1 = analogRead(7);
////    valorV = (val1 * 3.41)/896;
////    outFile.print(valorV,2);    
//    outFile = SD.open(str2, FILE_WRITE);
//    sprintf(buffer1, "%02d", dia);
//    outFile.print(buffer1);
//    outFile.print(F("/"));  
//    sprintf(buffer1, "%02d", mes);
//    outFile.print(buffer1);
//    outFile.print(F("/"));  
//    outFile.print("20");
//    outFile.print(anio);
//    outFile.print(F(" "));
//    sprintf(buffer1, "%02d", hora);
//    outFile.print(buffer1);
//    outFile.print(F(":"));
//    sprintf(buffer1, "%02d", minuto);
//    outFile.print(buffer1);
//    outFile.print(F(":"));
//    sprintf(buffer1, "%02d", segundo);
//    outFile.print(buffer1);
//    outFile.print(F(" - "));
//    // reusamos las variables resto y resultado_contador porque nos estamos quedando sin RAM
//    //resto = analogRead(7);
//    resto = 893; /// SOLO PARA LA PRUEBA!!!!
//    resultado_contador = (resto * 3.41)/896;
//    outFile.print(resultado_contador,2);    
//    resto = 0;
//    resultado_contador = 0;;  
//    outFile.println(F(" V"));    
//    // Cerrar archivo
//    outFile.close();
//    
//    SD.chdir("mensual");
//    sprintf(buffer1, "%02d", mes);
//    mi_cadena = buffer1;
//    sprintf(buffer1, "%02d", anio);
//    mi_cadena += buffer1;
//    mi_cadena += ".txt";
//    mi_cadena.toCharArray(str3, 9);
//    outFile = SD.open(str3, O_WRITE | O_APPEND);
//    outFile.println("");
//    outFile.print(CONSTANTE);
//    outFile.print(F(" "));  
//    sprintf(buffer2, "%07d", indice);
//    outFile.print(buffer2);
//    outFile.print(F(" - "));
//    sprintf(buffer1, "%02d", dia);
//    outFile.print(buffer1);
//    outFile.print(F("/"));  
//    sprintf(buffer1, "%02d", mes);
//    outFile.print(buffer1);
//    outFile.print(F("/"));  
//    outFile.print("20");
//    outFile.print(anio);
//    outFile.print(F(" "));
//    sprintf(buffer1, "%02d", hora);
//    outFile.print(buffer1);
//    outFile.print(F(":"));
//    sprintf(buffer1, "%02d", minuto);
//    outFile.print(buffer1);
//    outFile.print(F(":"));
//    sprintf(buffer1, "%02d", segundo);
//    outFile.print(buffer1);
//    outFile.print(F(" - "));
//    
//    cadena = String(event.temperature);
//    cadena.replace('.',',');
//    outFile.print(cadena);
//    // Humedad
//    outFile.print(F(" - "));
//    cadena = String(event.relative_humidity);
//    cadena.replace('.',',');
//    outFile.print(cadena);
//    outFile.print(F(" -               "));

//  outFile.print((float)temperature); //Serial.print(F(" *C, "));
//  outFile.print((float)humidity); //Serial.print(F(" RH%"));
//    
//    outFile.print(int(resultado_contador));  //prints the int part
//    outFile.print("."); // print the decimal point
//    if(resultado_contador >= 0){
//       frac = (resultado_contador - int(resultado_contador)) * 10;
//    }else{
//       frac = (int(resultado_contador)- resultado_contador ) * 10;
//    }
//    outFile.print(frac);
//    // Cerrar archivo
//    outFile.close();

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
  //wait_for_esp_response(500);
  delay(500);
  Serial.println(F("AT+CIPSERVER=1,80")); // iniciar servidor en puerto 80 (HTTP)
  //wait_for_esp_response(250);
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
    if ((inByte == '+') && (newData == false)) {
      newData = true;    
    }
    if (newData){
        receivedChars[ndx] = inByte;
        ndx++;
        if (ndx >= 28){
            newData = false;
            ndx = 0;
            if (receivedChars[16] == '7'){
              if (una_vez){
                primer_paquete = true;
                una_vez = false;                
              }
            }
            if (!((primer_paquete == true) || (segundo_paquete == true))) {
                cerrar;
                //wait_for_esp_response(200);
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
      digitalWrite(LED,HIGH);
      delay(500);
      digitalWrite(LED,LOW);
      primer_paquete = false;
      segundo_paquete = true;
      tiempo = tamanio/4400;   
      tiempo += 2;                  // para incluir un retardo al principio del próximo bloque IF THEN
      encabezado3 += encabezado3 + tiempo;
      encabezado3 += "  \r\n\r\n";
      cipSend2 += encabezado3.length();
      Serial.println(cipSend2);
      delay(500);
      Serial.print(encabezado3);
      Serial.println(""); Serial.println(""); Serial.println("");
      delay(500);
      cerrar;
      delay(500);
      previousMillis = millis();
  }

  if (segundo_paquete){
     delay(2000);
     segundo_paquete = false;
     file.open(str3, O_READ);    
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
                wait_for_esp_response(400);  
                cuenta2 = cuenta2 + 1;
                previousMillis = millis();               
             }else{
                cuenta2 = 1;
                Serial.print(F("AT+CIPSEND=0,"));
                resto = resto + encabezado.length();
                Serial.println(resto);                                 
                previousMillis = millis();
                wait_for_esp_response(400);  
            }
         }else{
                cuenta3 = cuenta3 + 1;            
              }       
      }
      file.close();
      Serial.println("");
      delay(500);          
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
  
    // caso RTC detenido
    delay(1500);
    Wire.beginTransmission(DS3231);
    Wire.write(byte(0));
    Wire.endTransmission();
    Wire.requestFrom(DS3231, 1);
    segundos = bcd2Dec(Wire.read());
    if (segundos < 58){
      if (segundos <= segundo){
         problema_rtc = true;
         return;        
      }
    }else{
      if (segundos >= segundo){
         problema_rtc = true;        
      }
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
void wakeUp() {contador = contador + 1;}
// ------------------------------------------------------------------------------------------------------------------


void setup(){
  analogReference(EXTERNAL);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
  Serial.begin(115200);
  pinMode(5, OUTPUT);
  //digitalWrite(5,HIGH);  
  digitalWrite(5,LOW);  
  pinMode(PULSADOR,INPUT_PULLUP );
  pinMode(LED_ROJO, OUTPUT);
  digitalWrite(LED_ROJO,HIGH);
  delay(300);    
  digitalWrite(LED_ROJO,LOW);

// setear al ESP8266 a 57600 (el arduino recibe mal a 115200)
  Serial.println(F("AT+UART_CUR=57600,8,1,0,0"));
  //wait_for_esp_response(500);
  delay(500);
  Serial.end();
  Serial.begin(57600);
  delay(500);
  // Inicializar I2C
  Wire.begin();
  pinMode(wakeUpPin, INPUT_PULLUP);   

  // inicializar sensor de humedad y temperatura
  //dht.begin();            

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

  // Habilitar la interrupción que se producirá al oprimirse el botón conectado al pin 2
  attachInterrupt(0, wakeUp, FALLING);
}



void loop(void) {

//    chequeo_rtc();
//    if (problema_rtc){
//      if ((contador_alarma==0) && (una_vez_alarma)) {     // por si arranca con el RTC muerto, pitea en ese momento.
//          alarma_rtc();
//          contador_alarma += 1;
//          una_vez_alarma = false;
//      }else if (contador_alarma==12){         // 12 cuentas de 5 minutos = 1 hora
//          alarma_rtc();
//          contador_alarma = 0;                  
//      }else{
//          contador_alarma += 1;
//      }
//    }




//    // SECCIÓN WIFI
//    // alimentar módulo wifi
//    // inicializar nuevamente el módulo wifi  
//    inicializar_wifi();
//    while (Serial.available() > 0) {Serial.read();}   // limpiar buffer serial de los mensajes de inicio
//    salir = false;   
//    // esperar pedido de conexión desde el celular durante "intervalo" segundos (20 por el momento).
//    previousMillis = millis();
//    while (salir == false) {  
//        recepcion_pedido_wifi();
//    }
//
//    Serial.println(F("AT+CWMODE_CUR=1"));
//    //wait_for_esp_response(100);
//    delay(100);
//    Serial.println(F("AT+CIPSERVER=0"));
//    //wait_for_esp_response(100);    
//    delay(100);
    for (cantidad_segundos = 0 ;  cantidad_segundos  <  intervalo ; cantidad_segundos++){
      //conmutar_sd_nordic(false);
      LowPower.powerDown(SLEEP_1S, ADC_OFF, BOD_OFF); 
    }

    conmutar_sd_nordic(true);
    grabar_datos_archivo();
    delay(100);
    conmutar_sd_nordic(false);



}
