VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "General particularizado para plaqueta EEPROM/RTC del Chequea Cable/Carga"
   ClientHeight    =   5190
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9735
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5190
   ScaleWidth      =   9735
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command1 
      Cancel          =   -1  'True
      Caption         =   "Salir"
      Height          =   975
      Left            =   6960
      TabIndex        =   27
      Top             =   3720
      Width           =   2415
   End
   Begin VB.TextBox Text7 
      Height          =   1815
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   23
      Top             =   360
      Width           =   3735
   End
   Begin VB.Frame Frame3 
      Caption         =   "Leer/Setear RTC"
      Height          =   4815
      Left            =   3960
      TabIndex        =   2
      Top             =   240
      Width           =   2415
      Begin VB.CommandButton Command3 
         Caption         =   "Setear RTC"
         Height          =   495
         Left            =   240
         TabIndex        =   10
         Top             =   4080
         Width           =   1935
      End
      Begin VB.CommandButton Command2 
         Caption         =   "Leer RTC"
         Height          =   495
         Left            =   240
         TabIndex        =   9
         Top             =   3360
         Width           =   1935
      End
      Begin VB.TextBox Text6 
         Height          =   375
         Left            =   1080
         TabIndex        =   8
         Text            =   "Text6"
         Top             =   2760
         Width           =   1095
      End
      Begin VB.TextBox Text5 
         Height          =   375
         Left            =   1080
         TabIndex        =   7
         Text            =   "Text5"
         Top             =   2280
         Width           =   1095
      End
      Begin VB.TextBox Text4 
         Height          =   375
         Left            =   1080
         TabIndex        =   6
         Text            =   "Text4"
         Top             =   1800
         Width           =   1095
      End
      Begin VB.TextBox Text3 
         Height          =   375
         Left            =   1080
         TabIndex        =   5
         Text            =   "Text3"
         Top             =   1320
         Width           =   1095
      End
      Begin VB.TextBox Text2 
         Height          =   375
         Left            =   1080
         TabIndex        =   4
         Text            =   "Text2"
         Top             =   840
         Width           =   1095
      End
      Begin VB.TextBox Text1 
         Height          =   375
         Left            =   1080
         TabIndex        =   3
         Text            =   "Text1"
         Top             =   360
         Width           =   1095
      End
      Begin VB.Label Label1 
         Caption         =   "Año:"
         Height          =   255
         Left            =   600
         TabIndex        =   16
         Top             =   360
         Width           =   375
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "Mes:"
         Height          =   195
         Left            =   600
         TabIndex        =   15
         Top             =   870
         Width           =   345
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Día:"
         Height          =   195
         Left            =   600
         TabIndex        =   14
         Top             =   1350
         Width           =   315
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "Hora:"
         Height          =   195
         Left            =   600
         TabIndex        =   13
         Top             =   1830
         Width           =   390
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "Minutos:"
         Height          =   195
         Left            =   360
         TabIndex        =   12
         Top             =   2310
         Width           =   600
      End
      Begin VB.Label Label6 
         AutoSize        =   -1  'True
         Caption         =   "Segundos:"
         Height          =   195
         Left            =   240
         TabIndex        =   11
         Top             =   2790
         Width           =   765
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Leer EEPROM a archivo"
      Height          =   2775
      Left            =   120
      TabIndex        =   1
      Top             =   2280
      Width           =   3735
      Begin VB.CommandButton Command6 
         Caption         =   "Detener Lectura"
         Height          =   495
         Left            =   240
         TabIndex        =   26
         Top             =   2040
         Width           =   3255
      End
      Begin VB.CommandButton Command9 
         Caption         =   "Guardar contenido EEPROM en archivo."
         Height          =   615
         Left            =   240
         TabIndex        =   19
         Top             =   960
         Width           =   3255
      End
      Begin VB.Label Label15 
         AutoSize        =   -1  'True
         Caption         =   "c:\archivo_datos_fecha_hora.txt"
         Height          =   195
         Left            =   240
         TabIndex        =   25
         Top             =   600
         Width           =   2325
      End
      Begin VB.Label Label11 
         Alignment       =   2  'Center
         BorderStyle     =   1  'Fixed Single
         Caption         =   "Label11"
         Height          =   255
         Left            =   1200
         TabIndex        =   22
         Top             =   1680
         Width           =   1695
      End
      Begin VB.Label Label9 
         AutoSize        =   -1  'True
         Caption         =   "Leyendo:"
         Height          =   195
         Left            =   480
         TabIndex        =   21
         Top             =   1680
         Width           =   660
      End
      Begin VB.Label Label10 
         Caption         =   "Los datos leídos se guardan en:"
         Height          =   255
         Left            =   240
         TabIndex        =   20
         Top             =   360
         Width           =   2415
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Borrar EEPROM (escribir 255s)"
      Height          =   2655
      Left            =   6480
      TabIndex        =   0
      Top             =   240
      Width           =   3135
      Begin VB.CommandButton Command7 
         Caption         =   "Detener Borrado"
         Height          =   495
         Left            =   240
         TabIndex        =   28
         Top             =   1440
         Width           =   2655
      End
      Begin VB.CommandButton Command5 
         Caption         =   "Borrar"
         Height          =   615
         Left            =   240
         TabIndex        =   17
         Top             =   360
         Width           =   2655
      End
      Begin VB.Label Label7 
         BorderStyle     =   1  'Fixed Single
         Height          =   255
         Left            =   240
         TabIndex        =   18
         Top             =   1080
         Width           =   2655
      End
   End
   Begin VB.Label Label8 
      Caption         =   "Detección Presencia y Tamaño (0=ausente):"
      Height          =   255
      Left            =   120
      TabIndex        =   24
      Top             =   120
      Width           =   3375
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const RTC = 208             'binario 11010000

Dim LF As String

Public anio As Byte, mes As Byte, dia As Byte
Public hora As Byte, minuto As Byte, segundo As Byte
Private Sub Command1_Click()
Unload Me
End Sub

Private Sub Command2_Click()
Dim i As Integer
Dim dato As Byte, loc As Byte
Dim arreglo(8) As Byte

I2Cdevadr% = RTC

For i = 0 To 7
    
    Call I2Cgenstart
    Call I2Ctransmit(CByte(RTC))
    Call I2Cwaitforack
    Call I2Ctransmit(CByte(i))
    Call I2Cwaitforack
    Call I2Cgenstop
    '--------------------------------------------
    Call I2Cgenstart
    Call I2Ctransmit(CByte(RTC + 1))    'modo lectura, R/W en 1
    Call I2Cwaitforack
    Call I2Creceive
    
    'TODO EL BLOQUE SIGUIENTE ES UN NACK, SUPUESTAMENTE
    '--------------------------------------------------------------------------------------------------
    delay hold
    vbOut I2Cloport, 127
    delay hold
    vbOut I2CHiPort, 8
    delay hold
    'While scl = bajo
    'Wend
    delay hold
    vbOut I2CHiPort, 0
    delay hold
    '--------------------------------------------END NACK?-------------------------------------
    
    Call I2Cgenstop
    
    dato = i2cresult%
    
    'para convertir de BCD a normal
    loc = dato
    loc = loc And &HF0
    loc = loc / 16
    dato = dato And &HF
    loc = loc * 10 + dato
    dato = loc
     
    arreglo(i) = dato
Next i

Text6 = Str(arreglo(0))
Text5 = Str(arreglo(1))
Text4 = Str(arreglo(2))
Text3 = Str(arreglo(4))
Text2 = Str(arreglo(5))
Text1 = Str(arreglo(6))

End Sub

Private Sub Command3_Click()
Dim respuesta As VbMsgBoxResult
Dim msg As String
Dim dia_semana As Integer

'Para poder abortar el proceso...
msg = "¿Está seguro de querer setear el RTC?"
respuesta = MsgBox(msg, vbYesNoCancel + vbExclamation, "Verificación")
If (respuesta = vbNo Or respuesta = vbCancel) Then Exit Sub

'Cargar datos desde cajas de texto
anio = Val(Text1.Text)
mes = Val(Text2.Text)
dia = Val(Text3.Text)
hora = Val(Text4.Text)
minuto = Val(Text5.Text)
segundo = Val(Text6.Text)
'convertir fecha a día de la semana (lunes, martes, etc.)
' dia_semana = Weekday(Str$(dia) & "/" & Str$(mes) & "/" & Str$(anio))
'Codificar en BCD
anio = codificar_bcd(anio)
mes = codificar_bcd(mes)
dia = codificar_bcd(dia)
hora = codificar_bcd(hora)
minuto = codificar_bcd(minuto)
segundo = codificar_bcd(segundo)

'Escribir a RTC...
I2Cdevadr% = RTC
'Secuencia de iniciación bus I2C
Call I2Cgenstart
'Poner dirección del RTC
Call I2Ctransmit(CByte(RTC))
'Esperar ACKNOWLEDGE
Call I2Cwaitforack
'Transmitir byte dirección interna del RTC a ser escrito
Call I2Ctransmit(0)
Call I2Cwaitforack
'Enviar byte a ser grabado en la dirección enviada previamente
Call I2Ctransmit(segundo)
Call I2Cwaitforack
'Y en la siguiente...
Call I2Ctransmit(minuto)
Call I2Cwaitforack
'Y en la siguiente...
Call I2Ctransmit(hora)
Call I2Cwaitforack
'Y en la siguiente...
Call I2Ctransmit(CByte(dia_semana))
Call I2Cwaitforack
'Y en la siguiente...
Call I2Ctransmit(dia)
Call I2Cwaitforack
'Y en la siguiente...
Call I2Ctransmit(mes)
Call I2Cwaitforack
'Y en la siguiente...
Call I2Ctransmit(anio)
Call I2Cwaitforack
'Y ahora se graba un 1 en el bit 4 del registro de control para habilitar la salida que
'hará titilar un led amarillo 1 vez por segundo, lo que sirve de testigo
Call I2Ctransmit(16)
Call I2Cwaitforack
Call I2Cgenstop

End Sub

Private Sub Command5_Click()
Dim indice As Integer
Dim otro_indice As Long
Dim dir_alta As Byte
Dim dir_baja As Byte

If MsgBox("¿Está seguro?", vbExclamation + vbOKCancel, "Borrar EEPROM") = vbCancel Then Exit Sub

For indice = 0 To 0
    If (tamanio_eeprom(indice)) Then
        'escribir 255s en las eeproms
        For otro_indice = 0 To tamanio_eeprom(indice)
           If detener_borrado Then Exit Sub
           dir_alta = CByte((otro_indice And 65280) / 256)
           dir_baja = CByte(otro_indice And 255)
           Call escribir_eeprom(eeproms(indice), dir_alta, dir_baja, 255)
           DoEvents
           Label7 = "Borrando " & Str$(otro_indice) & " de " & Str$(tamanio_eeprom(indice)) & " " & " - #" & Str$(indice)
        Next otro_indice
    End If
    DoEvents
Next indice


End Sub

Private Sub Command6_Click()
detener_lectura = True
End Sub


Private Sub Command7_Click()
detener_borrado = True
End Sub


Private Sub Command9_Click()
Dim index1 As Integer, index2 As Integer, indice As Integer, otro_indice As Integer
Dim X As Integer, numero As Integer, otro_numero As Integer, respuesta As Integer, contador As Integer
Dim msg As String
Dim valor As Byte
Dim dir_alta As Byte
Dim dir_baja As Byte
Dim canal As String

Dim pos As Long
Dim arreglo(10) As Byte

'nombre del archivo que guardará los datos leídos de la eeprom de la plaquetita
Dim nombre_archivo As String


' El código que sigue está basado en las rutinas de detección presencia y tamaño eeproms hechas en JAL.
' Las funciones existe_eeprom y es_tamanio están definidas en funciones.bas

indice = 0
Text7 = "#" & Str$(indice) & " - " & Str$(tamanio_eeprom(0))

If MsgBox("¿Continuar con el proceso?", vbOKCancel + vbInformation, "Verificación") = vbCancel Then Exit Sub

numero = FreeFile

nombre_archivo = "c:\archivo_datos_" & Replace(Str$(Date), "/", "-") & "_" & Replace(Str$(Time), ":", "-") & ".txt"



'Abrir archivo
Open nombre_archivo For Output As #numero
' Si tamanio_eeprom es 0 no existe eeprom, no hacer nada en ese caso
If tamanio_eeprom(0) <> 0 Then
        Print #numero, "Contenido EEPROM";
        Print #numero,
'        Print #numero, "Índice   Fecha      Hora      Pin#  Estado";
        Print #numero,
        For otro_indice = 0 To tamanio_eeprom(indice)
            dir_alta = CByte((otro_indice And 65280) / 256)
            dir_baja = CByte(otro_indice And 255)
            valor = leer_eeprom(eeproms(indice), dir_alta, dir_baja)
            arreglo(X) = valor
            'Mostrar en label cual posición se ha leído.
            Label11 = Str$(otro_indice) & " de eeprom #" & Str$(Trim(indice))
            DoEvents
            X = X + 1
            If X = 10 Then
                X = 0
'                'El último byte puede valer entre 1 y 3
'                If arreglo(7) > 3 Then
'                    canal = "estado inválido"
'                Else
'                    canal = Str$(Trim(arreglo(7)))
'                End If
                'dar formato y escribir al archivo
                Print #numero, arreglo(0);
                Print #numero, arreglo(1);
                Print #numero, arreglo(2);
                Print #numero, arreglo(3);
                Print #numero, arreglo(4);
                Print #numero, arreglo(5);
                Print #numero, arreglo(6);
                Print #numero, arreglo(7);
                Print #numero, arreglo(8);
                Print #numero, arreglo(9);
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
    End If
    DoEvents
''Cerrar archivo general
Close #numero

End Sub

Private Sub Form_Load()

Dim indice As Integer
Dim otro_msg As String, msg As String
Dim respuesta  As VbMsgBoxResult

'Para estar seguros de la condición del hardware
msg = "Asegúrese de haber conectado el banco de eeproms al programador, sino oprima No o Cancelar."
respuesta = MsgBox(msg, vbYesNoCancel + vbExclamation, "Verificación")
If (respuesta = vbNo Or respuesta = vbCancel) Then Unload Me

' IDs del bus I2C para la eeprom
eeproms(0) = eeprom0

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

Label11 = "-"
Text1 = ""
Text2 = ""
Text3 = ""
Text4 = ""
Text5 = ""
Text6 = ""

' El código que sigue está basado en las rutinas de detección presencia y tamaño eeproms hechas en JAL.
' Las funciones existe_eeprom y es_tamanio están definidas en uno de los módulos .BAS
' Recorrer las 8 posiciones, donde se encuentre una eeprom, determinar su tamaño y asignar valor
' al arreglo que contendrá dichos valores.
For indice = 0 To 0
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
        Text7 = "#" & Str$(indice) & " - " & otro_msg & " Bytes"
    Else
        Text7 = Text7 & LF & "#" & Str$(indice) & " - " & otro_msg & " Bytes"
    End If
Next indice

End Sub

Private Sub Form_Unload(Cancel As Integer)
I2Cclose
End
End Sub

