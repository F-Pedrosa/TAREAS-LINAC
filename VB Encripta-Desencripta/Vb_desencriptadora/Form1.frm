VERSION 5.00
Object = "{EA4C06C4-DD2F-41A9-AEF0-9FB0C8C9BAB9}#1.1#0"; "SComm32x.ocx"
Object = "{F9043C88-F6F2-101A-A3C9-08002B2F49FB}#1.2#0"; "COMDLG32.OCX"
Begin VB.Form Form1 
   Caption         =   "Desencriptadora"
   ClientHeight    =   5670
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5415
   LinkTopic       =   "Form1"
   ScaleHeight     =   5670
   ScaleWidth      =   5415
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   500
      Left            =   480
      Top             =   4200
   End
   Begin VB.TextBox Text2 
      Height          =   375
      Left            =   960
      TabIndex        =   7
      Top             =   3600
      Visible         =   0   'False
      Width           =   2535
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Pedir archivo"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   960
      TabIndex        =   1
      Top             =   1560
      Visible         =   0   'False
      Width           =   3615
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
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   3120
      TabIndex        =   3
      Top             =   4200
      Width           =   2055
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Desencriptar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   960
      TabIndex        =   2
      Top             =   2640
      Visible         =   0   'False
      Width           =   3615
   End
   Begin VB.TextBox Text1 
      Height          =   375
      Left            =   240
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   480
      Width           =   1335
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
   Begin VB.Shape Shape1 
      FillColor       =   &H000000FF&
      FillStyle       =   0  'Solid
      Height          =   300
      Left            =   5040
      Shape           =   3  'Circle
      Top             =   5197
      Width           =   375
   End
   Begin VB.Label Label5 
      Caption         =   "Escriba la contraseña y presione [ENTER]"
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
      TabIndex        =   6
      Top             =   960
      Width           =   3855
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
      TabIndex        =   5
      Top             =   5160
      Visible         =   0   'False
      Width           =   4695
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Contraseña:"
      Height          =   195
      Left            =   240
      TabIndex        =   4
      Top             =   240
      Width           =   855
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim fechas_iniciales(10) As Date
Dim fechas_finales(10) As Date
Dim contrasenias(10) As String
Dim fecha As Date
Dim pass As String
Dim pass2 As String
Public texto As String
Public nombre_archivo As String
Private Declare Function Beep Lib "kernel32" (ByVal dwFreq As Long, ByVal dwDuration As Long) As Long


Function DirExists(DirName As String) As Boolean
    On Error GoTo ErrorHandler
    DirExists = GetAttr(DirName) And vbDirectory
ErrorHandler:
End Function




Private Sub Command1_Click()
Dim textod As String
Dim numero As Integer
Dim caracter As Byte
Dim contador As Long
Dim tamanio As Long

Command1.Enabled = False
Text2.Visible = True
Beep 1600, 400

Label2.Caption = "Procesando, aguarde, puede demorar..."
numero = FreeFile
nombre_archivo = "c:\lecturas\datos.dat"
tamanio = FileLen(nombre_archivo)
'Open nombre_archivo For Binary Access Read As #numero
'    Do While contador <= (tamanio - 2)
'            Get #numero, , caracter
'            If caracter = 231 Then
'                textod = textod & Chr(10)
'                'Text2 = Text2 & texto
'            ElseIf caracter = 232 Then
'                textod = textod & Chr(13)
'                'Text2 = Text2 & texto
'            ElseIf caracter = 7 Then
'                textod = textod & Chr(32)
'                'Text2 = Text2 & texto
'            ElseIf caracter = 4 Then
'                textod = textod & Chr(45)
'                'Text2 = Text2 & texto
'            ElseIf caracter = 3 Then
'                textod = textod & Chr(48)
'                'Text2 = Text2 & texto
'            ElseIf caracter = 13 Then
'            ElseIf caracter = 10 Then
'            Else
'                textod = textod & Chr((caracter - 103))
'                'Text2 = Text2 & texto
'            End If
'            contador = contador + 1
'    DoEvents
'    Text2 = contador & " de " & (tamanio - 2)
'    Loop
'Close #numero


Dim b() As Byte

Timer1.Enabled = True
Shape1.FillStyle = 0

Open nombre_archivo For Binary As numero
ReDim b(LOF(numero))
Get numero, , b()
Close numero
Dim i As Long
tamanio = UBound(b)
Do While contador <= (tamanio - 2)
    caracter = b(contador)
    If caracter = 231 Then
        textod = textod & Chr(10)
    ElseIf caracter = 232 Then
        textod = textod & Chr(13)
    ElseIf caracter = 7 Then
        textod = textod & Chr(32)
    ElseIf caracter = 4 Then
        textod = textod & Chr(45)
    ElseIf caracter = 3 Then
        textod = textod & Chr(48)
    ElseIf caracter = 13 Then
    ElseIf caracter = 10 Then
    Else
        textod = textod & Chr((caracter - 103))

    End If
    contador = contador + 1
    DoEvents
    Text2 = contador & " de " & (tamanio - 1)
Loop

numero = FreeFile
nombre_archivo = "c:\lecturas\Datos.txt"
Open nombre_archivo For Output As #numero
Print #numero, textod
Close #numero
Label2.Caption = "Desencripción terminada"
DoEvents
Timer1.Enabled = False
Shape1.FillStyle = 1
Shape1.Visible = False
Kill "c:\lecturas\datos.dat"
Beep 1500, 700
Beep 1, 200
Beep 1500, 700

End Sub

Private Sub Command2_Click()
'CommonDialog1.DialogTitle = "Escriba el nombre del archivo a guardar"
'CommonDialog1.ShowSave
'nombre_archivo = CommonDialog1.FileName
'
'If SComm1.PortOpen = False Then
'    SComm1.PortOpen = True
'End If
'
'cual_pedido = 2
'SComm1.Output = "b"
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

Private Sub Command5_Click()
 If SComm1.PortOpen = False Then
    SComm1.PortOpen = True
End If

SComm1.Output = "c"
Label2.Visible = True
Timer1.Enabled = True
End Sub

Private Sub Form_Load()

If DirExists("c:\lecturas") = False Then
    MkDir "C:\lecturas"
End If

Text1 = vbNullString
If SComm1.PortOpen = True Then
    SComm1.PortOpen = False
End If
Command5.Enabled = False
Command1.Enabled = False

Shape1.Visible = False

' HAY QUE ESPECIFICARLO COMO MES/DIA/AÑO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
fechas_iniciales(0) = #8/1/2019#
fechas_iniciales(1) = #10/1/2019#
fechas_iniciales(2) = #12/1/2019#
fechas_iniciales(3) = #2/1/2020#

fechas_finales(0) = #9/30/2019#
fechas_finales(1) = #11/30/2019#
fechas_finales(2) = #1/31/2020#
fechas_finales(3) = #3/30/2020#

contrasenias(0) = "12345"
contrasenias(1) = "02468"
contrasenias(2) = "13579"
contrasenias(3) = "67890"

fecha = Date

For i = 0 To 2
    If (fecha >= fechas_iniciales(i)) And (fecha <= fechas_finales(i)) Then
        pass2 = contrasenias(i)
    Else
        pass2 = "12345"
    End If
Next



End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Sub SComm1_OnComm()

Dim pos As Long
Dim numero As Integer

Select Case SComm1.CommEvent
    Case comEvReceive
        If Label2.Caption = "" Then
            Label2.Caption = "Recibiendo archivo, espere..."
        End If
        texto = texto & SComm1.Input
        pos = InStr(texto, "#")
        If pos <> 0 Then
                Label2.Caption = "Archivo recibido"
                texto = Left(texto, Len(texto) - 3)
                numero = FreeFile
                nombre_archivo = "c:\lecturas\datos.dat"
                Open nombre_archivo For Output As #numero
                Print #numero, texto
                Close #numero
                Command1.Enabled = True
                Command1.Visible = True
                Command5.Enabled = False
                Command5.Visible = False
                Timer1.Enabled = False
                Shape1.FillStyle = 1
                Shape1.Visible = False
        End If
    Case Is > 1000
        Label2.Caption = "Error en puerto COM" & SComm1.CommPort
End Select

End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    pass = Text1.Text
    Text1 = vbNullString
    If pass = pass2 Then
        Command5.Visible = True
        Command5.Default = True
        Command5.Enabled = True
        Label1.Visible = False
        Label5.Visible = False
        Text1.Enabled = False
        Text1.Visible = False
    Else
        Text1 = "Incorrecta"
    End If
End If
End Sub

Private Sub Timer1_Timer()
If Shape1.Visible = False Then
    Shape1.Visible = True
End If
If Shape1.FillStyle = 0 Then
    Shape1.FillStyle = 1
ElseIf Shape1.FillStyle = 1 Then
    Shape1.FillStyle = 0
End If
End Sub
