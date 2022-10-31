Attribute VB_Name = "funciones"
Option Base 0

Public Const ppp_base = &H378
Public Const ppp_status = ppp_base + 1
Public Const ppp_control = ppp_base + 2

'Función API32 usada para implementar  retardos.
Public Declare Sub Sleep Lib "kernel32.dll" (ByVal dwMilliseconds As Long)

'Lista de IDs de las eeproms
Public Const eeprom0 = 160     ' binario 10100000
Public Const eeprom1 = 162     ' binario 10100010
Public Const eeprom2 = 164     ' binario 10100100
Public Const eeprom3 = 166     ' binario 10100110
Public Const eeprom4 = 168     ' binario 10101000
Public Const eeprom5 = 170     ' binario 10101010
Public Const eeprom6 = 172     ' binario 10101100
Public Const eeprom7 = 174     ' binario 10101110


Public tamanio_eeprom(8) As Long
Public eeproms(8) As Byte
Public Function existe_eeprom(cual_eeprom As Byte) As Boolean

Dim valor_orig As Byte
Dim valor As Byte

valor_orig = leer_eeprom(cual_eeprom, 0, 0)        ' guardar valor posición 0

Call escribir_eeprom(cual_eeprom, 0, 0, 170)

'Leer de nuevo posición 0
valor = leer_eeprom(cual_eeprom, 0, 0)

If valor = 170 Then
    existe_eeprom = True
    'restaurar dato original
    Call escribir_eeprom(cual_eeprom, 0, 0, valor_orig)
Else
    existe_eeprom = False
End If

End Function

Public Function es_tamanio(posicion As Byte, tamanio As Long) As Boolean
Dim mi_var0 As Byte
Dim mi_varl1 As Byte
Dim otra_variable As Byte
Dim otra_variable_mas As Byte
Dim dir_alta As Byte
Dim dir_baja As Byte

mi_var0 = 0
mi_var1 = 0

'Leer la dirección 0 de la eeprom determinada
mi_var0 = leer_eeprom(posicion, 0, 0)       ' guardar valor posición 0

dir_alta = CByte((tamanio And 65280) / 256)
dir_baja = CByte(tamanio And 255)

'Leer la supuesta última dirección más uno
mi_var1 = leer_eeprom(posicion, dir_alta, dir_baja)

If mi_var0 = 255 Then
    otra_variable = 0
Else
    otra_variable = mi_var0 + 1
End If

If mi_var0 = mi_var1 Then
    ' Escribir valor original más 1 en la dirección 0
    Call escribir_eeprom(posicion, 0, 0, CByte(otra_variable))
    ' Leer la supuesta última dirección + 1
    otra_variable_mas = leer_eeprom(posicion, dir_alta, dir_baja)
    ' Si son iguales, se leyó la 1ra dirección (fall-back)
    If otra_variable_mas = otra_variable Then
        ' Escribir valor original en la dirección 0
        Call escribir_eeprom(posicion, 0, 0, mi_var0)
        es_tamanio = True
    Else
        Call escribir_eeprom(posicion, 0, 0, mi_var0)	
        es_tamanio = False
    End If
End If

End Function

Public Sub escribir_eeprom(cual As Byte, dir_alta As Byte, dir_baja As Byte, valor As Byte)
Call I2Cgenstart
Call I2Ctransmit(cual)
Call I2Cwaitforack
Call I2Ctransmit(dir_alta)
Call I2Cwaitforack
Call I2Ctransmit(dir_baja)
Call I2Cwaitforack
Call I2Ctransmit(valor)
Call I2Cwaitforack
Call I2Cgenstop
Sleep 5
End Sub

Public Function leer_eeprom(cual As Byte, dir_alta As Byte, dir_baja As Byte) As Byte
Call I2Cgenstart
Call I2Ctransmit(cual)
Call I2Cwaitforack
Call I2Ctransmit(dir_alta)
Call I2Cwaitforack
Call I2Ctransmit(dir_baja)
Call I2Cwaitforack
Call I2Cgenstart
Call I2Ctransmit(cual Or 1)         ' se le suma 1 para cambiar el último bit de 0 a 1 (R/W)
Call I2Cwaitforack
Call I2Creceive
Call I2Cgenstop
'Devolver valor
leer_eeprom = i2cresult%
End Function
