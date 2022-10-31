// **** INCLUDES *****
#include "LowPower.h"
#include <SPI.h>
#include "SdFat.h"
#include <Wire.h>
// librerías para usar el sensor de humedad
#include <TroykaDHT.h>
#include <Adafruit_BMP085.h>

SdFat SD;
File file;

Adafruit_BMP085 bmp;
DHT dht(A0, DHT22);


#define SD_CS         10              // #define SD_CS         4    PARA LA MEGA CON SU SHIELD       
#define LED_ROJO      9 
#define PULSADOR          2
const char CONSTANTE[3] = "T1";


// dirección en el bus I2C del RTC
const int DS3231 = 0x68;

const float CONSTANTE_PULSADO = 0.3;

const int intervalo = 275; 

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

unsigned long indice = 0;               // índice de tramas
volatile int contador = 0;    // cuenta de pulsados
volatile int cantidad_segundos = 0;

char buffer1[3];
char buffer2[8];

boolean solicitado = false;

// Nombre del archivo donde se dejarán las tramas
const char str[] = "full.txt";
const char logfile[] = "bita.txt";
const char str2[] = "alim.txt";

// Use pin 3 as wake up pin
const int wakeUpPin = 3;

void wakeUp()
{
    solicitado = true;
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
  file.print(F(" - "));  
  sprintf(buffer2, "%07d", indice);
  file.print(buffer2);
  indice = indice + 1;
 
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
  dht.read();  
  file.print(dht.getTemperatureC(),1);
  file.print(F(" - "));
  delay(100);
  file.print(dht.getHumidity(),1);
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
  file.print(F(" - "));   
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
  unsigned int val1 = 0;  
  val1 = analogRead(6);
  valorV = ((val1 * 1.71)/513)*2;
  file.print(valorV,2);    
  file.println(F(" V"));    
  // Cerrar archivo
  file.close();
  delay(500);
}




void setup(){
    analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
    Serial.begin(115200);
    pinMode(5, OUTPUT);
    digitalWrite(5,LOW);  
    pinMode(PULSADOR,INPUT_PULLUP ); 
    pinMode(LED_ROJO,OUTPUT); 
    digitalWrite(LED_ROJO,HIGH);
    delay(500);    
    digitalWrite(LED_ROJO,LOW);
    delay(100);    
    digitalWrite(LED_ROJO,HIGH);
    delay(500);    
    digitalWrite(LED_ROJO,LOW);
    delay(100);      
    Wire.begin();
    // Configure wake up pin as input.
    // This will consumes few uA of current.
    pinMode(wakeUpPin, INPUT);
    digitalWrite(wakeUpPin,HIGH);    
    pinMode(SD_CS,OUTPUT);
    // initializar SPI
    SPI.begin();
    if (!SD.begin(SD_CS)) {
       digitalWrite(LED_ROJO,HIGH);
    }

    Serial.println(F("Iniciado"));         
    
    bmp.begin();
    dht.begin();
    delay(1000);
    dht.read();
    delay(2500);
    dht.read();     
}

void loop() {
char inByte;
byte datito;
char arreglo[9];
byte i = 0;
char str[9]= "0000.txt";

    // Allow wake up pin to trigger interrupt on low.
    attachInterrupt(1, wakeUp, LOW);

    for (cantidad_segundos = 0 ;  cantidad_segundos  < intervalo ; cantidad_segundos++){
        LowPower.idle(SLEEP_1S, ADC_OFF, TIMER2_OFF, TIMER1_OFF, TIMER0_OFF, SPI_OFF, USART0_ON, TWI_OFF);  
        if (solicitado == true){break;}
    }
    
    // Disable external pin interrupt on wake up pin.
    detachInterrupt(1); 
    delay(500);

    if (cantidad_segundos == intervalo) {
      grabar_datos_archivo();
      grabar_alimentacion();
      grabar_mensual();
      cantidad_segundos = 0;
//      digitalWrite(LED_ROJO,HIGH);
//      delay(100);    
//      digitalWrite(LED_ROJO,LOW);     
    }
    
    if (solicitado == true){
        //Serial.println(F("DESPERTADO"));
        solicitado = false;
        i = 0;
        while (i <= 8) {
          if (Serial.available()) {arreglo[i] = Serial.read();i++;}
        }
        i = 0;
        //while (Serial.available() == 0) {Serial.read();}        
//        for (i=0; i <= 7; i++){Serial.print(arreglo[i]);}
//        Serial.print("#");
        
//        while (Serial.available() == 0) {Serial.read();}
//        if (Serial.available() > 0) {
//             inByte = Serial.read();
//             while (Serial.available() > 0) {Serial.read();}
             if (arreglo[0]=='m'){
                str[0] = arreglo[3];
                str[1] = arreglo[4];
                str[2] = arreglo[5];
                str[3] = arreglo[6];
                SD.chdir("mensual");                  
                file.open(str, O_READ);
                while (file.available()) {                      // mientras no se haya llegado al final
                    datito = file.read();
                    Serial.write(datito);
                }
                file.close();
                Serial.print("#");
                Serial.println("");                         
                
                digitalWrite(LED_ROJO,HIGH);
                delay(100);    
                digitalWrite(LED_ROJO,LOW);
                delay(500);    
                digitalWrite(LED_ROJO,HIGH);
                delay(100);    
                digitalWrite(LED_ROJO,LOW);

                SD.chdir('/');
                file = SD.open(logfile, O_CREAT | O_APPEND | O_WRITE);
                file.print(str);          // escribir nombre de archivo
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
                //inByte=0;
                for (i=0; i <= 7; i++){arreglo[i]=0;}
             } else if (arreglo[0]=='a'){
                file.open("full.txt", O_READ);
                while (file.available()) {                      // mientras no se haya llegado al final
                    datito = file.read();
                    Serial.write(datito);
                }
                file.close();
                Serial.print("#");
                Serial.println("");                         
                
                digitalWrite(LED_ROJO,HIGH);
                delay(100);    
                digitalWrite(LED_ROJO,LOW);
                delay(500);    
                digitalWrite(LED_ROJO,HIGH);
                delay(100);    
                digitalWrite(LED_ROJO,LOW);

                SD.chdir('/');
                file = SD.open(logfile, O_CREAT | O_APPEND | O_WRITE);
                file.print("full.txt");          // escribir nombre de archivo
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
                //inByte=0;
                for (i=0; i <= 7; i++){arreglo[i]=0;}
                 
             } else if (arreglo[0]=='i'){
                file.open("alim.txt", O_READ);
                while (file.available()) {                      // mientras no se haya llegado al final
                    datito = file.read();
                    Serial.write(datito);
                }
                file.close();
                Serial.print("@");
                Serial.println("");                         
                
                digitalWrite(LED_ROJO,HIGH);
                delay(100);    
                digitalWrite(LED_ROJO,LOW);
                delay(500);    
                digitalWrite(LED_ROJO,HIGH);
                delay(100);    
                digitalWrite(LED_ROJO,LOW);

                SD.chdir('/');
                file = SD.open(logfile, O_CREAT | O_APPEND | O_WRITE);
                file.print("alim.txt");          // escribir nombre de archivo
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
                //inByte=0;
                for (i=0; i <= 7; i++){arreglo[i]=0;}
             } else if (arreglo[0]=='b'){
                file.open("bita.txt", O_READ);
                while (file.available()) {                      // mientras no se haya llegado al final
                    datito = file.read();
                    Serial.write(datito);
                }
                file.close();
                Serial.print("%");
                Serial.println("");                         
                
                digitalWrite(LED_ROJO,HIGH);
                delay(100);    
                digitalWrite(LED_ROJO,LOW);
                delay(500);    
                digitalWrite(LED_ROJO,HIGH);
                delay(100);    
                digitalWrite(LED_ROJO,LOW);
                inByte=0;
                SD.chdir('/');
                file = SD.open(logfile, O_CREAT | O_APPEND | O_WRITE);
                file.print("bita.txt");          // escribir nombre de archivo
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
                for (i=0; i <= 7; i++){arreglo[i]=0;}                            
            } else if (arreglo[0]=='z'){
                digitalWrite(LED_ROJO,HIGH);
//                SD.remove("full.txt");
//                SD.remove("alim.txt");
//                SD.remove("bita.txt");
                SD.wipe();
                SD.begin(SD_CS);            
                SD.mkdir("mensual");
                Serial.print("$");
                Serial.println("");                                     
                digitalWrite(LED_ROJO,LOW);
                //inByte=0;
                for (i=0; i <= 7; i++){arreglo[i]=0;}
             }
        }          
    //}
    

}
