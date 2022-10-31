VERSION 5.00
Object = "{648A5603-2C6E-101B-82B6-000000000014}#1.1#0"; "MSCOMM32.OCX"
Begin VB.Form Form1 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Lector EEPROM interna PIC via RS232"
   ClientHeight    =   4020
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7200
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4020
   ScaleWidth      =   7200
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command4 
      Caption         =   "Para leer las EEPROMs del banco"
      Height          =   855
      Left            =   5040
      TabIndex        =   11
      Top             =   1800
      Width           =   2055
   End
   Begin VB.Frame Frame1 
      Caption         =   "Número Canales"
      Height          =   1455
      Left            =   3240
      TabIndex        =   4
      Top             =   2280
      Visible         =   0   'False
      Width           =   2055
      Begin VB.OptionButton Option6 
         Caption         =   "6"
         Height          =   375
         Left            =   1440
         TabIndex        =   10
         Top             =   840
         Width           =   375
      End
      Begin VB.OptionButton Option5 
         Caption         =   "5"
         Height          =   375
         Left            =   840
         TabIndex        =   9
         Top             =   840
         Width           =   495
      End
      Begin VB.OptionButton Option4 
         Caption         =   "4"
         Height          =   375
         Left            =   240
         TabIndex        =   8
         Top             =   840
         Width           =   375
      End
      Begin VB.OptionButton Option3 
         Caption         =   "3"
         Height          =   255
         Left            =   1440
         TabIndex        =   7
         Top             =   360
         Width           =   495
      End
      Begin VB.OptionButton Option2 
         Caption         =   "2"
         Height          =   375
         Left            =   840
         TabIndex        =   6
         Top             =   300
         Width           =   375
      End
      Begin VB.OptionButton Option1 
         Caption         =   "1"
         Height          =   255
         Left            =   240
         TabIndex        =   5
         Top             =   360
         Value           =   -1  'True
         Width           =   375
      End
   End
   Begin VB.CommandButton Command3 
      Caption         =   "&Salir"
      Height          =   495
      Left            =   5040
      TabIndex        =   3
      Top             =   3360
      Width           =   2055
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Grabar a disco"
      Height          =   495
      Left            =   5040
      TabIndex        =   2
      Top             =   840
      Width           =   2055
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Leer EEPROM interna"
      Height          =   495
      Left            =   5040
      TabIndex        =   1
      Top             =   120
      Width           =   2055
   End
   Begin MSCommLib.MSComm MSComm1 
      Left            =   2520
      Top             =   3360
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
      DTREnable       =   -1  'True
      BaudRate        =   19200
   End
   Begin VB.TextBox Text1 
      Height          =   3735
      Left            =   240
      MultiLine       =   -1  'True
      TabIndex        =   0
      Text            =   "lector.frx":0000
      Top             =   120
      Width           =   4455
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public num_canals As Integer

Private Sub Command1_Click()
' Enviar caracter que le dice al PIC que lea su memoria interna y la transmita a la
' PC via la interfaz RS232

' MUY IMPORTANTE: esta rutina debe estar de acuerdo con el Jal que esté grabado en el PIC,
' pues de él se depende enteramente ya que NO HAY MANERA de leer la EEPROM interna
' del PIC si no es a través de él mismo, o usando el programador de PIC.
' Es decir, el firmware del PIC debe ser tal que al recibir un caracter "a" por la interfaz 232,
' lea y transmita el contenido de la eeprom interna.
MSComm1.Output = "a"
End Sub

Private Sub Command2_Click()
Dim numero As Integer
Dim nombre_archivo_individual As String

nombre_archivo_individual = "c:\contenido_eeprom_interna.txt"

numero = FreeFile
Open nombre_archivo_individual For Output As #numero
Put #numero, , Text1.Text
Close #numero




End Sub

Private Sub Command3_Click()
Unload Me
End Sub

Private Sub Command4_Click()
form2.Show
End Sub

Private Sub Form_Load()
Text1 = ""
num_canals = 1

With MSComm1
        .RThreshold = 1
        .InputLen = 1
        ' debe coincidir con lo seteado en el firmware del PIC
        .Settings = "115200,N,8,1"
        .DTREnable = False
        ' Abrir COM1, ajustar de acuerdo al que se use realmente
        .CommPort = 1
        .PortOpen = True
End With
End Sub

Private Sub Form_Unload(Cancel As Integer)
MSComm1.PortOpen = False
End
End Sub

Private Sub MSComm1_OnComm()
Dim datos As String * 1
If MSComm1.CommEvent = comEvReceive Then
        datos = MSComm1.Input
End If
Text1.Text = Text1.Text & datos
End Sub

Private Sub Option1_Click()
num_canals = 1
End Sub

Private Sub Option2_Click()
num_canals = 2
End Sub

Private Sub Option3_Click()
num_canals = 3
End Sub

Private Sub Option4_Click()
num_canals = 4
End Sub

Private Sub Option5_Click()
num_canals = 5
End Sub

Private Sub Option6_Click()
num_canals = 6
End Sub
