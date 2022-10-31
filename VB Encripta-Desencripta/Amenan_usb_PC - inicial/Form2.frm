VERSION 5.00
Begin VB.Form Form2 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Lectura de Datos"
   ClientHeight    =   2565
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4455
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2565
   ScaleWidth      =   4455
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text2 
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   1560
      Width           =   615
   End
   Begin VB.CommandButton Command2 
      Cancel          =   -1  'True
      Caption         =   "Salir"
      Height          =   495
      Left            =   3000
      TabIndex        =   4
      Top             =   1920
      Width           =   1335
   End
   Begin VB.CommandButton Command1 
      Caption         =   "OK"
      Default         =   -1  'True
      Height          =   495
      Left            =   1560
      TabIndex        =   3
      Top             =   1920
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   375
      IMEMode         =   3  'DISABLE
      Left            =   120
      PasswordChar    =   "*"
      TabIndex        =   0
      Top             =   600
      Width           =   4215
   End
   Begin VB.Label Label2 
      Caption         =   "Ingrese número de puerto COM:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   1200
      Width           =   2775
   End
   Begin VB.Label Label1 
      Caption         =   "Ingrese la contraseña:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   240
      Width           =   2295
   End
End
Attribute VB_Name = "Form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Dim fechas_iniciales(10) As Date
Dim fechas_finales(10) As Date
Dim contrasenias(10) As String
Dim fecha As Date
Dim pass As String

Private Sub Command1_Click()
If Len(Trim(Text1)) > 0 Then
    If Text1 = pass Then
        Form1.Visible = True
        Me.Visible = False
    Else
        MsgBox "Contraseña incorrecta"
    End If
Else
    MsgBox "La contraseña no puede ser vacía"
End If
    
If Text2.Visible = True Then
    puerto = Val(Text2.Text)
End If
    
End Sub

Private Sub Command2_Click()
End
End Sub

Private Sub Form_Load()
Dim i As Integer

' HAY QUE ESPECIFICARLO COMO MES/DIA/AÑO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
fechas_iniciales(0) = #7/1/2018#
fechas_iniciales(1) = #9/1/2018#
fechas_iniciales(2) = #10/1/2018#

fechas_finales(0) = #8/31/2018#
fechas_finales(1) = #9/30/2018#
fechas_finales(2) = #10/31/2018#

contrasenias(0) = "pepe"
contrasenias(1) = "cacho"
contrasenias(2) = "tito"

fecha = Date

For i = 0 To 2
    If (fecha >= fechas_iniciales(i)) And (fecha <= fechas_finales(i)) Then
        pass = contrasenias(i)
    End If
Next

Dim sINIFile As String
Dim puerto_ini As String





' Si NO existe el archivo INI, habilitar el ingreso de número de puerto.
If Dir(App.Path & "\amenan2usb.ini") <> "" Then
    Form2.Label2.Visible = False
    Form2.Text2.Visible = False
    ' obtener desde dicho INI el número de puerto a usar
    sINIFile = App.Path & "\amenan2usb.ini"
    puerto_ini = sGetINI(sINIFile, "puertos", "puerto", "?")
    puerto = Val(puerto_ini)
Else
    Form2.Label2.Visible = True
    Form2.Text2.Visible = True
End If



End Sub

Private Sub Text2_Change()
puerto = Val(Text2.Text)
End Sub
