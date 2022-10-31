; compiler: jal jalv24q2 (compiled Jan 23 2014)

; command line:  C:\ARCHIV~1\JALv2\Compiler\JALv2.exe E:\Documents and Settings\fabian\Escritorio\data_sobre_12vdc\ame_y_me\esclavo_me_contesta_ame.jal -s E:\Documents and Settings\fabian\Escritorio\data_sobre_12vdc\ame_y_me\;C:\ARCHIV~1\JALv2\LIBRAR~1 -no-variable-reuse
                                list p=18f4620, r=dec
                                errorlevel -306 ; no page boundary warnings
                                errorlevel -302 ; no bank 0 warnings
                                errorlevel -202 ; no 'argument out of range' warnings

                             __config 0x00300000, 0x00
                             __config 0x00300001, 0x02
                             __config 0x00300002, 0x18
                             __config 0x00300003, 0x1e
                             __config 0x00300004, 0x00
                             __config 0x00300005, 0x03
                             __config 0x00300006, 0x81
                             __config 0x00300007, 0x00
                             __config 0x00300008, 0x0f
                             __config 0x00300009, 0xc0
                             __config 0x0030000a, 0x0f
                             __config 0x0030000b, 0xe0
                             __config 0x0030000c, 0x0f
                             __config 0x0030000d, 0x40
v_true                         EQU 1
v_false                        EQU 0
v_on                           EQU 1
v_off                          EQU 0
v_input                        EQU 1
v_output                       EQU 0
v_portb                        EQU 0x0f81  ; portb
v_pin_b6                       EQU 0x0f81  ; pin_b6-->portb:6
v_latc                         EQU 0x0f8b  ; latc
v_trisb                        EQU 0x0f93  ; trisb
v_pin_b6_direction             EQU 0x0f93  ; pin_b6_direction-->trisb:6
v_trisc                        EQU 0x0f94  ; trisc
v_pin_c1_direction             EQU 0x0f94  ; pin_c1_direction-->trisc:1
v_pin_c6_direction             EQU 0x0f94  ; pin_c6_direction-->trisc:6
v_osctune                      EQU 0x0f9b  ; osctune
v_osctune_pllen                EQU 0x0f9b  ; osctune_pllen-->osctune:6
v_cmcon                        EQU 0x0fb4  ; cmcon
v_adcon2                       EQU 0x0fc0  ; adcon2
v_adcon1                       EQU 0x0fc1  ; adcon1
v_adcon0                       EQU 0x0fc2  ; adcon0
v_wdtcon                       EQU 0x0fd1  ; wdtcon
v_wdtcon_swdten                EQU 0x0fd1  ; wdtcon_swdten-->wdtcon:0
v_osccon                       EQU 0x0fd3  ; osccon
v__status                      EQU 0x0fd8  ; _status
v__c                           EQU 0
v__z                           EQU 2
v__banked                      EQU 1
v__access                      EQU 0
v__fsr0l                       EQU 0x0fe9  ; _fsr0l
v__ind                         EQU 0x0fef  ; _ind
v_contador                     EQU 0x0008  ; contador
v_byte_entrante                EQU 0x0009  ; byte_entrante
v_finalizado                   EQU 0x0014  ; finalizado-->_bitbucket:0
v_indice                       EQU 0x000a  ; indice
v_arreglo_entrante             EQU 0x000b  ; arreglo_entrante
v____temp_42                   EQU 0x0013  ; _temp
v__bitbucket                   EQU 0x0014  ; _bitbucket
v__pic_temp                    EQU 0x0004  ; _pic_temp-->_pic_state
v__pic_state                   EQU 0x0004  ; _pic_state
v___x_120                      EQU 0x0f8b  ; x-->latc:1
v___x_121                      EQU 0x0f8b  ; x-->latc:6
v___x_122                      EQU 0x0f8b  ; x-->latc:1
v___x_123                      EQU 0x0f8b  ; x-->latc:6
v__btemp16                     EQU 0x0014  ; _btemp16-->_bitbucket:2
v__btemp17                     EQU 0x0014  ; _btemp17-->_bitbucket:3
v__btemp18                     EQU 0x0014  ; _btemp18-->_bitbucket:4
v__btemp19                     EQU 0x0014  ; _btemp19-->_bitbucket:5
v__btemp20                     EQU 0x0014  ; _btemp20-->_bitbucket:6
v__btemp21                     EQU 0x0014  ; _btemp21-->_bitbucket:7
v__btemp22                     EQU 0x0014  ; _btemp22-->_bitbucket:8
v__btemp23                     EQU 0x0014  ; _btemp23-->_bitbucket:9
v__btemp24                     EQU 0x0014  ; _btemp24-->_bitbucket:10
v___x_124                      EQU 0x0f8b  ; x-->latc:6
v___x_125                      EQU 0x0f8b  ; x-->latc:6
v___holder_1                   EQU 0x0016  ; armar_byte:holder
v_bit0                         EQU 0x0016  ; armar_byte:bit0-->holder1:0
v_bit1                         EQU 0x0016  ; armar_byte:bit1-->holder1:1
v_bit2                         EQU 0x0016  ; armar_byte:bit2-->holder1:2
v_bit3                         EQU 0x0016  ; armar_byte:bit3-->holder1:3
v_bit4                         EQU 0x0016  ; armar_byte:bit4-->holder1:4
v_bit5                         EQU 0x0016  ; armar_byte:bit5-->holder1:5
v_bit6                         EQU 0x0016  ; armar_byte:bit6-->holder1:6
v_bit7                         EQU 0x0016  ; armar_byte:bit7-->holder1:7
v___n_5                        EQU 0x0017  ; delay_100ms:n
v__floop5                      EQU 0x0019  ; delay_100ms:_floop5
v__floop6                      EQU 0x001b  ; delay_100ms:_floop6
v___n_3                        EQU 0x001d  ; delay_1ms:n
v__floop3                      EQU 0x001f  ; delay_1ms:_floop3
v__floop4                      EQU 0x0021  ; delay_1ms:_floop4
v___n_1                        EQU 0x0023  ; delay_10us:n
v__floop1                      EQU 0x0024  ; delay_10us:_floop1
v__floop2                      EQU 0x0025  ; delay_10us:_floop2
;    2 include 18f4620
                               org      0
l__main
;   16 WDTCON_SWDTEN = OFF                 ; disable WDT
                               bcf      v_wdtcon, 0,v__access ; wdtcon_swdten
;   17 OSCCON_SCS = 0                      ; select primary oscillator
                               movlw    252
                               andwf    v_osccon,f,v__access
;   18 OSCTUNE_PLLEN = FALSE               ; no PLL
                               bcf      v_osctune, 6,v__access ; osctune_pllen
;   20 enable_digital_io()                   ; todos los pines como I/O digitales en el arranque
; 18f4620.jal
; 1530    ADCON0 = 0b0000_0000
                               clrf     v_adcon0,v__access
; 1531    ADCON1 = 0b0000_1111
                               movlw    15
                               movwf    v_adcon1,v__access
; 1532    ADCON2 = 0b0000_0000
                               clrf     v_adcon2,v__access
; E:\Documents and Settings\fabian\Escritorio\data_sobre_12vdc\ame_y_me\esclavo_me_contesta_ame.jal
;   20 enable_digital_io()                   ; todos los pines como I/O digitales en el arranque
; 18f4620.jal
; 1546    adc_off()
; E:\Documents and Settings\fabian\Escritorio\data_sobre_12vdc\ame_y_me\esclavo_me_contesta_ame.jal
;   20 enable_digital_io()                   ; todos los pines como I/O digitales en el arranque
; 18f4620.jal
; 1539    CMCON  = 0b0000_0111
                               movlw    7
                               movwf    v_cmcon,v__access
; E:\Documents and Settings\fabian\Escritorio\data_sobre_12vdc\ame_y_me\esclavo_me_contesta_ame.jal
;   20 enable_digital_io()                   ; todos los pines como I/O digitales en el arranque
; 18f4620.jal
; 1547    comparator_off()
; E:\Documents and Settings\fabian\Escritorio\data_sobre_12vdc\ame_y_me\esclavo_me_contesta_ame.jal
;   20 enable_digital_io()                   ; todos los pines como I/O digitales en el arranque
; delay.jal
;   26 procedure delay_1us() is
                               goto     l__l216
;   83 procedure delay_10us(byte in n) is
l_delay_10us
                               movwf    v___n_1,v__access
;   84    if n==0 then
                               movf     v___n_1,w,v__access
                               btfsc    v__status, v__z,v__access
;   85       return
                               return   
;   86    elsif n==1 then
l__l193
                               decf     v___n_1,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l194
;   89        _usec_delay(_ten_us_delay1)
                               movlb    0
                               movlw    10
                               movwf    v__pic_temp,v__access
l__l282
                               decfsz   v__pic_temp,f,v__access
                               goto     l__l282
                               nop      
                               nop      
;   90      end if
                               return   
;   91    else     
l__l194
;   92       n = n - 1;
                               decf     v___n_1,f,v__access
;   95          _usec_delay(_ten_us_delay2)   
                               movlb    0
                               movlw    7
                               movwf    v__pic_temp,v__access
l__l283
                               decfsz   v__pic_temp,f,v__access
                               goto     l__l283
                               nop      
;  101       for n loop
                               movf     v___n_1,w,v__access
                               movwf    v__floop1,v__access
                               clrf     v__floop2,v__access
                               goto     l__l200
l__l199
;  103             _usec_delay(_ten_us_delay3)
                               movlb    0
                               movlw    14
                               movwf    v__pic_temp,v__access
l__l284
                               decfsz   v__pic_temp,f,v__access
                               goto     l__l284
;  107       end loop
                               incf     v__floop2,f,v__access
l__l200
                               movf     v__floop2,w,v__access
                               subwf    v__floop1,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l199
;  108    end if
l__l192
;  110 end procedure
l__l191
                               return   
;  113 procedure delay_1ms(word in n) is
l_delay_1ms
;  115    for n loop
                               movf     v___n_3,w,v__access
                               movwf    v__floop3,v__access
                               movf     v___n_3+1,w,v__access
                               movwf    v__floop3+1,v__access
                               clrf     v__floop4,v__access
                               clrf     v__floop4+1,v__access
                               goto     l__l207
l__l206
;  117          _usec_delay(_one_ms_delay)
                               movlb    0
                               movlw    9
                               movwf    v__pic_temp,v__access
l__l285
                               movlw    183
                               movwf    v__pic_temp+1,v__access
l__l286
                               decfsz   v__pic_temp+1,f,v__access
                               goto     l__l286
                               decfsz   v__pic_temp,f,v__access
                               goto     l__l285
                               nop      
;  121    end loop
                               incf     v__floop4,f,v__access
                               btfsc    v__status, v__z,v__access
                               incf     v__floop4+1,f,v__access
l__l207
                               movf     v__floop4,w,v__access
                               subwf    v__floop3,w,v__access
                               movwf    v__pic_temp,v__access
                               movf     v__floop4+1,w,v__access
                               subwf    v__floop3+1,w,v__access
                               iorwf    v__pic_temp,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l206
;  122 end procedure
                               return   
;  125 procedure delay_100ms(word in n) is
l_delay_100ms
;  127    for n loop
                               movf     v___n_5,w,v__access
                               movwf    v__floop5,v__access
                               movf     v___n_5+1,w,v__access
                               movwf    v__floop5+1,v__access
                               clrf     v__floop6,v__access
                               clrf     v__floop6+1,v__access
                               goto     l__l214
l__l213
;  128       _usec_delay(_100_ms_delay)
                               movlb    0
                               movlw    17
                               movwf    v__pic_temp,v__access
l__l287
                               movlw    87
                               movwf    v__pic_temp+1,v__access
l__l288
                               movlw    111
                               movwf    v__pic_temp+2,v__access
l__l289
                               decfsz   v__pic_temp+2,f,v__access
                               goto     l__l289
                               decfsz   v__pic_temp+1,f,v__access
                               goto     l__l288
                               decfsz   v__pic_temp,f,v__access
                               goto     l__l287
;  129    end loop
                               incf     v__floop6,f,v__access
                               btfsc    v__status, v__z,v__access
                               incf     v__floop6+1,f,v__access
l__l214
                               movf     v__floop6,w,v__access
                               subwf    v__floop5,w,v__access
                               movwf    v__pic_temp,v__access
                               movf     v__floop6+1,w,v__access
                               subwf    v__floop5+1,w,v__access
                               iorwf    v__pic_temp,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l213
;  130 end procedure
                               return   
;  138 end procedure
l__l216
; E:\Documents and Settings\fabian\Escritorio\data_sobre_12vdc\ame_y_me\esclavo_me_contesta_ame.jal
;   25 pin_b6_direction = input
                               bsf      v_trisb, 6,v__access ; pin_b6_direction
;   28 pin_c6_direction = output
                               bcf      v_trisc, 6,v__access ; pin_c6_direction
;   31 pin_c1_direction = output
                               bcf      v_trisc, 1,v__access ; pin_c1_direction
;   33 var byte contador = 0
                               clrf     v_contador,v__access
;   34 var byte byte_entrante = 0
                               clrf     v_byte_entrante,v__access
;   35 var bit finalizado = false
                               bcf      v__bitbucket, 0,v__access ; finalizado
;   36 var byte indice = 7
                               movlw    7
                               movwf    v_indice,v__access
;   43 var byte arreglo_entrante[8] = {0,0,0,0,0,0,0,0}
                               clrf     v_arreglo_entrante,v__access
                               clrf     v_arreglo_entrante+1,v__access
                               clrf     v_arreglo_entrante+2,v__access
                               clrf     v_arreglo_entrante+3,v__access
                               clrf     v_arreglo_entrante+4,v__access
                               clrf     v_arreglo_entrante+5,v__access
                               clrf     v_arreglo_entrante+6,v__access
                               clrf     v_arreglo_entrante+7,v__access
;   49 procedure bin2digits( byte out dig2, byte out dig1, byte out dig0, byte in numero ) is
                               goto     l__l223
;   63 procedure armar_byte(byte out holder) is
l_armar_byte
;   74    if arreglo_entrante[7] == 1 then
                               decf     v_arreglo_entrante+7,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l226
;   75       bit0 = true
                               bsf      v___holder_1, 0,v__access ; bit0
;   76    else
                               goto     l__l225
l__l226
;   77       bit0 = false
                               bcf      v___holder_1, 0,v__access ; bit0
;   78    end if
l__l225
;   79    if arreglo_entrante[6] == 1 then
                               decf     v_arreglo_entrante+6,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l228
;   80       bit1 = true
                               bsf      v___holder_1, 1,v__access ; bit1
;   81    else
                               goto     l__l227
l__l228
;   82       bit1 = false
                               bcf      v___holder_1, 1,v__access ; bit1
;   83    end if
l__l227
;   84    if arreglo_entrante[5] == 1 then
                               decf     v_arreglo_entrante+5,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l230
;   85       bit2 = true
                               bsf      v___holder_1, 2,v__access ; bit2
;   86    else
                               goto     l__l229
l__l230
;   87       bit2 = false
                               bcf      v___holder_1, 2,v__access ; bit2
;   88    end if
l__l229
;   89    if arreglo_entrante[4] == 1 then
                               decf     v_arreglo_entrante+4,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l232
;   90       bit3 = true
                               bsf      v___holder_1, 3,v__access ; bit3
;   91    else
                               goto     l__l231
l__l232
;   92       bit3 = false
                               bcf      v___holder_1, 3,v__access ; bit3
;   93    end if
l__l231
;   94    if arreglo_entrante[3] == 1 then
                               decf     v_arreglo_entrante+3,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l234
;   95       bit4 = true
                               bsf      v___holder_1, 4,v__access ; bit4
;   96    else
                               goto     l__l233
l__l234
;   97       bit4 = false
                               bcf      v___holder_1, 4,v__access ; bit4
;   98    end if
l__l233
;   99    if arreglo_entrante[2] == 1 then
                               decf     v_arreglo_entrante+2,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l236
;  100       bit5 = true
                               bsf      v___holder_1, 5,v__access ; bit5
;  101    else
                               goto     l__l235
l__l236
;  102       bit5 = false
                               bcf      v___holder_1, 5,v__access ; bit5
;  103    end if
l__l235
;  104    if arreglo_entrante[1] == 1 then
                               decf     v_arreglo_entrante+1,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l238
;  105       bit6 = true
                               bsf      v___holder_1, 6,v__access ; bit6
;  106    else
                               goto     l__l237
l__l238
;  107       bit6 = false
                               bcf      v___holder_1, 6,v__access ; bit6
;  108    end if
l__l237
;  109    if arreglo_entrante[0] == 1 then
                               decf     v_arreglo_entrante,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l240
;  110       bit7 = true
                               bsf      v___holder_1, 7,v__access ; bit7
;  111    else
                               goto     l__l239
l__l240
;  112       bit7 = false
                               bcf      v___holder_1, 7,v__access ; bit7
;  113    end if
l__l239
;  114 end procedure
                               movf     v___holder_1,w,v__access
                               return   
l__l223
;  118 led_rojo = on
                               bsf      v_latc, 1,v__access ; x120
;  119 zumbador = on
                               bsf      v_latc, 6,v__access ; x121
;  120 delay_100ms(1)
                               movlw    1
                               movwf    v___n_5,v__access
                               clrf     v___n_5+1,v__access
                               call     l_delay_100ms
;  121 led_rojo = off
                               bcf      v_latc, 1,v__access ; x122
;  122 zumbador = off
                               bcf      v_latc, 6,v__access ; x123
;  124 indice = 0
                               clrf     v_indice,v__access
;  126 forever loop
l__l245
;  129    if pin_datos == true then
                               btfss    v_portb, 6,v__access ; pin_b6
                               goto     l__l248
;  131      while pin_datos loop
l__l249
                               btfss    v_portb, 6,v__access ; pin_b6
                               goto     l__l250
;  133          delay_10us(10)
                               movlw    10
                               call     l_delay_10us
;  134          contador = contador + 1
                               incf     v_contador,f,v__access
;  135      end loop
                               goto     l__l249
l__l250
;  136      if ( contador >= 5 ) & ( contador <= 35 ) then
                               movlw    5
                               subwf    v_contador,w,v__access
                               bcf      v__bitbucket, 2,v__access ; _btemp16
                               btfss    v__status, v__z,v__access
                               btfsc    v__status, v__c,v__access
                               bsf      v__bitbucket, 2,v__access ; _btemp16
                               movlw    35
                               subwf    v_contador,w,v__access
                               bcf      v__bitbucket, 3,v__access ; _btemp17
                               btfss    v__status, v__z,v__access
                               btfss    v__status, v__c,v__access
                               bsf      v__bitbucket, 3,v__access ; _btemp17
                               bsf      v__bitbucket, 4,v__access ; _btemp18
                               btfsc    v__bitbucket, 2,v__access ; _btemp16
                               btfss    v__bitbucket, 3,v__access ; _btemp17
                               bcf      v__bitbucket, 4,v__access ; _btemp18
                               btfss    v__bitbucket, 4,v__access ; _btemp18
                               goto     l__l253
;  138         contador = 0
                               clrf     v_contador,v__access
;  140         arreglo_entrante[indice] = 1
                               lfsr     0,v_arreglo_entrante
                               movf     v_indice,w,v__access
                               addwf    v__fsr0l,f,v__access
                               movlw    1
                               movwf    v__ind,v__access
;  141         indice = indice + 1
                               incf     v_indice,f,v__access
;  142      elsif ( contador >= 30 ) & ( contador <= 50 ) then
                               goto     l__l247
l__l253
                               movlw    30
                               subwf    v_contador,w,v__access
                               bcf      v__bitbucket, 5,v__access ; _btemp19
                               btfss    v__status, v__z,v__access
                               btfsc    v__status, v__c,v__access
                               bsf      v__bitbucket, 5,v__access ; _btemp19
                               movlw    50
                               subwf    v_contador,w,v__access
                               bcf      v__bitbucket, 6,v__access ; _btemp20
                               btfss    v__status, v__z,v__access
                               btfss    v__status, v__c,v__access
                               bsf      v__bitbucket, 6,v__access ; _btemp20
                               bsf      v__bitbucket, 7,v__access ; _btemp21
                               btfsc    v__bitbucket, 5,v__access ; _btemp19
                               btfss    v__bitbucket, 6,v__access ; _btemp20
                               bcf      v__bitbucket, 7,v__access ; _btemp21
                               btfss    v__bitbucket, 7,v__access ; _btemp21
                               goto     l__l254
;  144         contador = 0
                               clrf     v_contador,v__access
;  146         arreglo_entrante[indice] = 0
                               lfsr     0,v_arreglo_entrante
                               movf     v_indice,w,v__access
                               addwf    v__fsr0l,f,v__access
                               clrf     v__ind,v__access
;  147         indice = indice + 1
                               incf     v_indice,f,v__access
;  148      elsif ( contador >= 65 ) & ( contador <= 110 ) then
                               goto     l__l252
l__l254
                               movlw    65
                               subwf    v_contador,w,v__access
                               bcf      v__bitbucket+1, 0,v__access ; _btemp22
                               btfss    v__status, v__z,v__access
                               btfsc    v__status, v__c,v__access
                               bsf      v__bitbucket+1, 0,v__access ; _btemp22
                               movlw    110
                               subwf    v_contador,w,v__access
                               bcf      v__bitbucket+1, 1,v__access ; _btemp23
                               btfss    v__status, v__z,v__access
                               btfss    v__status, v__c,v__access
                               bsf      v__bitbucket+1, 1,v__access ; _btemp23
                               bsf      v__bitbucket+1, 2,v__access ; _btemp24
                               btfsc    v__bitbucket+1, 0,v__access ; _btemp22
                               btfss    v__bitbucket+1, 1,v__access ; _btemp23
                               bcf      v__bitbucket+1, 2,v__access ; _btemp24
                               btfss    v__bitbucket+1, 2,v__access ; _btemp24
                               goto     l__l255
;  150         contador = 0
                               clrf     v_contador,v__access
;  151         finalizado = true
                               bsf      v__bitbucket, 0,v__access ; finalizado
;  152         indice = 0
                               clrf     v_indice,v__access
;  153      else
                               goto     l__l252
l__l255
;  154         contador = 0
                               clrf     v_contador,v__access
;  155      end if
l__l252
;  157    end if
l__l248
l__l247
;  159    if finalizado then
                               btfss    v__bitbucket, 0,v__access ; finalizado
                               goto     l__l245
;  160       finalizado = false
                               bcf      v__bitbucket, 0,v__access ; finalizado
;  161       armar_byte(byte_entrante)
                               call     l_armar_byte
                               movwf    v_byte_entrante,v__access
;  162       if (byte_entrante % 2) == 0 then
                               movlw    1
                               andwf    v_byte_entrante,w,v__access
                               movwf    v____temp_42,v__access
                               movf     v____temp_42,w,v__access
                               btfss    v__status, v__z,v__access
                               goto     l__l259
;  163          zumbador = on
                               bsf      v_latc, 6,v__access ; x124
;  164          delay_1ms(30)
                               movlw    30
                               movwf    v___n_3,v__access
                               clrf     v___n_3+1,v__access
                               call     l_delay_1ms
;  165          zumbador = off
                               bcf      v_latc, 6,v__access ; x125
;  166       end if
l__l259
;  167       byte_entrante = 0
                               clrf     v_byte_entrante,v__access
;  169    end if
;  171 end loop
                               goto     l__l245
                               end
