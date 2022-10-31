VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form Form1 
   Caption         =   "Transmisión de archivo via módulos WiFi ESP8266"
   ClientHeight    =   10815
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   9720
   LinkTopic       =   "Form1"
   ScaleHeight     =   10815
   ScaleWidth      =   9720
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command3 
      Caption         =   "Inicializar módulo"
      Height          =   975
      Left            =   8280
      TabIndex        =   4
      Top             =   240
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
      Caption         =   "Enviar archivo activador"
      Height          =   1095
      Left            =   8280
      TabIndex        =   1
      Top             =   1800
      Width           =   1335
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   9120
      Top             =   4080
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
      RThreshold      =   1
      BaudRate        =   115200
   End
   Begin VB.TextBox Text1 
      Height          =   10455
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   0
      Top             =   240
      Width           =   8055
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Mensajes desde el módulo:"
      Height          =   195
      Left            =   120
      TabIndex        =   3
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

' ===========================================================================================
'ATENCIÓN!!!!!!!!!!!!!!!!!!
'Los tiempos entre comandos, especialmente los que siguen al IPSEND son críticos!!!!
'Igualmente el tamaño de los strings que se envían con IPSEND, ante cualquier problema
'chequear esos valores (tiempos y tamaños)!!!!!!
' ===========================================================================================



Text1 = vbNullString        ' limpia caja de texto

' arrancar puerto de datos local
MSComm1.Output = "AT+CIPSERVER=1,1027" & vbCrLf
For i = 0 To 10000
    DoEvents
Next

' Establecer conexión TCP, a la IP dada y el puerto dado al final, que debería ser el celular
MSComm1.Output = "AT+CIPSTART=0," & Chr(34) & "TCP" & Chr(34) & "," & Chr(34) & "192.168.4.2" & Chr(34) & ",9090" & vbCrLf
For i = 0 To 1000000
    DoEvents
Next
' enviar usuario y contraseña
MSComm1.Output = "AT+CIPSEND=0,11" & vbCrLf
For i = 0 To 50000
    DoEvents
Next
MSComm1.Output = "USER user" & vbCrLf
For i = 0 To 150000
    DoEvents
Next

MSComm1.Output = "AT+CIPSEND=0,11" & vbCrLf
For i = 0 To 70000
    DoEvents
Next
MSComm1.Output = "PASS pass" & vbCrLf
For i = 0 To 100000
    DoEvents
Next

' Enviar comando PORT
MSComm1.Output = "AT+CIPSEND=0,22" & vbCrLf
For i = 0 To 50000
    DoEvents
Next
' y el port
MSComm1.Output = "PORT 192,168,4,1,4,3" & vbCrLf
For i = 0 To 100000
    DoEvents
Next

MSComm1.Output = "AT+CIPSEND=0,15" & vbCrLf
For i = 0 To 150000
    DoEvents
Next

MSComm1.Output = "STOR 0001.txt" & vbCrLf
For i = 0 To 150000
    DoEvents
Next

MSComm1.Output = "AT+CIPSEND=1,10" & vbCrLf
For i = 0 To 50000
    DoEvents
Next
' el contenido del archivo NO IMPORTA, es su sola presencia lo que activa al programa en el celular
MSComm1.Output = "abcdefghij" & vbCrLf
For i = 0 To 100000
    DoEvents
Next

MSComm1.Output = "AT+CIPCLOSE=1" & vbCrLf
For i = 0 To 10000
    DoEvents
Next

MSComm1.Output = "AT+CIPCLOSE=0" & vbCrLf
For i = 0 To 10000
    DoEvents
Next

End Sub

Private Sub Command2_Click()
Unload Me
End Sub

Private Sub Command3_Click()

MSComm1.Output = "AT+RST" & vbCrLf    ' reset
For i = 0 To 500000
    DoEvents
Next

Text1 = vbNullString

MSComm1.Output = "AT+CWMODE=3" & vbCrLf ' establecer en modo AP/nodo
For i = 0 To 10000
    DoEvents
Next

MSComm1.Output = "AT+CWDHCP=2,1" & vbCrLf ' activar servidor DHCP
For i = 0 To 10000
    DoEvents
Next

MSComm1.Output = "AT+CIPMUX=1" & vbCrLf ' conexión múltiple
For i = 0 To 10000
    DoEvents
Next

End Sub

Private Sub Form_Load()

Me.Show

Dim i As Long

MSComm1.CommPort = 1
While MSComm1.PortOpen = False
    MSComm1.PortOpen = True
Wend

Text1 = vbNullString

End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Sub MSComm1_OnComm()
If MSComm1.CommEvent = comEvReceive Then
    Text1 = Text1 & MSComm1.Input
End If
End Sub
