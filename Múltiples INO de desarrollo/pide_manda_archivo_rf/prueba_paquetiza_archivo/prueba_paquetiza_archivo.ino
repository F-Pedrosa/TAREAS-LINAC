// este firm es para probar la lectura y paquetización del archivo, mostrándolo por la terminal serie
 
#include <SPI.h>
#include <SD.h>

//const int chipSelect = 10;
#define SD_CS             10        // alias del pin conectado a CS de la SD  
#define ZUMBADOR          2

char data[32]; 
int i;               


void setup(){

// esta línea por recomendaciones leídas en la web
  pinMode(53,OUTPUT);

  // testigo de arranque
  pinMode(ZUMBADOR, OUTPUT);
  digitalWrite(ZUMBADOR,HIGH);
  delay(100);
  digitalWrite(ZUMBADOR,LOW);  

  Serial.begin(9600);
  Serial.println(F("Enviador de archivo via nRF"));

  //pin CS a la SD definido como salida
  pinMode(SD_CS,OUTPUT);
  // initializar SPI
  SPI.begin();

  //Inicializar SD
  if (!SD.begin(SD_CS)) {
    Serial.println("Card failed, or not present");
    // don't do anything more:
    return;
  }


//  // Setup and configure radio
//
//Serial.println(F("conf nRF"));
//
//  radio.begin();
//
//  radio.setPALevel(RF24_PA_LOW);                //SOLO POR LAS PRUEBAS!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//  radio.enableAckPayload();                     // Allow optional ack payloads
//  radio.enableDynamicPayloads();                // Ack payloads are dynamic payloads
//  
//  if(radioNumber){
//    radio.openWritingPipe(addresses[1]);        // Both radios listen on the same pipes by default, but opposite addresses
//    radio.openReadingPipe(1,addresses[0]);      // Open a reading pipe on address 0, pipe 1
//  }else{
//    radio.openWritingPipe(addresses[0]);
//    radio.openReadingPipe(1,addresses[1]);
//  }
//  radio.startListening();                       // Start listening  
//  
//  radio.writeAckPayload(1,&counter,1);          // Pre-load an ack-paylod into the FIFO buffer for pipe 1
//  radio.printDetails();
//
//
//Serial.println(F("terminó conf nRF"));


          // abrir archivo
          File dataFile = SD.open("TRAMAS.txt");                 
          if (dataFile) {                                        // si se pudo abrir el archivo
             while (dataFile.available()) {                      // mientras no se haya llegado al final
                for (i = 0; i < 32; i = i + 1) {
                    data[i] = dataFile.read();                   // cargar arreglo de 32 bytes a enviar
                    }
                for (i = 0; i < 32; i = i + 1) {
                   Serial.print(data[i]);                       //mostrar por pantalla
                }
          }
          dataFile.close();
          }
}



void loop() {

}
