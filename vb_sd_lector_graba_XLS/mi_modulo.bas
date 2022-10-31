Attribute VB_Name = "Module1"
Option Explicit

Public Function Convert4Bytes2Long(v0 As Byte, v1 As Byte, v2 As Byte, v3 As Byte) As Long
If v0 > 127 Then
 Convert4Bytes2Long = -(RGB(v3, v2, v1) + (v0 - 128) * 2 ^ 24)
Else
 Convert4Bytes2Long = (RGB(v3, v2, v1) + v0 * 2 ^ 24)
End If
End Function

