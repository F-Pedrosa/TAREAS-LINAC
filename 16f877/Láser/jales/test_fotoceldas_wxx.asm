; compiler: jal 2.4n (compiled Jun  2 2010)

; command line:  C:\ARCHIV~1\JALV2\COMPILER\JALV2.EXE C:\Windows\Escritorio\fotoceldas\jales\test_fotoceldas_wxx.jal -s C:\Windows\Escritorio\fotoceldas\jales\;C:\ARCHIV~1\JALV2\LIBRAR~1 -no-variable-reuse
                                list p=16f877a, r=dec
                                errorlevel -306 ; no page boundary warnings
                                errorlevel -302 ; no bank 0 warnings
                                errorlevel -202 ; no 'argument out of range' warnings

                             __config 0x3f7a
datahi_set macro val
  bsf 3, 6 ; STATUS<rp1>
  endm
datahi_clr macro val
  bcf 3, 6 ; STATUS<rp1>
  endm
datalo_set macro val
  bsf 3, 5 ; STATUS<rp0>
  endm
datalo_clr macro val
  bcf 3, 5 ; STATUS<rp0>
  endm
irp_clr macro
  bcf 3, 7 ; STATUS<irp>
  endm
irp_set macro
  bsf 3, 7 ; STATUS<irp>
  endm
branchhi_set macro lbl
    bsf 10, 4 ; PCLATH<4>
  endm
branchhi_clr macro lbl
    bcf 10, 4 ; PCLATH<4>
  endm
branchlo_set macro lbl
    bsf 10, 3 ; PCLATH<3>
  endm
branchlo_clr macro lbl
    bcf 10, 3 ; PCLATH<3>
  endm
v_on                           EQU 1
v_off                          EQU 0
v_input                        EQU 1
v_output                       EQU 0
v__status                      EQU 0x0003  ; _status
v__z                           EQU 2
v__portc                       EQU 0x0007  ; _portc
v__portc_shadow                EQU 0x0021  ; _portc_shadow
v_adcon0                       EQU 0x001f  ; adcon0
v_trisb                        EQU 0x0086  ; trisb
v_pin_b0_direction             EQU 0x0086  ; pin_b0_direction-->trisb:0
v_trisc                        EQU 0x0087  ; trisc
v_pin_c4_direction             EQU 0x0087  ; pin_c4_direction-->trisc:4
v_cmcon                        EQU 0x009c  ; cmcon
v_adcon1                       EQU 0x009f  ; adcon1
v__pic_temp                    EQU 0x0020  ; _pic_temp-->_pic_state
v__pic_state                   EQU 0x0020  ; _pic_state
v___x_118                      EQU 0x0021  ; x-->_portc_shadow:4
v___x_119                      EQU 0x0021  ; x-->_portc_shadow:4
v___x_120                      EQU 0x0021  ; x-->_portc_shadow:4
v___n_1                        EQU 0x0022  ; delay_10us:n
v__floop1                      EQU 0x0023  ; delay_10us:_floop1
;    6 include 16f877a
                               org      0
l__main
;   13 enable_digital_io()
; 16f877a.jal
; 1046    ADCON0 = 0b0000_0000         -- disable ADC
                               clrf     v_adcon0
; 1047    ADCON1 = 0b0000_0111         -- digital I/O
                               movlw    7
                               datalo_set v_adcon1
                               movwf    v_adcon1
; C:\Windows\Escritorio\fotoceldas\jales\test_fotoceldas_wxx.jal
;   13 enable_digital_io()
; 16f877a.jal
; 1061    adc_off()
; C:\Windows\Escritorio\fotoceldas\jales\test_fotoceldas_wxx.jal
;   13 enable_digital_io()
; 16f877a.jal
; 1054    CMCON  = 0b0000_0111        -- disable comparator
                               movlw    7
                               movwf    v_cmcon
; C:\Windows\Escritorio\fotoceldas\jales\test_fotoceldas_wxx.jal
;   13 enable_digital_io()
; 16f877a.jal
; 1062    comparator_off()
; C:\Windows\Escritorio\fotoceldas\jales\test_fotoceldas_wxx.jal
;   13 enable_digital_io()
; delay.jal
;   27 procedure delay_1us() is
                               goto     l__l214
;   84 procedure delay_10us(byte in n) is
l_delay_10us
                               movwf    v___n_1
;   85    if n==0 then
                               movf     v___n_1,w
                               btfsc    v__status, v__z
;   86       return
                               return   
;   87    elsif n==1 then
l__l191
                               movlw    1
                               subwf    v___n_1,w
                               btfss    v__status, v__z
                               goto     l__l192
;   90        _usec_delay(_ten_us_delay1)
                               datalo_clr v__pic_temp
                               datahi_clr v__pic_temp
                               movlw    10
                               movwf    v__pic_temp
                               branchhi_clr l__l227
                               branchlo_clr l__l227
l__l227
                               decfsz   v__pic_temp,f
                               goto     l__l227
;   91      end if
                               return   
;   92    else     
l__l192
;   93       n = n - 1;
                               decf     v___n_1,f
;   96          _usec_delay(_ten_us_delay2)   
                               datalo_clr v__pic_temp
                               datahi_clr v__pic_temp
                               movlw    6
                               movwf    v__pic_temp
                               branchhi_clr l__l228
                               branchlo_clr l__l228
l__l228
                               decfsz   v__pic_temp,f
                               goto     l__l228
                               nop      
                               nop      
;  102       for n loop
                               clrf     v__floop1
                               goto     l__l198
l__l197
;  104             _usec_delay(_ten_us_delay3)
                               datalo_clr v__pic_temp
                               datahi_clr v__pic_temp
                               movlw    13
                               movwf    v__pic_temp
                               branchhi_clr l__l229
                               branchlo_clr l__l229
l__l229
                               decfsz   v__pic_temp,f
                               goto     l__l229
                               nop      
;  108       end loop
                               incf     v__floop1,f
l__l198
                               movf     v__floop1,w
                               subwf    v___n_1,w
                               btfss    v__status, v__z
                               goto     l__l197
;  109    end if
l__l190
;  111 end procedure
l__l189
                               return   
;  139 end procedure
l__l214
; C:\Windows\Escritorio\fotoceldas\jales\test_fotoceldas_wxx.jal
;   18 pin_b0_direction = input
                               bsf      v_trisb, 0 ; pin_b0_direction
;   21 pin_c4_direction = output
                               bcf      v_trisc, 4 ; pin_c4_direction
;   28 control_laser = off
                               datalo_clr v__portc_shadow ; x118
                               bcf      v__portc_shadow, 4 ; x118
; 16f877a.jal
;  351    _PORTC = _PORTC_shadow
                               movf     v__portc_shadow,w
                               movwf    v__portc
; C:\Windows\Escritorio\fotoceldas\jales\test_fotoceldas_wxx.jal
;   28 control_laser = off
;   30 forever loop
l__l220
;   44    control_laser = on
                               datalo_clr v__portc_shadow ; x119
                               bsf      v__portc_shadow, 4 ; x119
; 16f877a.jal
;  351    _PORTC = _PORTC_shadow
                               movf     v__portc_shadow,w
                               movwf    v__portc
; C:\Windows\Escritorio\fotoceldas\jales\test_fotoceldas_wxx.jal
;   44    control_laser = on
;   46    delay_10us(50)
                               movlw    50
                               call     l_delay_10us
;   47    control_laser = off
                               datalo_clr v__portc_shadow ; x120
                               bcf      v__portc_shadow, 4 ; x120
; 16f877a.jal
;  351    _PORTC = _PORTC_shadow
                               movf     v__portc_shadow,w
                               movwf    v__portc
; C:\Windows\Escritorio\fotoceldas\jales\test_fotoceldas_wxx.jal
;   47    control_laser = off
;   49    delay_10us(50)
                               movlw    50
                               call     l_delay_10us
;   71 end loop
                               goto     l__l220
                               end
