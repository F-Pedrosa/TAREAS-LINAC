VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Comunicación serial tramas AME2"
   ClientHeight    =   7290
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   9615
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7290
   ScaleWidth      =   9615
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame5 
      Caption         =   "Pedir tramas por fecha"
      Height          =   1575
      Left            =   120
      TabIndex        =   18
      Top             =   4440
      Width           =   4575
      Begin VB.CommandButton Command5 
         Caption         =   "Pedir"
         Height          =   615
         Left            =   3240
         TabIndex        =   21
         Top             =   600
         Width           =   1095
      End
      Begin VB.TextBox Text11 
         Height          =   375
         Left            =   240
         TabIndex        =   19
         Text            =   "Text11"
         Top             =   720
         Width           =   2655
      End
      Begin VB.Label Label1 
         Caption         =   "Introducir en formato YYMMDDHHMMSS"
         Height          =   495
         Left            =   120
         TabIndex        =   20
         Top             =   360
         Width           =   3015
      End
   End
   Begin VB.Frame Frame4 
      Caption         =   "Sincronización RTC"
      Height          =   4095
      Left            =   5040
      TabIndex        =   5
      Top             =   240
      Width           =   4095
      Begin VB.TextBox Text10 
         Height          =   375
         Left            =   1680
         TabIndex        =   16
         Text            =   "Text10"
         Top             =   2640
         Width           =   1095
      End
      Begin VB.TextBox Text9 
         Height          =   375
         Left            =   1680
         TabIndex        =   15
         Text            =   "Text9"
         Top             =   2160
         Width           =   1095
      End
      Begin VB.TextBox Text8 
         Height          =   375
         Left            =   1680
         TabIndex        =   14
         Text            =   "Text8"
         Top             =   1680
         Width           =   1095
      End
      Begin VB.TextBox Text7 
         Height          =   375
         Left            =   1680
         TabIndex        =   13
         Text            =   "Text7"
         Top             =   1200
         Width           =   1095
      End
      Begin VB.TextBox Text6 
         Height          =   375
         Left            =   1680
         TabIndex        =   12
         Text            =   "Text6"
         Top             =   720
         Width           =   1095
      End
      Begin VB.CommandButton Command3 
         Caption         =   "Sincronizar RTC con PC"
         Height          =   615
         Left            =   960
         TabIndex        =   11
         Top             =   3240
         Width           =   2175
      End
      Begin VB.TextBox Text5 
         Height          =   375
         Left            =   1680
         TabIndex        =   10
         Text            =   "Text5"
         Top             =   240
         Width           =   1095
      End
   End
   Begin VB.Frame Frame3 
      Caption         =   "Selección Tramas por rango de fechas"
      Enabled         =   0   'False
      Height          =   1695
      Left            =   5040
      TabIndex        =   3
      Top             =   4440
      Width           =   4095
      Begin VB.CommandButton Command4 
         Caption         =   "Pedir tramas"
         Enabled         =   0   'False
         Height          =   735
         Left            =   1800
         TabIndex        =   17
         Top             =   480
         Width           =   1935
      End
      Begin VB.TextBox Text4 
         Height          =   375
         Left            =   360
         TabIndex        =   9
         Text            =   "Text4"
         Top             =   960
         Width           =   975
      End
      Begin VB.TextBox Text3 
         Height          =   375
         Left            =   360
         TabIndex        =   8
         Text            =   "Text3"
         Top             =   360
         Width           =   975
      End
   End
   Begin VB.Frame Frame2 
      Caption         =   "Tramas enviadas desde AME2"
      Height          =   2895
      Left            =   120
      TabIndex        =   2
      Top             =   1440
      Width           =   4575
      Begin VB.TextBox Text2 
         Height          =   2295
         Left            =   240
         MultiLine       =   -1  'True
         TabIndex        =   7
         Text            =   "receptor_serial.frx":0000
         Top             =   360
         Width           =   4095
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Testear estado Conexión con AME2"
      Height          =   1095
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   4575
      Begin VB.CommandButton Command2 
         Caption         =   "PING"
         Height          =   495
         Left            =   2760
         TabIndex        =   6
         Top             =   360
         Width           =   1575
      End
      Begin VB.TextBox Text1 
         Height          =   375
         Left            =   240
         MultiLine       =   -1  'True
         TabIndex        =   4
         Text            =   "receptor_serial.frx":0006
         Top             =   420
         Width           =   2175
      End
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   4560
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
   End
   Begin VB.CommandButton Command1 
      Cancel          =   -1  'True
      Caption         =   "Salir"
      Height          =   855
      Left            =   7560
      TabIndex        =   0
      Top             =   6360
      Width           =   1575
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Dim habilitado_a_archivo As Boolean
Dim mostrar_en_texto As Boolean

Dim ame_ocupada As Boolean

Dim numero As Integer


Private Sub Command1_Click()
Unload Me
End Sub

Private Sub Command2_Click()
Dim resul As VbMsgBoxResult

If ame_ocupada = True Then
        resul = MsgBox("AME ocupada!", vbOKOnly, "error!")
        Exit Sub
End If

mostrar_en_texto = True

habilitado_a_archivo = False
' Enviar caracter # por el puerto serial, lo que es un pedido de verificación de conexión con la AME2
' ella debe responder con el string  "Conectado", a visualizarse en el Text1
MSComm1.Output = "#"


If Text1 = "Conectado" Then
End If


End Sub

Private Sub Command3_Click()
Dim fecha_hora As String * 12
Dim largo As Integer
Dim i As Integer
Dim resul As VbMsgBoxResult

If ame_ocupada = True Then
        resul = MsgBox("AME ocupada!", vbOKOnly, "error!")
        Exit Sub
End If


fecha_hora = Text5 & Text6 & Text7 & Text8 & Text9 & Text10
largo = Len(fecha_hora)

' Enviar caracter al PIC que indica que va arreglo fecha y hora para sincronizar RTC AME.
MSComm1.Output = "t"

' Enviar string con la fecha y la hora en formato ASCII
For i = 1 To largo
        MSComm1.Output = Mid(fecha_hora, i, 1)
Next i

' Enviar caracter que marca que terminó el envío de fecha/hora
MSComm1.Output = "z"
End Sub

Private Sub Command5_Click()
Dim largo As Integer
Dim i As Integer
Dim resul As VbMsgBoxResult

If ame_ocupada = True Then
        resul = MsgBox("AME ocupada!", vbOKOnly, "error!")
        Exit Sub
End If

largo = Len(Text11)


mostrar_en_texto = True
habilitado_a_archivo = True

' Se le indica a la AME2 que va fecha y hora de las tramas que se deberán enviar
MSComm1.Output = "x"

' Barrer el text11 y enviar su contenido, 1 byte a la vez
For i = 1 To largo
        MSComm1.Output = Mid(Text11, i, 1)
Next i

' Marcamos que terminó la transmisión de fecha/hora
' tendría que retorna un paquete de tramas...
MSComm1.Output = "p"


End Sub

Private Sub Form_Load()

Dim nombre_archivo_tramas As String


Text1 = ""
Text2 = ""
Text11 = ""

' Cargar cajas con fecha/hora reloj PC
Text5 = Format(Right(Year(Now), 2), "00")
Text6 = Format(Month(Now), "00")
Text7 = Format(Day(Now), "00")
Text8 = Format(Hour(Now), "00")
Text9 = Format(Minute(Now), "00")
Text10 = Format(Second(Now), "00")



'Evento Rx
MSComm1.RThreshold = 1
' When Inputting Data, Input 1 Bytes at a time
MSComm1.InputLen = 1
' 115200 Baud, No Parity, 8 Data Bits, 1 Stop Bit
MSComm1.Settings = "115200,N,8,1"
' Disable DTR
MSComm1.DTREnable = False
' Open COM1
MSComm1.CommPort = 1
MSComm1.PortOpen = True


nombre_archivo_tramas = "c:\tramas_ame2_CPU_.txt"

numero = FreeFile

' abrir archivo en el que se guardarán las tramas recibidas serialmente
Open nombre_archivo_tramas For Output As #numero
Print #numero, "Tramas recibidas serialmente desde la AME2"
Print #numero,


mostrar_en_texto = True



End Sub

Private Sub Form_Unload(Cancel As Integer)
MSComm1.PortOpen = False
End
End Sub

Private Sub MSComm1_OnComm()
Dim sData As String ' Holds our incoming data

If MSComm1.CommEvent = comEvReceive Then
        sData = MSComm1.Input ' Get data
        
        Select Case sData
                Case "^"
                        ame_ocupada = False
                        habilitado_a_archivo = False
                        sData = vbNullString
                Case "$"
                        ame_ocupada = True
                        habilitado_a_archivo = True
                        sData = vbNullString
                Case "%"
                        MSComm1.Output = "%"
                        sData = vbNullString
                Case "&"
                        sData = vbNullString
                        habilitado_a_archivo = True
                        Exit Sub
        End Select
                
        If habilitado_a_archivo Then
                ' Si llega la marca de final de grupo de tramas
                If sData = "@" Then
                        ' cerrar archivo
                        Close #numero
                        Exit Sub
                Else                            ' sino, grabar lo recibido
                        ' grabar en archivo
                        Print #numero, sData;
               End If
        End If

        If mostrar_en_texto Then
                Text2 = Text2 & sData
        End If

End If

End Sub
