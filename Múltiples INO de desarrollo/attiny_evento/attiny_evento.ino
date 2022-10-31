#include <avr/sleep.h>
#include <avr/interrupt.h>

const int entrada                     = 3;
const int salida1                     = 2;

void setup() {

    pinMode(entrada, INPUT);
    digitalWrite(entrada, HIGH);
    pinMode(salida1, OUTPUT);

    // Flash quick sequence so we know setup has started
    for (int k = 0; k < 10; k = k + 1) {
        if (k % 2 == 0) {
            digitalWrite(salida1, HIGH);
            }
        else {
            digitalWrite(salida1, LOW);
            }
        delay(250);
        }
}


void sleep() {

    GIMSK |= _BV(PCIE);                     // Enable Pin Change Interrupts
    PCMSK |= _BV(PCINT3);                   // Use PB3 as interrupt pin
    ADCSRA &= ~_BV(ADEN);                   // ADC off
    set_sleep_mode(SLEEP_MODE_PWR_DOWN);    // replaces above statement

    sleep_enable();                         // Sets the Sleep Enable bit in the MCUCR Register (SE BIT)
    sei();                                  // Enable interrupts
    sleep_cpu();                            // sleep

    cli();                                  // Disable interrupts
    PCMSK &= ~_BV(PCINT3);                  // Turn off PB3 as interrupt pin
    sleep_disable();                        // Clear SE bit
    ADCSRA |= _BV(ADEN);                    // ADC on

    sei();                                  // Enable interrupts
    } // sleep

ISR(PCINT0_vect) {
    // This is called when the interrupt occurs, but I don't need to do anything in it
    }

void loop() {
    sleep();
    digitalWrite(statusLED, HIGH);
    delay(1000);
    digitalWrite(statusLED, LOW);
    }
