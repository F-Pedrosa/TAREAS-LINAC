#include <ArduCAM.h>
#include <Wire.h>
#include <SPI.h>
#include "SdFat.h"
#include "memorysaver.h"
#include "LowPower.h"

#define SD_CS 10
const int SPI_CS = 8;
#define LED_ROJO 9
ArduCAM myCAM( OV2640, SPI_CS );

SdFat SD;

void myCAMSaveToSDFile(){
char str[8];
byte buf[128];
static int i = 0;
static int k = 0;
uint8_t temp = 0,temp_last=0;
uint32_t length = 0;
bool is_header = false;
File outFile;
//Flush the FIFO
myCAM.flush_fifo();
//Clear the capture done flag
myCAM.clear_fifo_flag();
//Start capture
myCAM.start_capture();
Serial.println(F("Comienza captura"));
while(!myCAM.get_bit(ARDUCHIP_TRIG , CAP_DONE_MASK));
Serial.println(F("Captura hecha."));  
length = myCAM.read_fifo_length();
if (length == 0 ) //0 kb
{
  //Serial.println(F("Size is 0."));
  return ;
}
//Construct a file name
k = k + 1;
itoa(k, str, 10);
strcat(str, ".jpg");
//Open the new file
outFile = SD.open(str, O_WRITE | O_CREAT | O_TRUNC);
//if(!outFile){
//  Serial.println(F("Error de archivo"));
//  return;
//}
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
    Serial.println(F("Imagen grabada"));
    is_header = false;
    i = 0;
  }  
  if (is_header == true)
  { 
    //Write image data to buffer if not full
    if (i < 128)
    buf[i++] = temp;
    else
    {
      //Write 128 bytes image data to file
      myCAM.CS_HIGH();
      outFile.write(buf, 128);
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

void setup(){                 // esta función es el código de INICIALIZACIÓN del arduino y los periféricos!!!!!
//uint8_t vid, pid;
//uint8_t temp;
Wire.begin();
Serial.begin(115200);
Serial.println(F("ArduCAM iniciado"));
//set the CS as an output:
pinMode(SPI_CS,OUTPUT);
// initialize SPI:
SPI.begin();

pinMode(LED_ROJO, OUTPUT);
digitalWrite(LED_ROJO, HIGH); 
delay(500);
digitalWrite(LED_ROJO, LOW);  
delay(500);
digitalWrite(LED_ROJO, HIGH); 
delay(500);
digitalWrite(LED_ROJO, LOW);  

//while(1){
//  //Check if the ArduCAM SPI bus is OK
//  myCAM.write_reg(ARDUCHIP_TEST1, 0x55);
//  temp = myCAM.read_reg(ARDUCHIP_TEST1);
//  
//  if (temp != 0x55){
//    Serial.println(F("SPI interface Error!"));
//    delay(1000);continue;
//  }else{
//    Serial.println(F("SPI interface OK."));break;
//  }
//}
//Initialize SD Card
pinMode(SD_CS,OUTPUT);
  if (!SD.begin(SD_CS)) {
      digitalWrite(LED_ROJO,HIGH);
  }

//while(!SD.begin(SD_CS)){
//  Serial.println(F("SD Card Error!"));delay(1000);
//}
//Serial.println(F("SD Card detected."));
myCAM.set_format(JPEG);     //le dice a ArduCAM que use formato JPEG
myCAM.InitCAM();
myCAM.OV2640_set_JPEG_size(OV2640_1280x1024);     // le dice que la resolución del JPEG sea de 1280x960 (el valor 1280x1024 es inexacto)
}



void loop(){
myCAMSaveToSDFile();
digitalWrite(LED_ROJO, HIGH); 
delay(200);
digitalWrite(LED_ROJO, LOW);  
delay(500);
}

