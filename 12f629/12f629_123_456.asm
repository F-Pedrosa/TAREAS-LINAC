; compiler: jal jalv24q5 (compiled Dec 29 2015)

; command line:  C:\JALLIB~1\compiler\jalv2.exe C:\Users\fabian\Desktop\12f629\12f629_123_456.jal -s C:\JALLIB~1\lib -no-variable-reuse
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
v_true                         EQU 1
v_false                        EQU 0
v_low                          EQU 0
v_on                           EQU 1
v_off                          EQU 0
v_input                        EQU 1
v_output                       EQU 0
v__pic_isr_w                   EQU 0x005e  ; _pic_isr_w
v__status                      EQU 0x0003  ; _status
v__z                           EQU 2
v_gpio_                        EQU 0x0005  ; gpio_
v_porta_shadow_                EQU 0x005d  ; porta_shadow_
v_pin_a3                       EQU 0x0005  ; pin_a3-->gpio_:3
v_pin_a4                       EQU 0x0005  ; pin_a4-->gpio_:4
v_pin_a5                       EQU 0x0005  ; pin_a5-->gpio_:5
v__pclath                      EQU 0x000a  ; _pclath
v_intcon                       EQU 0x000b  ; intcon
v_intcon_gpif                  EQU 0x000b  ; intcon_gpif-->intcon:0
v_intcon_gpie                  EQU 0x000b  ; intcon_gpie-->intcon:3
v_intcon_gie                   EQU 0x000b  ; intcon_gie-->intcon:7
v_cmcon                        EQU 0x0019  ; cmcon
v_option_reg                   EQU 0x0081  ; option_reg
v_option_reg_intedg            EQU 0x0081  ; option_reg_intedg-->option_reg:6
v_option_reg_ngppu             EQU 0x0081  ; option_reg_ngppu-->option_reg:7
v_trisio                       EQU 0x0085  ; trisio
v_pin_a0_direction             EQU 0x0085  ; pin_a0_direction-->trisio:0
v_pin_a1_direction             EQU 0x0085  ; pin_a1_direction-->trisio:1
v_pin_a2_direction             EQU 0x0085  ; pin_a2_direction-->trisio:2
v_pin_a3_direction             EQU 0x0085  ; pin_a3_direction-->trisio:3
v_pin_a4_direction             EQU 0x0085  ; pin_a4_direction-->trisio:4
v_pin_a5_direction             EQU 0x0085  ; pin_a5_direction-->trisio:5
v_osccal                       EQU 0x0090  ; osccal
v_wpu                          EQU 0x0095  ; wpu
v_wpu_wpu4                     EQU 0x0095  ; wpu_wpu4-->wpu:4
v_wpu_wpu5                     EQU 0x0095  ; wpu_wpu5-->wpu:5
v_ioc                          EQU 0x0096  ; ioc
v_ioc_ioc3                     EQU 0x0096  ; ioc_ioc3-->ioc:3
v_ioc_ioc4                     EQU 0x0096  ; ioc_ioc4-->ioc:4
v_ioc_ioc5                     EQU 0x0096  ; ioc_ioc5-->ioc:5
v_encender4                    EQU 0x0025  ; encender4-->_bitbucket:0
v_encender5                    EQU 0x0025  ; encender5-->_bitbucket:1
v_encender6                    EQU 0x0025  ; encender6-->_bitbucket:2
v_tiempo_encendido             EQU 4
v__bitbucket                   EQU 0x0025  ; _bitbucket
v__pic_temp                    EQU 0x0020  ; _pic_temp-->_pic_state
v__pic_isr_status              EQU 0x0022  ; _pic_isr_status
v__pic_isr_pclath              EQU 0x0023  ; _pic_isr_pclath
v__pic_state                   EQU 0x0020  ; _pic_state
v___x_22                       EQU 0x005d  ; x-->porta_shadow_:0
v___x_23                       EQU 0x005d  ; x-->porta_shadow_:1
v___x_24                       EQU 0x005d  ; x-->porta_shadow_:2
v___x_25                       EQU 0x005d  ; x-->porta_shadow_:0
v___x_26                       EQU 0x005d  ; x-->porta_shadow_:1
v___x_27                       EQU 0x005d  ; x-->porta_shadow_:2
v__floop9                      EQU 0x0026  ; _floop9
v___x_28                       EQU 0x005d  ; x-->porta_shadow_:0
v___x_29                       EQU 0x005d  ; x-->porta_shadow_:0
v__floop10                     EQU 0x0027  ; _floop10
v___x_30                       EQU 0x005d  ; x-->porta_shadow_:1
v___x_31                       EQU 0x005d  ; x-->porta_shadow_:1
v__floop11                     EQU 0x0028  ; _floop11
v___x_32                       EQU 0x005d  ; x-->porta_shadow_:2
v___x_33                       EQU 0x005d  ; x-->porta_shadow_:2
v___n_5                        EQU 0x0029  ; delay_100ms:n
v__floop5                      EQU 0x002b  ; delay_100ms:_floop5
v__floop6                      EQU 0x002d  ; delay_100ms:_floop6
l__l36                         EQU 0x03ff
;    1 include 12f629
                               org      0
                               goto     l__main
                               org      4
                               movwf    v__pic_isr_w
                               swapf    v__status,w
                               clrf     v__status
                               movwf    v__pic_isr_status
                               movf     v__pclath,w
                               movwf    v__pic_isr_pclath
                               clrf     v__pclath
                               goto     l_rutina_isr
l__main
;   13 assembler
;   14   page call 0x3FF
                               call     l__l36
;   15   bank movwf OSCCAL                ; valor de calibración de fábrica del oscilador interno
                               datalo_set v_osccal
                               movwf    v_osccal
;   18 enable_digital_io()                ; todos los pines disponibles como digitales
; C:\JALLIB~1\lib/12f629.jal
;  382    CMCON  = 0b0000_0111
                               movlw    7
                               datalo_clr v_cmcon
                               movwf    v_cmcon
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;   18 enable_digital_io()                ; todos los pines disponibles como digitales
; C:\JALLIB~1\lib/12f629.jal
;  389    comparator_off()
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;   18 enable_digital_io()                ; todos los pines disponibles como digitales
; delay.jal
;   26 procedure delay_1us() is
                               goto     l__l81
;  125 procedure delay_100ms(word in n) is
l_delay_100ms
;  127    for n loop
                               movf     v___n_5,w
                               movwf    v__floop5
                               movf     v___n_5+1,w
                               movwf    v__floop5+1
                               clrf     v__floop6
                               clrf     v__floop6+1
                               goto     l__l79
l__l78
;  128       _usec_delay(_100_ms_delay)
                               nop      
                               nop      
                               movlw    161
                               movwf    v__pic_temp
l__l125
                               movlw    123
                               movwf    v__pic_temp+1
l__l126
                               branchhi_clr l__l126
                               branchlo_clr l__l126
                               decfsz   v__pic_temp+1,f
                               goto     l__l126
                               branchhi_clr l__l125
                               branchlo_clr l__l125
                               decfsz   v__pic_temp,f
                               goto     l__l125
                               nop      
                               nop      
;  129    end loop
                               incf     v__floop6,f
                               btfsc    v__status, v__z
                               incf     v__floop6+1,f
l__l79
                               movf     v__floop6,w
                               subwf    v__floop5,w
                               movwf    v__pic_temp
                               movf     v__floop6+1,w
                               subwf    v__floop5+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l78
;  130 end procedure
                               return   
;  138 end procedure
l__l81
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;   22 pin_GP5_direction = INPUT
                               datalo_set v_trisio ; pin_a5_direction
                               bsf      v_trisio, 5 ; pin_a5_direction
;   24 pin_GP4_direction = INPUT
                               bsf      v_trisio, 4 ; pin_a4_direction
;   26 pin_GP3_direction = INPUT
                               bsf      v_trisio, 3 ; pin_a3_direction
;   29 pin_GP2_direction = OUTPUT
                               bcf      v_trisio, 2 ; pin_a2_direction
;   31 pin_GP1_direction = OUTPUT
                               bcf      v_trisio, 1 ; pin_a1_direction
;   33 pin_GP0_direction = OUTPUT
                               bcf      v_trisio, 0 ; pin_a0_direction
;   37 salida4 = off
                               bcf      v_porta_shadow_, 0 ; x22
; C:\JALLIB~1\lib/12f629.jal
;  131    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;   37 salida4 = off
;   38 salida5 = off
                               bcf      v_porta_shadow_, 1 ; x23
; C:\JALLIB~1\lib/12f629.jal
;  141    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;   38 salida5 = off
;   39 salida6 = off
                               bcf      v_porta_shadow_, 2 ; x24
; C:\JALLIB~1\lib/12f629.jal
;  152    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;   39 salida6 = off
;   42 var bit encender4 = false
                               bcf      v__bitbucket, 0 ; encender4
;   43 var bit encender5 = false
                               bcf      v__bitbucket, 1 ; encender5
;   44 var bit encender6 = false
                               bcf      v__bitbucket, 2 ; encender6
;   49 OPTION_REG_NGPPU = false          ; este bit es activo negado, por alguna idea peregrina de los diseñadores
                               datalo_set v_option_reg ; option_reg_ngppu
                               bcf      v_option_reg, 7 ; option_reg_ngppu
;   51 WPU_WPU5 = true
                               bsf      v_wpu, 5 ; wpu_wpu5
;   52 WPU_WPU4 = true
                               bsf      v_wpu, 4 ; wpu_wpu4
;   54 IOC_IOC5 = true
                               bsf      v_ioc, 5 ; ioc_ioc5
;   55 IOC_IOC4 = true
                               bsf      v_ioc, 4 ; ioc_ioc4
;   56 IOC_IOC3 = true
                               bsf      v_ioc, 3 ; ioc_ioc3
;   58 OPTION_REG_INTEDG = false
                               bcf      v_option_reg, 6 ; option_reg_intedg
;   59 INTCON_GPIE = true
                               bsf      v_intcon, 3 ; intcon_gpie
;   60 INTCON_GIE = true
                               bsf      v_intcon, 7 ; intcon_gie
;   63 delay_100ms(10)
                               movlw    10
                               movwf    v___n_5
                               clrf     v___n_5+1
                               call     l_delay_100ms
;   64 INTCON_GPIF = low
                               bcf      v_intcon, 0 ; intcon_gpif
;   66 salida4 = off
                               bcf      v_porta_shadow_, 0 ; x25
; C:\JALLIB~1\lib/12f629.jal
;  131    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;   66 salida4 = off
;   67 salida5 = off
                               bcf      v_porta_shadow_, 1 ; x26
; C:\JALLIB~1\lib/12f629.jal
;  141    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;   67 salida5 = off
;   68 salida6 = off
                               bcf      v_porta_shadow_, 2 ; x27
; C:\JALLIB~1\lib/12f629.jal
;  152    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;   68 salida6 = off
;   73 PROCEDURE rutina_isr() IS
                               goto     l__l92
l_rutina_isr
;   75    if INTCON_GPIF then
                               btfss    v_intcon, 0 ; intcon_gpif
                               goto     l__l95
;   76       INTCON_GPIF = low
                               bcf      v_intcon, 0 ; intcon_gpif
;   77       if entrada1 == low then
                               btfsc    v_gpio_, 5 ; pin_a5
                               goto     l__l97
;   78          encender4 = true
                               bsf      v__bitbucket, 0 ; encender4
;   79          encender5 = false
                               bcf      v__bitbucket, 1 ; encender5
;   80          encender6 = false
                               bcf      v__bitbucket, 2 ; encender6
;   81       elsif entrada2 == low then
                               goto     l__l94
l__l97
                               btfsc    v_gpio_, 4 ; pin_a4
                               goto     l__l98
;   82          encender5 = true
                               bsf      v__bitbucket, 1 ; encender5
;   83          encender4 = false
                               bcf      v__bitbucket, 0 ; encender4
;   84          encender6 = false
                               bcf      v__bitbucket, 2 ; encender6
;   85       elsif entrada3 == low then
                               goto     l__l96
l__l98
                               btfsc    v_gpio_, 3 ; pin_a3
                               goto     l__l99
;   86          encender6 = true
                               bsf      v__bitbucket, 2 ; encender6
;   87          encender5 = false
                               bcf      v__bitbucket, 1 ; encender5
;   88          encender4 = false
                               bcf      v__bitbucket, 0 ; encender4
;   89       end if
l__l99
l__l96
;   90    end if
l__l95
l__l94
;   91 END PROCEDURE
                               movf     v__pic_isr_pclath,w
                               movwf    v__pclath
                               swapf    v__pic_isr_status,w
                               movwf    v__status
                               swapf    v__pic_isr_w,f
                               swapf    v__pic_isr_w,w
                               retfie   
l__l92
;   99 forever loop
l__l100
;  100    if encender4 then
                               btfss    v__bitbucket, 0 ; encender4
                               goto     l__l103
;  101       encender4 = false
                               bcf      v__bitbucket, 0 ; encender4
;  102       salida4 = on
                               bsf      v_porta_shadow_, 0 ; x28
; C:\JALLIB~1\lib/12f629.jal
;  131    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;  102       salida4 = on
;  103       for tiempo_encendido loop
                               clrf     v__floop9
l__l105
;  104              delay_100ms(10)
                               movlw    10
                               movwf    v___n_5
                               clrf     v___n_5+1
                               call     l_delay_100ms
;  105       end loop
                               incf     v__floop9,f
                               movlw    4
                               subwf    v__floop9,w
                               btfss    v__status, v__z
                               goto     l__l105
;  106       salida4 = off
                               bcf      v_porta_shadow_, 0 ; x29
; C:\JALLIB~1\lib/12f629.jal
;  131    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;  106       salida4 = off
;  107    end if
l__l103
;  108    if encender5 then
                               btfss    v__bitbucket, 1 ; encender5
                               goto     l__l110
;  109       encender5 = false
                               bcf      v__bitbucket, 1 ; encender5
;  110       salida5 = on
                               bsf      v_porta_shadow_, 1 ; x30
; C:\JALLIB~1\lib/12f629.jal
;  141    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;  110       salida5 = on
;  111       for tiempo_encendido loop
                               clrf     v__floop10
l__l112
;  112              delay_100ms(10)
                               movlw    10
                               movwf    v___n_5
                               clrf     v___n_5+1
                               call     l_delay_100ms
;  113       end loop
                               incf     v__floop10,f
                               movlw    4
                               subwf    v__floop10,w
                               btfss    v__status, v__z
                               goto     l__l112
;  114       salida5 = off
                               bcf      v_porta_shadow_, 1 ; x31
; C:\JALLIB~1\lib/12f629.jal
;  141    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;  114       salida5 = off
;  115    end if
l__l110
;  116    if encender6 then
                               btfss    v__bitbucket, 2 ; encender6
                               goto     l__l117
;  117       encender6 = false
                               bcf      v__bitbucket, 2 ; encender6
;  118       salida6 = on
                               bsf      v_porta_shadow_, 2 ; x32
; C:\JALLIB~1\lib/12f629.jal
;  152    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;  118       salida6 = on
;  119       for tiempo_encendido loop
                               clrf     v__floop11
l__l119
;  120              delay_100ms(10)
                               movlw    10
                               movwf    v___n_5
                               clrf     v___n_5+1
                               call     l_delay_100ms
;  121       end loop
                               incf     v__floop11,f
                               movlw    4
                               subwf    v__floop11,w
                               btfss    v__status, v__z
                               goto     l__l119
;  122       salida6 = off
                               bcf      v_porta_shadow_, 2 ; x33
; C:\JALLIB~1\lib/12f629.jal
;  152    PORTA_ = PORTA_shadow_
                               movf     v_porta_shadow_,w
                               datalo_clr v_gpio_
                               movwf    v_gpio_
; C:\Users\fabian\Desktop\12f629\12f629_123_456.jal
;  122       salida6 = off
;  123    end if
l__l117
;  124    asm sleep
                               sleep    
;  125 end loop
                               goto     l__l100
                               end
