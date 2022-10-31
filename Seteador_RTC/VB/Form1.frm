VERSION 5.00
Object = "{EA4C06C4-DD2F-41A9-AEF0-9FB0C8C9BAB9}#1.1#0"; "SComm32x.ocx"
Begin VB.Form Form1 
   Caption         =   "Seteador RTC"
   ClientHeight    =   6645
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5415
   LinkTopic       =   "Form1"
   ScaleHeight     =   6645
   ScaleWidth      =   5415
   StartUpPosition =   2  'CenterScreen
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   3000
      Top             =   4920
   End
   Begin VB.TextBox Text3 
      Height          =   375
      Left            =   120
      TabIndex        =   8
      Text            =   "Text3"
      Top             =   6000
      Visible         =   0   'False
      Width           =   2295
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Command4"
      Height          =   615
      Left            =   360
      TabIndex        =   7
      Top             =   5280
      Visible         =   0   'False
      Width           =   1575
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Setear RTC con la fecha y hora de la PC"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   360
      TabIndex        =   6
      Top             =   3960
      Width           =   4695
   End
   Begin VB.TextBox Text2 
      Height          =   495
      Left            =   360
      TabIndex        =   5
      Text            =   "Text2"
      Top             =   480
      Width           =   3855
   End
   Begin VB.TextBox Text1 
      Height          =   495
      Left            =   600
      TabIndex        =   2
      Text            =   "Text1"
      Top             =   2760
      Width           =   3975
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Pedir fecha y hora al RTC"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   975
      Left            =   600
      TabIndex        =   1
      Top             =   1320
      Width           =   4215
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
      TabIndex        =   0
      Top             =   5640
      Width           =   2055
   End
   Begin SCommLib.SComm SComm1 
      Left            =   4800
      Top             =   2400
      _ExtentX        =   953
      _ExtentY        =   979
      CommPort        =   3
      DTREnable       =   0   'False
      InBufferSize    =   32760
      OutBufferSize   =   32766
      RThreshold      =   1
      RTSEnable       =   0   'False
      Settings        =   "57600,N,8,1"
      CommName        =   "Silicon Labs CP210x USB to UART Bridge (COM3)"
      OverlappedIO    =   -1  'True
   End
   Begin VB.Line Line2 
      X1              =   240
      X2              =   5280
      Y1              =   3600
      Y2              =   3600
   End
   Begin VB.Line Line1 
      X1              =   240
      X2              =   5280
      Y1              =   1080
      Y2              =   1080
   End
   Begin VB.Label Label2 
      Caption         =   "Fecha y hora de la PC:"
      Height          =   255
      Left            =   360
      TabIndex        =   4
      Top             =   120
      Width           =   1815
   End
   Begin VB.Label Label1 
      Caption         =   "Fecha y hora del RTC:"
      Height          =   255
      Left            =   360
      TabIndex        =   3
      Top             =   2400
      Width           =   1815
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private ahora_no As Boolean
Private Declare Sub Sleep Lib "kernel32.dll" (ByVal dwMilliseconds As Long)
Private Declare Function Beep Lib "kernel32" (ByVal dwFreq As Long, ByVal dwDuration As Long) As Long

Private Sub Command1_Click()
ahora_no = False
Text1 = vbNullString
If SComm1.PortOpen = False Then
    SComm1.PortOpen = True
End If

cual_pedido = 1
SComm1.Output = "a"
End Sub

Private Sub Command2_Click()
If SComm1.PortOpen = False Then
    SComm1.PortOpen = True
End If

SComm1.Output = Right(Year(Date), 2) & Format(Month(Date), "00") & Weekday(Date) & Format(Day(Date), "00") & Format(Hour(Time), "00") & Format(Minute(Time), "00") & Format(Second(Time), "00") & "b"

ahora_no = True

End Sub

Private Sub Command3_Click()
Unload Me
End Sub
Private Sub Command5_Click()
If SComm1.PortOpen = False Then
    SComm1.PortOpen = True
End If

SComm1.Output = "c"

End Sub

Private Sub Command4_Click()
Text3 = Right(Year(Date), 2) & Format(Month(Date), "00")
Text3 = Text3 & Weekday(Date) & Format(Day(Date), "00")
Text3 = Text3 & Format(Hour(Time), "00") & Format(Minute(Time), "00")
Text3 = Text3 & Format(Second(Time), "00")
End Sub

Private Sub Form_Load()
Text1 = vbNullString
Text2 = vbNullString
If SComm1.PortOpen = True Then
    SComm1.PortOpen = False
End If

Text2 = StrConv(WeekdayName(Weekday(Date)), vbProperCase) & ", " & Day(Date) & " de " & StrConv(MonthName(Month(Date)), vbProperCase) & " de " & Year(Date) & "  " & Time

ahora_no = False
End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Sub SComm1_OnComm()

Dim pos As Long
Dim numero As Integer

Select Case SComm1.CommEvent
    Case comEvReceive
        If ahora_no = False Then
            Text1.Text = Text1.Text & SComm1.Input
        End If
    Case Is > 1000
        Label2.Caption = "Error en puerto COM" & SComm1.CommPort
End Select

End Sub

Private Sub Timer1_Timer()
'Text2 = StrConv(WeekdayName(Weekday(Date)), vbProperCase) & " " & Date & "  " & Time
Text2 = StrConv(WeekdayName(Weekday(Date)), vbProperCase) & ", " & Day(Date) & " de " & StrConv(MonthName(Month(Date)), vbProperCase) & " de " & Year(Date) & "  " & Time
End Sub
