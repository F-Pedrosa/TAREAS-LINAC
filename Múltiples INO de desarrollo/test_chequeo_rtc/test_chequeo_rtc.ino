// Para probar rutina chequeo RTC
#include <Wire.h>
#define LED_ROJO          9 
#define PULSADOR          2
#define BATA1             7
#define BATA2             6

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

const int wakeUpPin = 2;

boolean problema_rtc = false;
byte contador_alarma = 0;
boolean una_vez_alarma = true;

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
  
//    // caso RTC detenido
//    delay(1500);
//    Wire.beginTransmission(DS3231);
//    Wire.write(byte(0));
//    Wire.endTransmission();
//    Wire.requestFrom(DS3231, 1);
//    segundos = bcd2Dec(Wire.read());
//    if (segundos < 58){
//      if (segundos <= segundo){
//         problema_rtc = true;
//         return;        
//      }
//    }else{
//      if (segundos >= segundo){
//         problema_rtc = true;        
//      }
//    }
}

void alarma_rtc(void){
    for (byte i=0; i <= 9; i++){
        digitalWrite(LED_ROJO,HIGH);
        delay(100);    
        digitalWrite(LED_ROJO,LOW);          
        delay(200);            
    }   
}



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
  // Inicializar I2C
  Wire.begin();
  pinMode(wakeUpPin, INPUT_PULLUP);   
}



void loop(void) {
  chequeo_rtc();
  delay(300);
  if (problema_rtc){
    alarma_rtc();
    problema_rtc = false;
  }
  delay(1000);
}
