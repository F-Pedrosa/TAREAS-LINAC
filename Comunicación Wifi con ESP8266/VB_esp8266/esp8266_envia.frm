VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Form1 
   Caption         =   "Transmisión de archivo via módulos WiFi ESP8266"
   ClientHeight    =   5580
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9720
   LinkTopic       =   "Form1"
   ScaleHeight     =   5580
   ScaleWidth      =   9720
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command4 
      Caption         =   "paso 2"
      Height          =   495
      Left            =   8280
      TabIndex        =   4
      Top             =   3000
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.CommandButton Command3 
      Caption         =   "paso 1"
      Height          =   495
      Left            =   8280
      TabIndex        =   3
      Top             =   3600
      Visible         =   0   'False
      Width           =   1335
   End
   Begin VB.CommandButton Command2 
      Cancel          =   -1  'True
      Caption         =   "Salir"
      Height          =   495
      Left            =   8280
      TabIndex        =   2
      Top             =   4920
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Elegir archivo y enviar"
      Height          =   1095
      Left            =   8280
      TabIndex        =   1
      Top             =   240
      Width           =   1335
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   8280
      Top             =   4680
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   9120
      Top             =   4560
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
      RThreshold      =   1
      BaudRate        =   115200
   End
   Begin VB.TextBox Text1 
      Height          =   5175
      Left            =   120
      MultiLine       =   -1  'True
      TabIndex        =   0
      Text            =   "esp8266_envia.frx":0000
      Top             =   240
      Width           =   8055
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Mensajes desde el módulo:"
      Height          =   195
      Left            =   120
      TabIndex        =   5
      Top             =   0
      Width           =   1920
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Private Sub Command1_Click()

Dim tamanio As Long
Dim byte_leido As Byte
Dim BytesRestantes As Long
Dim filenumber As Long
Dim filename As String

Dim i As Long

' elegir archivo
CommonDialog1.Filter = "Apps (*.txt)|*.txt|All files (*.*)|*.*"
CommonDialog1.DefaultExt = "txt"
CommonDialog1.DialogTitle = "Select File"
CommonDialog1.ShowOpen
' decirle al módulo que se van a mandar datos del tamaño del archivo
tamanio = FileLen(CommonDialog1.filename)
filename = CommonDialog1.filename


MSComm1.Output = "AT+CWQAP" & vbCrLf    ' desconectarse de cualquier AP
For i = 0 To 20000
    DoEvents
Next
MSComm1.Output = "AT+CWMODE=1" & vbCrLf ' establecer en modo nodo, no AP
For i = 0 To 10000
    DoEvents
Next
MSComm1.Output = "AT+CIPMUX=1" & vbCrLf ' conexión múltiple
For i = 0 To 10000
    DoEvents
Next
' Conectarse al AP provisto por el otro módulo.
MSComm1.Output = "AT+CWJAP=" & Chr(34) & "AI-THINKER_F469E4" & Chr(34) & "," & Chr(34) & Chr(34) & vbCrLf
For i = 0 To 2500000
    DoEvents
Next
' Establecer conexión TCP, a la IP dada y el puerto dado al final
MSComm1.Output = "AT+CIPSTART=4," & Chr(34) & "TCP" & Chr(34) & "," & Chr(34) & "192.168.4.1" & Chr(34) & ",333" & vbCrLf
For i = 0 To 300000
    DoEvents
Next
' Indicar que se van a transmitir datos (y su tamaño)
MSComm1.Output = "AT+CIPSEND=4," & Trim(Str(tamanio)) & vbCrLf

filenumber = FreeFile
Open filename For Binary Access Read As filenumber
BytesRestantes = LOF(filenumber)
Do While BytesRestantes > 0
    Get filenumber, , byte_leido
    MSComm1.Output = Chr(byte_leido)        ' estamos mandando como texto
    BytesRestantes = BytesRestantes - 1
Loop
Close filenumber

' Por algún motivo aún no aclarado si no se mandan estos bytes extras al final el proceso no termina...
For i = 0 To 5
MSComm1.Output = " "
Next

End Sub

Private Sub Command2_Click()
Unload Me
End Sub

Private Sub Command3_Click()
'Me.MousePointer = vbHourglass

' Seteos iniciales del módulo
MSComm1.Output = "ATE0" & vbCrLf        ' sin eco
For i = 0 To 10000
    DoEvents
Next
MSComm1.Output = "AT+CWQAP" & vbCrLf    ' desconectarse de cualquier AP
For i = 0 To 10000
    DoEvents
Next
MSComm1.Output = "AT+CWMODE=1" & vbCrLf ' modo nodo, no AP
For i = 0 To 10000
    DoEvents
Next
MSComm1.Output = "AT+CWJAP=" & Chr(34)
MSComm1.Output = "AI-THINKER_F469E4" & Chr(34) & "," & Chr(34) & Chr(34) & vbCrLf
For i = 0 To 100000
    DoEvents
Next



'' Sleep (4000)
'MSComm1.Output = "AT+CIPMUX=1" & vbCrLf ' conexión simple
'For i = 0 To 10000
'    DoEvents
'Next
'' establecer conexión TCP, a la IP dada y el puerto dado al final
'MSComm1.Output = "AT+CIPSTART=4," & Chr(34) & "TCP" & Chr(34) & "," & Chr(34) & "192.168.4.1" & Chr(34) & ",333" & vbCrLf
'For i = 0 To 100000
'    DoEvents
'Next
'For i = 0 To 100000
'    DoEvents
'Next
''Sleep (4000)
'
'Me.MousePointer = vbDefault         ' volver al default
End Sub

Private Sub Command4_Click()
Dim i As Long
MSComm1.Output = "AT+CIPMUX=1" & vbCrLf ' conexión simple
For i = 0 To 10000
    DoEvents
Next
' establecer conexión TCP, a la IP dada y el puerto dado al final
MSComm1.Output = "AT+CIPSTART=4," & Chr(34) & "TCP" & Chr(34) & "," & Chr(34) & "192.168.4.1" & Chr(34) & ",333" & vbCrLf
For i = 0 To 100000
    DoEvents
Next
For i = 0 To 100000
    DoEvents
Next
End Sub

Private Sub Form_Load()

Dim i As Long

Text1 = vbNullString

MSComm1.CommPort = 2
While MSComm1.PortOpen = False
    MSComm1.PortOpen = True
Wend

Me.Show



End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Sub MSComm1_OnComm()
If MSComm1.CommEvent = comEvReceive Then
    Text1 = Text1 & MSComm1.Input
End If
End Sub
