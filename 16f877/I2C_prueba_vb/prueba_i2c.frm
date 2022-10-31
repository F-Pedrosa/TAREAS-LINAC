VERSION 5.00
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Soft para probar hardware I2C"
   ClientHeight    =   4230
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   3990
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4230
   ScaleWidth      =   3990
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text2 
      Height          =   495
      Left            =   2880
      TabIndex        =   8
      Text            =   "Text1"
      Top             =   2520
      Width           =   615
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Leer SCL"
      Height          =   495
      Left            =   2520
      TabIndex        =   7
      Top             =   1800
      Width           =   1215
   End
   Begin VB.TextBox Text1 
      Height          =   495
      Left            =   2880
      TabIndex        =   6
      Text            =   "Text1"
      Top             =   960
      Width           =   615
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Leer SDA"
      Height          =   495
      Left            =   2520
      TabIndex        =   5
      Top             =   240
      Width           =   1215
   End
   Begin VB.CommandButton Command5 
      Caption         =   "SCL a 1"
      Height          =   495
      Left            =   240
      TabIndex        =   4
      Top             =   2520
      Width           =   2055
   End
   Begin VB.CommandButton Command4 
      Caption         =   "SCL a 0"
      Height          =   495
      Left            =   240
      TabIndex        =   3
      Top             =   1800
      Width           =   2055
   End
   Begin VB.CommandButton Command3 
      Caption         =   "SDA a 1"
      Height          =   495
      Left            =   240
      TabIndex        =   2
      Top             =   960
      Width           =   2055
   End
   Begin VB.CommandButton Command2 
      Caption         =   "SDA a 0"
      Height          =   495
      Left            =   240
      TabIndex        =   1
      Top             =   240
      Width           =   2055
   End
   Begin VB.CommandButton Command1 
      Cancel          =   -1  'True
      Caption         =   "Salir"
      Height          =   495
      Left            =   600
      TabIndex        =   0
      Top             =   3600
      Width           =   2655
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Dim LF As String
Private Sub Command1_Click()
Unload Me
End Sub

Private Sub Command2_Click()
vbOut I2Cloport, 255  ' sda lo
End Sub

Private Sub Command3_Click()
vbOut I2Cloport, 127    ' sda high

End Sub

Private Sub Command4_Click()
vbOut I2CHiPort, 0    ' scl lo
End Sub

Private Sub Command5_Click()
vbOut I2CHiPort, 8    ' scl high
End Sub

Private Sub Command6_Click()
            
Dim SDA As Integer

SDA = (vbInp(I2Cmidport) And 128)

If SDA = 1 Then
        Text1 = "1"
Else
        Text1 = "0"
End If


End Sub

Private Sub Form_Load()

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


Text1 = ""
Text2 = ""

End Sub

Private Sub Form_Unload(Cancel As Integer)
I2Cclose
End
End Sub

