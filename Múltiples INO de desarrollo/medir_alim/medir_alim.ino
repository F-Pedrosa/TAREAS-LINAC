#define SSID "nodoA2"   // acá el nombre de la red wifi
const char CONSTANTE[3] = "A2";
#define PASS "pepepepe" // esta es la contraseña para la misma 
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define LED_ROJO          9 
#define PULSADOR          2
#define BATA1             7
#define BATA2             6


void setup() {
  analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
  Serial.begin(115200);
  pinMode(5, OUTPUT);
  pinMode(A6, INPUT);
  pinMode(A7, INPUT);
  digitalWrite(5,LOW);  
  pinMode(PULSADOR,INPUT_PULLUP );
  pinMode(LED_ROJO, OUTPUT);
  // prender 2 segs el led rojo
  digitalWrite(LED_ROJO,HIGH);
  delay(500);    
  digitalWrite(LED_ROJO,LOW);
}

void loop() {
  float valorV = 0;
  unsigned int val1 = 0;  
  val1 = analogRead(6);
  //valorV = ((val1 * 14.56)/1023);
    valorV = ((val1 * 11.8)/813);
  Serial.print(val1);
  Serial.print("  ");          
  Serial.print(valorV,2);    
  Serial.println(F(" V"));
  delay(2000);
}
