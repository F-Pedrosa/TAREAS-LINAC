#include <SnoozeLib.h>//Include the library


#define LED             9   
#define PULSADOR        2


void setup(){

  //pinMode(PULSADOR,INPUT);
  pinMode(LED,OUTPUT);

  pinMode(5,OUTPUT);    
  digitalWrite(5,LOW);

 
  digitalWrite(LED,HIGH);
  delay(1000);    //1 seg
  digitalWrite(LED,LOW);

}



void loop(void) {

     snoozeLib.snooze(5000);
     digitalWrite(LED,HIGH);
     delay(200);
     digitalWrite(LED,LOW);
     digitalWrite(5,LOW);
}
