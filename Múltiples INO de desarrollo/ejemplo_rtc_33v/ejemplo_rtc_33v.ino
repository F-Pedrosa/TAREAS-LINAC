#include <Wire.h>
const int DS3231 = 0x68; // dirección I2C del RTC
 
// Inicializar variables
byte segundo = 0;
byte minuto = 0;
byte hora = 0;
byte mes = 0;
byte anio = 0;
byte weekday = 0;
byte dia = 0;

void printTime() {
  char buffer[3];
  readTime();
  sprintf(buffer, "%02d", dia);
  Serial.print(buffer);
  Serial.print("/");
  sprintf(buffer, "%02d", mes);
  Serial.print(buffer);
  Serial.print("/");
  Serial.print("20");
  Serial.print(anio);
  Serial.print(" ");
  sprintf(buffer, "%02d", hora);
  Serial.print(buffer);  
  Serial.print(":");
  sprintf(buffer, "%02d", minuto);
  Serial.print(buffer);
  Serial.print(":");
  sprintf(buffer, "%02d", segundo);
  Serial.println(buffer);
}


void readTime() {
  Wire.beginTransmission(DS3231);
  Wire.write(byte(0));
  Wire.endTransmission();
  Wire.requestFrom(DS3231, 7);
  segundo = bcdToDec(Wire.read());
  minuto = bcdToDec(Wire.read());
  hora = bcdToDec(Wire.read());
  weekday = bcdToDec(Wire.read());
  dia = bcdToDec(Wire.read());
  mes = bcdToDec(Wire.read());
  anio = bcdToDec(Wire.read());
}

byte decToBcd(byte val) {
  return ((val/10*16) + (val%10));
}

byte bcdToDec(byte val) {
  return ((val/16*10) + (val%16));
}

void setup() {
  Wire.begin();
  Serial.begin(9600);
  Serial.println("Serial OK");
  delay(2000); // This delay allows the MCU to read the current date and time.
  Serial.print("Fecha y hora del RTC: ");
  printTime();
}

void loop() {
  delay(2000);
  printTime();
}
