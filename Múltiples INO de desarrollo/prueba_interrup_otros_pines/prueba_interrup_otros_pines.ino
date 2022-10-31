/*
 * Firm de prueba para interrupciones en todas las borneras verdes (puede extenderse).
 */
#include <YetAnotherPcInt.h>
#define ARRAY_SIZE(X) (sizeof(X)/sizeof(*X))

struct Pin {
  int number;
  const char* name;
};

// Lista de pins que se controlarán
Pin monitored_pins[] = {
  {2,  "D2"},
  {3,  "D3"},
  {4,  "D4"},
};

//función que es "llamada" (callback) cuando cambia el estado de alguno de los pines antes definidos
void pinChanged(Pin* pin, bool pinstate) {
  Serial.print("Pin ");
  Serial.print(pin->name);
  Serial.print(" (");
  Serial.print(pin->number);
  Serial.print(") cambió a ");
  Serial.println(pinstate ? "HIGH" : "LOW");
}

// --------------------------------------------------------------------------------

void setup() {
  Serial.begin(115200);
  
  //Setear pin x pin para que sean entradas con pull-up y que reporten cambios de estado.
  for (int i=0; i<ARRAY_SIZE(monitored_pins); i++) {
    pinMode(monitored_pins[i].number, INPUT_PULLUP);
    PcInt::attachInterrupt(monitored_pins[i].number, pinChanged, &monitored_pins[i], FALLING);
  }
  Serial.println(F("Listo"));
}







void loop() {
  delay(5000);
  Serial.println(millis()/1000);
  
}
