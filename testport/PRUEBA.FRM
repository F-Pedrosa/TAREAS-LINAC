VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "TestPort 4 - para 48 y 96 "
   ClientHeight    =   4200
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   4755
   KeyPreview      =   -1  'True
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   4200
   ScaleWidth      =   4755
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame2 
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   3045
      TabIndex        =   10
      Top             =   630
      Width           =   750
      Begin VB.OptionButton Option3 
         Caption         =   "Option1"
         Height          =   225
         Left            =   0
         TabIndex        =   12
         Top             =   0
         Value           =   -1  'True
         Width           =   225
      End
      Begin VB.OptionButton Option4 
         Caption         =   "Option1"
         Height          =   225
         Left            =   525
         TabIndex        =   11
         Top             =   0
         Width           =   225
      End
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
      BorderStyle     =   0  'None
      ForeColor       =   &H80000008&
      Height          =   225
      Left            =   840
      TabIndex        =   7
      Top             =   630
      Width           =   750
      Begin VB.OptionButton Option1 
         Caption         =   "Option1"
         Height          =   225
         Left            =   0
         TabIndex        =   9
         Top             =   0
         Value           =   -1  'True
         Width           =   225
      End
      Begin VB.OptionButton Option2 
         Caption         =   "Option1"
         Height          =   225
         Left            =   525
         TabIndex        =   8
         Top             =   0
         Width           =   225
      End
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Puerto A"
      Height          =   435
      Left            =   2730
      TabIndex        =   6
      Top             =   1050
      Width           =   1485
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Puerto B"
      Height          =   435
      Left            =   2730
      TabIndex        =   5
      Top             =   1785
      Width           =   1485
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Puerto C"
      Height          =   435
      Left            =   2730
      TabIndex        =   4
      Top             =   2520
      Width           =   1485
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Puerto C"
      Height          =   435
      Left            =   525
      TabIndex        =   3
      Top             =   2520
      Width           =   1380
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Puerto B"
      Height          =   435
      Left            =   525
      TabIndex        =   2
      Top             =   1785
      Width           =   1380
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Puerto A"
      Height          =   435
      Left            =   525
      TabIndex        =   1
      Top             =   1050
      Width           =   1380
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Salir"
      Height          =   540
      Left            =   1155
      TabIndex        =   0
      Top             =   3255
      Width           =   2325
   End
   Begin VB.Frame Frame3 
      Height          =   3900
      Left            =   105
      TabIndex        =   13
      Top             =   100
      Width           =   4530
      Begin VB.Line Line2 
         BorderColor     =   &H80000005&
         X1              =   2215
         X2              =   2215
         Y1              =   210
         Y2              =   3045
      End
      Begin VB.Label Label1 
         AutoSize        =   -1  'True
         Caption         =   "(IC1 o IC3)"
         Height          =   195
         Left            =   735
         TabIndex        =   15
         Top             =   315
         Width           =   750
      End
      Begin VB.Label Label2 
         AutoSize        =   -1  'True
         Caption         =   "(IC2 o IC4)"
         Height          =   195
         Left            =   2940
         TabIndex        =   14
         Top             =   315
         Width           =   750
      End
      Begin VB.Line Line1 
         X1              =   2205
         X2              =   2205
         Y1              =   210
         Y2              =   3045
      End
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim address As Integer, address2 As Integer

Private Sub Command1_Click()
Unload Me
End Sub

Private Sub Command2_Click()
Dim i As Integer
i = 1
  Command3.Enabled = False
  Command4.Enabled = False
  Command5.Enabled = False
  Command6.Enabled = False
  Command7.Enabled = False
Do
   Out address, i
   i = i * 2
   DoEvents
   Delay (250)
Loop While i <= 128
Out address, 255
Delay (500)
Out address, 0
Command3.Enabled = True
Command4.Enabled = True
Command5.Enabled = True
Command6.Enabled = True
Command7.Enabled = True
End Sub

Private Sub Command3_Click()
Dim i As Integer
i = 1
Command2.Enabled = False
Command4.Enabled = False
Command5.Enabled = False
Command6.Enabled = False
Command7.Enabled = False
Do
   Out address + 1, i
   i = i * 2
   DoEvents
   Delay (250)
Loop While i <= 128
Out address + 1, 255
Delay (500)
Out address + 1, 0
Command2.Enabled = True
Command4.Enabled = True
Command5.Enabled = True
Command6.Enabled = True
Command7.Enabled = True
End Sub


Private Sub Command4_Click()
Dim i As Integer
i = 1
Command3.Enabled = False
Command2.Enabled = False
Command5.Enabled = False
Command6.Enabled = False
Command7.Enabled = False
Do
   Out address + 2, i
   i = i * 2
   DoEvents
   Delay (250)
Loop While i <= 128
Out address + 2, 255
Delay (500)
Out address + 2, 0
Command3.Enabled = True
Command2.Enabled = True
Command5.Enabled = True
Command6.Enabled = True
Command7.Enabled = True
End Sub


Private Sub Command5_Click()
Dim i As Integer
i = 1
Command3.Enabled = False
Command4.Enabled = False
Command2.Enabled = False
Command6.Enabled = False
Command7.Enabled = False
Do
   Out address2 + 2, i
   i = i * 2
   DoEvents
   Delay (250)
Loop While i <= 128
Out address2 + 2, 255
Delay (500)
Out address2 + 2, 0
Command3.Enabled = True
Command4.Enabled = True
Command2.Enabled = True
Command6.Enabled = True
Command7.Enabled = True
End Sub

Private Sub Command6_Click()
Dim i As Integer
i = 1
Command3.Enabled = False
Command4.Enabled = False
Command5.Enabled = False
Command2.Enabled = False
Command7.Enabled = False
Do
   Out address2 + 1, i
   i = i * 2
   DoEvents
   Delay (250)
Loop While i <= 128
Out address2 + 1, 255
Delay (500)
Out address2 + 1, 0
Command3.Enabled = True
Command4.Enabled = True
Command5.Enabled = True
Command2.Enabled = True
Command7.Enabled = True

End Sub

Private Sub Command7_Click()
Dim i As Integer
i = 1
Command3.Enabled = False
Command4.Enabled = False
Command5.Enabled = False
Command6.Enabled = False
Command2.Enabled = False
Do
   Out address2, i
   i = i * 2
   DoEvents
   Delay (250)
Loop While i <= 128
Out address2, 255
Delay (500)
Out address2, 0
Command3.Enabled = True
Command4.Enabled = True
Command5.Enabled = True
Command6.Enabled = True
Command2.Enabled = True
End Sub


Private Sub Form_KeyPress(KeyAscii As Integer)
If KeyAscii = 27 Then Unload Me
End Sub

Private Sub Form_Load()
Dim i As Byte
'setear todos los puertos como salidas mandando
'el hexa 80 al puerto de control de cada 8255
Out ic1_base + 3, &H80
Out ic2_base + 3, &H80
Out ic3_base + 3, &H80
Out ic4_base + 3, &H80

'todas las salidas a cero
For i = 0 To 2
   Out ic1_base + i, 0
   Out ic2_base + i, 0
   Out ic3_base + i, 0
   Out ic4_base + i, 0
Next

'cargar valores iniciales para las direcciones
address = ic1_base
address2 = ic2_base
End Sub


Private Sub Form_Unload(Cancel As Integer)
Dim i As Byte
'dejar todas las salidas en cero
For i = 0 To 2
   Out ic1_base + i, 0
   Out ic2_base + i, 0
   Out ic3_base + i, 0
   Out ic4_base + i, 0
Next

End
End Sub


Private Sub Option1_Click()
address = ic1_base
End Sub


Private Sub Option2_Click()
address = ic3_base
End Sub


Private Sub Option3_Click()
address2 = ic2_base

End Sub


Private Sub Option4_Click()
address2 = ic4_base

End Sub


