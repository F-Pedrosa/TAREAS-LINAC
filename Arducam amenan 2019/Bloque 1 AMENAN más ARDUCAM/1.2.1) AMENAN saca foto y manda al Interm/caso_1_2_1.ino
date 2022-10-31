// Firmware para prueba envío listado archivos a celular
#include <ArduCAM.h>
#include <Wire.h>
#include <SPI.h>
#include "SdFat.h"
#include "memorysaver.h"
//This demo can only work on OV2640_MINI_2MP or OV5642_MINI_5MP or OV5642_MINI_5MP_BIT_ROTATION_FIXED platform.
#if !(defined OV5642_MINI_5MP || defined OV5642_MINI_5MP_BIT_ROTATION_FIXED || defined OV2640_MINI_2MP || defined OV3640_MINI_3MP)
  #error Please select the hardware platform and camera module in the ../libraries/ArduCAM/memorysaver.h file
#endif
#define SD_CS             10
#define LED_ROJO          9 
const int SPI_CS = 8;
#define PULSADOR          2
#define SSID "nodoT1"   // acá el nombre de la red wifi

SdFat SD;
File outFile;

char buffer2[13];

//const String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: text/html\r\n\r\n";  
String encabezado = "HTTP/1.1 200 OK\r\nContent-Type: image/jpeg\r\nContent-Length: ";
const String cipSend = "AT+CIPSEND=0,2048";
String cipSend2 = "AT+CIPSEND=0,";


bool listo = false;


// DEFINIR RESOLUCIÓN POR DEFAULT
#define resolucion OV2640_1280x1024
//#define resolucion OV2640_1024x768
//#define resolucion OV2640_800x600
//#define resolucion OV2640_640x480
//#define resolucion OV2640_352x288
//#define resolucion OV2640_320x240
//#define resolucion OV2640_176x144

// DEFINIR ILUMINACIÓN POR DEFAULT
#define iluminacion Office       //Oficina, iluminación artificial
//#define iluminacion Auto       //Automático, normalmente el 1er disparo sale feo
//#define iluminacion Sunny      //Exterior, soleado
//#define iluminacion Cloudy     //Exterior, nublado
//#define iluminacion Home       //???

// DEFINIR BRILLO POR DEFAULT (5 niveles)
#define brillo Brightness2
//#define brillo Brightness1
//#define brillo Brightness0
//#define brillo Brightness_1
//#define brillo Brightness_2

// DEFINIR CONTRASTE POR DEFAULT (5 niveles)
#define contraste Contrast2
//#define contraste Contrast1
//#define contraste Contrast0
//#define contraste Contrast_1
//#define contraste Contrast_2

// DEFINIR SATURACIÓN POR DEFAULT (5 niveles)
#define saturacion Saturation2
//#define saturacion Saturation1
//#define saturacion Saturation0
//#define saturacion Saturation_1
//#define saturacion Saturation_2

// instanciar objeto
ArduCAM myCAM( OV2640, SPI_CS );


// macro para simplificar escritura (y ver si de paso se achica el uso de memoria y programa)
#define cerrar {Serial.println(F("AT+CIPCLOSE=0"));}

void inicializar_wifi(void){
  // establecer seteos del módulo   
  Serial.println(F("AT+CWMODE=3"));
  delay(100);
  Serial.println(F("AT+CWDHCP=2,1"));
  delay(100);
  Serial.println(F("AT+CIPMUX=1"));
  delay(100);
  Serial.print(F("AT+CWSAP="));
  Serial.write(34);
  Serial.print(SSID);
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.write(34);    //comilla 
  Serial.print("pepepepe");
  Serial.write(34);    //comilla 
  Serial.write(44);   //coma
  Serial.println(F("5,3"));
  delay(500);
}

// ---------------------------------------------------------------------------


void setup(){
analogReference(DEFAULT);   //TIENE QUE SER LA PRIMERA INSTRUCCIÓN POR CUESTIONES INTERNAS DEL MICRO
uint8_t vid, pid;
uint8_t temp;
Wire.begin();
Serial.begin(115200);
pinMode(SPI_CS,OUTPUT);
pinMode(LED_ROJO, OUTPUT);
digitalWrite(LED_ROJO, HIGH);
delay(500);
digitalWrite(LED_ROJO, LOW);
pinMode(PULSADOR, INPUT_PULLUP);
pinMode(SD_CS,OUTPUT);

  Serial.println(F("AT+UART_CUR=57600,8,1,0,0"));
  delay(500);
  Serial.end();
  Serial.begin(57600);
  delay(500);
  inicializar_wifi();

// initialize SPI:
SPI.begin();
while(1){
  //Check if the ArduCAM SPI bus is OK
  myCAM.write_reg(ARDUCHIP_TEST1, 0x55);
  temp = myCAM.read_reg(ARDUCHIP_TEST1);
  
  if (temp != 0x55){
    Serial.println(F("Error de bus SPI!"));
    //                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               digitalWrite(LED_ROJO, HIGH);
    delay(1000);continue;
  }else{
    Serial.println(F("Interfaz SPI OK."));break;
  }
}
//Initialize SD Card
while(!SD.begin(SD_CS)){
  //Serial.println(F("Error de tarjeta SD!"));
  digitalWrite(LED_ROJO, HIGH);
  delay(1000);
  }
//Serial.println(F("Tarjeta SD detectada."));
#if defined (OV2640_MINI_2MP)
  while(1){
    //Check if the camera module type is OV2640
    myCAM.wrSensorReg8_8(0xff, 0x01);
    myCAM.rdSensorReg8_8(OV2640_CHIPID_HIGH, &vid);
    myCAM.rdSensorReg8_8(OV2640_CHIPID_LOW, &pid);
    if ((vid != 0x26 ) && (( pid != 0x41 ) || ( pid != 0x42 ))){
      Serial.println(F("Can't find OV2640 module!"));
      //digitalWrite(LED_ROJO, HIGH);
      delay(1000);continue;
    }
    else{
      Serial.println(F("OV2640 detectado."));break;
    } 
  }
#endif


// Seteos de imagen
myCAM.set_format(JPEG);
myCAM.InitCAM();
myCAM.OV2640_set_JPEG_size(resolucion);
myCAM.OV2640_set_Light_Mode(iluminacion);

myCAM.OV2640_set_Color_Saturation(saturacion);
myCAM.OV2640_set_Brightness(brillo);
myCAM.OV2640_set_Contrast(contraste);

delay(1000);



}

void myCAMSaveToSDFile(){

//  char buffer2[13];
  byte buf[256];
  static int i = 0;
  static int k = 0;
  uint8_t temp = 0,temp_last=0;
  uint32_t length = 0;
  bool is_header = false;
//  File outFile;
  //Flush the FIFO
  myCAM.flush_fifo();
  //Clear the capture done flag
  myCAM.clear_fifo_flag();
  //Start capture
  myCAM.start_capture();
  //Serial.println(F("Inicio Captura"));
  while(!myCAM.get_bit(ARDUCHIP_TRIG , CAP_DONE_MASK));
  //Serial.println(F("Captura hecha."));  
  length = myCAM.read_fifo_length();
//  //Serial.print(F("Longitud FIFO:"));
//  //Serial.println(length, DEC);

  if (length >= MAX_FIFO_SIZE) //384K
  {
    //Serial.println(F("Over size."));
    return ;
  }
  if (length == 0 ) //0 kb
  {
    //Serial.println(F("Size is 0."));
    return ;
  }

  //Construct a file name
  k = k + 1;
  
  sprintf(buffer2, "%07d", k);      // agregarle los ceros iniciales al nombre de archivo
  strcat(buffer2, ".jpg");
  outFile = SD.open(buffer2, O_WRITE | O_CREAT | O_TRUNC);
  if(!outFile){
    //Serial.println(F("File open faild"));
    return;
  }
  myCAM.CS_LOW();
  myCAM.set_fifo_burst();
  while ( length-- )
  {
    temp_last = temp;
    temp =  SPI.transfer(0x00);
    //Read JPEG data from FIFO
    if ( (temp == 0xD9) && (temp_last == 0xFF) ) //If find the end ,break while,
    {
      buf[i++] = temp;  //save the last  0XD9     
      //Write the remain bytes in the buffer
      myCAM.CS_HIGH();
      outFile.write(buf, i);    
      //Close the file
      outFile.close();
      Serial.println(F("Imagen grabada!"));
      is_header = false;
      i = 0;
    }  
    if (is_header == true)
    { 
      //Write image data to buffer if not full
      if (i < 256)
      buf[i++] = temp;
      else
      {
        //Write 256 bytes image data to file
        myCAM.CS_HIGH();
        outFile.write(buf, 256);
        i = 0;
        buf[i++] = temp;
        myCAM.CS_LOW();
        myCAM.set_fifo_burst();
      }        
    }
    else if ((temp == 0xD8) & (temp_last == 0xFF))
    {
      is_header = true;
      buf[i++] = temp_last;
      buf[i++] = temp;   
    } 
  } 
}


void recepcion_pedido_wifi(void){
  byte inByte;
  unsigned long tamanio = 0;
  unsigned int cantidad_paquetes = 0;  
  unsigned int resto = 0;
  unsigned int cuenta2 = 1; 
  unsigned int cuenta3 = 0;
 //File file;
  
  while (Serial.available() > 0) {
    inByte = Serial.read();
        if (inByte == '@'){
          while (Serial.available() > 0) {Serial.read();}
          inByte = ' ';
          digitalWrite(LED_ROJO, HIGH);
          delay(100);
          digitalWrite(LED_ROJO, LOW);
          delay(100);      
          digitalWrite(LED_ROJO, HIGH);
          delay(100);
          digitalWrite(LED_ROJO, LOW);
          delay(100);      
          digitalWrite(LED_ROJO, HIGH);
          delay(100);
          digitalWrite(LED_ROJO, LOW);
          delay(100);      
//          outFile.open("0000001.jpg", O_READ);
          outFile.open(buffer2, O_READ);    
          tamanio = outFile.size();
          Serial.println(tamanio);
          cantidad_paquetes = (tamanio - (2048 - encabezado.length())) / 2048;
          resto = tamanio - ((cantidad_paquetes+1) * 2048);                  
          encabezado = encabezado + String(tamanio) + "\r\n\r\n";
//          Serial.println(encabezado.length());
//          Serial.print(encabezado);
//          delay(1000);          
          
          // 1er paquete del archivo, difiere de los otros paquetes en q al principio lleva el encabezado.
          Serial.println(cipSend);
          delay(1000);
          Serial.print(encabezado);
          //for (int i=0; i <= 2002; i++){
          for (int i=0; i <= (2047 - encabezado.length()); i++){                
                Serial.write(outFile.read());
          }   
          Serial.println("");     // necesaria línea extra, motivo desconocido        
          delay(500);
          // arranca los otros paquetes
          Serial.println(cipSend);
          delay(500);          
          while (outFile.available()) {                      // mientras no se haya llegado al final
             Serial.write(outFile.read());
             if (cuenta3 == 2047){
                 cuenta3 = 0;
                 Serial.println("");
                 delay(500);          
                 if (cuenta2 != cantidad_paquetes){
                    Serial.println(cipSend);
                    delay(600);          
                    cuenta2 = cuenta2 + 1;
                 }else{
                    cuenta2 = 1;
                    Serial.print(F("AT+CIPSEND=0,"));
                    resto = resto + encabezado.length();
                    Serial.println(resto);                                 
                    delay(600);          
                }
             }else{
                    cuenta3 = cuenta3 + 1;            
                  }       
          }                  
          outFile.close();
          Serial.println("");
          delay(500);          
          cerrar;
          delay(1000);
          while (true){};
                
        }
    }
}


void loop(){
  
  if (digitalRead(PULSADOR)==LOW){
      digitalWrite(LED_ROJO, HIGH);
      delay(100);
      digitalWrite(LED_ROJO, LOW);
      delay(100);      
      myCAMSaveToSDFile();      
      delay(3000);    
      // iniciar comunicación UDP con el celular
      Serial.print(F("AT+CIPSTART=4,"));
      Serial.write(34);    //comilla 
      Serial.print(F("UDP"));
      Serial.write(34);    //comilla       
      Serial.print(F(","));    //coma   
      Serial.write(34);    //comilla       
      Serial.print(F("192.168.4.2"));
      Serial.write(34);    //comilla       
      Serial.print(F(","));    //coma   
      Serial.print(F("8080"));
      Serial.print(F(","));    //coma   
      Serial.print(F("1112"));    
      Serial.print(F(","));    //coma   
      Serial.println(F("2"));    
      delay(1000);  
      // enviar un string corto para que el servidor UDP en el celular sepa que debe iniciar el proceso
      Serial.println(F("AT+CIPSEND=4,5"));
      delay(500);        
      Serial.print(F("LISTO"));
      delay(1000);  
      // terminar comunicación
      Serial.println(F("AT+CIPCLOSE=4")); 
      delay(500);

      Serial.println(F("AT+CIPSERVER=1,80")); // iniciar servidor en puerto 80 (HTTP)
      delay(250);
      listo = true;
  }  

    if (listo == true){
      if (Serial.available() > 0) {
          recepcion_pedido_wifi();
          while (Serial.available() > 0) {Serial.read();delay(100);}    
      }      
    }

}
