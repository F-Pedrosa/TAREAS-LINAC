// Firm para comunicarse con un  SIM900 y enviar mensajes (y archivos?)

#include <SPI.h>
#include "SdFat.h"

// SD chip select pin
const uint8_t chipSelect = 10;
// file system
SdFat SD;
// test file
SdFile file;

#define LED             9   
#define PULSADOR1       2
#define PWRKEY          8

byte val1;
char str3[] = "archivo.txt";

void setup() {
  Serial.begin(115200);

  digitalWrite(PWRKEY,LOW);
  pinMode(PWRKEY, OUTPUT);
  

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
  // esperar 8 segundos indica la hoja de datos del SIM900
  delay(8000);
  // activación del módulo SIM900 mediante un pulso en línea PWRKEY
  digitalWrite(PWRKEY,HIGH);
  delay_(2500);     //2,5 segundos, con este valor anda bien según las pruebas
  digitalWrite(PWRKEY,LOW);
  // esperar 20 segundos, con este valor le damos tiempo a registrarse en la red celular
  delay(20000);


  //  AT+SAPBR=3,1,"CONTYPE","GPRS"
  Serial.print(F("AT+SAPBR=3,1,"));
  Serial.write(34);    //comilla 
  Serial.print(F("CONTYPE"));
  Serial.write(34);    //comilla 
  Serial.print(F(","));    
  Serial.write(34);    //comilla   
  Serial.println(F("GPRS"));  
  delay(200);

  //   AT+SAPBR=3,1,"APN","internet"
  Serial.print(F("AT+SAPBR=3,1,"));
  Serial.write(34);    //comilla 
  Serial.print(F("APN"));
  Serial.write(34);    //comilla     
  Serial.print(F(","));    
  Serial.write(34);    //comilla   
  Serial.print(F("internet"));
  Serial.write(34);    //comilla     
  Serial.println("");
  delay(200);

  //  AT+SAPBR=1,1
  Serial.println(F("AT+SAPBR=1,1"));  
  delay(300);

  // AT+FTPCID=1
  Serial.println(F("AT+FTPCID=1"));
  delay_(200);

  // AT+FTPSERV="linac01.hopto.org"
  Serial.print(F("AT+FTPSERV="));
  Serial.write(34);    //comilla     
  Serial.print(F("linac01.hopto.org"));
  Serial.write(34);    //comilla     
  Serial.println("");
  delay(200);

  // AT+FTPUN="user"
  Serial.print(F("AT+FTPUN="));
  Serial.write(34);    //comilla     
  Serial.print(F("user"));
  Serial.write(34);    //comilla     
  Serial.println("");
  delay(200);

  //  AT+FTPPW="pass"
  Serial.print(F("AT+FTPPW="));
  Serial.write(34);    //comilla     
  Serial.print(F("pass"));
  Serial.write(34);    //comilla     
  Serial.println("");
  delay(200);

   // AT+FTPPUTPATH="/"
  Serial.print(F("AT+FTPPUTPATH=");
  Serial.write(34);    //comilla     
  Serial.print(F("/");
  Serial.write(34);    //comilla     
  Serial.println("");
  delay(200);

  //  AT+FTPPUTNAME="nombre.extension"
  Serial.print(F("AT+FTPPUTNAME="));
  // Las siguientes  líneas arman y envían el nombre del archivo
  Serial.write(34);    //comilla     
  Serial.print(str3);
  Serial.write(34);    //comilla     
  Serial.println("");
  delay(200);
  
  //   AT+FTPPUT=1
  Serial.println(F("AT+FTPPUT=1"));
  delay(15000);          // esperar 15 segs, la respuesta debería ser +FTPPUT:1,1,1260

  //  AT+FTPPUT=2,tamaño archivo
  Serial.println(F("AT+FTPPUT=2"));
  Serial.println(file.size());
  delay(1000);

  // Enviar archivo propiamente dicho
  File file;
  file.open(str3, O_READ);     
      
  while (file.available()) {                      // mientras no se haya llegado al final
      datito = file.read();
      Serial.write(datito);
  }              
      
  // cerrar todo
  file.close();  
  
  // AT+FTPPUT=2,0         cierra transmisión
  Serial.println(F("AT+FTPPUT=2,0"));
  delay(500);

}

void loop() {
byte datito;


  if (enviar == true ){
     enviar = false; 
      
}
