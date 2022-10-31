// **** INCLUDES *****
#include "LowPower.h"

// Use pin 3 as wake up pin
const int wakeUpPin = 3;
#define LED_ROJO      9 

void wakeUp()
{
    // Just a handler for the pin interrupt.
}

void setup(){
    Serial.begin(115200);
    pinMode(LED_ROJO,OUTPUT);
    pinMode(LED_BUILTIN,OUTPUT);
    digitalWrite(LED_ROJO,HIGH);
    delay(1000);    
    digitalWrite(LED_ROJO,LOW);
    digitalWrite(LED_BUILTIN,LOW);
    // Configure wake up pin as input.
    // This will consumes few uA of current.
    pinMode(wakeUpPin, INPUT);
    digitalWrite(wakeUpPin,HIGH);
}

void loop() 
{
    // Allow wake up pin to trigger interrupt on low.
    attachInterrupt(1, wakeUp, LOW);
    
    
    // Enter power down state with ADC and BOD module disabled.
    // Wake up when wake up pin is low.
    LowPower.powerDown(SLEEP_FOREVER, ADC_OFF, BOD_OFF); 

//    LowPower.idle(SLEEP_FOREVER, ADC_OFF, TIMER5_OFF, TIMER4_OFF, TIMER3_OFF,
//          TIMER2_OFF, TIMER1_OFF, TIMER0_OFF, SPI_OFF, USART3_OFF, 
//          USART2_OFF, USART1_OFF, USART0_ON, TWI_OFF);

    
    // Disable external pin interrupt on wake up pin.
    detachInterrupt(1); 
    delay(1000);    
    
        
    // Do something here
    digitalWrite(LED_ROJO,HIGH);
    delay(100);    
    digitalWrite(LED_ROJO,LOW);
    delay(500);    
    digitalWrite(LED_ROJO,HIGH);
    delay(100);    
    digitalWrite(LED_ROJO,LOW);
}
