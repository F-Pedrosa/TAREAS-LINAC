// Firm para medir consumo MEGA2560
#define LED             9
//#include <Sleep_n0m1.h>
#include "LowPower.h"


void setup() {
    pinMode(LED,OUTPUT);
    pinMode(LED_BUILTIN,OUTPUT);
    digitalWrite(LED_BUILTIN,LOW);
    digitalWrite(LED,HIGH);
    delay(200);    
    digitalWrite(LED,LOW);

}

void loop() {

   digitalWrite(LED,HIGH);
   delay(1500);    
   digitalWrite(LED,LOW);
   delay(1500);
   digitalWrite(LED,HIGH);
   delay(1500);    
   digitalWrite(LED,LOW);
  LowPower.powerDown(SLEEP_8S, ADC_OFF, BOD_OFF);
}
