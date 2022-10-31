VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Pedido de archivos a AMENAN"
   ClientHeight    =   12615
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5175
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   12615
   ScaleWidth      =   5175
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin VB.CommandButton Command8 
      Caption         =   "Pedir archivo respaldo"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   9
      Top             =   5520
      Width           =   4695
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Pedir mensual(es)"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   8
      Top             =   2280
      Width           =   4695
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Seleccionar Mensual(es)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   7
      Top             =   1200
      Width           =   4695
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   200
      Left            =   360
      Top             =   11760
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Pedir bitácora envíos"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   6
      Top             =   4440
      Width           =   4695
   End
   Begin VB.TextBox Text1 
      Height          =   3135
      Left            =   240
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   5
      Top             =   7680
      Width           =   4695
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Borrar SD "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   4
      Top             =   6600
      Width           =   4695
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Pedir archivo alimentación"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   3
      Top             =   3360
      Width           =   4695
   End
   Begin VB.CommandButton Command2 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   3840
      TabIndex        =   1
      Top             =   11520
      Width           =   1215
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Pedir archivo completo"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   4695
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   0
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      CommPort        =   3
      DTREnable       =   0   'False
      InputLen        =   1
      BaudRate        =   115200
   End
   Begin VB.Shape Shape1 
      BackColor       =   &H0000FF00&
      Height          =   255
      Left            =   4800
      Shape           =   3  'Circle
      Top             =   10980
      Visible         =   0   'False
      Width           =   255
   End
   Begin VB.Label Label1 
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   2
      Top             =   10920
      Visible         =   0   'False
      Width           =   4455
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private nombre_archivo As String

Private caso As Integer

Private Declare Function Beep Lib "kernel32" (ByVal dwFreq As Long, ByVal dwDuration As Long) As Long
Private Declare Function QueryDosDevice Lib "kernel32" _
    Alias "QueryDosDeviceW" ( _
    ByVal lpDeviceName As Long, _
    ByVal lpTargetPath As Long, _
    ByVal ucchMax As Long) As Long
Private Sub Command1_Click()
While MSComm1.PortOpen <> True
    MSComm1.PortOpen = True
Wend
MSComm1.Output = "a"
Sleep 50
MSComm1.Output = "a"
Sleep 50
MSComm1.Output = "a"
Sleep 50
MSComm1.Output = "a"
Sleep 50
MSComm1.Output = "a"
Sleep 50
MSComm1.Output = "a"
Sleep 50
MSComm1.Output = "a"
Sleep 50
Form1.MSComm1.Output = vbCrLf

Label1.Caption = "Pedido full.txt, aguarde..."
Label1.Visible = True
'Timer1.Enabled = True
Shape1.Visible = True

'Dim cBuffer As String
'Dim caracter As String
'Dim numero As Integer

numero = FreeFile
Open "c:\lecturas\full.txt" For Output As #numero

'Do
'  DoEvents
'  caracter = MSComm1.Input
'  'cBuffer = cBuffer & MSComm1.Input
'  'cBuffer = cBuffer & caracter
'  Print #numero, caracter
'  'Text1 = Text1 & caracter
'Loop Until (InStr(caracter, "#") Or caracter = vbNullString)
'Loop Until (caracter = "#")

'Text1 = Text1 & cBuffer



'numero = FreeFile
'Open "c:\lecturas\full.txt" For Output As #numero
'Print #numero, cBuffer
'Close #numero
'Label1.Caption = "Grabado " & "c:\lecturas\full.txt"
'
'Beep 1000, 200
'Beep 1000, 200

'Timer1.Enabled = False
'Shape1.Visible = False

End Sub

Private Sub Command2_Click()
Unload Me
End Sub
Private Sub Command3_Click()
While MSComm1.PortOpen <> True
    MSComm1.PortOpen = True
Wend
'MSComm1.Output = "i"
'Sleep 500
'MSComm1.Output = "i"
'Sleep 500
'MSComm1.Output = "i"

MSComm1.Output = "i"
Sleep 50
MSComm1.Output = "i"
Sleep 50
MSComm1.Output = "i"
Sleep 50
MSComm1.Output = "i"
Sleep 50
MSComm1.Output = "i"
Sleep 50
MSComm1.Output = "i"
Sleep 50
MSComm1.Output = "i"
Sleep 50
Form1.MSComm1.Output = vbCrLf




Label1.Caption = "Pedido alim.txt"
Label1.Visible = True
Timer1.Enabled = True
Shape1.Visible = True

Dim cBuffer As String
Dim caracter As String * 1

Do
  DoEvents
  cBuffer = cBuffer & MSComm1.Input
Loop Until InStr(cBuffer, "@")

Text1 = Text1 & cBuffer

Dim numero As Integer

numero = FreeFile
Open "c:\lecturas\alim.txt" For Output As #numero
Print #numero, cBuffer
Close #numero
Label1.Caption = "Grabado " & "c:\lecturas\alim.txt"
Beep 1000, 200
Beep 1000, 200

Timer1.Enabled = False
Shape1.Visible = False
End Sub
Private Sub Command4_Click()
Dim respuesta As Integer
respuesta = MsgBox("¿Seguro que desea borrar la SD? ", vbCritical + vbYesNo, "¡Atención!")
If respuesta = vbYes Then
Else
    Exit Sub
End If

While MSComm1.PortOpen <> True
    MSComm1.PortOpen = True
Wend
'MSComm1.Output = "z"
'Sleep 500
'MSComm1.Output = "z"
'Sleep 500
'MSComm1.Output = "z"

MSComm1.Output = "z"
Sleep 50
MSComm1.Output = "z"
Sleep 50
MSComm1.Output = "z"
Sleep 50
MSComm1.Output = "z"
Sleep 50
MSComm1.Output = "z"
Sleep 50
MSComm1.Output = "z"
Sleep 50
MSComm1.Output = "z"
Sleep 50
Form1.MSComm1.Output = vbCrLf



Label1.Caption = "Borrando SD..."

Dim cBuffer As String
Dim caracter As String * 1

Do
  DoEvents
  cBuffer = cBuffer & MSComm1.Input
Loop Until InStr(cBuffer, "%")

Label1.Caption = "SD borrada"

End Sub
Private Sub Command5_Click()
While MSComm1.PortOpen <> True
    MSComm1.PortOpen = True
Wend
'MSComm1.Output = "b"
'Sleep 500
'MSComm1.Output = "b"
'Sleep 500
'MSComm1.Output = "b"

MSComm1.Output = "b"
Sleep 50
MSComm1.Output = "b"
Sleep 50
MSComm1.Output = "b"
Sleep 50
MSComm1.Output = "b"
Sleep 50
MSComm1.Output = "b"
Sleep 50
MSComm1.Output = "b"
Sleep 50
MSComm1.Output = "b"
Sleep 50
Form1.MSComm1.Output = vbCrLf


Label1.Caption = "Pedido bita.txt"
Label1.Visible = True
Timer1.Enabled = True
Shape1.Visible = True

Dim cBuffer As String
Dim caracter As String * 1

Do
  DoEvents
  cBuffer = cBuffer & MSComm1.Input
Loop Until InStr(cBuffer, "%")

Text1 = Text1 & cBuffer

Dim numero As Integer

numero = FreeFile
Open "c:\lecturas\bita.txt" For Output As #numero
Print #numero, cBuffer
Close #numero
Label1.Caption = "Grabado " & "c:\lecturas\bita.txt"
Beep 1000, 200
Beep 1000, 200

Timer1.Enabled = False
Shape1.Visible = False
End Sub



Private Sub Command6_Click()
Form3.Show
Me.Hide
End Sub

Private Sub Command7_Click()
Dim cadena As String
Dim i As Integer
Dim nombre As String
Dim cBuffer As String
Dim caracter As String * 1
Dim numero As Integer

While Form1.MSComm1.PortOpen <> True
    Form1.MSComm1.PortOpen = True
Wend

For i = 0 To cantidad
    Form1.MSComm1.Output = "m"
    Sleep 50
    Form1.MSComm1.Output = "m"
    Sleep 50
    Form1.MSComm1.Output = "m"
    Sleep 50
    Form1.MSComm1.Output = Left(arreglo_meses(i), 1)
    Sleep 50
    Form1.MSComm1.Output = Mid(arreglo_meses(i), 2, 1)
    Sleep 50
    Form1.MSComm1.Output = Mid(arreglo_meses(i), 3, 1)
    Sleep 50
    Form1.MSComm1.Output = Mid(arreglo_meses(i), 4, 1)
    Sleep 50
    Form1.MSComm1.Output = vbCrLf
    nombre = "c:\lecturas\" & arreglo_meses(i) & ".txt"

    Label1.Caption = "Pedido " & arreglo_meses(i) & ".txt"
    Label1.Visible = True

    Timer1.Enabled = True
    Shape1.Visible = True
    
    Do
      DoEvents
      cBuffer = cBuffer & MSComm1.Input
    Loop Until InStr(cBuffer, "#")

    Text1 = Text1 & cBuffer

    numero = FreeFile

    Open nombre For Output As #numero
    Print #numero, cBuffer
    Close #numero
    Label1.Caption = "Grabado " & nombre
    Beep 1000, 200
    Beep 1000, 200

    Timer1.Enabled = False
    Shape1.Visible = False
    
    If i <> cantidad Then
        Sleep 2000
    End If

Next

End Sub

Private Sub Command8_Click()
While MSComm1.PortOpen <> True
    MSComm1.PortOpen = True
Wend
MSComm1.Output = "r"
Sleep 50
MSComm1.Output = "r"
Sleep 50
MSComm1.Output = "r"
Sleep 50
MSComm1.Output = "r"
Sleep 50
MSComm1.Output = "r"
Sleep 50
MSComm1.Output = "r"
Sleep 50
MSComm1.Output = "r"
Sleep 50
Form1.MSComm1.Output = vbCrLf

Label1.Caption = "Pedido full.txt"
Label1.Visible = True
Timer1.Enabled = True
Shape1.Visible = True

Dim cBuffer As String
Dim caracter As String * 1

Do
  DoEvents
  cBuffer = cBuffer & MSComm1.Input
Loop Until InStr(cBuffer, "#")

Text1 = Text1 & cBuffer

Dim numero As Integer

numero = FreeFile
Open "c:\lecturas\full_respaldo.txt" For Output As #numero
Print #numero, cBuffer
Close #numero
Label1.Caption = "Grabado " & "c:\lecturas\full_respaldo.txt"
Beep 1000, 200
Beep 1000, 200

Timer1.Enabled = False
Shape1.Visible = False

End Sub

Private Sub Form_Load()

' Con estos seteos funciona bien, ATENCIÓN!!!!!!!!!!!!!!!!! NO CAMBIAR!!!!!
' Sobre todo los 5 primeros, influyen críticamente sobre la transmisión
MSComm1.InBufferSize = 1024
MSComm1.OutBufferSize = 512
MSComm1.RThreshold = 1
MSComm1.SThreshold = 0
MSComm1.InputLen = 0
MSComm1.Handshaking = comNone
MSComm1.CommPort = puerto


End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Sub MSComm1_OnComm()
Static InBuff As String
'Dim posicion As Integer
'Dim caracter As String * 1
'Dim numero As Integer
Static cBuffer As String

Select Case MSComm1.CommEvent
            Case comEvReceive ' Received RThreshold # of chars.
               InBuff = MSComm1.Input
               'cBuffer = cBuffer & InBuff
               Print #numero, InBuff;
               If (InStr(InBuff, "#")) Then
                    'numero = FreeFile
                    'Open "c:\lecturas\full.txt" For Output As #numero
                    'Print #numero, cBuffer
                    Close #numero
                    Label1.Caption = "Grabado " & "c:\lecturas\full.txt"
                    Beep 1000, 200
                    Beep 1000, 200
                    Timer1.Enabled = False
                    Shape1.Visible = False
                    'Label1.Caption = "Grabado " & "c:\lecturas\full.txt"
               End If

'               posicion = InStr("1", InBuff)
'               If posicion <> 0 Then
'                    Label1.Caption = "Despertó!"
'                    Timer2.Enabled = False
'
'                    ' Pedir y guardar archivo(s)
'                    If caso = 1 Then
'                        MSComm1.Output = "a"
'                        Label1.Caption = "Recibiendo full.txt"
'                        caracter = "#"
'                        nombre_archivo = "c:\lecturas\full.txt"
'                        Timer1.Enabled = True
'                    End If
'                    If caso = 2 Then
'                        MSComm1.Output = "i"
'                        Label1.Caption = "Recibiendo alim.txt"
'                        caracter = "@"
'                        nombre_archivo = "c:\lecturas\alim.txt"
'                        Timer1.Enabled = True
'                    End If
'                    If caso = 3 Then
'                        MSComm1.Output = "b"
'                        Label1.Caption = "Recibiendo bita.txt"
'                        caracter = "%"
'                        nombre_archivo = "c:\lecturas\bita.txt"
'                        Timer1.Enabled = True
'                    End If
'                    If caso = 4 Then
'                        MSComm1.Output = "z"
'                        Label1.Caption = "Borrando SD..."
'                        caracter = "$"
'                    End If
'                    Label1.Visible = True
'                    Text1 = vbNullString
'
'                    ' leer el puerto hasta que llegue el caracter que marca fin de proceso
'                    Do
'                        DoEvents
'                        cBuffer = cBuffer & MSComm1.Input
'                    Loop Until InStr(cBuffer, caracter)
'                    Dim tamanio As Integer
'                    tamanio = Len(cBuffer) - 1
'                    cBuffer = Left(cBuffer, tamanio)
'                    'cerramos el puerto
'                    MSComm1.PortOpen = False
'                    Text1 = cBuffer
'                    Timer1.Enabled = False
'                    Shape1
'
'                    If caso = 4 Then
'                        Label1.Caption = "SD borrada"
'                        Beep 1000, 200
'                        Beep 1000, 200
'                        Beep 1000, 200
'                        Beep 1000, 200
'                        Beep 1000, 200
'                        Beep 1000, 200
'                    Else
'                        numero = FreeFile
'                        Open nombre_archivo For Output As #numero
'                        Print #numero, cBuffer
'                        Close #numero
'                        Label1.Caption = "Grabado " & nombre_archivo
'                        Beep 1000, 200
'                        Beep 1000, 200
'                    End If
'               End If
         End Select
End Sub
Private Sub Text1_DblClick()
Text1.Text = vbNullString
End Sub

Private Sub Timer1_Timer()
If Shape1.BackStyle = 1 Then
    Shape1.BackStyle = 0
Else
    Shape1.BackStyle = 1
End If
End Sub
