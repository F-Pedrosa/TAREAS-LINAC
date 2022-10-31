VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Lectura EEPROMs Acelere 3 ejes"
   ClientHeight    =   4740
   ClientLeft      =   48
   ClientTop       =   336
   ClientWidth     =   3372
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4740
   ScaleWidth      =   3372
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command3 
      Caption         =   "&Detener Lectura"
      Height          =   495
      Left            =   120
      TabIndex        =   3
      Top             =   3240
      Width           =   3135
   End
   Begin VB.TextBox Text1 
      Height          =   1815
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   2
      Top             =   120
      Width           =   3135
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Leer EEPROMs y grabar en archivo"
      Height          =   495
      Left            =   120
      TabIndex        =   1
      Top             =   2280
      Width           =   3135
   End
   Begin VB.CommandButton Command1 
      Cancel          =   -1  'True
      Caption         =   "&Salir"
      Height          =   615
      Left            =   1320
      TabIndex        =   0
      Top             =   3960
      Width           =   1935
   End
   Begin VB.Label Label2 
      Caption         =   "EEPROM Detectadas:"
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   2040
      Width           =   1695
   End
   Begin VB.Label Label1 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Label1"
      Height          =   255
      Left            =   120
      TabIndex        =   4
      Top             =   2880
      Width           =   3135
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim LF As String
Dim numero_canales As Integer
Private Sub Command1_Click()
Unload Me
End Sub

Private Sub Command2_Click()
Dim index1 As Integer, index2 As Integer, indice As Integer, otro_indice As Integer
Dim X As Integer, numero As Integer, otro_numero As Integer, respuesta As Integer, contador As Integer
Dim X_final As Integer
Dim msg As String, msg_inicio As String
Dim valor As Byte
Dim dir_alta As Byte
Dim dir_baja As Byte
Dim canal As String

Dim pos As Long
Dim arreglo(16) As Byte

'El nombre del archivo único
Dim nombre_archivo_general As String

For indice = 0 To 7
    If indice = 0 Then
        Text1 = "#" & Str$(indice) & " - " & Str$(tamanio_eeprom(indice))
    Else
        Text1 = Text1 & LF & "#" & Str$(indice) & " - " & Str$(tamanio_eeprom(indice))
    End If
Next indice

If MsgBox("¿Continuar con el proceso?", vbOKCancel + vbInformation, "Verificación") = vbCancel Then Exit Sub

nombre_archivo_general = "c:\archivo_eeproms_completo_" & Replace(Str$(Date), "/", "-") & "_" & Replace(Str$(Time), ":", "-") & ".txt"

numero = FreeFile

msg_inicio = "Lectura de EEPROMS con trama de los acelerómetros."

X_final = 16

'Abrir archivo general
Open nombre_archivo_general For Output As #numero
Print #numero, msg_inicio
'Recorrer las 8 posiciones posibles de existencia de eeproms...
For indice = 0 To 7
'    ' Si tamanio_eeprom es 0 no existe esa eeprom, no hacer nada en ese caso
    If tamanio_eeprom(indice) <> 0 Then
        
        Print #numero, "Contenido EEPROM #"; indice
        ' Print #numero, "Índice     Fecha       Hora        Caso       X       Y       Z";
        Print #numero, "Índice     Fecha       Hora            X        Y        Z";
        Print #numero,
        
        For otro_indice = 0 To tamanio_eeprom(indice)
            dir_alta = CByte((otro_indice And 65280) / 256)
            dir_baja = CByte(otro_indice And 255)
            valor = leer_eeprom(eeproms(indice), dir_alta, dir_baja)
            arreglo(X) = valor
            'Mostrar en label cual posición se ha leído.
            Label1 = Str$(otro_indice) & " de eeprom #" & Str$(Trim(indice))
            DoEvents
            X = X + 1
            If X = X_final Then
                X = 0
                'dar formato y escribir al archivo
                Print #numero, Format((contador), "0000"); "  --  ";
                Print #numero, Format(arreglo(0), "00"); "/";
                Print #numero, Format(arreglo(1), "00"); "/";
                Print #numero, Format(arreglo(2), "00"); "-";
                Print #numero, Format(arreglo(3), "00"); ":";
                Print #numero, Format(arreglo(4), "00"); ":";
                Print #numero, Format(arreglo(5), "00"); ":";
                
                If arreglo(6) < 4 Then
                        Print #numero, Format(arreglo(6) * 256 + arreglo(7), "000"); "      ";
                End If
                'Arreglo(8) contiene el valor que indica si la lectura de los acelerómetros fue (x,y), (x,z), (y,z) ó (x,y,z)   ¿?¿?¿?¿?¿?¿?¿?¿?¿? PARA QUÉ SE HIZO ESO??????
               'Print #numero, Format(arreglo(8), "0"); "       ";


                ' ATENCIÓN A LA INVERSIÓN DEL ORDEN DEL ARREGLO, ES DEBIDA A LA FORMA EN QUE LA LIBRERÍA ADC DEL JAL DEVUELVE UN WORD!!!
                ' Valor x
                If arreglo(10) <> 255 Then
                        Print #numero, Format(arreglo(10) * 256 + arreglo(9), "0000"); "     ";
                End If
                ' Valor y
                If arreglo(12) <> 255 Then
                        Print #numero, Format(arreglo(12) * 256 + arreglo(11), "0000"); "     ";
                End If
                ' Valor z
                If arreglo(14) <> 255 Then
                        Print #numero, Format(arreglo(14) * 256 + arreglo(13), "0000"); "     ";
                End If
                
                Print #numero,
                
                contador = contador + 1
                
            End If
                DoEvents
                If detener_lectura = True Then
                    Print #numero, "Lectura interrumpida a petición del usuario";
                    Print #numero,
                    Close #numero
                    Exit Sub
                End If
        Next otro_indice
        'Escribir separador de grupos de datos de eeproms en el archivo general
        Print #numero, "----------------------------------------------------------------------------------------------------------------------------";
        Print #numero,
    End If
    DoEvents
Next indice
''Cerrar archivo general
Close #numero

End Sub

Private Sub Command3_Click()
detener_lectura = True
End Sub

Private Sub Form_Load()
Dim indice As Integer
Dim otro_msg As String, msg As String
Dim respuesta  As VbMsgBoxResult

'Para estar seguros de la condición del hardware
msg = "Asegúrese de haber conectado el banco de eeproms al programador, sino oprima No o Cancelar."
respuesta = MsgBox(msg, vbYesNoCancel + vbExclamation, "Verificación")
If (respuesta = vbNo Or respuesta = vbCancel) Then Unload Me


Label1 = ""

' IDs del bus I2C para las eeproms del banco
eeproms(0) = eeprom0
eeproms(1) = eeprom1
eeproms(2) = eeprom2
eeproms(3) = eeprom3
eeproms(4) = eeprom4
eeproms(5) = eeprom5
eeproms(6) = eeprom6
eeproms(7) = eeprom7

'Para que en el inicio la variable de dirección arranque apuntando a la primera
Direccion_I2C = eeproms(0)

hold = 0.001 ' No modificar este valor. Adaptar el que está en el sub DELAY (i2cvb.bas)
' Inicialización normal del driver I2C
I2Copen 0, 1  ' Abrir puerto &h378 (LPT1)
I2Cinit 10    ' Valor de timeout
ICEEdebugon
Iceebreak = False ' Desctivar el Break On Error
ICeeTraceSize = 10 ' Sólo registrar 10 eventos
DoEvents

'Retorno de carro para las cajas de texto
LF = Chr(13) & Chr(10)

' El código que sigue está basado en las rutinas de detección presencia y tamaño eeproms hechas en JAL.
' Las funciones existe_eeprom y es_tamanio están definidas en uno de los módulos .BAS
' Recorrer las 8 posiciones, donde se encuentre una eeprom, determinar su tamaño y asignar valor
' al arreglo que contendrá dichos valores.
For indice = 0 To 7
    If existe_eeprom(eeproms(indice)) Then
        If es_tamanio(eeproms(indice), 4096) Then
            tamanio_eeprom(indice) = 4095
        Else
            If es_tamanio(eeproms(indice), 8192) Then
                tamanio_eeprom(indice) = 8191
            Else
                If es_tamanio(eeproms(indice), 16384) Then
                    tamanio_eeprom(indice) = 16383
                Else
                    If es_tamanio(eeproms(indice), 32768) Then
                        tamanio_eeprom(indice) = 32767
                    Else
                        tamanio_eeprom(indice) = 65535
                    End If
                End If
            End If
        End If
    End If
Next

For indice = 0 To 7
    If tamanio_eeprom(indice) <> 0 Then
        otro_msg = Str$(tamanio_eeprom(indice) + 1)
    Else
        otro_msg = "0"
    End If
    If indice = 0 Then
        Text1 = "#" & Str$(indice) & " - " & otro_msg & " Bytes"
    Else
        Text1 = Text1 & LF & "#" & Str$(indice) & " - " & otro_msg & " Bytes"
    End If
Next indice


numero_canales = 1

End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Sub Option1_Click()
numero_canales = 1
End Sub


Private Sub Option2_Click()
numero_canales = 2
End Sub


Private Sub Option3_Click()
numero_canales = 3
End Sub


Private Sub Option4_Click()
numero_canales = 4
End Sub


Private Sub Option5_Click()
numero_canales = 5
End Sub


