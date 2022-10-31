VERSION 5.00
Object = "{EA4C06C4-DD2F-41A9-AEF0-9FB0C8C9BAB9}#1.1#0"; "SComm32x.ocx"
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Pedido de archivos a AMENAN"
   ClientHeight    =   10965
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   5175
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   10965
   ScaleWidth      =   5175
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Visible         =   0   'False
   Begin SCommLib.SComm SComm1 
      Left            =   0
      Top             =   120
      _ExtentX        =   953
      _ExtentY        =   979
      DTREnable       =   0   'False
      InBufferSize    =   32760
      OutBufferSize   =   32766
      RTSEnable       =   0   'False
      Settings        =   "115200,N,8,1"
      OverlappedIO    =   -1  'True
   End
   Begin VB.CommandButton Command8 
      Caption         =   "Pedir archivo respaldo"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   8
      Top             =   5520
      Width           =   4695
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Pedir mensual(es)"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   7
      Top             =   2280
      Width           =   4695
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Seleccionar Mensual(es)"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   6
      Top             =   1200
      Width           =   4695
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   200
      Left            =   120
      Top             =   10080
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Pedir bitácora envíos"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   5
      Top             =   4440
      Width           =   4695
   End
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1935
      Left            =   240
      MultiLine       =   -1  'True
      ScrollBars      =   3  'Both
      TabIndex        =   4
      Top             =   7680
      Width           =   4695
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Borrar SD "
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   3
      Top             =   6600
      Width           =   4695
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Pedir archivo alimentación"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   2
      Top             =   3360
      Width           =   4695
   End
   Begin VB.CommandButton Command2 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   3480
      TabIndex        =   1
      Top             =   9840
      Width           =   1455
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Pedir archivo completo"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   855
      Left            =   240
      TabIndex        =   0
      Top             =   120
      Width           =   4695
   End
   Begin VB.Shape Shape1 
      BackColor       =   &H0000FF00&
      Height          =   255
      Left            =   2280
      Shape           =   3  'Circle
      Top             =   9840
      Visible         =   0   'False
      Width           =   255
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private nombre_archivo As String

'Private caso As Integer

Private Declare Function Beep Lib "kernel32" (ByVal dwFreq As Long, ByVal dwDuration As Long) As Long
Private Declare Function QueryDosDevice Lib "kernel32" _
    Alias "QueryDosDeviceW" ( _
    ByVal lpDeviceName As Long, _
    ByVal lpTargetPath As Long, _
    ByVal ucchMax As Long) As Long
Private Sub Command1_Click()
nombre_archivo = "full.txt"
While SComm1.PortOpen <> True
    SComm1.PortOpen = True
Wend
SComm1.Output = "a"
Sleep 50
SComm1.Output = "a"
Sleep 50
SComm1.Output = "a"
Sleep 50
SComm1.Output = "a"
Sleep 50
SComm1.Output = "a"
Sleep 50
SComm1.Output = "a"
Sleep 50
SComm1.Output = "a"
Sleep 50
SComm1.Output = vbCrLf

'Label1.Caption = "Pedido " & nombre_archivo & ", aguarde..."
Text1 = Text1 & "Pedido " & nombre_archivo & ", aguarde..." & vbCrLf
'Label1.Visible = True
Timer1.Enabled = True
Shape1.Visible = True

numero = FreeFile
Open "c:\lecturas\" & nombre_archivo For Output As #numero

End Sub

Private Sub Command2_Click()
Unload Me
End Sub
Private Sub Command3_Click()
nombre_archivo = "alim.txt"
While SComm1.PortOpen <> True
    SComm1.PortOpen = True
Wend

SComm1.Output = "i"
Sleep 50
SComm1.Output = "i"
Sleep 50
SComm1.Output = "i"
Sleep 50
SComm1.Output = "i"
Sleep 50
SComm1.Output = "i"
Sleep 50
SComm1.Output = "i"
Sleep 50
SComm1.Output = "i"
Sleep 50
SComm1.Output = vbCrLf

'Label1.Caption = "Pedido " & nombre_archivo
Text1 = Text1 & "Pedido " & nombre_archivo & ", aguarde..." & vbCrLf
'Label1.Visible = True
Timer1.Enabled = True
Shape1.Visible = True
numero = FreeFile
Open "c:\lecturas\" & nombre_archivo For Output As #numero

End Sub
Private Sub Command4_Click()
Dim respuesta As Integer
respuesta = MsgBox("¿Seguro que desea borrar la SD? ", vbCritical + vbYesNo, "¡Atención!")
If respuesta = vbYes Then
Else
    Exit Sub
End If

nombre_archivo = "borrasd"

While SComm1.PortOpen <> True
    SComm1.PortOpen = True
Wend

SComm1.Output = "z"
Sleep 50
SComm1.Output = "z"
Sleep 50
SComm1.Output = "z"
Sleep 50
SComm1.Output = "z"
Sleep 50
SComm1.Output = "z"
Sleep 50
SComm1.Output = "z"
Sleep 50
SComm1.Output = "z"
Sleep 50
Form1.SComm1.Output = vbCrLf

'Label1.Caption = "Borrando SD..."
Text1 = Text1 & "Borrando SD..." & vbCrLf

End Sub
Private Sub Command5_Click()
nombre_archivo = "bita.txt"
While SComm1.PortOpen <> True
    SComm1.PortOpen = True
Wend
SComm1.Output = "b"
Sleep 50
SComm1.Output = "b"
Sleep 50
SComm1.Output = "b"
Sleep 50
SComm1.Output = "b"
Sleep 50
SComm1.Output = "b"
Sleep 50
SComm1.Output = "b"
Sleep 50
SComm1.Output = "b"
Sleep 50
SComm1.Output = vbCrLf


'Label1.Caption = "Pedido " & nombre_archivo
'Label1.Visible = True
Text1 = Text1 & "Pedido " & nombre_archivo & ", aguarde..." & vbCrLf
Timer1.Enabled = True
Shape1.Visible = True

numero = FreeFile
Open "c:\lecturas\" & nombre_archivo For Output As #numero

End Sub

Private Sub Command6_Click()
Form3.Show
Me.Hide
End Sub

Private Sub Command7_Click()
Dim i As Integer

While Form1.SComm1.PortOpen <> True
    Form1.SComm1.PortOpen = True
Wend

For i = 0 To cantidad
    Form1.SComm1.Output = "m"
    Sleep 50
    Form1.SComm1.Output = "m"
    Sleep 50
    Form1.SComm1.Output = "m"
    Sleep 50
    Form1.SComm1.Output = Left(arreglo_meses(i), 1)
    Sleep 50
    Form1.SComm1.Output = Mid(arreglo_meses(i), 2, 1)
    Sleep 50
    Form1.SComm1.Output = Mid(arreglo_meses(i), 3, 1)
    Sleep 50
    Form1.SComm1.Output = Mid(arreglo_meses(i), 4, 1)
    Sleep 50
    Form1.SComm1.Output = vbCrLf
    'nombre = "c:\lecturas\" & arreglo_meses(i) & ".txt"

    nombre_archivo = arreglo_meses(i) & ".txt"

    'Label1.Caption = "Pedido " & arreglo_meses(i) & ".txt"
    'Label1.Visible = True
    Text1 = Text1 & "Pedido " & arreglo_meses(i) & ".txt" & ", aguarde..." & vbCrLf

    Timer1.Enabled = True
    Shape1.Visible = True
       
    numero = FreeFile
    Open "c:\lecturas\" & nombre_archivo For Output As #numero
       
    If i <> cantidad Then
        Sleep 2000
    End If

Next

End Sub

Private Sub Command8_Click()
nombre_archivo = "full_respaldo.txt"
While SComm1.PortOpen <> True
    SComm1.PortOpen = True
Wend
SComm1.Output = "r"
Sleep 50
SComm1.Output = "r"
Sleep 50
SComm1.Output = "r"
Sleep 50
SComm1.Output = "r"
Sleep 50
SComm1.Output = "r"
Sleep 50
SComm1.Output = "r"
Sleep 50
SComm1.Output = "r"
Sleep 50
Form1.SComm1.Output = vbCrLf

'Label1.Caption = "Pedido full.txt de respaldo"
'Label1.Visible = True
Text1 = Text1 & "Pedido full.txt de respaldo" & vbCrLf
Timer1.Enabled = True
Shape1.Visible = True

numero = FreeFile
Open "c:\lecturas\" & nombre_archivo For Output As #numero

End Sub

Private Sub Form_Load()

' Con estos seteos funciona bien, ATENCIÓN!!!!!!!!!!!!!!!!! NO CAMBIAR!!!!!
' Sobre todo los 5 primeros, influyen críticamente sobre la transmisión
'MSComm1.InBufferSize = 1024
'MSComm1.OutBufferSize = 512
'MSComm1.RThreshold = 1
'MSComm1.SThreshold = 0
'MSComm1.InputLen = 0
'MSComm1.Handshaking = comNone
'MSComm1.CommPort = puerto

'SComm1.InBufferSize = 1024
'SComm1.OutBufferSize = 512
SComm1.RThreshold = 1
SComm1.SThreshold = 0
SComm1.InputLen = 0
SComm1.Handshaking = comNone
SComm1.CommPort = puerto


End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub
Private Sub SComm1_OnComm()
Static InBuff As String

Select Case SComm1.CommEvent
            Case comEvReceive ' Received RThreshold # of chars.
                InBuff = SComm1.Input
                If nombre_archivo = "borrasd" Then
                    If (InStr(InBuff, "#")) Then
                        'Label1.Caption = "SD borrada"
                        Text1 = Text1 & "SD borrada" & vbCrLf
                        Beep 1000, 200
                        Beep 1000, 200
                        Timer1.Enabled = False
                        Shape1.Visible = False
                    End If
                Else
                    Print #numero, InBuff;
                    If (InStr(InBuff, "#")) Then
                        Close #numero
                        'Label1.Caption = "Grabado " & "c:\lecturas\" & nombre_archivo
                        Text1 = Text1 & "Grabado " & "c:\lecturas\" & nombre_archivo & vbCrLf
                        Beep 1000, 200
                        Beep 1000, 200
                        Timer1.Enabled = False
                        Shape1.Visible = False
                    End If
                End If
End Select
End Sub
Private Sub Text1_DblClick()
Text1.Text = vbNullString
End Sub

Private Sub Timer1_Timer()
If Shape1.BackStyle = 1 Then
    Shape1.BackStyle = 0
Else
    Shape1.BackStyle = 1
End If
End Sub
