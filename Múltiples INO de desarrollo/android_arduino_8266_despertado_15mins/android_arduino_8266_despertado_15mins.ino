// Firm para que Arduino despierte al ESP8266 (le da alimentación primero a través de mosfet o bc557) cada 15 mins, y si en 7 segs no se detecta
// al celular lo apaga.
#include <Wire.h>
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

#define LED             9   
#define PULSADOR1       2

byte val1;

unsigned long cantidad_paquetes = 0; 

byte inByte;

char pass1[]="pepepepe";
char pass2[]="titotito";
char pass3[]="juanjuan";


unsigned long milis_previo = 0;
const long intervalo = 60000;        // 1 minutos para la prueba (60 seg en milis)

boolean activacion = true;

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


void setup() {
  Serial.begin(115200);

  pinMode(8, OUTPUT);
  digitalWrite(8,LOW);

  pinMode(LED,OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(PULSADOR1,INPUT_PULLUP );

  digitalWrite(LED,HIGH);
  delay(200);    
  digitalWrite(LED,LOW);
  
  digitalWrite(5,HIGH);
  delay(2);

  //mySerial.println(F("Encendido"));

  
}

void loop() {
byte datito;


    // leer minutos desde el RTC
    // si minutos es 0, 15, 30 ó 45, energizar al ESP8266 y setearlo para que busque al celular
//    obtenerFechaHora();
//    if (minuto == 0 || minuto == 15 || minuto == 30 || minuto == 45) then{


    unsigned long milis_actual = millis();
    if (milis_actual - milis_previo >= intervalo) {
    // guardar último tiempo
    milis_previo = milis_actual;

       
       if (activacion == true){
          // encender ESP8266
          digitalWrite(8,HIGH);
            delay(1000);          
          // establecer seteos del módulo   
            Serial.println(F("AT+CWMODE=3"));
            delay(500);
            Serial.println(F("AT+CWDHCP=2,1"));
            delay(500);
            Serial.println(F("AT+CIPMUX=1"));
            delay(500);
          
            Serial.print(F("AT+CWSAP="));
            Serial.write(34);
            Serial.print(F("linac"));
            Serial.write(34);    //comilla 
            Serial.write(44);   //coma
            Serial.write(34);    //comilla 
            
            Serial.print(pass1);        // esta es una de las contraseñas (MÍNIMO 8 CARACTERES!!!!), declaradas al principio
            Serial.write(34);    //comilla 
            Serial.write(44);   //coma
            Serial.println(F("5,3"));
            delay(2000);
            
            Serial.println(F("ATE0"));      // deshabilitar eco local
            delay(500);          
            // preguntar si hay algún dispositivo conectado al esp8266 como access point
            Serial.println(F("AT+CWLIF"));
            delay(100);
            while (Serial.available() > 0)
            //if (Serial.available() > 0)
            {
             inByte = Serial.read();
             if (inByte == '1') {           // "1" por la IP del celular (que arranca en 192)
                digitalWrite(LED,HIGH);
                delay(1500);    // pitido de 1,5 s
                digitalWrite(LED,LOW); 
                
//                enviar = true;
                break; 
   }
  }
       }
       activacion = false;       
    } else {
          digitalWrite(8,LOW);
          activacion = true;      
    }



//
//  if (enviar == true ){
//
//      delay(6000);          // retardo largo para poder arrancar el servidor FTP en el celular
//      
//      enviar = false; 
//      Serial.println(F("ATE1"));
//      delay(500);    
//      Serial.println(F("AT+CIPSERVER=1,1027"));    
//      delay(500);    
//      Serial.print(F("AT+CIPSTART=4,"));
//      Serial.write(34);
//      Serial.print(F("TCP"));
//      Serial.write(34);
//      Serial.print(F(","));
//      Serial.write(34);
//      Serial.print(F("192.168.4.2"));
//      Serial.write(34);      
//      Serial.println(F(",9090"));
//      delay(5000);    
//      Serial.println(F("AT+CIPSEND=4,11"));
//      delay(1500);
//      Serial.println(F("USER user"));
//      delay(800);
//      Serial.println(F("AT+CIPSEND=4,11"));      
//      delay(800);
//      Serial.println(F("PASS pass"));
//      delay(800);
//      Serial.println(F("AT+CIPSEND=4,22"));
//      delay(800);
//      Serial.println(F("PORT 192,168,4,1,4,3"));      
//      //Serial.println("");
//      delay(4000);
//      Serial.println(F("AT+CIPSEND=4,19"));
//      delay(2000);
//      Serial.print(F("STOR "));
//      Serial.print(F("archivo.txt"));    
//      Serial.write(13);
//      Serial.write(10);
//      Serial.write(13);
//      Serial.write(10);
//
//      delay(1000);
//      
//      File file;
//      file.open(str3, O_READ);
//      
//      //Serial.print(F("AT+CIPSEND=0,")); 
//      //enviar tamaño archivo como ASCII, termina con CRLF
//      //Serial.println(file.size());
//
//      Serial.println(F("AT+CIPSEND=0,2048")); 
//      
//      cantidad_paquetes = file.size()/2048;   // si el cociente es entero la división es entera
//      delay(500);
//      
//      // enviar archivo, en paquetes de 2048 bytes por exigencias del ESP8266, con esperas de 20 ms entre paquete y paquete
//      while (file.available()) {                      // mientras no se haya llegado al final
//          datito = file.read();
//          Serial.write(datito);
//          if (cuenta == 2047){
//             cuenta = 0;
//             Serial.print(F("+++"));
//             delay(500); 
//             if (cuenta2 != cantidad_paquetes){
//                Serial.println(F("AT+CIPSEND=0,2048"));
//                cuenta2 = cuenta2 + 1;               
//                delay(500); 
//             }else{
//                cuenta2 = 1;
//                resto = file.size() - (cantidad_paquetes * 2048);
//                Serial.print(F("AT+CIPSEND=0,"));
//                Serial.println(resto);                                 
//                delay(500); 
//             }
//          }else{
//            cuenta = cuenta + 1;            
//          }              
//      }              
//      
//      // cerrar todo
//      file.close();
//      Serial.print(F("+++"));     
//      delay(500);      
//      Serial.println(F("AT+CIPCLOSE=0"));
//      delay(500);
//      Serial.println(F("AT+CIPCLOSE=4"));
//      delay(500);
//      while(1){
//        digitalWrite(LED,HIGH);
//        delay(100);    
//        digitalWrite(LED,LOW); 
//        delay(400);    
//      }
//  }
//  delay(2000);  
}
