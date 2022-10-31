; compiler: jal jalv24q5 (compiled Dec 29 2015)

; command line:  C:\JALLIB~1\compiler\jalv2.exe C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal -s C:\JALLIB~1\lib -no-variable-reuse
                                list p=12f629, r=dec
                                errorlevel -306 ; no page boundary warnings
                                errorlevel -302 ; no bank 0 warnings
                                errorlevel -202 ; no 'argument out of range' warnings

                             __config 0x3f9c
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
v_option_reg                   EQU 0x0081  ; option_reg
v_trisio                       EQU 0x0085  ; trisio
v_pin_a0_direction             EQU 0x0085  ; pin_a0_direction-->trisio:0
v_pin_a1_direction             EQU 0x0085  ; pin_a1_direction-->trisio:1
v_pin_a2_direction             EQU 0x0085  ; pin_a2_direction-->trisio:2
v_tiempo                       EQU 25
v_encendido1                   EQU 20
v__pic_temp                    EQU 0x0020  ; _pic_temp-->_pic_state
v__pic_state                   EQU 0x0020  ; _pic_state
v___x_22                       EQU 0x005d  ; x-->porta_shadow_:0
v___x_23                       EQU 0x005d  ; x-->porta_shadow_:2
v___x_24                       EQU 0x005d  ; x-->porta_shadow_:1
v___x_25                       EQU 0x005d  ; x-->porta_shadow_:0
v___x_26                       EQU 0x005d  ; x-->porta_shadow_:2
v___x_27                       EQU 0x005d  ; x-->porta_shadow_:2
v___x_28                       EQU 0x005d  ; x-->porta_shadow_:0
v__floop9                      EQU 0x0023  ; _floop9
v__floop10                     EQU 0x0025  ; _floop10
v___x_29                       EQU 0x005d  ; x-->porta_shadow_:0
v___x_30                       EQU 0x005d  ; x-->porta_shadow_:0
v___n_5                        EQU 0x0026  ; delay_100ms:n
v__floop5                      EQU 0x0028  ; delay_100ms:_floop5
v__floop6                      EQU 0x002a  ; delay_100ms:_floop6
;    2 include 12f629                     -- target PICmicro
                               org      0
l__main
;   10 enable_digital_io()                 -- make all pins digital I/O
; C:\JALLIB~1\lib/12f629.jal
;  382    CMCON  = 0b0000_0111
                               movlw    7
                               movwf    v_cmcon
; C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal
;   10 enable_digital_io()                 -- make all pins digital I/O
; C:\JALLIB~1\lib/12f629.jal
;  389    comparator_off()
; C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal
;   10 enable_digital_io()                 -- make all pins digital I/O
;   11 OPTION_REG = 0b00001110    ; ajuste del prescaler del watchdog para que de unos 1,1 seg
                               movlw    14
                               datalo_set v_option_reg
                               movwf    v_option_reg
;   13 carga = off
                               bcf      v_porta_shadow_, 0 ; x22
; C:\JALLIB~1\lib/12f629.jal
;  131    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal
;   13 carga = off
;   14 pin_GP0_direction = OUTPUT
                               datalo_set v_trisio ; pin_a0_direction
                               bcf      v_trisio, 0 ; pin_a0_direction
;   16 led = off
                               bcf      v_porta_shadow_, 2 ; x23
; C:\JALLIB~1\lib/12f629.jal
;  152    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal
;   16 led = off
;   17 pin_GP2_direction = OUTPUT
                               datalo_set v_trisio ; pin_a2_direction
                               bcf      v_trisio, 2 ; pin_a2_direction
;   22 pin_GP1_direction = OUTPUT
                               bcf      v_trisio, 1 ; pin_a1_direction
;   25 salida5 = off
                               bcf      v_porta_shadow_, 1 ; x24
; C:\JALLIB~1\lib/12f629.jal
;  141    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal
;   25 salida5 = off
; delay.jal
;   26 procedure delay_1us() is
                               goto     l__l83
;  125 procedure delay_100ms(word in n) is
l_delay_100ms
;  127    for n loop
                               movf     v___n_5,w
                               movwf    v__floop5
                               movf     v___n_5+1,w
                               movwf    v__floop5+1
                               clrf     v__floop6
                               clrf     v__floop6+1
                               goto     l__l81
l__l80
;  128       _usec_delay(_100_ms_delay)
                               nop      
                               nop      
                               movlw    161
                               movwf    v__pic_temp
l__l104
                               movlw    123
                               movwf    v__pic_temp+1
l__l105
                               branchhi_clr l__l105
                               branchlo_clr l__l105
                               decfsz   v__pic_temp+1,f
                               goto     l__l105
                               branchhi_clr l__l104
                               branchlo_clr l__l104
                               decfsz   v__pic_temp,f
                               goto     l__l104
                               nop      
                               nop      
;  129    end loop
                               incf     v__floop6,f
                               btfsc    v__status, v__z
                               incf     v__floop6+1,f
l__l81
                               movf     v__floop6,w
                               subwf    v__floop5,w
                               movwf    v__pic_temp
                               movf     v__floop6+1,w
                               subwf    v__floop5+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l80
;  130 end procedure
                               return   
;  138 end procedure
l__l83
; C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal
;   37 carga = off
                               bcf      v_porta_shadow_, 0 ; x25
; C:\JALLIB~1\lib/12f629.jal
;  131    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal
;   37 carga = off
;   38 delay_100ms(10)
                               movlw    10
                               movwf    v___n_5
                               clrf     v___n_5+1
                               call     l_delay_100ms
;   39 led = on
                               bsf      v_porta_shadow_, 2 ; x26
; C:\JALLIB~1\lib/12f629.jal
;  152    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal
;   39 led = on
;   40 delay_100ms(4)
                               movlw    4
                               movwf    v___n_5
                               clrf     v___n_5+1
                               call     l_delay_100ms
;   41 led = off
                               bcf      v_porta_shadow_, 2 ; x27
; C:\JALLIB~1\lib/12f629.jal
;  152    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal
;   41 led = off
;   42 carga = off
                               bcf      v_porta_shadow_, 0 ; x28
; C:\JALLIB~1\lib/12f629.jal
;  131    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal
;   42 carga = off
;   69 forever loop
l__l92
;   71   for tiempo loop
                               clrf     v__floop9
                               clrf     v__floop9+1
l__l94
;   72       asm sleep
                               sleep    
;   73   end loop
                               incf     v__floop9,f
                               btfsc    v__status, v__z
                               incf     v__floop9+1,f
                               movlw    25
                               subwf    v__floop9,w
                               iorwf    v__floop9+1,w
                               btfss    v__status, v__z
                               goto     l__l94
;   74   carga = on
                               bsf      v_porta_shadow_, 0 ; x29
; C:\JALLIB~1\lib/12f629.jal
;  131    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal
;   74   carga = on
;   75   for encendido1 loop
                               clrf     v__floop10
l__l98
;   76       delay_100ms(5)
                               movlw    5
                               movwf    v___n_5
                               clrf     v___n_5+1
                               call     l_delay_100ms
;   77       asm CLRWDT
                               clrwdt   
;   78   end loop
                               incf     v__floop10,f
                               movlw    20
                               subwf    v__floop10,w
                               btfss    v__status, v__z
                               goto     l__l98
;   79   carga = off
                               bcf      v_porta_shadow_, 0 ; x30
; C:\JALLIB~1\lib/12f629.jal
;  131    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\Pruebas_12f629\jal_despertado_watchdog\12f629_despertado_wdt_pruebas_largas.jal
;   79   carga = off
;   80   asm CLRWDT
                               clrwdt   
;   81 end loop
                               goto     l__l92
                               end
