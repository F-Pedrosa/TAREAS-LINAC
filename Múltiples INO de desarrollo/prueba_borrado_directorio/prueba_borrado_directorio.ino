

#include <SdFat.h>
SdFat sd;

void setup() {
  Serial.begin(115200);
  Serial.println("Oprima cualquier tecla");
  while (Serial.read() <= 0) {}
  if (!sd.begin()) sd.initErrorHalt();
  // list all files
  //sd.chdir("mensual");
  //sd.ls(LS_R);
  // sd.vwd() is root, working directory for volume
  // remove all files and directories in root
  //sd.vwd()->rmRfStar();
  //Serial.println("---------- rmRfStar()");
  Serial.println("En raiz:");
  sd.chdir('/');
  sd.ls(LS_R);
  Serial.println("En mensual:");
  sd.chdir("mensual");
  sd.ls(LS_R);
  Serial.println("---------- rmRfStar()");
  sd.vwd()->rmRfStar();
  sd.ls(LS_R);
  Serial.println("Listo");
  }
void loop() {}
