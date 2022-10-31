VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Test TEA"
   ClientHeight    =   7830
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6615
   LinkTopic       =   "Form1"
   ScaleHeight     =   7830
   ScaleWidth      =   6615
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command2 
      Cancel          =   -1  'True
      Caption         =   "&Salir"
      Height          =   495
      Left            =   3960
      TabIndex        =   5
      Top             =   7200
      Width           =   2535
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Desencriptar"
      Height          =   495
      Left            =   2400
      TabIndex        =   4
      Top             =   3600
      Width           =   2535
   End
   Begin VB.TextBox Text2 
      Height          =   1815
      Left            =   240
      TabIndex        =   3
      Text            =   "Text2"
      Top             =   4920
      Width           =   6255
   End
   Begin VB.TextBox Text1 
      Height          =   3015
      Left            =   240
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   360
      Width           =   6255
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "String desencriptado:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   240
      TabIndex        =   2
      Top             =   4560
      Width           =   1830
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "String encriptado:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   240
      TabIndex        =   1
      Top             =   120
      Width           =   1530
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
'Dim texto As String
'
'texto = Text1.Text
'CryptBuffer = texto
'TEA_Encrypt (CryptBuffer)
'Text2 = CryptBuffer
k = "1234567890abcdef"
TEST

End Sub

Private Sub Command2_Click()
Unload Me
End Sub

Private Sub Form_Load()
Text1.Text = vbNullString
Text2.Text = vbNullString
End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub
