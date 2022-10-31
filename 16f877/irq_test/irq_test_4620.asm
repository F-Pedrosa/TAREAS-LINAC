; compiler: jal jalv24q2 (compiled Jan 23 2014)

; command line:  C:\ARCHIV~1\JALv2\Compiler\JALv2.exe E:\Documents and Settings\fabian\Escritorio\irq_test\irq_test_4620.jal -s E:\Documents and Settings\fabian\Escritorio\irq_test\;C:\ARCHIV~1\JALv2\LIBRAR~1 -no-variable-reuse
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
v_latb                         EQU 0x0f8a  ; latb
v_pin_b7                       EQU 0x0f81  ; pin_b7-->portb:7
v_trisb                        EQU 0x0f93  ; trisb
v_pin_b0_direction             EQU 0x0f93  ; pin_b0_direction-->trisb:0
v_pin_b7_direction             EQU 0x0f93  ; pin_b7_direction-->trisb:7
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
v__z                           EQU 2
v__banked                      EQU 1
v__access                      EQU 0
v_intcon2                      EQU 0x0ff1  ; intcon2
v_intcon2_intedg0              EQU 0x0ff1  ; intcon2_intedg0-->intcon2:6
v_intcon                       EQU 0x0ff2  ; intcon
v_intcon_int0if                EQU 0x0ff2  ; intcon_int0if-->intcon:1
v_intcon_int0ie                EQU 0x0ff2  ; intcon_int0ie-->intcon:4
v_intcon_peie                  EQU 0x0ff2  ; intcon_peie-->intcon:6
v_intcon_gie                   EQU 0x0ff2  ; intcon_gie-->intcon:7
v_int_falling_edge             EQU 0
v__pic_temp                    EQU 0x0002  ; _pic_temp-->_pic_state
v__pic_state                   EQU 0x0002  ; _pic_state
v___x_122                      EQU 0x0f8a  ; x-->latb:7
v___x_123                      EQU 0x0f8a  ; x-->latb:7
v___x_124                      EQU 0x0f8a  ; x-->latb:7
v___x_120                      EQU 0x0f8a  ; int_on_change_b0:x-->latb:7
v___x_121                      EQU 0x0f8a  ; int_on_change_b0:x-->latb:7
v___n_5                        EQU 0x0008  ; delay_100ms:n
v__floop5                      EQU 0x000a  ; delay_100ms:_floop5
v__floop6                      EQU 0x000c  ; delay_100ms:_floop6
;    4 include 18f4620
                               org      0
                               goto     l__main
                               org      8
                               goto     l_interrupt
l__main
;   18 WDTCON_SWDTEN = OFF                 ; disable WDT
                               bcf      v_wdtcon, 0,v__access ; wdtcon_swdten
;   19 OSCCON_SCS = 0                      ; select primary oscillator
                               movlw    252
                               andwf    v_osccon,f,v__access
;   20 OSCTUNE_PLLEN = FALSE               ; no PLL
                               bcf      v_osctune, 6,v__access ; osctune_pllen
;   23 enable_digital_io()                   ; todos los pines como I/O digitales en el arranque
; 18f4620.jal
; 1530    ADCON0 = 0b0000_0000
                               clrf     v_adcon0,v__access
; 1531    ADCON1 = 0b0000_1111
                               movlw    15
                               movwf    v_adcon1,v__access
; 1532    ADCON2 = 0b0000_0000
                               clrf     v_adcon2,v__access
; E:\Documents and Settings\fabian\Escritorio\irq_test\irq_test_4620.jal
;   23 enable_digital_io()                   ; todos los pines como I/O digitales en el arranque
; 18f4620.jal
; 1546    adc_off()
; E:\Documents and Settings\fabian\Escritorio\irq_test\irq_test_4620.jal
;   23 enable_digital_io()                   ; todos los pines como I/O digitales en el arranque
; 18f4620.jal
; 1539    CMCON  = 0b0000_0111
                               movlw    7
                               movwf    v_cmcon,v__access
; E:\Documents and Settings\fabian\Escritorio\irq_test\irq_test_4620.jal
;   23 enable_digital_io()                   ; todos los pines como I/O digitales en el arranque
; 18f4620.jal
; 1547    comparator_off()
; E:\Documents and Settings\fabian\Escritorio\irq_test\irq_test_4620.jal
;   23 enable_digital_io()                   ; todos los pines como I/O digitales en el arranque
; delay.jal
;   26 procedure delay_1us() is
                               goto     l__l216
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
l__l239
                               movlw    87
                               movwf    v__pic_temp+1,v__access
l__l240
                               movlw    111
                               movwf    v__pic_temp+2,v__access
l__l241
                               decfsz   v__pic_temp+2,f,v__access
                               goto     l__l241
                               decfsz   v__pic_temp+1,f,v__access
                               goto     l__l240
                               decfsz   v__pic_temp,f,v__access
                               goto     l__l239
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
; E:\Documents and Settings\fabian\Escritorio\irq_test\irq_test_4620.jal
;   28 pin_b7_direction = output
                               bcf      v_trisb, 7,v__access ; pin_b7_direction
;   38 INT_0_EDGE_BIT =  INT_FALLING_EDGE
                               bcf      v_intcon2, 6,v__access ; intcon2_intedg0
;   42 INTCON_GIE  = TRUE        -- Enables all unmasked interrupts
                               bsf      v_intcon, 7,v__access ; intcon_gie
;   43 INTCON_PEIE = TRUE        -- Enables all unmasked peripheral interrupts
                               bsf      v_intcon, 6,v__access ; intcon_peie
;   49 interrupt_pin_direction = INPUT -- interrupt pin is input
                               bsf      v_trisb, 0,v__access ; pin_b0_direction
;   50 INT_0_ENABLE_BIT = TRUE   -- interrupt pin enable bit for B0
                               bsf      v_intcon, 4,v__access ; intcon_int0ie
;   54 procedure interrupt() is
                               goto     l__l221
l_interrupt
;   57    if INT_0_FLAG_BIT then
                               btfss    v_intcon, 1,v__access ; intcon_int0if
                               goto     l__l226
;   58       int_on_change_b0() -- call our B0 procedure
                               call     l_int_on_change_b0
;   59       INT_0_FLAG_BIT = FALSE -- reset interrupt flag
                               bcf      v_intcon, 1,v__access ; intcon_int0if
;   60    end if
l__l226
;   61 end procedure
                               retfie   1
;   65 procedure int_on_change_b0() is
l_int_on_change_b0
;   67    if led == on then
                               btfss    v_portb, 7,v__access ; pin_b7
                               goto     l__l228
;   68       led = off
                               bcf      v_latb, 7,v__access ; x120
;   69    else
                               return   
l__l228
;   70       led = on
                               bsf      v_latb, 7,v__access ; x121
;   71    end if
l__l227
;   72 end procedure
                               return   
l__l221
;   75 led = off
                               bcf      v_latb, 7,v__access ; x122
;   77 led = on
                               bsf      v_latb, 7,v__access ; x123
;   78 delay_100ms(15)
                               movlw    15
                               movwf    v___n_5,v__access
                               clrf     v___n_5+1,v__access
                               call     l_delay_100ms
;   79 led = off
                               bcf      v_latb, 7,v__access ; x124
;   80 delay_100ms(15)
                               movlw    15
                               movwf    v___n_5,v__access
                               clrf     v___n_5+1,v__access
                               call     l_delay_100ms
;   83 forever loop
l__l234
;   84   delay_100ms(1)
                               movlw    1
                               movwf    v___n_5,v__access
                               clrf     v___n_5+1,v__access
                               call     l_delay_100ms
;   85 end loop
                               goto     l__l234
                               end
