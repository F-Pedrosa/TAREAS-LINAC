VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Pedido de archivos a AMENAN"
   ClientHeight    =   9480
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5175
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   9480
   ScaleWidth      =   5175
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin VB.Timer Timer2 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   2040
      Top             =   8640
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   200
      Left            =   360
      Top             =   8640
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
      Height          =   735
      Left            =   240
      TabIndex        =   6
      Top             =   2280
      Width           =   4695
   End
   Begin VB.TextBox Text1 
      Height          =   3375
      Left            =   240
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   5
      Top             =   4320
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
      Height          =   735
      Left            =   240
      TabIndex        =   4
      Top             =   3360
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
      Top             =   1200
      Width           =   4695
   End
   Begin VB.CommandButton Command2 
      Cancel          =   -1  'True
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
      Top             =   8400
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
      Top             =   7860
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
      Top             =   7800
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
If MSComm1.PortOpen = True Then
    Command1.Enabled = False
Else
    Command1.Enabled = True
End If

caso = 1

Timer2.Enabled = True

End Sub

Private Sub Command2_Click()
Unload Me
End Sub
Private Sub Command3_Click()
While MSComm1.PortOpen <> True
    MSComm1.PortOpen = True
Wend
If MSComm1.PortOpen = True Then
    Command3.Enabled = False
Else
    Command3.Enabled = True
End If

caso = 2

Timer2.Enabled = True

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
If MSComm1.PortOpen = True Then
    Command4.Enabled = False
Else
    Command4.Enabled = True
End If

caso = 4

Timer2.Enabled = True

End Sub
Private Sub Command5_Click()
While MSComm1.PortOpen <> True
    MSComm1.PortOpen = True
Wend
If MSComm1.PortOpen = True Then
    Command5.Enabled = False
Else
    Command5.Enabled = True
End If

caso = 3

Timer2.Enabled = True

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
Dim InBuff As String
Dim posicion As Integer
Dim caracter As String * 1
Dim numero As Integer
Dim cBuffer As String
                    
Select Case MSComm1.CommEvent
            Case comEvReceive ' Received RThreshold # of chars.
               InBuff = MSComm1.Input
               Text1 = InBuff
               posicion = InStr("1", InBuff)
               If posicion <> 0 Then
                    Label1.Caption = "Despertó!"
                    Timer2.Enabled = False
                    
                    ' Pedir y guardar archivo(s)
                    If caso = 1 Then
                        MSComm1.Output = "a"
                        Label1.Caption = "Recibiendo full.txt"
                        caracter = "#"
                        nombre_archivo = "c:\lecturas\full.txt"
                        Timer1.Enabled = True
                    End If
                    If caso = 2 Then
                        MSComm1.Output = "i"
                        Label1.Caption = "Recibiendo alim.txt"
                        caracter = "@"
                        nombre_archivo = "c:\lecturas\alim.txt"
                        Timer1.Enabled = True
                    End If
                    If caso = 3 Then
                        MSComm1.Output = "b"
                        Label1.Caption = "Recibiendo bita.txt"
                        caracter = "%"
                        nombre_archivo = "c:\lecturas\bita.txt"
                        Timer1.Enabled = True
                    End If
                    If caso = 4 Then
                        MSComm1.Output = "z"
                        Label1.Caption = "Borrando SD..."
                        caracter = "$"
                    End If
                    Label1.Visible = True
                    Text1 = vbNullString
                                        
                    ' leer el puerto hasta que llegue el caracter que marca fin de proceso
                    Do
                        DoEvents
                        cBuffer = cBuffer & MSComm1.Input
                    Loop Until InStr(cBuffer, caracter)
                    Dim tamanio As Integer
                    tamanio = Len(cBuffer) - 1
                    cBuffer = Left(cBuffer, tamanio)
                    'cerramos el puerto
                    MSComm1.PortOpen = False
                    Text1 = cBuffer
                    Timer1.Enabled = False
                    Shape1

                    If caso = 4 Then
                        Label1.Caption = "SD borrada"
                        Beep 1000, 200
                        Beep 1000, 200
                        Beep 1000, 200
                        Beep 1000, 200
                        Beep 1000, 200
                        Beep 1000, 200
                    Else
                        numero = FreeFile
                        Open nombre_archivo For Output As #numero
                        Print #numero, cBuffer
                        Close #numero
                        Label1.Caption = "Grabado " & nombre_archivo
                        Beep 1000, 200
                        Beep 1000, 200
                    End If
               End If
         End Select
End Sub

Private Sub Timer1_Timer()
If Shape1.BackStyle = 1 Then
    Shape1.BackStyle = 0
Else
    Shape1.BackStyle = 1
End If
End Sub

Private Sub Timer2_Timer()
    Label1.Caption = "Espere, pedido enviado"
    Label1.Visible = True
    MSComm1.Output = "1"
End Sub
