Attribute VB_Name = "test4"
Option Explicit

Global Const PORCENT = 100 / 255

Global Const ic1_base = &H300    'dirección base 1er 8255
Global Const ic2_base = &H304    'dirección base 2do 8255
Global Const ic3_base = &H308    'dirección base 3er 8255
Global Const ic4_base = &H30C    'dirección base 4to 8255
'nota: las direcciones base están seteadas EN la tarjeta mediante los jumpers

'Inp and Out declarations for direct port I/O in 32-bit Visual Basic.
Public Declare Function Inp Lib "inpout32.dll" _
Alias "Inp32" (ByVal PortAddress As Integer) As Integer
Public Declare Sub Out Lib "inpout32.dll" _
Alias "Out32" (ByVal PortAddress As Integer, ByVal Value As Integer)

'función API32 usada para implementar procedimiento Delay
Public Declare Function GetTickCount Lib "kernel32" () As Long

Sub Delay(retardo As Long)
Dim tempo As Long

tempo = GetTickCount() + retardo
Do
Loop Until (GetTickCount() >= tempo)

End Sub

