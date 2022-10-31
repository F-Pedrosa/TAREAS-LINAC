#include <Wire.h>
const int DS1307 = 0x68; // Address of DS1307 see data sheets
const char* days[] =
{"Domingo", "Lunes", "Martes", "Miercoles", "Jueves", "Viernes", "Sabado"};
const char* months[] =
{"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto","Septiembre", "Octubre", "Noviembre", "Diciembre"};
 
// Initializes all values: 
byte second = 0;
byte minute = 0;
byte hour = 0;
byte weekday = 0;
byte monthday = 0;
byte month = 0;
byte year = 0;


byte i = 0;

byte segundo = 0;
byte minuto = 0;
byte hora = 0;
byte diasemana = 0;
byte dia = 0;
byte mes = 0;
byte anio = 0;
  
  byte dato;
  byte caracter;

  char arreglo[13];


void setup() {
  Wire.begin();
  Serial.begin(57600);
  delay(1000); 
 
//
//  while (!Serial.available()) delay(10);
//  if (Serial.read() == 'y' || Serial.read() == 'Y')
// 
//  // This set of functions allows the user to change the date and time
//  {
//    Serial.read();
//    setTime();
//    Serial.print("The current date and time is now: ");
//    printTime();
//  }
// 
// 
//  Serial.println("Thank you.");
}

// Continuous function for converting bytes to decimals and vice versa

byte decToBcd(byte val) {
  return ((val/10*16) + (val%10));
}
byte bcdToDec(byte val) {
  return ((val/16*10) + (val%16));
}


// This set of codes is allows input of data
void setTime() {
  Serial.print("Please enter the current year, 00-99. - ");
  year = readByte();
  Serial.println(year);
  Serial.print("Please enter the current month, 1-12. - ");
  month = readByte();
  Serial.println(months[month-1]);
  Serial.print("Please enter the current day of the month, 1-31. - ");
  monthday = readByte();
  Serial.println(monthday);
  Serial.println("Please enter the current day of the week, 1-7.");
  Serial.print("1 Sun | 2 Mon | 3 Tues | 4 Weds | 5 Thu | 6 Fri | 7 Sat - ");
  weekday = readByte();
  Serial.println(days[weekday-1]);
  Serial.print("Please enter the current hour in 24hr format, 0-23. - ");
  hour = readByte();
  Serial.println(hour);
  Serial.print("Please enter the current minute, 0-59. - ");
  minute = readByte();
  Serial.println(minute);
  second = 0;
  Serial.println("The data has been entered.");
 
  // The following codes transmits the data to the RTC
  Wire.beginTransmission(DS1307);
  Wire.write(byte(0));
  Wire.write(decToBcd(second));
  Wire.write(decToBcd(minute));
  Wire.write(decToBcd(hour));
  Wire.write(decToBcd(weekday));
  Wire.write(decToBcd(monthday));
  Wire.write(decToBcd(month));
  Wire.write(decToBcd(year));
  Wire.write(byte(0));
  Wire.endTransmission();
  // Ends transmission of data
}


byte readByte() {
  while (!Serial.available()) delay(10);
  byte reading = 0;
  byte incomingByte = Serial.read();
  while (incomingByte != '\n') {
    if (incomingByte >= '0' && incomingByte <= '9')
      reading = reading * 10 + (incomingByte - '0');
    else;
    incomingByte = Serial.read();
  }
  Serial.flush();
  return reading;
}


void printTime() {
  char buffer[3];
  readTime();
  Serial.print(days[weekday-1]);
  Serial.print(" ");
  Serial.print(monthday);
  Serial.print(" de ");
  Serial.print(months[month-1]);
  Serial.print(", 20");
  Serial.print(year);
  Serial.print("  -  ");
  Serial.print(hour);
  Serial.print(":");
  sprintf(buffer, "%02d", minute);
  Serial.println(buffer);
  Serial.print(":");  
  sprintf(buffer, "%02d", second);
  Serial.println(buffer);

}


void readTime() {
  Wire.beginTransmission(DS1307);
  Wire.write(byte(0));
  Wire.endTransmission();
  Wire.requestFrom(DS1307, 7);
  second = bcdToDec(Wire.read());
  minute = bcdToDec(Wire.read());
  hour = bcdToDec(Wire.read());
  weekday = bcdToDec(Wire.read());
  monthday = bcdToDec(Wire.read());
  month = bcdToDec(Wire.read());
  year = bcdToDec(Wire.read());
}


void loop() {


  if (Serial.available() > 0) {
      dato = Serial.read();
      if ( dato == 'a') {
          printTime();
      }
      if (dato >= '0' && dato <= '9'){
          arreglo[i] = dato;
          i++;
          if (i == 13){
              i = 0;
          }
      }          
//      if ( dato == '0') {
//          arreglo[i] = dato;
//          i++;
//          if (i == 13){
//              i = 0;
//          }          
//      }
//      if ( dato == '1') {
//          arreglo[i] = dato;
//          i++;
//          if (i == 13){
//              i = 0;
//          }          
//      }
//      if ( dato == '2') {
//          arreglo[i] = dato;
//          i++;
//          if (i == 13){
//              i = 0;
//          }                    
//      }
//      if ( dato == '3') {
//          arreglo[i] = dato;
//          i++;
//          if (i == 13){
//              i = 0;
//          }                    
//      }
//      if ( dato == '4') {
//          arreglo[i] = dato;
//          i++;
//          if (i == 13){
//              i = 0;
//          }                   
//      }
//      if ( dato == '5') {
//          arreglo[i] = dato;
//          i++;
//          if (i == 13){
//              i = 0;
//          }                    
//      }
//      if ( dato == '6') {
//          arreglo[i] = dato;
//          i++;
//          if (i == 13){
//              i = 0;
//          }                    
//      }
//      if ( dato == '7') {
//          arreglo[i] = dato;
//          i++;
//          if (i == 13){
//              i = 0;
//          }                    
//      }
//      if ( dato == '8') {
//          arreglo[i] = dato;
//          i++;
//          if (i == 13){
//              i = 0;
//          }                    
//      }
//      if ( dato == '9') {
//          arreglo[i] = dato;
//          i++;
//          if (i == 13){
//              i = 0;
//          }                    
//      }
      
      if ( dato == 'b') {
        anio = (arreglo[0] -48) * 10 + arreglo[1] - 48;
        mes = (arreglo[2] -48) * 10 + arreglo[3] - 48;
        diasemana = (arreglo[4] -48);
        dia = (arreglo[5] -48) * 10 + arreglo[6] - 48;
        hora = (arreglo[7] -48) * 10 + arreglo[8] - 48;
        minuto = (arreglo[9] -48) * 10 + arreglo[10] - 48;
        segundo = (arreglo[11] -48) * 10 + arreglo[12] - 48;

        Wire.beginTransmission(DS1307);
        Wire.write(byte(0));
        Wire.write(decToBcd(segundo));
        Wire.write(decToBcd(minuto));
        Wire.write(decToBcd(hora));
        Wire.write(decToBcd(diasemana));
        Wire.write(decToBcd(dia));
        Wire.write(decToBcd(mes));
        Wire.write(decToBcd(anio));
        Wire.write(byte(0));
        Wire.endTransmission();
      }
   }
}
