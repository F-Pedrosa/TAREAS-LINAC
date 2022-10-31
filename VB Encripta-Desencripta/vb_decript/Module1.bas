Attribute VB_Name = "Module1"
Option Explicit

Const Rounds = 32
Const Delta = &H9E3779B9

'* VB style shifts
Const shl4 = 16
Const shr5 = 32

'* copy the 16 key-bytes into this array
Dim k(15) As Byte

'* the 128-bit key (as 4 32-bit integers)
Dim Tk(3) As Long

'* data you want to encrypt/decrypt
Dim CryptBuffer() As Byte
Dim BufferPointer&, i&

'* scratch variables
Dim b1 As Byte, b2 As Byte, b3 As Byte, b4 As Byte
Dim w1&, w2&, w3&, w4&



Sub TEST()

    For i& = 0 To 15: k(i&) = i&: Next
    TEA_Key

    ReDim CryptBuffer(7) As Byte
    For i& = 0 To 7
        CryptBuffer(i&) = i&
    Next

    BufferPointer& = 0
    TEA_Encrypt (1)


Form1.Text1 = BufferPointer



    BufferPointer& = 0
    TEA_Decrypt (1)


Form1.Text1 = Form1.Text1 & BufferPointer


End Sub


'* encryption function
Sub TEA_Encrypt(Blocks&)

'* left and right half of Feistel block
Dim Xl As Long, Xr As Long, Sl As Long, Sr As Long

Dim sum As Long, x As Integer

For i& = 0 To Blocks& - 1

    '* Copy the plaintext bytes into 32-bit words
    w1& = CryptBuffer(BufferPointer& + 3)
    w2& = CryptBuffer(BufferPointer& + 2)
    w3& = CryptBuffer(BufferPointer& + 1)
    w4& = CryptBuffer(BufferPointer&)

    w2& = (w2& * &H100)
    w3& = (w3& * &H10000)
    w4& = (w4& * &H1000000)
    Xl = w1& Or w2& Or w3& Or w4&

    w1& = CryptBuffer(BufferPointer& + 7)
    w2& = CryptBuffer(BufferPointer& + 6)
    w3& = CryptBuffer(BufferPointer& + 5)
    w4& = CryptBuffer(BufferPointer& + 4)

    w2& = (w2& * &H100)
    w3& = (w3& * &H10000)
    w4& = (w4& * &H1000000)
    Xr = w1& Or w2& Or w3& Or w4&

    sum = 0

    For x = 1 To Rounds

        sum = (sum + Delta)

        ' correct for shr5 negative integers
        Sr = Xr And &HFFFFFFE0
        Sr = (Sr \ shr5) And &H7FFFFFF

        Xl = Xl + (((Xr * shl4) + Tk(0)) Xor (Xr + _
             sum) Xor (Sr + Tk(1)))

        Sl = Xl And &HFFFFFFE0
        Sl = (Sl \ shr5) And &H7FFFFFF

        Xr = Xr + (((Xl * shl4) + Tk(2)) Xor (Xl + _
             sum) Xor (Sl + Tk(3)))
    Next

    b1 = (Xl And &HFF)
    b2 = (Xl And &HFF00) \ 256
    b3 = (Xl And &HFF0000) \ 65536
    b4 = (Xl And &HFF000000) \ 16777216

    CryptBuffer(BufferPointer&) = b4
    CryptBuffer(BufferPointer& + 1) = b3
    CryptBuffer(BufferPointer& + 2) = b2
    CryptBuffer(BufferPointer& + 3) = b1

    b1 = (Xr And &HFF)
    b2 = (Xr And &HFF00) \ 256
    b3 = (Xr And &HFF0000) \ 65536
    b4 = (Xr And &HFF000000) \ 16777216

    CryptBuffer(BufferPointer& + 4) = b4
    CryptBuffer(BufferPointer& + 5) = b3
    CryptBuffer(BufferPointer& + 6) = b2
    CryptBuffer(BufferPointer& + 7) = b1

    '* 64-bit block
    BufferPointer& = BufferPointer& + 8

Next

End Sub


'* decryption function
Sub TEA_Decrypt(Blocks&)

'* left and right half of Feistel block
Dim Xl As Long, Xr As Long, Sl As Long, Sr As Long

Dim sum As Long, x As Integer

For i& = 0 To Blocks& - 1

    w1& = CryptBuffer(BufferPointer& + 3)
    w2& = CryptBuffer(BufferPointer& + 2)
    w3& = CryptBuffer(BufferPointer& + 1)
    w4& = CryptBuffer(BufferPointer&)

    w2& = (w2& * &H100)
    w3& = (w3& * &H10000)
    w4& = (w4& * &H1000000)
    Xl = w1& Or w2& Or w3& Or w4&

    w1& = CryptBuffer(BufferPointer& + 7)
    w2& = CryptBuffer(BufferPointer& + 6)
    w3& = CryptBuffer(BufferPointer& + 5)
    w4& = CryptBuffer(BufferPointer& + 4)

    w2& = (w2& * &H100)
    w3& = (w3& * &H10000)
    w4& = (w4& * &H1000000)
    Xr = w1& Or w2& Or w3& Or w4&

    'Note:  {Delta * 32 != &H6526b0d9}
    sum = (Delta * Rounds)

    For x = 1 To Rounds

        ' correct for shr5 negative integers
        Sl = Xl And &HFFFFFFE0
        Sl = (Sl \ shr5) And &H7FFFFFF

        Xr = Xr - (((Xl * shl4) + Tk(2)) Xor (Xl + _
             sum) Xor (Sl + Tk(3)))

        Sr = Xr And &HFFFFFFE0
        Sr = (Sr \ shr5) And &H7FFFFFF

        Xl = Xl - (((Xr * shl4) + Tk(0)) Xor (Xr + _
             sum) Xor (Sr + Tk(1)))

        sum = (sum - Delta)

    Next

    b1 = (Xl And &HFF)
    b2 = (Xl And &HFF00) \ 256
    b3 = (Xl And &HFF0000) \ 65536
    b4 = (Xl And &HFF000000) \ 16777216

    CryptBuffer(BufferPointer&) = b4
    CryptBuffer(BufferPointer& + 1) = b3
    CryptBuffer(BufferPointer& + 2) = b2
    CryptBuffer(BufferPointer& + 3) = b1

    b1 = (Xr And &HFF)
    b2 = (Xr And &HFF00) \ 256
    b3 = (Xr And &HFF0000) \ 65536
    b4 = (Xr And &HFF000000) \ 16777216

    CryptBuffer(BufferPointer& + 4) = b4
    CryptBuffer(BufferPointer& + 5) = b3
    CryptBuffer(BufferPointer& + 6) = b2
    CryptBuffer(BufferPointer& + 7) = b1

    BufferPointer& = BufferPointer& + 8

Next

End Sub


Sub TEA_Key()

    '* copy 128-bits of key
    w1& = k(3)
    w2& = k(2): w2& = (w2& * &H100)
    w3& = k(1): w3& = (w3& * &H10000)
    w4& = k(0): w4& = (w4& * &H1000000)
    Tk(0) = w1& Or w2& Or w3& Or w4&

    w1& = k(7)
    w2& = k(6): w2& = (w2& * &H100)
    w3& = k(5): w3& = (w3& * &H10000)
    w4& = k(4): w4& = (w4& * &H1000000)
    Tk(1) = w1& Or w2& Or w3& Or w4&

    w1& = k(11)
    w2& = k(10): w2& = (w2& * &H100)
    w3& = k(9): w3& = (w3& * &H10000)
    w4& = k(8): w4& = (w4& * &H1000000)
    Tk(2) = w1& Or w2& Or w3& Or w4&

    w1& = k(15)
    w2& = k(14): w2& = (w2& * &H100)
    w3& = k(13): w3& = (w3& * &H10000)
    w4& = k(12): w4& = (w4& * &H1000000)
    Tk(3) = w1& Or w2& Or w3& Or w4&

End Sub



