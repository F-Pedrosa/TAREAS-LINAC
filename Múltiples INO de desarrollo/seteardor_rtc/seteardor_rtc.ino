
byte weekday = 0;
byte monthday = 0;
byte month = 0;
byte year = 0;

void setup() {
  Wire.begin();
  Serial.begin(57600);
  pinMode(LED_ROJO, OUTPUT);
  digitalWrite(LED_ROJO,HIGH);
  delay(300);    
  digitalWrite(LED_ROJO,LOW);
//  delay(2000); // This delay allows the MCU to read the current date and time.
 
  Serial.print("Fecha y hora actual: ");
  printTime();
  Serial.println("");
  Serial.println("Quiere cambiar la fecha y la hora del RTC? S/N");
 
  while (!Serial.available()) delay(10);
  if (Serial.read() == 's' || Serial.read() == 'S')
  // This set of functions allows the user to change the date and time
  {
    Serial.read();
    setTime();
    Serial.print("Fecha y hora nuevos: ");
    printTime();
  }
}


// Continuous function for converting bytes to decimals and vice versa
void loop() {
}
byte decToBcd(byte val) {
  return ((val/10*16) + (val%10));
}
byte bcdToDec(byte val) {
  return ((val/16*10) + (val%16));
}


// This set of codes is allows input of data
void setTime() {
  Serial.print("Ingrese el año, en formato 00-99. - ");
  year = readByte();
  Serial.println(year);
  Serial.print("Ingrese el mes, 1-12. - ");
  month = readByte();
  Serial.println(months[month-1]);
  Serial.print("Ingrese el día, 1-31. - ");
  monthday = readByte();
  Serial.println(monthday);
  Serial.println("Ingrese el día de la semana, 1-7.");
  Serial.print("1 Dom | 2 Lun | 3 Mar | 4 Mie | 5 Jue | 6 Vie | 7 Sáb - ");
  weekday = readByte();
  Serial.println(days[weekday-1]);
  Serial.print("Ingrese la hora en formato de 24H, 0-23. - ");
  hour = readByte();
  Serial.println(hour);
  Serial.print("Ingrese los minutos, 0-59. - ");
  minute = readByte();
  Serial.println(minute);
  second = 0;
  Serial.println("Datos ingresados.");
 
  // Enviar al RTC
  Wire.beginTransmission(DS3231);
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

}


byte readByte() {
  while (!Serial.available()) delay(50);
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
  const char* AMPM = 0;
  readTime();
  Serial.print(days[weekday-1]);
  Serial.print(" ");
  Serial.print(months[month-1]);
  Serial.print(" ");
  Serial.print(monthday);
  Serial.print(", 20");
  Serial.print(year);
  Serial.print(" ");
//  if (hour > 12) {
//    hour -= 12;
//    AMPM = " PM";
//  }
//  else AMPM = " AM";
  Serial.print(hour);
  Serial.print(":");
  sprintf(buffer, "%02d", minute);
  Serial.print(buffer);
//  Serial.println(AMPM);
}


void readTime() {
  Wire.beginTransmission(DS3231);
  Wire.write(byte(0));
  Wire.endTransmission();
  Wire.requestFrom(DS3231, 7);
  second = bcdToDec(Wire.read());
  minute = bcdToDec(Wire.read());
  hour = bcdToDec(Wire.read());
  weekday = bcdToDec(Wire.read());
  monthday = bcdToDec(Wire.read());
  month = bcdToDec(Wire.read());
  year = bcdToDec(Wire.read());
}
