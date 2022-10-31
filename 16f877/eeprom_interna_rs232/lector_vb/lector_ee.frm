VERSION 5.00
Begin VB.Form form2 
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Lector  EEPROMs v4"
   ClientHeight    =   7155
   ClientLeft      =   1005
   ClientTop       =   1530
   ClientWidth     =   3735
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000008&
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   7155
   ScaleWidth      =   3735
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command1 
      Caption         =   "Detener Lectura"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   240
      TabIndex        =   11
      Top             =   3120
      Width           =   3255
   End
   Begin VB.TextBox Text3 
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2055
      Left            =   240
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   5
      Top             =   4200
      Width           =   3255
   End
   Begin VB.CommandButton Command9 
      Caption         =   "Detectar Presencia y tamaño EEPROMs, Guardar en Archivo General y Archivos Particulares"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   735
      Left            =   240
      TabIndex        =   0
      Top             =   1680
      Width           =   3255
   End
   Begin VB.CommandButton Command3 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      Cancel          =   -1  'True
      Caption         =   "&Esconder"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   615
      Left            =   720
      TabIndex        =   2
      Top             =   6360
      Width           =   2295
   End
   Begin VB.Label Label5 
      AutoSize        =   -1  'True
      Caption         =   "Archivos Particulares:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   240
      TabIndex        =   10
      Top             =   1080
      Width           =   1530
   End
   Begin VB.Label Label4 
      AutoSize        =   -1  'True
      Caption         =   "Archivo General:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   240
      TabIndex        =   9
      Top             =   480
      Width           =   1185
   End
   Begin VB.Label Label3 
      AutoSize        =   -1  'True
      Caption         =   "c:\archivo_individual_#_fecha_hora.txt"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   240
      TabIndex        =   8
      Top             =   1320
      Width           =   2790
   End
   Begin VB.Label Label2 
      AutoSize        =   -1  'True
      Caption         =   "c:\archivo_eeproms_completo_fecha_hora.txt"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   240
      TabIndex        =   7
      Top             =   720
      Width           =   3270
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Detección Presencia y Tamaño (0 = ausente):"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   120
      TabIndex        =   6
      Top             =   3960
      Width           =   3255
   End
   Begin VB.Label Label10 
      AutoSize        =   -1  'True
      Caption         =   "Los datos leídos se guardan en:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   240
      TabIndex        =   4
      Top             =   120
      Width           =   2280
   End
   Begin VB.Label Label7 
      AutoSize        =   -1  'True
      Caption         =   "Leyendo:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   240
      TabIndex        =   3
      Top             =   2640
      Width           =   660
   End
   Begin VB.Label Label6 
      Alignment       =   2  'Center
      BorderStyle     =   1  'Fixed Single
      Caption         =   "Label6"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   1080
      TabIndex        =   1
      Top             =   2640
      Width           =   2415
   End
End
Attribute VB_Name = "form2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Public LF As String

Public detener_lectura As Boolean

'Esta variable contendrá la dirección, dentro del banco, de cada una de las 8 eeproms, según la
'lista de constantes mostrada arriba.
Public indice1 As Byte

Private Sub Command1_Click()
detener_lectura = True
End Sub

Private Sub Command3_Click()
Me.Hide
End Sub

Private Sub Command9_Click()
Dim index1 As Integer, index2 As Integer, indice As Integer, otro_indice As Integer
Dim X As Integer, numero As Integer, otro_numero As Integer, respuesta As Integer
Dim msg As String
Dim valor As Byte
Dim dir_alta As Byte
Dim dir_baja As Byte
Dim canal As String

Dim tamanio_eeprom(8) As Integer
Dim pos As Long
Dim arreglo(10) As Byte

'El nombre del archivo único
Dim nombre_archivo_general As String

'El de los archivo separados por cada eeprom
Dim nombre_archivo_individual(8) As String

Dim nombre_archivo_solo As String

' IDs del bus I2C para las eeproms del banco
eeproms(0) = eeprom0
eeproms(1) = eeprom1
eeproms(2) = eeprom2
eeproms(3) = eeprom3
eeproms(4) = eeprom4
eeproms(5) = eeprom5
eeproms(6) = eeprom6
eeproms(7) = eeprom7

msg = "Asegúrese de haber conectado el banco de eeproms al programador, sino oprima No o Cancelar."
'respuesta = MsgBox(msg, vbYesNoCancel + vbExclamation, "Verificación")
If MsgBox(msg, vbYesNoCancel + vbExclamation, "Verificación") <> vbYes Then Exit Sub

' El código que sigue está basado en las rutinas de detección presencia y tamaño eeproms hechas en JAL.
' Las funciones existe_eeprom y es_tamanio están definidas en funciones.bas

' Recorrer las 8 posiciones, donde se encuentre una eeprom, determinar su tamaño y asignar valor
' equivalente (en múltiplos de 10, por los registros), al arreglo que contiene esos valores.
For indice = 0 To 7
    If existe_eeprom(eeproms(indice)) Then
        If es_tamanio(eeproms(indice), 4096) Then
            tamanio_eeprom(indice) = 4000
        Else
            If es_tamanio(eeproms(indice), 8192) Then
                tamanio_eeprom(indice) = 8000
            Else
                If es_tamanio(eeproms(indice), 16384) Then
                    tamanio_eeprom(indice) = 16000
                Else
                    If es_tamanio(eeproms(indice), 32768) Then
                        tamanio_eeprom(indice) = 32000
                    Else
                        tamanio_eeprom(indice) = 64000
                    End If
                End If
            End If
        End If
    End If
Next

For indice = 0 To 7
    If indice = 0 Then
        Text3 = "#" & Str$(indice) & " - " & Str$(tamanio_eeprom(indice))
    Else
        Text3 = Text3 & LF & "#" & Str$(indice) & " - " & Str$(tamanio_eeprom(indice))
    End If
Next indice

If MsgBox("¿Continuar con el proceso?", vbOKCancel + vbInformation, "Interrupción") = vbCancel Then Exit Sub

nombre_archivo_general = "c:\archivo_eeproms_completo.txt"

For indice = 0 To 7
    nombre_archivo_individual(indice) = "c:\archivo_individual_" & Str$(indice) & ".txt"
Next indice

numero = FreeFile

'Abrir archivo general
Open nombre_archivo_general For Output As #numero
'Recorrer las 8 posiciones posibles de existencia de eeproms...
For indice = 0 To 7
'    ' Si tamanio_eeprom es 0 no existe esa eeprom, no hacer nada en ese caso
    If tamanio_eeprom(indice) Then
        nombre_archivo_solo = nombre_archivo_individual(indice)
        'Abrir archivos individuales
        otro_numero = FreeFile
        Open nombre_archivo_individual(indice) For Output As #otro_numero
        Print #numero, "Contenido EEPROM #"; indice;
        Print #otro_numero, "Contenido EEPROM #"; indice;
        Print #otro_numero,
        Print #numero,
        For otro_indice = 0 To tamanio_eeprom(indice)
            dir_alta = CByte((otro_indice And 65280) / 256)
            dir_baja = CByte(otro_indice And 255)
            valor = leer_eeprom(eeproms(indice), dir_alta, dir_baja)
            arreglo(X) = valor
            'Mostrar en label cual posición se ha leído.
            Label6 = Str$(otro_indice) & " de eeprom #" & Str$(Trim(indice))
            DoEvents
            X = X + 1
            If X = 10 Then
                X = 0
                'El último byte puede valer entre 247 (canal analógico 0) y 254 (canal analógico 7)
                If arreglo(9) = 255 Then
                    canal = "nulo"
                Else
                    canal = Str$(Trim(arreglo(9) - 247))
                End If

                'dar formato y escribir al archivo
                Print #numero, Trim(arreglo(3)); "/";
                Print #numero, Trim(arreglo(4)); "/";
                Print #numero, Trim(arreglo(5)); " - ";
                Print #numero, Trim(arreglo(6)); ":";
                Print #numero, Trim(arreglo(7)); ":";
                Print #numero, Trim(arreglo(8)); " - ";
                Print #numero, Trim(arreglo(0));
                Print #numero, Trim(arreglo(1));
                Print #numero, Trim(arreglo(2)); "-";
                Print #numero, "Canal "; canal;
                Print #numero,

                Print #otro_numero, Trim(arreglo(3)); "/";
                Print #otro_numero, Trim(arreglo(4)); "/";
                Print #otro_numero, Trim(arreglo(5)); " - ";
                Print #otro_numero, Trim(arreglo(6)); ":";
                Print #otro_numero, Trim(arreglo(7)); ":";
                Print #otro_numero, Trim(arreglo(8)); " - ";
                Print #otro_numero, Trim(arreglo(0));
                Print #otro_numero, Trim(arreglo(1));
                Print #otro_numero, Trim(arreglo(2)); "-";
                Print #otro_numero, "Canal "; canal;
                Print #otro_numero,

                End If
                DoEvents
                If detener_lectura = True Then
                    Print #numero, "Lectura interrumpida a petición del usuario";
                    Print #numero,
                    Print #otro_numero, "Lectura interrumpida a petición del usuario";
                    Print #otro_numero,
                    Close #otro_numero
                    Close #numero
                    Exit Sub
                End If

        Next otro_indice
        'Escribir separador de grupos de datos de eeproms en el archivo general
        Print #numero, "----------------------------------------------------------------------------------------------------------------------------";
        Print #numero,
        'Cerrar archivo parcial
        Close #otro_numero
    End If
Next indice
''Cerrar archivo general
Close #numero

End Sub

Private Sub Form_Load()

hold = 0.001 ' No modificar este valor. Adaptar el que está en el sub DELAY (i2cvb.bas)
' Inicialización normal del driver I2C
I2Copen 0, 1  ' Abrir puerto &h378 (LPT1)
I2Cinit 10    ' Valor de timeout
ICEEdebugoff  ' Detener el debugger
Iceebreak = False ' Desctivar el Break On Error
ICeeTraceSize = 10 ' Sólo registrar 10 eventos
DoEvents

'Limpiar caja de texto
Text3 = ""
'Y rótulos...
Label6 = ""

'Retorno de carro para las cajas de texto
LF = Chr(13) & Chr(10)

'Habilitar mensajes de debugging
i2cdebug = 1

End Sub

Private Sub Form_Unload(Cancel As Integer)
' Dejar el puerto paralelo en una condición "normal"
I2Cclose
End
End Sub
