VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Desencriptador VB"
   ClientHeight    =   5940
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5415
   LinkTopic       =   "Form1"
   ScaleHeight     =   5940
   ScaleWidth      =   5415
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text2 
      Height          =   375
      Left            =   240
      TabIndex        =   6
      Top             =   3240
      Visible         =   0   'False
      Width           =   3615
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
      Left            =   3240
      TabIndex        =   2
      Top             =   4320
      Width           =   2055
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Desencriptar archivo"
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
      Left            =   240
      TabIndex        =   1
      Top             =   2280
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
   Begin VB.Label Label3 
      Caption         =   "El archivo a desencriptar debe estar en C:\datos"
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
      TabIndex        =   7
      Top             =   1680
      Width           =   4935
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
      TabIndex        =   5
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
      Height          =   615
      Left            =   120
      TabIndex        =   4
      Top             =   5280
      Width           =   5175
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Contraseña:"
      Height          =   195
      Left            =   240
      TabIndex        =   3
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
Dim b() As Byte

Command1.Enabled = False
Text2.Visible = True
Beep 1600, 400

Label2.Caption = "Procesando, aguarde, puede demorar..."
numero = FreeFile

If Dir("c:\datos\datos.dat") = "" Then
  MsgBox "No existe el archivo!!", vbCritical, "ERROR"
  Label2.Caption = "No existe el archivo!!"
  Exit Sub
End If

nombre_archivo = "c:\datos\datos.dat"
tamanio = FileLen(nombre_archivo)

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
'    ElseIf caracter = 13 Then
'    ElseIf caracter = 10 Then
    Else
        textod = textod & Chr((caracter - 103))
    End If
    contador = contador + 1
    DoEvents
    Text2 = contador & " de " & (tamanio - 1)
Loop

numero = FreeFile
nombre_archivo = "c:\datos\datos.txt"

Open nombre_archivo For Output As #numero
Print #numero, textod
Close #numero
Label2.Caption = "Desencripción terminada, Datos.txt en C:\datos\"
DoEvents
'Kill "c:\lecturas\datos.dat"
Beep 1500, 700
Beep 1, 200
Beep 1500, 700

End Sub
Private Sub Command3_Click()
Unload Me
End Sub
Private Sub Form_Load()
Text1 = vbNullString
'If DirExists("c:\datos") = False Then
'    MkDir "C:\datos"
'End If
Command1.Enabled = False

' HAY QUE ESPECIFICARLO COMO MES/DIA/AÑO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
fechas_iniciales(0) = #1/1/2020#
fechas_iniciales(1) = #4/1/2020#
fechas_iniciales(2) = #7/1/2020#
fechas_iniciales(3) = #10/1/2020#

fechas_finales(0) = #3/30/2020#
fechas_finales(1) = #6/30/2020#
fechas_finales(2) = #9/30/2020#
fechas_finales(3) = #12/31/2020#

contrasenias(0) = "12345"
contrasenias(1) = "02468"
contrasenias(2) = "13579"
contrasenias(3) = "67890"

fecha = Date

For i = 0 To 2
    If (fecha >= fechas_iniciales(i)) And (fecha <= fechas_finales(i)) Then
        pass2 = contrasenias(i)
    End If
Next



End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Sub Text1_KeyPress(KeyAscii As Integer)
If KeyAscii = 13 Then
    pass = Text1.Text
    Text1 = vbNullString
    If pass = pass2 Then
        Command1.Visible = True
        Command1.Default = True
        Command1.Enabled = True
        Label1.Visible = False
        Label5.Visible = False
        Text1.Enabled = False
        Text1.Visible = False
    Else
        Text1 = "Incorrecta"
    End If
End If
End Sub
