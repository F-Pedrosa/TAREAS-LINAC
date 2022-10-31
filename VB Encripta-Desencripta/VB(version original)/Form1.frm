VERSION 5.00
Object = "{EA4C06C4-DD2F-41A9-AEF0-9FB0C8C9BAB9}#1.1#0"; "SComm32x.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Form1 
   Caption         =   "Desencriptadora"
   ClientHeight    =   5550
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5550
   LinkTopic       =   "Form1"
   ScaleHeight     =   5550
   ScaleWidth      =   5550
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command4 
      Caption         =   "Command4"
      Height          =   615
      Left            =   120
      TabIndex        =   6
      Top             =   9000
      Width           =   1695
   End
   Begin VB.ListBox List1 
      Height          =   1425
      Left            =   120
      TabIndex        =   5
      Top             =   9720
      Width           =   5295
   End
   Begin MSComDlg.CommonDialog CommonDialog1 
      Left            =   4440
      Top             =   720
      _ExtentX        =   847
      _ExtentY        =   847
      _Version        =   393216
   End
   Begin VB.CommandButton Command3 
      Cancel          =   -1  'True
      Caption         =   "Salir"
      Height          =   1095
      Left            =   3240
      TabIndex        =   4
      Top             =   3840
      Width           =   2055
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Guardar archivo"
      Enabled         =   0   'False
      Height          =   735
      Left            =   240
      TabIndex        =   3
      Top             =   2640
      Width           =   5055
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Desencriptar"
      Enabled         =   0   'False
      Height          =   735
      Left            =   240
      TabIndex        =   2
      Top             =   1560
      Width           =   5055
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   480
      Width           =   2895
   End
   Begin SCommLib.SComm SComm1 
      Left            =   4440
      Top             =   0
      _ExtentX        =   953
      _ExtentY        =   979
      CommPort        =   3
      DTREnable       =   0   'False
      InBufferSize    =   32760
      OutBufferSize   =   32766
      RThreshold      =   1
      RTSEnable       =   0   'False
      Settings        =   "115200,N,8,1"
      CommName        =   "Silicon Labs CP210x USB to UART Bridge (COM3)"
      OverlappedIO    =   -1  'True
   End
   Begin VB.Label Label5 
      Caption         =   "La contraseña es password"
      Height          =   375
      Left            =   240
      TabIndex        =   10
      Top             =   960
      Width           =   2775
   End
   Begin VB.Label Label4 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Label4"
      Height          =   375
      Left            =   3000
      TabIndex        =   9
      Top             =   9120
      Width           =   855
   End
   Begin VB.Label Label3 
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Label3"
      Height          =   375
      Left            =   1920
      TabIndex        =   8
      Top             =   9120
      Width           =   735
   End
   Begin VB.Label Label2 
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   240
      TabIndex        =   7
      Top             =   5040
      Width           =   5055
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Ingrese Contraseña:"
      Height          =   195
      Left            =   240
      TabIndex        =   1
      Top             =   240
      Width           =   1425
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public texto As String
Public nombre_archivo As String
Public cual_pedido As Integer


Private Sub Command1_Click()
If SComm1.PortOpen = False Then
    SComm1.PortOpen = True
End If
cual_pedido = 1
SComm1.Output = "a"
Label2.Caption = "Procesando, aguarde, puede demorar..."
End Sub

Private Sub Command2_Click()
CommonDialog1.DialogTitle = "Escriba el nombre del archivo a guardar"
CommonDialog1.ShowSave
nombre_archivo = CommonDialog1.FileName

If SComm1.PortOpen = False Then
    SComm1.PortOpen = True
End If

cual_pedido = 2
SComm1.Output = "b"

End Sub

Private Sub Command3_Click()
Unload Me
End Sub

Private Sub Command4_Click()
Dim i As Long
Dim puerto As Integer
Dim nombre As String
Dim nombre2 As String
Dim existe As Long
Dim temporal As String

nombre2 = "Silicon"

       List1.Clear
       '// In this example we'll test for ports up to 32 - you can test up to 255 if you want.
       For i = 1 To 32
              SComm1.CommPort = i
              If SComm1.CommName = "" Then
                     '// This Com Port does not exist at all
                  Else
                     '// This port exists so show the DeviceName in the list
                     List1.AddItem SComm1.CommName
                     nombre = SComm1.CommName
                     existe = InStr(1, nombre, nombre2, 1)
                     If existe = 0 Then
                     Else
                        Label3.Caption = Right(SComm1.CommName, 6)
                        temporal = Right(Label3.Caption, 2)
                        temporal = Left(temporal, 1)
                        puerto = Val(temporal)
                        Label4.Caption = puerto
                        SComm1.CommPort = Val(Label4.Caption)
                        
                     End If

                     '// Also store i so that when the user selects one we'll know which port to open
                     ' List1.ItemData(List1.NewIndex) = i
              End If
       Next i
If Label4.Caption = "3" Then
    SComm1.CommPort = 3
End If
puerto = SComm1.CommPort
SComm1.Settings = "115200,n,8,1"
SComm1.PortOpen = True
End Sub

Private Sub Form_Load()
Text1 = vbNullString
If SComm1.PortOpen = True Then
    SComm1.PortOpen = False
End If
End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Sub SComm1_OnComm()

Dim pos As Long
Dim numero As Integer

Select Case SComm1.CommEvent
    Case comEvReceive
        If cual_pedido = 1 Then
            texto = texto & SComm1.Input
                pos = InStr(texto, "#")
                If pos <> 0 Then
                        Label2.Caption = "Desencriptado"
                End If

        ElseIf cual_pedido = 2 Then
            texto = texto & SComm1.Input
            pos = InStr(texto, "#")
            If pos <> 0 Then
                    Label2.Caption = "Archivo recibido"
            End If
            numero = FreeFile
            Open nombre_archivo For Output As #numero
            Print #numero, texto
            Close #numero
        End If
    Case Is > 1000
        Label2.Caption = "Error en puerto COM" & SComm1.CommPort
End Select

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    pass = Text1.Text
    Text1 = vbNullString
    If pass = "password" Then
        Command1.Enabled = True
        Command2.Enabled = True
        Label1.Visible = False
        Text1.Enabled = False
    Else
        Text1 = "Incorrecta"
    End If
End If
End Sub
