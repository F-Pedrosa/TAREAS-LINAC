VERSION 5.00
Begin VB.Form Form1 
   AutoRedraw      =   -1  'True
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Lectura de tramas y grabar como XLS"
   ClientHeight    =   5460
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   7605
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   5460
   ScaleWidth      =   7605
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame4 
      Caption         =   "Lectura tramas y grabado en archivo XLS"
      Height          =   4575
      Left            =   120
      TabIndex        =   1
      Top             =   0
      Width           =   7335
      Begin VB.CommandButton Command2 
         Caption         =   "Leer tramas y grabar a disco como XLS. "
         Height          =   855
         Left            =   960
         TabIndex        =   5
         Top             =   1800
         Width           =   2175
      End
      Begin VB.DriveListBox Drive1 
         Height          =   315
         Left            =   960
         TabIndex        =   4
         Top             =   840
         Width           =   2175
      End
      Begin VB.TextBox Text6 
         Height          =   375
         Left            =   6000
         TabIndex        =   3
         Top             =   840
         Width           =   852
      End
      Begin VB.TextBox Text5 
         Height          =   375
         Left            =   6000
         TabIndex        =   2
         Top             =   360
         Width           =   852
      End
      Begin VB.Label Label1 
         BorderStyle     =   1  'Fixed Single
         Height          =   255
         Left            =   960
         TabIndex        =   13
         Top             =   2880
         Width           =   2175
      End
      Begin VB.Label Label5 
         AutoSize        =   -1  'True
         Caption         =   "en los 3 últimos bytes del mismo. Usar HxD para ello."
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   120
         TabIndex        =   12
         Top             =   4080
         Width           =   4725
      End
      Begin VB.Label Label4 
         AutoSize        =   -1  'True
         Caption         =   "la tarjeta SD debe contar con el string FEP en el MBR"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   120
         TabIndex        =   11
         Top             =   3840
         Width           =   4740
      End
      Begin VB.Label Label3 
         AutoSize        =   -1  'True
         Caption         =   "Recordar que para evitar problemas de offsets en XP,"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   240
         Left            =   120
         TabIndex        =   10
         Top             =   3600
         Width           =   4800
      End
      Begin VB.Label Label2 
         Caption         =   "¡FIJARSE DE ELEGIR EL CORRECTO!"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   540
         Left            =   360
         TabIndex        =   9
         Top             =   1200
         Width           =   3975
      End
      Begin VB.Line Line1 
         X1              =   4560
         X2              =   4560
         Y1              =   240
         Y2              =   2520
      End
      Begin VB.Label Label9 
         Caption         =   "Seleccionar el drive donde está la tarjeta SD"
         Height          =   372
         Left            =   960
         TabIndex        =   8
         Top             =   360
         Width           =   2172
      End
      Begin VB.Label Label14 
         Caption         =   "Sector Final:"
         Height          =   372
         Left            =   4920
         TabIndex        =   7
         Top             =   960
         Width           =   972
      End
      Begin VB.Label Label13 
         Caption         =   "Sector Inicial:"
         Height          =   372
         Left            =   4920
         TabIndex        =   6
         Top             =   480
         Width           =   972
      End
   End
   Begin VB.CommandButton Command3 
      Cancel          =   -1  'True
      Caption         =   "Salir"
      Height          =   615
      Left            =   5880
      TabIndex        =   0
      Top             =   4680
      Width           =   1575
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public bandera_indice As Boolean
Dim lector_sd As String

Private Type LARGE_INTEGER
    lowpart As Long
    highpart As Long
End Type

Private Declare Sub Sleep Lib "KERNEL32" (ByVal dwMilliseconds As Long)
Private Const IOCTL_DISK_GET_LENGTH_INFO = &H7405C
Private Declare Function DeviceIoControl Lib "KERNEL32" (ByVal hdevice As Long, ByVal dwIoControlCode As Long, ByRef lpInBuffer As Any, ByVal nInBufferSize As Long, ByRef lpOutBuffer As Any, ByVal nOutBufferSize As Long, ByRef lpBytesReturned As Long, ByVal lpOverlapped As Long) As Long
Private Declare Sub CopyMemory Lib "KERNEL32" Alias "RtlMoveMemory" (Destination As Any, Source As Any, ByVal length As Long)
Private Declare Function GetDiskFreeSpaceEx Lib "KERNEL32" Alias "GetDiskFreeSpaceExA" (ByVal lpRootPathName As String, lpFreeBytesAvailableToCaller As LARGE_INTEGER, lpTotalNumberOfBytes As LARGE_INTEGER, lpTotalNumberOfFreeBytes As LARGE_INTEGER) As Long
Public Function insertar_caracter(sentrada As String, caracter As String, pos As Integer) As String
Dim string_izq As String
Dim string_der As String
Dim largo As Integer

largo = Len(sentrada)
'' NO agregar a final
If pos >= largo Then
        insertar_caracter = sentrada
        Exit Function
End If
string_izq = Left(sentrada, pos) 'separar la parte izquierda
string_der = Right(sentrada, largo - pos) 'y ahora la parte derecha
insertar_caracter = string_izq & caracter & string_der 'reconcatenar

End Function

Private Function CLargeInt(Lo As Long, Hi As Long) As Double
    'This function converts the LARGE_INTEGER data type to a double
    Dim dblLo As Double, dblHi As Double
   
    If Lo < 0 Then
        dblLo = 2 ^ 32 + Lo
    Else
        dblLo = Lo
    End If
   
    If Hi < 0 Then
        dblHi = 2 ^ 32 + Hi
    Else
        dblHi = Hi
    End If
    CLargeInt = dblLo + dblHi * 2 ^ 32
End Function
Public Function GetDiskSpace(sDrive As String) As String
Dim lResult As Long
Dim liAvailable As LARGE_INTEGER
Dim liTotal As LARGE_INTEGER
Dim liFree As LARGE_INTEGER
Dim dblAvailable As Double
Dim dblTotal As Double
Dim dblFree As Double
If Right(sDrive, 1) <> "" Then sDrive = sDrive & ""
'Determine the Available Space, Total Size and Free Space of a drive
lResult = GetDiskFreeSpaceEx(sDrive, liAvailable, liTotal, liFree)

'Convert the return values from LARGE_INTEGER to doubles
dblAvailable = CLargeInt(liAvailable.lowpart, liAvailable.highpart)
dblTotal = CLargeInt(liTotal.lowpart, liTotal.highpart)
dblFree = CLargeInt(liFree.lowpart, liFree.highpart)

'Display the results
GetDiskSpace = "Available Space on " & sDrive & ":  " & dblAvailable & " bytes (" & _
            Format(dblAvailable / 1024 ^ 3, "0.00") & " G) " & vbCr & _
            "Total Space on " & sDrive & ":      " & dblTotal & " bytes (" & _
            Format(dblTotal / 1024 ^ 3, "0.00") & " G) " & vbCr & _
            "Free Space on " & sDrive & ":       " & dblFree & " bytes (" & _
            Format(dblFree / 1024 ^ 3, "0.00") & " G) " & "   " & (dblTotal / 512) & " sectores"

End Function
Public Function ByteArrayToString(bytArray() As Byte) As String
Dim sAns As String
Dim iPos As String

sAns = StrConv(bytArray, vbUnicode)
iPos = InStr(sAns, Chr(0))
If iPos > 0 Then sAns = Left(sAns, iPos - 1)
ByteArrayToString = sAns

End Function
Public Function LongToByteArray(ByVal lng As Long) As Byte()

Dim ByteArray(0 To 3) As Byte
CopyMemory ByteArray(0), ByVal VarPtr(lng), Len(lng)
LongToByteArray = ByteArray

End Function

Private Sub Command2_Click()
Dim sector_inicial As Long
Dim sector_final As Long
Dim buffer As String
Dim buffer1() As Byte
Dim sector As Long
Dim resultado As VbMsgBoxResult
Dim indice As Long

Dim cadena As String
Dim fila As Long
Dim columna As Long

fila = 1
columna = 1

resultado = MsgBox("¿Está seguro de haber elegido el DISCO y sectores correctos? Si no, oprima Cancelar", vbOKCancel)
If resultado <> vbOK Then
        Exit Sub
End If
Label1 = "Grabando..."

DoEvents

' cargar valores iniciales, si fuese necesario (para pruebas, por ej)
sector_inicial = CLng(Text5.Text)
sector_final = CLng(Text6.Text)

' Generar archivo tipo XLS
Dim ArchivoExcel As New ExcelFile
Dim FileName As String
FileName$ = ".\mi_planilla.xls"  'crear planilla en el directorio actual
' Armar el encabezado de la planilla
With ArchivoExcel
    .CreateFile FileName$
    'specify whether to print the gridlines or not
    'this should come before the setting of fonts and margins
    .PrintGridLines = False
    'it is a good idea to set margins, fonts and column widths
    'prior to writing any text/numerics to the spreadsheet. These
    'should come before setting the fonts.
    .SetMargin xlsTopMargin, 1.5   'set to 1.5 inches
    .SetMargin xlsLeftMargin, 1.5
    .SetMargin xlsRightMargin, 1.5
    .SetMargin xlsBottomMargin, 1.5
    'set a default row height for the entire spreadsheet (1/20th of a point)
    .SetDefaultRowHeight 14
    'Up to 4 fonts can be specified for the spreadsheet. This is a
    'limitation of the Excel 2.1 format. For each value written to the
    'spreadsheet you can specify which font to use.
    .SetFont "Arial", 10, xlsNoFormat              'font0
    .SetFont "Arial", 10, xlsBold                  'font1
    .SetFont "Arial", 10, xlsBold + xlsUnderline   'font2
    .SetFont "Courier", 16, xlsBold + xlsItalic    'font3
    'Column widths are specified in Excel as 1/256th of a character.
    .SetColumnWidth 1, 5, 18
    'Set special row heights for row 1 and 2
    .SetRowHeight 1, 30
    .SetRowHeight 2, 30
    ' Poner texto inicial
    .WriteValue xlsText, xlsFont0, xlsLeftAlign, xlsNormal, fila, 1, "TRAMAS LEIDAS DESDE LA SD"
    fila = fila + 1
    ' Poner encabezados de columnas
    .WriteValue xlsText, xlsFont0, xlsLeftAlign, xlsNormal, fila, 1, "INDICE"
    .WriteValue xlsText, xlsFont0, xlsLeftAlign, xlsNormal, fila, 2, "FECHA"
    .WriteValue xlsText, xlsFont0, xlsLeftAlign, xlsNormal, fila, 3, "HORA"
    .WriteValue xlsText, xlsFont0, xlsLeftAlign, xlsNormal, fila, 4, "VALOR1"
    .WriteValue xlsText, xlsFont0, xlsLeftAlign, xlsNormal, fila, 5, "VALOR2"
    .WriteValue xlsText, xlsFont0, xlsLeftAlign, xlsNormal, fila, 6, "VALOR3"
End With
fila = fila + 1         ' Pasar a la siguiente fila

' leer un sector a la vez (512 bytes), con acceso de bajo nivel, empezando por el sector definido como inicial
sector = sector_inicial
buffer1 = DirectReadDrive(lector_sd, sector, 0, 512)         ' leer el sector propiamente dicho
Do While sector <= sector_final

        buffer1 = DirectReadDrive(lector_sd, sector, 0, 512)         ' leer el sector propiamente dicho
        ' en los primeros 4 bytes está el índice, que sería como un dword del JAL
        indice = Convert4Bytes2Long(buffer1(0), buffer1(1), buffer1(2), buffer1(3))
        
        ' Escribir la fila de datos a la planilla XLS
        With ArchivoExcel
            ' Indice
            .WriteValue xlsinteger, xlsFont0, xlsLeftAlign, xlsNormal, fila, columna, indice, 3
            columna = columna + 1       ' A la siguiente columna
            ' Fecha
            cadena = Format(buffer1(4), "00") & "/" & Format(buffer1(5), "00") & "/" & Format(buffer1(6), "00")
            .WriteValue xlsText, xlsFont0, xlsCentreAlign, xlsNormal, fila, columna, cadena
            columna = columna + 1       ' A la siguiente columna
            ' Hora
            cadena = Format(buffer1(7), "00") & ":" & Format(buffer1(8), "00") & ":" & Format(buffer1(9), "00")
            .WriteValue xlsText, xlsFont0, xlsCentreAlign, xlsNormal, fila, columna, cadena
            columna = columna + 1       ' A la siguiente columna
            ' 3 valores (por ejemplo, de 3 sensores)
            .WriteValue xlsinteger, xlsFont0, xlsLeftAlign, xlsNormal, fila, columna, buffer1(10), 3
            columna = columna + 1       ' A la siguiente columna
            .WriteValue xlsinteger, xlsFont0, xlsLeftAlign, xlsNormal, fila, columna, buffer1(11), 3
            columna = columna + 1       ' A la siguiente columna
            .WriteValue xlsinteger, xlsFont0, xlsLeftAlign, xlsNormal, fila, columna, buffer1(12), 3
            columna = 1                 ' volver a la columna de inicio
        End With
       
        ' pasar al siguiente sector de la SD
        sector = sector + 1
        buffer = ""             ' limpiar variable
        fila = fila + 1         ' Apuntar a la siguiente fila desde ya
Loop

ArchivoExcel.CloseFile  ' Cerrar archivo XLS
resultado = MsgBox("Archivo XLS grabados", vbCritical)
Label1 = vbNullString

End Sub

Private Sub Command3_Click()
Unload Me
End Sub

Private Sub Drive1_Change()

lector_sd = Drive1.Drive

End Sub
Private Sub Form_Load()

' Las SD usan sectores físicos de 512 bytes
BytesPerSector = 512

' Valores de las pruebas
Text5 = "2"      ' el firmware empieza a escribir desde este sector
Text6 = "5"      ' valor sin mayor significado, adecuarlo a la prueba?


ChDir App.Path

End Sub
Private Sub Form_Unload(Cancel As Integer)
End
End Sub


