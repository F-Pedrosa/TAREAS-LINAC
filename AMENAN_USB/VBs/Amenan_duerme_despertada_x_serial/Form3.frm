VERSION 5.00
Begin VB.Form Form3 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Selección de mes(es)"
   ClientHeight    =   2955
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4275
   LinkTopic       =   "Form3"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2955
   ScaleWidth      =   4275
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command3 
      Caption         =   "Aceptar"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   495
      Left            =   2520
      TabIndex        =   6
      Top             =   2280
      Width           =   1455
   End
   Begin VB.ComboBox Combo4 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   2520
      TabIndex        =   3
      Text            =   "Año"
      Top             =   1680
      Width           =   1455
   End
   Begin VB.ComboBox Combo3 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   360
      TabIndex        =   2
      Text            =   "Mes"
      Top             =   1680
      Width           =   1455
   End
   Begin VB.ComboBox Combo2 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      Left            =   2520
      TabIndex        =   1
      Text            =   "Año"
      Top             =   600
      Width           =   1455
   End
   Begin VB.ComboBox Combo1 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   360
      ItemData        =   "Form3.frx":0000
      Left            =   360
      List            =   "Form3.frx":0002
      TabIndex        =   0
      Text            =   "Mes"
      Top             =   600
      Width           =   1455
   End
   Begin VB.Label Label2 
      Caption         =   "Final"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   360
      TabIndex        =   5
      Top             =   1440
      Width           =   1335
   End
   Begin VB.Label Label1 
      Caption         =   "Inicial"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   360
      TabIndex        =   4
      Top             =   360
      Width           =   855
   End
End
Attribute VB_Name = "Form3"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Combo1_Click()
mes_inicial = Combo1.Text
If Val(mes_inicial) < 10 Then
    mes_inicial = "0" & mes_inicial
End If
End Sub
Private Sub Combo2_Click()
anio_inicial = Combo2.Text
End Sub
Private Sub Combo3_Click()
mes_final = Combo3.Text
If Val(mes_final) < 10 Then
    mes_final = "0" & mes_final
End If
End Sub
Private Sub Combo4_Click()
anio_final = Combo4.Text
End Sub
Private Sub Command1_Click()
'Dim cadena As String
'Dim test
'
'If Val(anio_final) < Val(anio_inicial) Then
'    test = MsgBox("Ingreso de años incorrecto", vbOKOnly, "ERROR")
'    Exit Sub
'End If
'
'cadena = mes_inicial & anio_inicial
'
'Text1 = vbNullString
'
'While Form1.MSComm1.PortOpen <> True
'    Form1.MSComm1.PortOpen = True
'Wend
'Form1.MSComm1.Output = "m"
'Sleep 50
'Form1.MSComm1.Output = "m"
'Sleep 50
'Form1.MSComm1.Output = "m"
'Sleep 50
'Form1.MSComm1.Output = Left(mes_inicial, 1)
'Sleep 50
'Form1.MSComm1.Output = Right(mes_inicial, 1)
'Sleep 50
'Form1.MSComm1.Output = Left(anio_inicial, 1)
'Sleep 50
'Form1.MSComm1.Output = Right(anio_inicial, 1)
'Sleep 50
'Form1.MSComm1.Output = vbCrLf
'
'Dim nombre As String
'nombre = "c:\lecturas\" & cadena & ".txt"
'
'Label3.Caption = "Pedido " & cadena & ".txt"
'
'Dim cBuffer As String
'Dim caracter As String * 1
'
'Do
'  DoEvents
'  cBuffer = cBuffer & Form1.MSComm1.Input
'Loop Until InStr(cBuffer, "#")
'
'Text1 = Text1 & cBuffer
'
'Dim numero As Integer
'
'numero = FreeFile
'
'Open nombre For Output As #numero
'Print #numero, cBuffer
'Close #numero
'Label3.Caption = "Grabado " & nombre
'Beep 1000, 200
'Beep 1000, 200

End Sub


Private Sub Command3_Click()
Dim cadena As String
Dim cadena2 As String
Dim test
Dim i As Integer
Dim valor As Integer
Dim valorstr As String

If Val(anio_inicial) > Right(Year(Now), 2) Then
    test = MsgBox("Ingreso de años incorrecto", vbOKOnly, "ERROR")
    Exit Sub
End If

If Val(anio_final) > Right(Year(Now), 2) Then
    test = MsgBox("Ingreso de años incorrecto", vbOKOnly, "ERROR")
    Exit Sub
End If

If Val(mes_inicial) > Month(Now) Then
    test = MsgBox("Ingreso de mes incorrecto", vbOKOnly, "ERROR")
    Exit Sub
End If

If Val(mes_final) > Month(Now) Then
    test = MsgBox("Ingreso de mes incorrecto", vbOKOnly, "ERROR")
    Exit Sub
End If

If Val(anio_final) < Val(anio_inicial) Then
    test = MsgBox("Ingreso de años incorrecto", vbOKOnly, "ERROR")
    Exit Sub
End If

cadena = mes_inicial & anio_inicial
cadena2 = mes_final & anio_final

valor = Val(mes_inicial)
valorstr = mes_inicial

cantidad = Val(mes_final) - Val(mes_inicial)

ReDim Preserve arreglo_meses(cantidad)

If Val(anio_final) = Val(anio_inicial) Then
    Do Until valor = Val(mes_final)
        arreglo_meses(i) = valorstr & anio_inicial
        i = i + 1
        valor = valor + 1
        If valor < 10 Then
            valorstr = "0" & Trim(Str(valor))
        End If
    Loop
    arreglo_meses(i) = cadena2
    i = 0
End If

Form1.Command7.Enabled = True
'Form1.Command7.SetFocus
Form1.Show
Me.Hide

End Sub

Private Sub Form_Load()
Dim i As Integer
For i = 1 To 12
    Combo1.AddItem i
    Combo3.AddItem i
Next
For i = 18 To 25
    Combo2.AddItem i
    Combo4.AddItem i
Next

End Sub
