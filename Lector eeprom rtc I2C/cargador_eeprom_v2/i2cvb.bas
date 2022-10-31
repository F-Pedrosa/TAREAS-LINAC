Attribute VB_Name = "I2CVB"
Option Explicit
' *************************************************
'BAS Declaration file for the 32 bit DLL
'
' (c)1995-1997 Vincent Himpe All right reserved released as Public Domain for NONCOMMERCIAL usage
' *************************************************

'Declare Function vbInp& Lib "win95io.dll" Alias "inpb" (ByVal x1&)
'Declare Function inpw& Lib "win95io.dll" Alias "inpdb" (ByVal x1&)
'Declare Sub vbOut Lib "win95io.dll" (ByVal addr As Integer, ByVal dta As Integer)
'Declare Sub outw Lib "win95io.dll" (ByVal x1&, ByVal x2&)
'Declare Sub mybeep Lib "win95io.dll" Alias "beep" ()
Global radress&, wadress&, ddata&, sdata&

Public Declare Sub vbOut Lib "WIN95IO.DLL" (ByVal nPort As Integer, ByVal nData As Integer)
Public Declare Sub vbOutw Lib "WIN95IO.DLL" Alias "outw" (ByVal nPort As Integer, ByVal nData As Integer)
Public Declare Function vbInp Lib "WIN95IO.DLL" (ByVal nPort As Integer) As Integer
Public Declare Function vbInpw Lib "WIN95IO.DLL" Alias "inp)" (ByVal nPort As Integer) As Integer

' **************************************************************************
' * ICee95  I2C Bus Driver Version 1.01  For Windows 95 / Vb 4
' * (c) 1995-1997 Vincent Himpe   All Rights Reserved
' * Features  ICee DebuggCr
' * Released as PUBLIC DOMAIN. Use as you please
'
' * This driver is intended for VISUAL Basic version 4.0
' * Although it might also run on older
' **************************************************************************

Global I2Cdta(10), Iceebreak, ICeeTraceSize
Global I2Cloport, I2Cmidport, I2CHiPort, I2Csavedstatus, scl, SDA
Global i2cdebug, I2Ctimeout, I2Cdevadr%, i2cresult%, hold

Sub delay(count)

Dim a As Long
' Notice about this routine.
' this routine inserts a delay loop .
' VISUAL basic lacks the feature of a microtimer.
' There are cleaner approches to do this but this works just fine.
' the parameter of 1000 is fine on a 486 DX2-66

For a = 0 To (count * 16000)  ' adapt this value according to the speed of the CPU
Next a

End Sub

   Sub holdsystem() ' Freezes the system so you can read ICee debugger messages
       ' This is a relic from the DOS based drivers.
       ' Under Windows you are responsible for popping up the debugger.

       Call iceemessage(" Press any key to continue ... ")
       DoEvents
       DoEvents
   End Sub

   Sub I2Cclose() ' Closes the I2C driver. This resets the parallel port
       vbOut I2CHiPort, I2Csavedstatus
       vbOut I2Cloport, 127           ' set sda hi all others high (VCC for opto)
       iceemessage "ICee SYS003 :I2C Bus closed "
   End Sub

   Sub I2Cgenstart() ' transmits a start condition
       If i2cdebug = 1 Then
          Call iceemessage("ICee MSG001:  Generating START on bus ")
       End If
       '  start of transmission
       vbOut I2Cloport, 127    ' sda high
       delay hold
       vbOut I2CHiPort, 8    ' scl high
       delay hold
       vbOut I2Cloport, 255  ' sda lo
       delay hold
       vbOut I2Cloport, 255  ' sda lo
       delay hold
       vbOut I2CHiPort, 0    ' scl lo
       delay hold
   End Sub

   Sub I2Cgenstop() ' transmits a stop on the bus
       If i2cdebug = 1 Then
          Call iceemessage("ICee MSG002:  Generating STOP on bus ")
       End If
       vbOut I2Cloport, 255 ' sda lo
       delay hold
       vbOut I2Cloport, 255 ' sda lo
       delay hold
       vbOut I2CHiPort, 8   ' scl hi
       delay hold
       vbOut I2CHiPort, 8   ' scl hi
       delay hold
       vbOut I2Cloport, 127 ' sda hi
       delay hold
       'end of transmission
   End Sub

   Sub I2Cgiveack() ' Gives an ACK to a slave
       vbOut I2CHiPort, 0   ' scl low
       delay hold
       vbOut I2Cloport, 255 ' sda low
       delay hold
       vbOut I2CHiPort, 8   ' scl hi
       delay hold
       vbOut I2CHiPort, 0   ' scl low
       delay hold
       vbOut I2Cloport, 127 ' sda high
       delay hold
       If i2cdebug = 1 Then
       iceemessage "Giving ACK"
       End If

   End Sub

   Sub I2Cinit(timeout) ' aborts transmission and clears bus
   Dim i2ca As Integer
       For i2ca = 0 To 5
           vbOut I2Cloport, 255 ' set SDA low
           delay hold
           vbOut I2CHiPort, 8   ' set SCL HI
           delay hold
           vbOut I2Cloport, 127 ' bring SDA HIGH
           delay hold
           vbOut I2CHiPort, 0   ' bring SCL Low
           delay hold
       Next i2ca
       I2Ctimeout = timeout
       vbOut I2CHiPort, 8
       delay hold
       If i2cdebug = 1 Then
          iceemessage "ICee SYS001: I2C port initialised. Bus cleared and released"
       End If
   End Sub

   Sub I2Cmultiread(adr As Byte, count%) ' performs a multiread from a slave
       Dim internalloop As Integer
       adr = (adr Or 1) 'make shure adress is odd
       I2Cdevadr% = adr
       Call I2Cgenstart
       Call I2Ctransmit(adr)
       Call I2Cwaitforack
       I2Cdevadr% = 0
       For internalloop = 0 To count%
           Call I2Creceive
           If internalloop < count% Then ' prevent giving ack on last byte
              Call I2Cgiveack
           End If
           I2Cdta(internalloop) = i2cresult%
       Next internalloop
       Call I2Cgenstop
   End Sub

   Sub I2Copen(port%, dbug%) ' Always call this before any other routines !
       Select Case port%
          Case 0
               I2Cloport = &H378
               I2Cmidport = &H379
               I2CHiPort = &H37A
          Case 1
               I2Cloport = &H278
               I2Cmidport = &H279
               I2CHiPort = &H27A
          Case 2
               I2Cloport = &H3BC
               I2Cmidport = &H3BD
               I2CHiPort = &H3BE
       End Select
       I2Csavedstatus = vbInp(I2CHiPort)
       If dbug% = 1 Then
          i2cdebug = 1
          Else
          i2cdebug = 0
       End If
       If i2cdebug = 1 Then
          iceemessage "ICee SYS002: I2C bus opened on adress " + Hex$(I2Cloport) + "h"
       End If
   End Sub

   Sub I2Cpob() ' puts bits on the bus
       If SDA = 1 Then
          vbOut I2Cloport, 127
          delay hold
       Else
          vbOut I2Cloport, 255
          delay hold
       End If
       If scl = 1 Then
          vbOut I2CHiPort, 8
          delay hold
       Else
          vbOut I2CHiPort, 0
          delay hold
       End If
       If i2cdebug = 1 Then
       End If
   End Sub

   Function I2Cread(adr As Byte) ' reads a byte vbOut of a slave
       adr = (adr Or 1) ' make shure adress is odd
       I2Cdevadr% = adr
       Call I2Cgenstart
       Call I2Ctransmit(adr)
       Call I2Cwaitforack
       I2Cdevadr% = 0
       Call I2Creceive
       Call I2Cgiveack
       Call I2Cgenstop
       I2Cread = i2cresult%
   End Function

   Sub I2Creceive() ' receives a byte from a slave
   Dim i2ca As Integer
   Dim i2cb As Integer
   Dim I2Cin As Integer
       i2cresult% = 0
       vbOut I2Cloport, 127 ' release sda
       delay hold
       For i2ca% = 7 To 0 Step -1
           i2cb% = 2 ^ i2ca%
           vbOut I2CHiPort, 8
           delay hold
           I2Cin% = (vbInp(I2Cmidport) And 128)
           vbOut I2CHiPort, 0
           delay hold
           If I2Cin% = 128 Then
              i2cresult% = i2cresult% + i2cb%
            '  Print "1";
              Else
            '  Print "0";
           End If
          
       Next i2ca%
       ' Print
       If i2cdebug = 1 Then
          iceemessage "ICee MSG005:  Receiving data from slave :" + Right$("00" + Hex$(i2cresult%), 2) + "h"
       End If

   End Sub

   Sub I2Csettimeout(tme)   ' assigns a timeout value
       I2Ctimeout = tme
   End Sub

   Sub I2Ctransmit(dta As Byte)   ' transmits a byte on the bus
   Dim i2ca As Integer
   Dim i2cb As Integer
   
       If i2cdebug = 1 Then
          Call iceemessage("ICee MSG004:  Transmitting data byte on bus ")
       End If
       i2ca% = 0
       For i2ca% = 7 To 0 Step -1
           i2cb% = 2 ^ i2ca%
           If (dta And i2cb%) = i2cb% Then
              vbOut I2Cloport, 127
              delay hold
           Else
              vbOut I2Cloport, 255
              delay hold
           End If
           vbOut I2CHiPort, 8
           delay hold
           vbOut I2CHiPort, 0
           delay hold
        Next i2ca%
       vbOut I2Cloport, 127   ' release sda
       delay hold
   End Sub

   Sub I2Cwaitforack()    ' waits for slave acknowledge
   Dim acknowledge As Integer
   Dim acktimer As Integer
       
   Dim I2Cmon As Byte
       
       If i2cdebug = 1 Then
          Call iceemessage("ICee MSG003:  Waiting for ACKNOWLEDGE ")
       End If
       vbOut I2Cloport, 127    ' poner SDA en alto
       vbOut I2Cloport, 127
       delay hold
       vbOut I2CHiPort, 8    ' poner SCL en alto
       vbOut I2CHiPort, 8
       delay hold
       acknowledge = 0
       acktimer = 0
       While acknowledge = 0
             acktimer = acktimer + 1
             I2Cmon = (vbInp(I2Cmidport) And 128)
             If I2Cmon <> 128 Then
                acknowledge = 1
             End If
             If acktimer = I2Ctimeout Then
                acknowledge = 1
                If I2Cdevadr% <> 0 Then
                       If i2cdebug = 1 Then
                          Call iceemessage("ICee ERR001:  Device is not responding ")
                          
                         Else
                          Beep
                       End If
                   Else
                       If i2cdebug = 1 Then
                          Call iceemessage("ICee ERR002:  No ACK received")
                          
                       Else
                          Beep
                       End If
                End If
             End If
       Wend
       vbOut I2Cloport, 127    ' maak SDa hi
       vbOut I2Cloport, 127
       delay hold
       vbOut I2CHiPort, 0   ' maak scl LO
       vbOut I2CHiPort, 0
       delay hold
   End Sub

Sub I2Cwrite(adr As Byte, dta As Byte)     ' Escribe un byte (parámetro 2) a un dispositivo I2C (parámetro 1)
'Asegurarse que el número de la dirección termina en un bit 0, porque así lo exige el protocolo I2C
adr = (adr And 254)       '254 decimal = 11111110 binario
I2Cdevadr% = adr
Call I2Cgenstart
Call I2Ctransmit(adr)
Call I2Cwaitforack
I2Cdevadr% = 0
Call I2Ctransmit(dta)
Call I2Cwaitforack
Call I2Cgenstop
End Sub

   Function I2Cwwread(adr As Byte, sbadr As Byte)    ' reads with subadress
       adr = (adr Or 1) '  make shure adr is odd
       I2Cdevadr% = adr
       Call I2Cgenstart
       Call I2Ctransmit(adr)
       Call I2Cwaitforack
       I2Cdevadr% = 0
       Call I2Ctransmit(sbadr)
       Call I2Cwaitforack
       Call I2Cgenstart
       adr = adr + 1
       Call I2Ctransmit(adr)
       Call I2Creceive
       Call I2Cgenstop
       I2Cwwread = i2cresult%
   End Function

   Sub I2Cwwsend(adr As Byte, sbadr As Byte, dta As Byte)     ' writes with subadress
       adr = (adr And 254) '  make shure addr is even
       I2Cdevadr% = adr
       Call I2Cgenstart
        Call I2Ctransmit(adr)
       Call I2Cwaitforack
       I2Cdevadr% = 0
       Call I2Ctransmit(sbadr)
       Call I2Cwaitforack
       Call I2Ctransmit(dta)
       Call I2Cwaitforack
       Call I2Cgenstop
   End Sub

   Sub ICEEdebugoff() ' Turns off the I2C debugger
       'Call iceemessage("ICee95 V1.01 : debugger  DISABLED ")
       i2cdebug = 0
   End Sub

   Sub ICEEdebugon() ' Turns the debugger on
       'Call iceemessage("ICee Debugger ENABLED ")
       i2cdebug = 1
   End Sub

Sub iceemessage(dta$)
   ' mensaje_debug = mensaje_debug & dta$
End Sub

