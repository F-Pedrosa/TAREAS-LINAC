#include <SPI.h>
#include "SdFat.h"
#include <Wire.h>

// SD chip select pin
const uint8_t chipSelect = 10;
// file system
SdFat SD;
// test file
SdFile file;

#define LED             9   
#define PULSADOR1       2

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

unsigned long cantidad_paquetes = 0; 
boolean enviar = false;
char str3[] = "archivo.txt";
int cuenta = 0;
int cuenta2 = 1;
int resto = 0;
byte inByte;

byte bcd2Dec(byte val)
{
  return ((val/16*10) + (val%16));
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


#define BUFFER_SIZE 256
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


void setup() {
  Serial.begin(115200);
  Wire.begin();

  pinMode(LED,OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(PULSADOR1,INPUT_PULLUP );

  digitalWrite(LED,HIGH);
  delay(200);    
  digitalWrite(LED,LOW);
  
  digitalWrite(5,HIGH);
  delay(2);
  if (!SD.begin(chipSelect, SD_SCK_MHZ(50))) {
     digitalWrite(LED,HIGH);
  }
  
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

void loop() {
byte datito;
  // preguntar periódicamente si hay algún dispositivo conectado al esp8266 como access point
  Serial.println(F("AT+CWLIF"));
  while (Serial.available() > 0)
  {
   inByte = Serial.read();
   if (inByte == '1') {           // "1" por la IP del celular (que arranca en 192)
      // pitido inicio proceso de transmisión
      digitalWrite(LED,HIGH);
      delay(200);    
      digitalWrite(LED,LOW);     
      enviar = true;
      break; 
   }
  }


  if (enviar == true ){
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
          datito = file.read();
          Serial.write(datito);
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
      
      delay(4000);           // esperar 4 segs antes de mandar msje de terminación

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
        digitalWrite(LED,HIGH);
        delay(100);    
        digitalWrite(LED,LOW); 
        delay(400);    
      }
     while(1){
      // lazo infinito para detener ejecución
      }
      
 }

 delay(2000);  
}
