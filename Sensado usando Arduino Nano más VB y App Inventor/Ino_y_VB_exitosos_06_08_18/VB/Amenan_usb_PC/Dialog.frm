VERSION 5.00
Begin VB.Form Dialog 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Confirmación"
   ClientHeight    =   2160
   ClientLeft      =   2760
   ClientTop       =   3750
   ClientWidth     =   6690
   FillColor       =   &H0000FFFF&
   FillStyle       =   0  'Solid
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2160
   ScaleWidth      =   6690
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin VB.CommandButton Command1 
      Cancel          =   -1  'True
      Caption         =   "Cancelar"
      Height          =   615
      Left            =   3600
      TabIndex        =   1
      Top             =   1320
      Width           =   1215
   End
   Begin VB.CommandButton OKButton 
      Caption         =   "Aceptar"
      Default         =   -1  'True
      Height          =   615
      Left            =   1320
      TabIndex        =   0
      Top             =   1320
      Width           =   1215
   End
   Begin VB.Image Image1 
      Appearance      =   0  'Flat
      Height          =   960
      Left            =   120
      Picture         =   "Dialog.frx":0000
      Stretch         =   -1  'True
      Top             =   120
      Width           =   960
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "¿Está seguro de querer borrar la SD?"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   13.5
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   360
      Left            =   1320
      TabIndex        =   2
      Top             =   360
      Width           =   5220
   End
End
Attribute VB_Name = "Dialog"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit

Private Sub CancelButton_Click()
Me.Hide
Form1.Show
cancelado = True

End Sub


Private Sub OKButton_Click()
Me.Hide
Form1.Show
aceptado = False
End Sub
