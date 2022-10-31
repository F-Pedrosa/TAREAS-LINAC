// ArduCAM demo (C)2017 Lee
// Web: http://www.ArduCAM.com
// This program is a demo of how to use most of the functions
// of the library with a supported camera modules, and can run on any Arduino platform.
//
// This demo was made for Omnivision 2MP/5MP sensor.
// It will run the ArduCAM 2MP/5MP as a real 2MP/5MP digital camera, provide both JPEG capture.
// The demo sketch will do the following tasks:
// 1. Set the sensor to JPEG mode.
// 2. Capture and buffer the image to FIFO every 5 seconds 
// 3. Store the image to Micro SD/TF card with JPEG format in sequential.
// 4. Resolution can be changed by myCAM.set_JPEG_size() function.
// This program requires the ArduCAM V4.0.0 (or later) library and ArduCAM 2MP/5MP shield
// and use Arduino IDE 1.6.8 compiler or above
#include <ArduCAM.h>
#include <Wire.h>
#include <SPI.h>
#include <SD.h>
#include "memorysaver.h"
//This demo can only work on OV2640_MINI_2MP or OV5642_MINI_5MP or OV5642_MINI_5MP_BIT_ROTATION_FIXED platform.
#if !(defined OV5642_MINI_5MP || defined OV5642_MINI_5MP_BIT_ROTATION_FIXED || defined OV2640_MINI_2MP || defined OV3640_MINI_3MP)
  #error Please select the hardware platform and camera module in the ../libraries/ArduCAM/memorysaver.h file
#endif

#define SD_CS             10
#define LED_ROJO          9 
const int SPI_CS = 8;
#define PULSADOR          2

ArduCAM myCAM( OV2640, SPI_CS );

void myCAMSaveToSDFile(){
char str[8];
byte buf[256];
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
Serial.println(F("start Capture"));
while(!myCAM.get_bit(ARDUCHIP_TRIG , CAP_DONE_MASK));
Serial.println(F("Capture Done."));  
length = myCAM.read_fifo_length();
Serial.print(F("The fifo length is :"));
Serial.println(length, DEC);
if (length >= MAX_FIFO_SIZE) //384K
{
  Serial.println(F("Over size."));
  return ;
}
if (length == 0 ) //0 kb
{
  Serial.println(F("Size is 0."));
  return ;
}
//Construct a file name
k = k + 1;
itoa(k, str, 10);
strcat(str, ".jpg");
//Open the new file
outFile = SD.open(str, O_WRITE | O_CREAT | O_TRUNC);
if(!outFile){
  Serial.println(F("File open faild"));
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
    Serial.println(F("Image save OK."));
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

void setup(){                 // esta función es el código de INICIALIZACIÓN del arduino y los periféricos!!!!!
uint8_t vid, pid;
uint8_t temp;
Wire.begin();
Serial.begin(115200);
Serial.println(F("ArduCAM Start!"));
//set the CS as an output:
pinMode(SPI_CS,OUTPUT);
// initialize SPI:
SPI.begin();

pinMode(LED_ROJO, OUTPUT);
digitalWrite(LED_ROJO, HIGH);
delay(500);
digitalWrite(LED_ROJO, LOW);

 pinMode(PULSADOR, INPUT_PULLUP);

while(1){
  //Check if the ArduCAM SPI bus is OK
  myCAM.write_reg(ARDUCHIP_TEST1, 0x55);
  temp = myCAM.read_reg(ARDUCHIP_TEST1);
  
  if (temp != 0x55){
    Serial.println(F("SPI interface Error!"));
    delay(1000);continue;
  }else{
    Serial.println(F("SPI interface OK."));break;
  }
}
//Initialize SD Card
while(!SD.begin(SD_CS)){
  Serial.println(F("SD Card Error!"));delay(1000);
}
Serial.println(F("SD Card detected."));

#if defined (OV2640_MINI_2MP)     // esta definición está hecha en un archivo EXTERNO
  while(1){
    //Check if the camera module type is OV2640
    myCAM.wrSensorReg8_8(0xff, 0x01);
    myCAM.rdSensorReg8_8(OV2640_CHIPID_HIGH, &vid);
    myCAM.rdSensorReg8_8(OV2640_CHIPID_LOW, &pid);
    if ((vid != 0x26 ) && (( pid != 0x41 ) || ( pid != 0x42 ))){
      Serial.println(F("Can't find OV2640 module!"));
      delay(1000);continue;
    }
    else{
      Serial.println(F("OV2640 detected."));break;
    } 
  } 
#endif

myCAM.set_format(JPEG);     //le dice a ArduCAM que use formato JPEG
myCAM.InitCAM();
//myCAM.OV2640_set_JPEG_size(OV2640_160x120);     
//myCAM.OV2640_set_JPEG_size(OV2640_176x144);     
//myCAM.OV2640_set_JPEG_size(OV2640_320x240);     
//myCAM.OV2640_set_JPEG_size(OV2640_352x288);     
//myCAM.OV2640_set_JPEG_size(OV2640_640x480);     
//myCAM.OV2640_set_JPEG_size(OV2640_800x600);     
//myCAM.OV2640_set_JPEG_size(OV2640_1024x768);     
myCAM.OV2640_set_JPEG_size(OV2640_1280x1024);     // el real es 1280x960, no se sabe porqué

myCAM.OV2640_set_Light_Mode(Office);

}


void loop(){
  if (digitalRead(PULSADOR)==LOW){
      digitalWrite(LED_ROJO, HIGH);
      delay(200);
      digitalWrite(LED_ROJO, LOW);
//      delay(2000);
      myCAMSaveToSDFile();    
  }


//  myCAMSaveToSDFile();
//  delay(5000);
//  myCAMSaveToSDFile();
//  delay(5000);  
//  myCAM.OV2640_set_JPEG_size(OV2640_176x144);     
//  myCAMSaveToSDFile();
//  delay(5000);
//  myCAMSaveToSDFile();
//  delay(5000);  
//  myCAM.OV2640_set_JPEG_size(OV2640_320x240);     
//  myCAMSaveToSDFile();
//  delay(5000);
//  myCAMSaveToSDFile();
//  delay(5000);  
//  myCAM.OV2640_set_JPEG_size(OV2640_352x288);     
//  myCAMSaveToSDFile();
//  delay(5000);
//  myCAMSaveToSDFile();
//  delay(5000);  
////  myCAM.OV2640_set_JPEG_size(OV2640_640x480);         
////  myCAMSaveToSDFile();
////  delay(5000);
////  myCAMSaveToSDFile();
////  delay(5000);  
////  myCAMSaveToSDFile();
////  delay(5000);  
////  myCAM.OV2640_set_JPEG_size(OV2640_800x600);     
////  myCAMSaveToSDFile();
////  delay(5000);
////  myCAMSaveToSDFile();
////  delay(5000);
////  myCAMSaveToSDFile();
////  delay(5000);      
////  myCAM.OV2640_set_JPEG_size(OV2640_1024x768);     
////  myCAMSaveToSDFile();
////  delay(5000);
////  myCAMSaveToSDFile();
////  delay(5000);
////  myCAMSaveToSDFile();
////  delay(5000);      
////  myCAM.OV2640_set_JPEG_size(OV2640_1280x1024);     // el real es 1280x960, no se sabe porqué
////  myCAMSaveToSDFile();
////  delay(5000);
////  myCAMSaveToSDFile();
////  delay(5000);
////  myCAMSaveToSDFile();
////  delay(5000);      
////  Serial.println(F("Terminado."));
//digitalWrite(LED_ROJO, HIGH);  
//  while (true){
//    
//  }
  
}

