VERSION 5.00
Object = "{5E9E78A0-531B-11CF-91F6-C2863C385E30}#1.0#0"; "MSFLXGRD.OCX"
Begin VB.Form Form1 
   BackColor       =   &H8000000A&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Cargador de tabla(s)"
   ClientHeight    =   6945
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   11325
   FillColor       =   &H00C0C0C0&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   6945
   ScaleWidth      =   11325
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin MSFlexGridLib.MSFlexGrid MSFlexGrid1 
      Height          =   5055
      Left            =   4080
      TabIndex        =   15
      Top             =   240
      Width           =   4095
      _ExtentX        =   7223
      _ExtentY        =   8916
      _Version        =   393216
      Rows            =   22
      Cols            =   3
      FixedRows       =   0
      FixedCols       =   0
   End
   Begin VB.TextBox Text1 
      Height          =   2055
      Left            =   120
      MultiLine       =   -1  'True
      ScrollBars      =   2  'Vertical
      TabIndex        =   12
      Text            =   "cargador_eeprom_v2.frx":0000
      Top             =   4200
      Width           =   3495
   End
   Begin VB.Frame Frame1 
      Caption         =   "Selección Manual de EEPROM"
      Height          =   1455
      Left            =   120
      TabIndex        =   3
      Top             =   120
      Width           =   3495
      Begin VB.OptionButton Option8 
         Caption         =   "7"
         Height          =   495
         Left            =   2760
         TabIndex        =   11
         Top             =   840
         Width           =   495
      End
      Begin VB.OptionButton Option7 
         Caption         =   "6"
         Height          =   495
         Left            =   1920
         TabIndex        =   10
         Top             =   840
         Width           =   495
      End
      Begin VB.OptionButton Option6 
         Caption         =   "5"
         Height          =   495
         Left            =   1080
         TabIndex        =   9
         Top             =   840
         Width           =   495
      End
      Begin VB.OptionButton Option5 
         Caption         =   "4"
         Height          =   495
         Left            =   240
         TabIndex        =   8
         Top             =   840
         Width           =   495
      End
      Begin VB.OptionButton Option4 
         Caption         =   "3"
         Height          =   495
         Left            =   2760
         TabIndex        =   7
         Top             =   240
         Width           =   495
      End
      Begin VB.OptionButton Option3 
         Caption         =   "2"
         Height          =   495
         Left            =   1920
         TabIndex        =   6
         Top             =   240
         Width           =   495
      End
      Begin VB.OptionButton Option2 
         Caption         =   "1"
         Height          =   495
         Left            =   1080
         TabIndex        =   5
         Top             =   240
         Width           =   495
      End
      Begin VB.OptionButton Option1 
         Caption         =   "0"
         Height          =   495
         Left            =   240
         TabIndex        =   4
         Top             =   240
         Value           =   -1  'True
         Width           =   495
      End
   End
   Begin VB.CommandButton Command3 
      Caption         =   "&Borrar Todas las Presentes"
      Height          =   375
      Left            =   120
      TabIndex        =   2
      Top             =   2160
      Width           =   3495
   End
   Begin VB.CommandButton Command2 
      Caption         =   "&Cargar tabla en Seleccionada"
      Height          =   375
      Left            =   120
      TabIndex        =   1
      Top             =   1680
      Width           =   3495
   End
   Begin VB.CommandButton Command1 
      Cancel          =   -1  'True
      Caption         =   "&Terminar"
      Height          =   375
      Left            =   120
      TabIndex        =   0
      Top             =   6360
      Width           =   3495
   End
   Begin VB.Label Label2 
      Caption         =   "Detección Presencia y Tamaño (0 = ausente):"
      Height          =   255
      Left            =   120
      TabIndex        =   14
      Top             =   3840
      Width           =   3375
   End
   Begin VB.Label Label1 
      BorderStyle     =   1  'Fixed Single
      Height          =   255
      Left            =   120
      TabIndex        =   13
      Top             =   2640
      Width           =   3495
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public detener_borrado As Boolean
Private Sub Command1_Click()
Unload Me
End Sub

Private Sub Command2_Click()

' Variables usadas para el procesado del archivo de texto, para eliminar los caracteres no deseados (TABs) y guardar solamente los números de las 3 columnas de una fila
Dim una_linea As String
Dim var1 As String
Dim var2 As String
Dim var3 As String
Dim posicion_tab As Integer
Dim posicion_tab_2 As Integer

' Arreglo donde se guardarán los valores de las tablas leídos desde el archivo generado como TXT por Excel, para luego guardarlos en la eeprom
' Se armó un ejemplo de uso con 2 tablas ((3 columnas x 10 filas)  * 2 = 60 elementos)
Dim arreglo_tabla(60)

' Variables usadas para el acceso y escritura en la eeprom (la dirección y/o los valores pueden ser words JAL, pero a la eeprom hay que mandarle siempre bytes)
Dim byte_bajo As Byte
Dim byte_alto As Byte
Dim direccion As Integer
Dim dir_alta As Byte
Dim dir_baja As Byte
Dim indice As Integer    ' Usado para invocar al arreglo que contiene las constantes binarias que identifican a cada eeprom dentro del banco, declarado en el módulo FUNCIONES.BAS
Dim otro_indice As Long      ' para moverse dentro del arreglo de valores

'Variables para manejo del archivo TXT
Dim nombre As String
Dim numer As Long
' Variable usada para ayudar en la separación de los valores presentes en una línea del archivo de texto (que equivale a una fila).
Dim i As Integer



' Asegurarse que se quiere escribir la(s) tabla(s) en la eeprom seleccionada
If MsgBox("¿Está seguro?", vbExclamation + vbOKCancel, "Cargar Tablas") = vbCancel Then Exit Sub

' Lazo que determina cuántas eeproms hay presentes (de un posible total de 8 en una AME2), usando cosas del FUNCIONES.BAS
For indice = 0 To 7
    If cual_eeprom = eeproms(indice) Then Exit For
Next indice

'Si la eeprom seleccionada NO ha sido detectada en el arranque, poner un mensaje de error y salir del procedimiento.
If tamanio_eeprom(indice) = 0 Then
    MsgBox "Error!", vbExclamation, "No existe tal EEPROM en el banco"
    Exit Sub
End If

' Se asume que el archivo de texto que contiene la tabla (generado por Excel grabando como Texto MS-DOS) está en mismo directorio de la aplicación
nombre = App.Path & "\tabla_ejemplo.txt"

numer = FreeFile
' Abrir archivo que contiene la(s) tabla(s) a grabarse en la eeprom
Open nombre For Input As #numer


' Leer de a una línea (equivale a una fila) por vez, separando luego por los tabuladores (que separan los elementos) e ir armando el vector a grabar en la eeprom.
Do While Not EOF(numer)
        ' Leer una línea completa (fila) del archivo de texto
        Line Input #numer, una_linea
        ' Separar los valores presentes en la línea, descartar caracteres TAB y líneas vacías
        If una_linea <> "" Then
                posicion_tab = InStr(1, una_linea, Chr$(9))
                posicion_tab_2 = InStr(posicion_tab + 1, una_linea, Chr$(9))
                
                ' generalizando para más columnas en la fila...
                ' posicion_tab_3 = InStr(posicion_tab_2 + 1, una_linea, Chr$(9))
                ' posicion_tab_4 = InStr(posicion_tab_3 + 1, una_linea, Chr$(9))
                                
                ' Guardar en variables cada uno de los 3 elementos de la fila, separando los números dentro del string, basándose en las posiciones de los TAB.
                var1 = Mid(una_linea, 1, posicion_tab - 1)
                var2 = Mid(una_linea, posicion_tab + 1, posicion_tab_2 - 1 - posicion_tab)
                var3 = Right(una_linea, Len(una_linea) - posicion_tab_2)

                
                ' generalizando para más columnas en la fila...
                ' var3 = Mid(una_linea, posicion_tab + 1, posicion_tab_2 - 1 - posicion_tab)
                ' var4 = Mid(una_linea, posicion_tab_2 + 1, posicion_tab_3 - 1 - posicion_tab)
                ' var5 = Right(una_linea, Len(una_linea) - posicion_tab_3)
                
                
                ' Descartar tabuladores y dejar variables en el arreglo
                If var1 <> Chr$(9) Or var2 <> Chr$(9) Or var3 <> Chr$(9) Then
                        ' If var1 <> Chr$(9) Or var2 <> Chr$(9) Or var3 <> Chr$(9) Or var4 <> Chr$(9) Or var5 <> Chr$(9) Then
                        arreglo_tabla(i) = var1
                        i = i + 1
                        arreglo_tabla(i) = var2
                        i = i + 1
                        arreglo_tabla(i) = var3
                        i = i + 1
'                        arreglo_tabla(i) = var4
'                        i = i + 1
'                        arreglo_tabla(i) = var5
'                        i = i + 1
                End If
        End If
Loop

Close

' Grabar arreglo conteniendo tablas en la eeprom
direccion = 0
' barrer los 60 elementos
For otro_indice = 0 To 59
    ' Separar byes que forman la dirección (1 word)
    dir_alta = CByte((direccion And 65280) / 256)
    dir_baja = CByte(direccion And 255)
    ' Separar byes que forman el valor de cada elemento del arreglo (1 word)
    byte_alto = CByte((CInt(arreglo_tabla(otro_indice)) And 65280) / 256)
    byte_bajo = CByte((CInt(arreglo_tabla(otro_indice)) And 255))
    ' Enviar a eeprom de un byte a la vez
    Call escribir_eeprom(eeproms(indice), dir_alta, dir_baja, byte_alto)
    ' Después de cada escritura en la eeprom hay que incrementar la variable dirección para que apunte al siguiente byte al último escrito
    direccion = direccion + 1
    dir_alta = CByte((direccion And 65280) / 256)
    dir_baja = CByte(direccion And 255)
    Call escribir_eeprom(eeproms(indice), dir_alta, dir_baja, byte_bajo)
    direccion = direccion + 1
    DoEvents
    ' Mostrar avance del proceso
    Label1 = "Escribiendo " & Str$(otro_indice) & " de " & Str$(tamanio_eeprom(indice))
Next otro_indice


MsgBox "Terminado!", vbOKOnly, "Carga de tabla en EEPROM"

End Sub

Private Sub Command3_Click()
Dim indice As Integer
Dim otro_indice As Long
Dim dir_alta As Byte
Dim dir_baja As Byte

If MsgBox("¿Está seguro?", vbExclamation + vbOKCancel, "Borrar EEPROM") = vbCancel Then Exit Sub

For indice = 0 To 7
    If (tamanio_eeprom(indice)) Then
        'escribir 255s en las eeproms
        For otro_indice = 0 To tamanio_eeprom(indice)
            dir_alta = CByte((otro_indice And 65280) / 256)
            dir_baja = CByte(otro_indice And 255)
           Call escribir_eeprom(eeproms(indice), dir_alta, dir_baja, 255)
           DoEvents
           Label1 = "Borrando " & Str$(otro_indice) & " de " & Str$(tamanio_eeprom(indice)) & " " & " - #" & Str$(indice)
        Next otro_indice
    End If
    DoEvents
Next indice

End Sub


Private Sub Form_Load()

Dim msg As String
Dim respuesta As VbMsgBoxResult
Dim indice As Integer

Dim otro_msg As String

Dim LF As String

LF = Chr(13) & Chr(10)

Text1 = ""

'Para estar seguros de la condición del hardware
msg = "Asegúrese de haber conectado el banco de eeproms al programador, sino oprima No o Cancelar."
respuesta = MsgBox(msg, vbYesNoCancel + vbExclamation, "Verificación")
If (respuesta = vbNo Or respuesta = vbCancel) Then Unload Me

' IDs del bus I2C para las eeproms del banco
eeproms(0) = eeprom0
eeproms(1) = eeprom1
eeproms(2) = eeprom2
eeproms(3) = eeprom3
eeproms(4) = eeprom4
eeproms(5) = eeprom5
eeproms(6) = eeprom6
eeproms(7) = eeprom7

'Para que en el inicio la variable de dirección arranque apuntando a la primera
Direccion_I2C = eeproms(0)

hold = 0.001 ' do not adapt this value. Adapt the value in the sub DELAY

'Standard initialisation block for the driver
I2Copen 0, 1  ' open port &h378 (LPT1) with ICee enabled
I2Cinit 10    ' set a timeoutvalue
ICEEdebugon
Iceebreak = False ' turns off  Break On Error
ICeeTraceSize = 10 ' sets tracebuffer to 10 events
DoEvents


' El código que sigue está basado en las rutinas de detección presencia y tamaño eeproms hechas en JAL.
' Las funciones existe_eeprom y es_tamanio están definidas en uno de los módulos .BAS
' Recorrer las 8 posiciones, donde se encuentre una eeprom, determinar su tamaño y asignar valor
' al arreglo que contendrá dichos valores.
For indice = 0 To 7
    If existe_eeprom(eeproms(indice)) Then
        If es_tamanio(eeproms(indice), 4096) Then
            tamanio_eeprom(indice) = 4095
        Else
            If es_tamanio(eeproms(indice), 8192) Then
                tamanio_eeprom(indice) = 8191
            Else
                If es_tamanio(eeproms(indice), 16384) Then
                    tamanio_eeprom(indice) = 16383
                Else
                    If es_tamanio(eeproms(indice), 32768) Then
                        tamanio_eeprom(indice) = 32767
                    Else
                        tamanio_eeprom(indice) = 65535
                    End If
                End If
            End If
        End If
    End If
Next

For indice = 0 To 7
    If tamanio_eeprom(indice) <> 0 Then
        otro_msg = Str$(tamanio_eeprom(indice) + 1)
    Else
        otro_msg = "0"
    End If
    If indice = 0 Then
        Text1 = otro_msg & " Bytes"
    Else
        Text1 = Text1 & LF & otro_msg & " Bytes"
    End If
Next indice

cual_eeprom = eeproms(0)

End Sub

Private Sub Form_Unload(Cancel As Integer)
I2Cclose
End
End Sub

Private Sub Option1_Click()
cual_eeprom = eeproms(0)
End Sub

Private Sub Option2_Click()
cual_eeprom = eeproms(1)
End Sub

Private Sub Option3_Click()
cual_eeprom = eeproms(2)
End Sub

Private Sub Option4_Click()
cual_eeprom = eeproms(3)
End Sub

Private Sub Option5_Click()
cual_eeprom = eeproms(4)
End Sub

Private Sub Option6_Click()
cual_eeprom = eeproms(5)
End Sub

Private Sub Option7_Click()
cual_eeprom = eeproms(6)
End Sub

Private Sub Option8_Click()
cual_eeprom = eeproms(7)
End Sub


Private Sub Text1_DblClick()
Text1 = ""
mensaje_debug = ""
End Sub
