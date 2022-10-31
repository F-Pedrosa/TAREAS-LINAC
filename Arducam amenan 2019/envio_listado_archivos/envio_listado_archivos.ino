// Firmware para prueba envío listado archivos a celular
#include <SPI.h>
#include "SdFat.h"
#include "memorysaver.h"

#define SD_CS             10
#define LED_ROJO          9 
const int SPI_CS = 8;
#define PULSADOR          2
#define SSID "nodoT1"   // acá el nombre de la red wifi

SdFat SD;
File outFile;

//char buffer2[13];

const String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";  
//String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: image/jpeg\r\nContent-Length: ";
//const String cipSend = "AT+CIPSEND=0,2048";
String cipSend2 = "AT+CIPSEND=0,";

String listado;


// macro para simplificar escritura (y ver si de paso se achica el uso de memoria y programa)
#define cerrar {Serial.println(F("AT+CIPCLOSE=0"));}

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

// ---------------------------------------------------------------------------


void setup(){
analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
Serial.begin(115200);
pinMode(SPI_CS,OUTPUT);
pinMode(LED_ROJO, OUTPUT);
digitalWrite(LED_ROJO, HIGH);
delay(500);
digitalWrite(LED_ROJO, LOW);
pinMode(PULSADOR, INPUT_PULLUP);
pinMode(SD_CS,OUTPUT);

  Serial.println(F("AT+UART_CUR=57600,8,1,0,0"));
  delay(500);
  Serial.end();
  Serial.begin(57600);
  delay(500);
  inicializar_wifi();

// initialize SPI:
SPI.begin();
//Initialize SD Card
while(!SD.begin(SD_CS)){
  //Serial.println(F("Error de tarjeta SD!"));
  digitalWrite(LED_ROJO, HIGH);
  delay(1000);
  }
//Serial.println(F("Tarjeta SD detectada."));
}

void recepcion_pedido_wifi(void){
  byte inByte;
//  unsigned long tamanio = 0;
//  unsigned int cantidad_paquetes = 0;  
//  unsigned int resto = 0;
//  unsigned int cuenta2 = 1; 
//  unsigned int cuenta3 = 0;
 //File file;
  
  while (Serial.available() > 0) {
    inByte = Serial.read();
        if (inByte == '@'){
          while (Serial.available() > 0) {Serial.read();}
          inByte = ' ';
          digitalWrite(LED_ROJO, HIGH);
          delay(100);
          digitalWrite(LED_ROJO, LOW);
          delay(100);      
          digitalWrite(LED_ROJO, HIGH);
          delay(100);
          digitalWrite(LED_ROJO, LOW);
          delay(100);      
          digitalWrite(LED_ROJO, HIGH);
          delay(100);
          digitalWrite(LED_ROJO, LOW);
          delay(100);      

          Serial.print(cipSend2);
          Serial.println(encabezado.length());
          delay(1000);
          Serial.print(encabezado);
          delay(1000);          

          Serial.print(cipSend2);
          //Serial.println(listado.length());
          Serial.println(F("70"));
          SD.chdir("imgs");
          SD.ls("/imgs", LS_R);

          Serial.println("");
          Serial.println("");
          Serial.println("");
          Serial.println("");
          Serial.println("");                    
          //Serial.print(listado);
          delay(1000);          
          
          cerrar;
          delay(1000);
               
        }
    }
}


void loop(){
  if (Serial.available() > 0) {
      recepcion_pedido_wifi();
      while (Serial.available() > 0) {Serial.read();delay(100);}    
  }
}


