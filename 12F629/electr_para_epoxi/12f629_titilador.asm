; compiler: jal jalv24q5 (compiled Dec 29 2015)

; command line:  C:\JALLIB~1\compiler\jalv2.exe C:\Users\fabian\Desktop\disco_viejo\escritorio_xp\electr_para_epoxi\12f629_titilador.jal -s C:\JALLIB~1\lib -no-variable-reuse
                                list p=12f629, r=dec
                                errorlevel -306 ; no page boundary warnings
                                errorlevel -302 ; no bank 0 warnings
                                errorlevel -202 ; no 'argument out of range' warnings

                             __config 0x3f94
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
  nop
  endm
branchhi_clr macro lbl
  nop
  endm
branchlo_set macro lbl
  nop
  endm
branchlo_clr macro lbl
  nop
  endm
v_on                           EQU 1
v_off                          EQU 0
v_output                       EQU 0
v__status                      EQU 0x0003  ; _status
v__z                           EQU 2
v_gpio_                        EQU 0x0005  ; gpio_
v_porta_shadow_                EQU 0x005d  ; porta_shadow_
v_cmcon                        EQU 0x0019  ; cmcon
v_trisio                       EQU 0x0085  ; trisio
v_pin_a1_direction             EQU 0x0085  ; pin_a1_direction-->trisio:1
v_pin_a2_direction             EQU 0x0085  ; pin_a2_direction-->trisio:2
v_osccal                       EQU 0x0090  ; osccal
v__pic_temp                    EQU 0x0020  ; _pic_temp-->_pic_state
v__pic_state                   EQU 0x0020  ; _pic_state
v___x_22                       EQU 0x005d  ; x-->porta_shadow_:1
v___x_23                       EQU 0x005d  ; x-->porta_shadow_:2
v___x_24                       EQU 0x005d  ; x-->porta_shadow_:1
v___x_25                       EQU 0x005d  ; x-->porta_shadow_:2
v___x_26                       EQU 0x005d  ; x-->porta_shadow_:1
v___x_27                       EQU 0x005d  ; x-->porta_shadow_:2
v___n_5                        EQU 0x0023  ; delay_100ms:n
v__floop5                      EQU 0x0025  ; delay_100ms:_floop5
v__floop6                      EQU 0x0027  ; delay_100ms:_floop6
l__l85                         EQU 0x03ff
;    3 include 12f629
                               org      0
l__main
;   11 enable_digital_io()                 -- make all pins digital I/O
; 12f629.jal
;  382    CMCON  = 0b0000_0111
                               movlw    7
                               movwf    v_cmcon
; C:\Users\fabian\Desktop\disco_viejo\escritorio_xp\electr_para_epoxi\12f629_titilador.jal
;   11 enable_digital_io()                 -- make all pins digital I/O
; 12f629.jal
;  389    comparator_off()
; C:\Users\fabian\Desktop\disco_viejo\escritorio_xp\electr_para_epoxi\12f629_titilador.jal
;   11 enable_digital_io()                 -- make all pins digital I/O
; delay.jal
;   26 procedure delay_1us() is
                               goto     l__l80
;  125 procedure delay_100ms(word in n) is
l_delay_100ms
;  127    for n loop
                               movf     v___n_5,w
                               movwf    v__floop5
                               movf     v___n_5+1,w
                               movwf    v__floop5+1
                               clrf     v__floop6
                               clrf     v__floop6+1
                               goto     l__l78
l__l77
;  128       _usec_delay(_100_ms_delay)
                               nop      
                               nop      
                               movlw    161
                               movwf    v__pic_temp
l__l96
                               movlw    123
                               movwf    v__pic_temp+1
l__l97
                               branchhi_clr l__l97
                               branchlo_clr l__l97
                               decfsz   v__pic_temp+1,f
                               goto     l__l97
                               branchhi_clr l__l96
                               branchlo_clr l__l96
                               decfsz   v__pic_temp,f
                               goto     l__l96
                               nop      
                               nop      
;  129    end loop
                               incf     v__floop6,f
                               btfsc    v__status, v__z
                               incf     v__floop6+1,f
l__l78
                               movf     v__floop6,w
                               subwf    v__floop5,w
                               movwf    v__pic_temp
                               movf     v__floop6+1,w
                               subwf    v__floop5+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l77
;  130 end procedure
                               return   
;  138 end procedure
l__l80
; C:\Users\fabian\Desktop\disco_viejo\escritorio_xp\electr_para_epoxi\12f629_titilador.jal
;   16 pin_A1_direction = OUTPUT
                               datalo_set v_trisio ; pin_a1_direction
                               bcf      v_trisio, 1 ; pin_a1_direction
;   19 pin_A2_direction = OUTPUT
                               bcf      v_trisio, 2 ; pin_a2_direction
;   23 assembler
;   24   page call 0x3FF
                               call     l__l85
;   25   bank movwf OSCCAL                ; valor de calibración de fábrica del oscilador interno
                               datalo_set v_osccal
                               movwf    v_osccal
;   29 led1 = OFF
                               bcf      v_porta_shadow_, 1 ; x22
; 12f629.jal
;  141    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\disco_viejo\escritorio_xp\electr_para_epoxi\12f629_titilador.jal
;   29 led1 = OFF
;   30 led2 = OFF
                               bcf      v_porta_shadow_, 2 ; x23
; 12f629.jal
;  152    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\disco_viejo\escritorio_xp\electr_para_epoxi\12f629_titilador.jal
;   30 led2 = OFF
;   33 forever loop
l__l88
;   34    led1 = ON
                               bsf      v_porta_shadow_, 1 ; x24
; 12f629.jal
;  141    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\disco_viejo\escritorio_xp\electr_para_epoxi\12f629_titilador.jal
;   34    led1 = ON
;   35    led2 = OFF
                               bcf      v_porta_shadow_, 2 ; x25
; 12f629.jal
;  152    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\disco_viejo\escritorio_xp\electr_para_epoxi\12f629_titilador.jal
;   35    led2 = OFF
;   36    delay_100ms(10)
                               movlw    10
                               movwf    v___n_5
                               clrf     v___n_5+1
                               call     l_delay_100ms
;   37    led1 = OFF
                               bcf      v_porta_shadow_, 1 ; x26
; 12f629.jal
;  141    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\disco_viejo\escritorio_xp\electr_para_epoxi\12f629_titilador.jal
;   37    led1 = OFF
;   38    led2 = ON
                               bsf      v_porta_shadow_, 2 ; x27
; 12f629.jal
;  152    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\disco_viejo\escritorio_xp\electr_para_epoxi\12f629_titilador.jal
;   38    led2 = ON
;   39    delay_100ms(10)
                               movlw    10
                               movwf    v___n_5
                               clrf     v___n_5+1
                               call     l_delay_100ms
;   40 end loop
                               goto     l__l88
                               end
