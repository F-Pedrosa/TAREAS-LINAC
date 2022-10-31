; compiler: jal 2.4n (compiled Jun  2 2010)

; command line:  C:\ARCHIV~1\JALV2\COMPILER\JALV2.EXE C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal -s C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\;C:\ARCHIV~1\JALV2\LIBRAR~1 -no-variable-reuse
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
v_true                         EQU 1
v_false                        EQU 0
v_high                         EQU 1
v_low                          EQU 0
v_on                           EQU 1
v_off                          EQU 0
v_input                        EQU 1
v_output                       EQU 0
v_all_output                   EQU 0
v__ind                         EQU 0x0000  ; _ind
v__pcl                         EQU 0x0002  ; _pcl
v__status                      EQU 0x0003  ; _status
v__z                           EQU 2
v__c                           EQU 0
v__fsr                         EQU 0x0004  ; _fsr
v__portb                       EQU 0x0006  ; _portb
v__portb_shadow                EQU 0x0032  ; _portb_shadow
v__portc                       EQU 0x0007  ; _portc
v__portc_shadow                EQU 0x0033  ; _portc_shadow
v_pin_c2                       EQU 0x0007  ; pin_c2-->_portc:2
v__pclath                      EQU 0x000a  ; _pclath
v_pir1                         EQU 0x000c  ; pir1
v_pir1_sspif                   EQU 0x000c  ; pir1_sspif-->pir1:3
v_sspbuf                       EQU 0x0013  ; sspbuf
v_sspcon                       EQU 0x0014  ; sspcon
v_sspcon_sspen                 EQU 0x0014  ; sspcon_sspen-->sspcon:5
v_adcon0                       EQU 0x001f  ; adcon0
v_trisb                        EQU 0x0086  ; trisb
v_portb_direction              EQU 0x0086  ; portb_direction-->trisb
v_pin_b6_direction             EQU 0x0086  ; pin_b6_direction-->trisb:6
v_pin_b2_direction             EQU 0x0086  ; pin_b2_direction-->trisb:2
v_pin_b1_direction             EQU 0x0086  ; pin_b1_direction-->trisb:1
v_pin_b0_direction             EQU 0x0086  ; pin_b0_direction-->trisb:0
v_trisc                        EQU 0x0087  ; trisc
v_pin_c4_direction             EQU 0x0087  ; pin_c4_direction-->trisc:4
v_pin_c3_direction             EQU 0x0087  ; pin_c3_direction-->trisc:3
v_pin_c2_direction             EQU 0x0087  ; pin_c2_direction-->trisc:2
v_pin_c1_direction             EQU 0x0087  ; pin_c1_direction-->trisc:1
v_trisd                        EQU 0x0088  ; trisd
v_pin_d1_direction             EQU 0x0088  ; pin_d1_direction-->trisd:1
v_sspcon2                      EQU 0x0091  ; sspcon2
v_sspcon2_ackstat              EQU 0x0091  ; sspcon2_ackstat-->sspcon2:6
v_sspcon2_ackdt                EQU 0x0091  ; sspcon2_ackdt-->sspcon2:5
v_sspcon2_acken                EQU 0x0091  ; sspcon2_acken-->sspcon2:4
v_sspcon2_rcen                 EQU 0x0091  ; sspcon2_rcen-->sspcon2:3
v_sspcon2_pen                  EQU 0x0091  ; sspcon2_pen-->sspcon2:2
v_sspcon2_rsen                 EQU 0x0091  ; sspcon2_rsen-->sspcon2:1
v_sspcon2_sen                  EQU 0x0091  ; sspcon2_sen-->sspcon2:0
v_sspadd                       EQU 0x0093  ; sspadd
v_sspstat                      EQU 0x0094  ; sspstat
v_sspstat_bf                   EQU 0x0094  ; sspstat_bf-->sspstat:0
v_cmcon                        EQU 0x009c  ; cmcon
v_adcon1                       EQU 0x009f  ; adcon1
v__i2c_1mhz                    EQU 4
v_lcd_rows                     EQU 2
v_lcd_clear_display            EQU 1
v_lcd_set_ddram_address        EQU 128
v_lcd_pos                      EQU 0x002c  ; lcd_pos
v_digi4                        EQU 0x0034  ; digi4
v_digi3                        EQU 0x0035  ; digi3
v_digi2                        EQU 0x0036  ; digi2
v_digi1                        EQU 0x0037  ; digi1
v_digi0                        EQU 0x0038  ; digi0
v_contador                     EQU 0x0039  ; contador
v_arreglo_mediciones           EQU 0x00a0  ; arreglo_mediciones
v_promedio                     EQU 0x003b  ; promedio
v_centimetros                  EQU 0x003d  ; centimetros
v_valor_tabla                  EQU 0x003f  ; valor_tabla
v_direcc                       EQU 0x0041  ; direcc
v_dire                         EQU 0x0041  ; dire-->direcc
v_valores                      EQU 0x003f  ; valores-->valor_tabla
v___resul_1                    EQU 0x0045  ; resul-->_bitbucket:0
v____temp_99                   EQU 0x0043  ; _temp
v__bitbucket                   EQU 0x0045  ; _bitbucket
v__pic_temp                    EQU 0x0020  ; _pic_temp-->_pic_state
v__pic_pointer                 EQU 0x002a  ; _pic_pointer
v__pic_loop                    EQU 0x0028  ; _pic_loop
v__pic_divisor                 EQU 0x0024  ; _pic_divisor-->_pic_state+4
v__pic_dividend                EQU 0x0020  ; _pic_dividend-->_pic_state
v__pic_quotient                EQU 0x0026  ; _pic_quotient-->_pic_state+6
v__pic_remainder               EQU 0x0022  ; _pic_remainder-->_pic_state+2
v__pic_divaccum                EQU 0x0020  ; _pic_divaccum-->_pic_state
v__pic_multiplier              EQU 0x0020  ; _pic_multiplier-->_pic_state
v__pic_multiplicand            EQU 0x0022  ; _pic_multiplicand-->_pic_state+2
v__pic_mresult                 EQU 0x0024  ; _pic_mresult-->_pic_state+4
v__pic_state                   EQU 0x0020  ; _pic_state
v___x_152                      EQU 0x0032  ; x-->_portb_shadow:7
v___x_153                      EQU 0x0032  ; x-->_portb_shadow:7
v__btemp337                    EQU 0x0045  ; _btemp337-->_bitbucket:3
v__btemp339                    EQU 0x0045  ; _btemp339-->_bitbucket:5
v__btemp341                    EQU 0x0045  ; _btemp341-->_bitbucket:7
v__rparam3                     EQU 0x0047  ; _rparam3
v__rparam4                     EQU 0x0048  ; _rparam4
v__rparam5                     EQU 0x0049  ; _rparam5
v__rparam6                     EQU 0x004a  ; _rparam6
v__rparam7                     EQU 0x004b  ; _rparam7
v__rparam8                     EQU 0x004c  ; _rparam8
v__rparam9                     EQU 0x004d  ; _rparam9
v__rparam10                    EQU 0x004e  ; _rparam10
v___x_154                      EQU 0x0032  ; x-->_portb_shadow:4
v____temp_100                  EQU 0x004f  ; _temp
v___x_155                      EQU 0x0032  ; x-->_portb_shadow:4
v____temp_101                  EQU 0x0050  ; _temp
v___x_156                      EQU 0x0032  ; x-->_portb_shadow:4
v____temp_102                  EQU 0x0051  ; _temp
v___x_157                      EQU 0x0032  ; x-->_portb_shadow:4
v____temp_103                  EQU 0x0052  ; _temp
v___x_158                      EQU 0x0032  ; x-->_portb_shadow:4
v____temp_104                  EQU 0x0053  ; _temp
v___x_159                      EQU 0x0032  ; x-->_portb_shadow:4
v____temp_105                  EQU 0x0054  ; _temp
v___x_160                      EQU 0x0032  ; x-->_portb_shadow:4
v____temp_106                  EQU 0x0055  ; _temp
v___x_161                      EQU 0x0032  ; x-->_portb_shadow:4
v____temp_107                  EQU 0x0056  ; _temp
v_y                            EQU 0x0057  ; medir:y
v_total                        EQU 0x0058  ; medir:total
v_cantidad                     EQU 0x005a  ; medir:cantidad
v____temp_98                   EQU 0x005b  ; medir:_temp
v___x_150                      EQU 0x0033  ; medir:x-->_portc_shadow:1
v___x_151                      EQU 0x0033  ; medir:x-->_portc_shadow:1
v____temp_96                   EQU 0       ; leer_rtc(): _temp
v___digi4_2                    EQU 0x005c  ; word2digits:digi4
v___digi3_2                    EQU 0x005d  ; word2digits:digi3
v___digi2_4                    EQU 0x005e  ; word2digits:digi2
v___digi1_4                    EQU 0x005f  ; word2digits:digi1
v___digi0_4                    EQU 0x0060  ; word2digits:digi0
v___numero_3                   EQU 0x0061  ; word2digits:numero
v_dec_miles                    EQU 0x0063  ; word2digits:dec_miles
v_miles                        EQU 0x0065  ; word2digits:miles
v___centena_1                  EQU 0x0067  ; word2digits:centena
v___decena_1                   EQU 0x0069  ; word2digits:decena
v___valor_1                    EQU 0x006a  ; valor_a_cm:valor
v___cms_1                      EQU 0x006c  ; valor_a_cm:cms
v__btemp52                     EQU 0x0110  ; valor_a_cm:_btemp52-->_bitbucket7:1
v__btemp53                     EQU 0x0110  ; valor_a_cm:_btemp53-->_bitbucket7:2
v__btemp54                     EQU 0x0110  ; valor_a_cm:_btemp54-->_bitbucket7:3
v__btemp55                     EQU 0x0110  ; valor_a_cm:_btemp55-->_bitbucket7:4
v__btemp56                     EQU 0x0110  ; valor_a_cm:_btemp56-->_bitbucket7:5
v__btemp57                     EQU 0x0110  ; valor_a_cm:_btemp57-->_bitbucket7:6
v__btemp58                     EQU 0x0110  ; valor_a_cm:_btemp58-->_bitbucket7:7
v__btemp59                     EQU 0x0110  ; valor_a_cm:_btemp59-->_bitbucket7:8
v__btemp60                     EQU 0x0110  ; valor_a_cm:_btemp60-->_bitbucket7:9
v__btemp61                     EQU 0x0110  ; valor_a_cm:_btemp61-->_bitbucket7:10
v__btemp62                     EQU 0x0110  ; valor_a_cm:_btemp62-->_bitbucket7:11
v__btemp63                     EQU 0x0110  ; valor_a_cm:_btemp63-->_bitbucket7:12
v__btemp64                     EQU 0x0110  ; valor_a_cm:_btemp64-->_bitbucket7:13
v__btemp65                     EQU 0x0110  ; valor_a_cm:_btemp65-->_bitbucket7:14
v__btemp66                     EQU 0x0110  ; valor_a_cm:_btemp66-->_bitbucket7:15
v__btemp67                     EQU 0x0110  ; valor_a_cm:_btemp67-->_bitbucket7:16
v__btemp68                     EQU 0x0110  ; valor_a_cm:_btemp68-->_bitbucket7:17
v__btemp69                     EQU 0x0110  ; valor_a_cm:_btemp69-->_bitbucket7:18
v__btemp70                     EQU 0x0110  ; valor_a_cm:_btemp70-->_bitbucket7:19
v__btemp71                     EQU 0x0110  ; valor_a_cm:_btemp71-->_bitbucket7:20
v__btemp72                     EQU 0x0110  ; valor_a_cm:_btemp72-->_bitbucket7:21
v__btemp73                     EQU 0x0110  ; valor_a_cm:_btemp73-->_bitbucket7:22
v__btemp74                     EQU 0x0110  ; valor_a_cm:_btemp74-->_bitbucket7:23
v__btemp75                     EQU 0x0110  ; valor_a_cm:_btemp75-->_bitbucket7:24
v__btemp76                     EQU 0x0110  ; valor_a_cm:_btemp76-->_bitbucket7:25
v__btemp77                     EQU 0x0110  ; valor_a_cm:_btemp77-->_bitbucket7:26
v__btemp78                     EQU 0x0110  ; valor_a_cm:_btemp78-->_bitbucket7:27
v__btemp79                     EQU 0x0110  ; valor_a_cm:_btemp79-->_bitbucket7:28
v__btemp80                     EQU 0x0110  ; valor_a_cm:_btemp80-->_bitbucket7:29
v__btemp81                     EQU 0x0110  ; valor_a_cm:_btemp81-->_bitbucket7:30
v__btemp82                     EQU 0x0110  ; valor_a_cm:_btemp82-->_bitbucket7:31
v__btemp83                     EQU 0x0110  ; valor_a_cm:_btemp83-->_bitbucket7:32
v__btemp84                     EQU 0x0110  ; valor_a_cm:_btemp84-->_bitbucket7:33
v__btemp85                     EQU 0x0110  ; valor_a_cm:_btemp85-->_bitbucket7:34
v__btemp86                     EQU 0x0110  ; valor_a_cm:_btemp86-->_bitbucket7:35
v__btemp87                     EQU 0x0110  ; valor_a_cm:_btemp87-->_bitbucket7:36
v__btemp88                     EQU 0x0110  ; valor_a_cm:_btemp88-->_bitbucket7:37
v__btemp89                     EQU 0x0110  ; valor_a_cm:_btemp89-->_bitbucket7:38
v__btemp90                     EQU 0x0110  ; valor_a_cm:_btemp90-->_bitbucket7:39
v__btemp91                     EQU 0x0110  ; valor_a_cm:_btemp91-->_bitbucket7:40
v__btemp92                     EQU 0x0110  ; valor_a_cm:_btemp92-->_bitbucket7:41
v__btemp93                     EQU 0x0110  ; valor_a_cm:_btemp93-->_bitbucket7:42
v__btemp94                     EQU 0x0110  ; valor_a_cm:_btemp94-->_bitbucket7:43
v__btemp95                     EQU 0x0110  ; valor_a_cm:_btemp95-->_bitbucket7:44
v__btemp96                     EQU 0x0110  ; valor_a_cm:_btemp96-->_bitbucket7:45
v__btemp97                     EQU 0x0110  ; valor_a_cm:_btemp97-->_bitbucket7:46
v__btemp98                     EQU 0x0110  ; valor_a_cm:_btemp98-->_bitbucket7:47
v__btemp99                     EQU 0x0110  ; valor_a_cm:_btemp99-->_bitbucket7:48
v__btemp100                    EQU 0x0110  ; valor_a_cm:_btemp100-->_bitbucket7:49
v__btemp101                    EQU 0x0110  ; valor_a_cm:_btemp101-->_bitbucket7:50
v__btemp102                    EQU 0x0110  ; valor_a_cm:_btemp102-->_bitbucket7:51
v__btemp103                    EQU 0x0110  ; valor_a_cm:_btemp103-->_bitbucket7:52
v__btemp104                    EQU 0x0110  ; valor_a_cm:_btemp104-->_bitbucket7:53
v__btemp105                    EQU 0x0110  ; valor_a_cm:_btemp105-->_bitbucket7:54
v__btemp106                    EQU 0x0110  ; valor_a_cm:_btemp106-->_bitbucket7:55
v__btemp107                    EQU 0x0110  ; valor_a_cm:_btemp107-->_bitbucket7:56
v__btemp108                    EQU 0x0110  ; valor_a_cm:_btemp108-->_bitbucket7:57
v__btemp109                    EQU 0x0110  ; valor_a_cm:_btemp109-->_bitbucket7:58
v__btemp110                    EQU 0x0110  ; valor_a_cm:_btemp110-->_bitbucket7:59
v__btemp111                    EQU 0x0110  ; valor_a_cm:_btemp111-->_bitbucket7:60
v__btemp112                    EQU 0x0110  ; valor_a_cm:_btemp112-->_bitbucket7:61
v__btemp113                    EQU 0x0110  ; valor_a_cm:_btemp113-->_bitbucket7:62
v__btemp114                    EQU 0x0110  ; valor_a_cm:_btemp114-->_bitbucket7:63
v__btemp115                    EQU 0x0110  ; valor_a_cm:_btemp115-->_bitbucket7:64
v__btemp116                    EQU 0x0110  ; valor_a_cm:_btemp116-->_bitbucket7:65
v__btemp117                    EQU 0x0110  ; valor_a_cm:_btemp117-->_bitbucket7:66
v__btemp118                    EQU 0x0110  ; valor_a_cm:_btemp118-->_bitbucket7:67
v__btemp119                    EQU 0x0110  ; valor_a_cm:_btemp119-->_bitbucket7:68
v__btemp120                    EQU 0x0110  ; valor_a_cm:_btemp120-->_bitbucket7:69
v__btemp121                    EQU 0x0110  ; valor_a_cm:_btemp121-->_bitbucket7:70
v__btemp122                    EQU 0x0110  ; valor_a_cm:_btemp122-->_bitbucket7:71
v__btemp123                    EQU 0x0110  ; valor_a_cm:_btemp123-->_bitbucket7:72
v__btemp124                    EQU 0x0110  ; valor_a_cm:_btemp124-->_bitbucket7:73
v__btemp125                    EQU 0x0110  ; valor_a_cm:_btemp125-->_bitbucket7:74
v__btemp126                    EQU 0x0110  ; valor_a_cm:_btemp126-->_bitbucket7:75
v__btemp127                    EQU 0x0110  ; valor_a_cm:_btemp127-->_bitbucket7:76
v__btemp128                    EQU 0x0110  ; valor_a_cm:_btemp128-->_bitbucket7:77
v__btemp129                    EQU 0x0110  ; valor_a_cm:_btemp129-->_bitbucket7:78
v__btemp130                    EQU 0x0110  ; valor_a_cm:_btemp130-->_bitbucket7:79
v__btemp131                    EQU 0x0110  ; valor_a_cm:_btemp131-->_bitbucket7:80
v__btemp132                    EQU 0x0110  ; valor_a_cm:_btemp132-->_bitbucket7:81
v__btemp133                    EQU 0x0110  ; valor_a_cm:_btemp133-->_bitbucket7:82
v__btemp134                    EQU 0x0110  ; valor_a_cm:_btemp134-->_bitbucket7:83
v__btemp135                    EQU 0x0110  ; valor_a_cm:_btemp135-->_bitbucket7:84
v__btemp136                    EQU 0x0110  ; valor_a_cm:_btemp136-->_bitbucket7:85
v__btemp137                    EQU 0x0110  ; valor_a_cm:_btemp137-->_bitbucket7:86
v__btemp138                    EQU 0x0110  ; valor_a_cm:_btemp138-->_bitbucket7:87
v__btemp139                    EQU 0x0110  ; valor_a_cm:_btemp139-->_bitbucket7:88
v__btemp140                    EQU 0x0110  ; valor_a_cm:_btemp140-->_bitbucket7:89
v__btemp141                    EQU 0x0110  ; valor_a_cm:_btemp141-->_bitbucket7:90
v__btemp142                    EQU 0x0110  ; valor_a_cm:_btemp142-->_bitbucket7:91
v__btemp143                    EQU 0x0110  ; valor_a_cm:_btemp143-->_bitbucket7:92
v__btemp144                    EQU 0x0110  ; valor_a_cm:_btemp144-->_bitbucket7:93
v__btemp145                    EQU 0x0110  ; valor_a_cm:_btemp145-->_bitbucket7:94
v__btemp146                    EQU 0x0110  ; valor_a_cm:_btemp146-->_bitbucket7:95
v__btemp147                    EQU 0x0110  ; valor_a_cm:_btemp147-->_bitbucket7:96
v__btemp148                    EQU 0x0110  ; valor_a_cm:_btemp148-->_bitbucket7:97
v__btemp149                    EQU 0x0110  ; valor_a_cm:_btemp149-->_bitbucket7:98
v__btemp150                    EQU 0x0110  ; valor_a_cm:_btemp150-->_bitbucket7:99
v__btemp151                    EQU 0x0110  ; valor_a_cm:_btemp151-->_bitbucket7:100
v__btemp152                    EQU 0x0110  ; valor_a_cm:_btemp152-->_bitbucket7:101
v__btemp153                    EQU 0x0110  ; valor_a_cm:_btemp153-->_bitbucket7:102
v__btemp154                    EQU 0x0110  ; valor_a_cm:_btemp154-->_bitbucket7:103
v__btemp155                    EQU 0x0110  ; valor_a_cm:_btemp155-->_bitbucket7:104
v__btemp156                    EQU 0x0110  ; valor_a_cm:_btemp156-->_bitbucket7:105
v__btemp157                    EQU 0x0110  ; valor_a_cm:_btemp157-->_bitbucket7:106
v__btemp158                    EQU 0x0110  ; valor_a_cm:_btemp158-->_bitbucket7:107
v__btemp159                    EQU 0x0110  ; valor_a_cm:_btemp159-->_bitbucket7:108
v__btemp160                    EQU 0x0110  ; valor_a_cm:_btemp160-->_bitbucket7:109
v__btemp161                    EQU 0x0110  ; valor_a_cm:_btemp161-->_bitbucket7:110
v__btemp162                    EQU 0x0110  ; valor_a_cm:_btemp162-->_bitbucket7:111
v__btemp163                    EQU 0x0110  ; valor_a_cm:_btemp163-->_bitbucket7:112
v__btemp164                    EQU 0x0110  ; valor_a_cm:_btemp164-->_bitbucket7:113
v__btemp165                    EQU 0x0110  ; valor_a_cm:_btemp165-->_bitbucket7:114
v__btemp166                    EQU 0x0110  ; valor_a_cm:_btemp166-->_bitbucket7:115
v__btemp167                    EQU 0x0110  ; valor_a_cm:_btemp167-->_bitbucket7:116
v__btemp168                    EQU 0x0110  ; valor_a_cm:_btemp168-->_bitbucket7:117
v__btemp169                    EQU 0x0110  ; valor_a_cm:_btemp169-->_bitbucket7:118
v__btemp170                    EQU 0x0110  ; valor_a_cm:_btemp170-->_bitbucket7:119
v__btemp171                    EQU 0x0110  ; valor_a_cm:_btemp171-->_bitbucket7:120
v__btemp182                    EQU 0x0110  ; valor_a_cm:_btemp182-->_bitbucket7:131
v__btemp183                    EQU 0x0110  ; valor_a_cm:_btemp183-->_bitbucket7:132
v__btemp184                    EQU 0x0110  ; valor_a_cm:_btemp184-->_bitbucket7:133
v__btemp185                    EQU 0x0110  ; valor_a_cm:_btemp185-->_bitbucket7:134
v__btemp186                    EQU 0x0110  ; valor_a_cm:_btemp186-->_bitbucket7:135
v__btemp187                    EQU 0x0110  ; valor_a_cm:_btemp187-->_bitbucket7:136
v__btemp188                    EQU 0x0110  ; valor_a_cm:_btemp188-->_bitbucket7:137
v__btemp189                    EQU 0x0110  ; valor_a_cm:_btemp189-->_bitbucket7:138
v__btemp190                    EQU 0x0110  ; valor_a_cm:_btemp190-->_bitbucket7:139
v__btemp191                    EQU 0x0110  ; valor_a_cm:_btemp191-->_bitbucket7:140
v__btemp192                    EQU 0x0110  ; valor_a_cm:_btemp192-->_bitbucket7:141
v__btemp193                    EQU 0x0110  ; valor_a_cm:_btemp193-->_bitbucket7:142
v__btemp194                    EQU 0x0110  ; valor_a_cm:_btemp194-->_bitbucket7:143
v__btemp195                    EQU 0x0110  ; valor_a_cm:_btemp195-->_bitbucket7:144
v__btemp196                    EQU 0x0110  ; valor_a_cm:_btemp196-->_bitbucket7:145
v__btemp197                    EQU 0x0110  ; valor_a_cm:_btemp197-->_bitbucket7:146
v__btemp198                    EQU 0x0110  ; valor_a_cm:_btemp198-->_bitbucket7:147
v__btemp199                    EQU 0x0110  ; valor_a_cm:_btemp199-->_bitbucket7:148
v__btemp200                    EQU 0x0110  ; valor_a_cm:_btemp200-->_bitbucket7:149
v__btemp201                    EQU 0x0110  ; valor_a_cm:_btemp201-->_bitbucket7:150
v__btemp202                    EQU 0x0110  ; valor_a_cm:_btemp202-->_bitbucket7:151
v__btemp203                    EQU 0x0110  ; valor_a_cm:_btemp203-->_bitbucket7:152
v__btemp204                    EQU 0x0110  ; valor_a_cm:_btemp204-->_bitbucket7:153
v__btemp205                    EQU 0x0110  ; valor_a_cm:_btemp205-->_bitbucket7:154
v__btemp206                    EQU 0x0110  ; valor_a_cm:_btemp206-->_bitbucket7:155
v__btemp207                    EQU 0x0110  ; valor_a_cm:_btemp207-->_bitbucket7:156
v__btemp208                    EQU 0x0110  ; valor_a_cm:_btemp208-->_bitbucket7:157
v__btemp209                    EQU 0x0110  ; valor_a_cm:_btemp209-->_bitbucket7:158
v__btemp210                    EQU 0x0110  ; valor_a_cm:_btemp210-->_bitbucket7:159
v__btemp211                    EQU 0x0110  ; valor_a_cm:_btemp211-->_bitbucket7:160
v__btemp212                    EQU 0x0110  ; valor_a_cm:_btemp212-->_bitbucket7:161
v__btemp213                    EQU 0x0110  ; valor_a_cm:_btemp213-->_bitbucket7:162
v__btemp214                    EQU 0x0110  ; valor_a_cm:_btemp214-->_bitbucket7:163
v__btemp215                    EQU 0x0110  ; valor_a_cm:_btemp215-->_bitbucket7:164
v__btemp216                    EQU 0x0110  ; valor_a_cm:_btemp216-->_bitbucket7:165
v__btemp217                    EQU 0x0110  ; valor_a_cm:_btemp217-->_bitbucket7:166
v__btemp218                    EQU 0x0110  ; valor_a_cm:_btemp218-->_bitbucket7:167
v__btemp219                    EQU 0x0110  ; valor_a_cm:_btemp219-->_bitbucket7:168
v__btemp220                    EQU 0x0110  ; valor_a_cm:_btemp220-->_bitbucket7:169
v__btemp221                    EQU 0x0110  ; valor_a_cm:_btemp221-->_bitbucket7:170
v__btemp222                    EQU 0x0110  ; valor_a_cm:_btemp222-->_bitbucket7:171
v__btemp223                    EQU 0x0110  ; valor_a_cm:_btemp223-->_bitbucket7:172
v__btemp224                    EQU 0x0110  ; valor_a_cm:_btemp224-->_bitbucket7:173
v__btemp225                    EQU 0x0110  ; valor_a_cm:_btemp225-->_bitbucket7:174
v__btemp226                    EQU 0x0110  ; valor_a_cm:_btemp226-->_bitbucket7:175
v__btemp227                    EQU 0x0110  ; valor_a_cm:_btemp227-->_bitbucket7:176
v__btemp228                    EQU 0x0110  ; valor_a_cm:_btemp228-->_bitbucket7:177
v__btemp229                    EQU 0x0110  ; valor_a_cm:_btemp229-->_bitbucket7:178
v__btemp230                    EQU 0x0110  ; valor_a_cm:_btemp230-->_bitbucket7:179
v__btemp231                    EQU 0x0110  ; valor_a_cm:_btemp231-->_bitbucket7:180
v__btemp232                    EQU 0x0110  ; valor_a_cm:_btemp232-->_bitbucket7:181
v__btemp233                    EQU 0x0110  ; valor_a_cm:_btemp233-->_bitbucket7:182
v__btemp234                    EQU 0x0110  ; valor_a_cm:_btemp234-->_bitbucket7:183
v__btemp235                    EQU 0x0110  ; valor_a_cm:_btemp235-->_bitbucket7:184
v__btemp236                    EQU 0x0110  ; valor_a_cm:_btemp236-->_bitbucket7:185
v__btemp237                    EQU 0x0110  ; valor_a_cm:_btemp237-->_bitbucket7:186
v__btemp238                    EQU 0x0110  ; valor_a_cm:_btemp238-->_bitbucket7:187
v__btemp239                    EQU 0x0110  ; valor_a_cm:_btemp239-->_bitbucket7:188
v__btemp240                    EQU 0x0110  ; valor_a_cm:_btemp240-->_bitbucket7:189
v__btemp241                    EQU 0x0110  ; valor_a_cm:_btemp241-->_bitbucket7:190
v__btemp242                    EQU 0x0110  ; valor_a_cm:_btemp242-->_bitbucket7:191
v__btemp243                    EQU 0x0110  ; valor_a_cm:_btemp243-->_bitbucket7:192
v__btemp244                    EQU 0x0110  ; valor_a_cm:_btemp244-->_bitbucket7:193
v__btemp245                    EQU 0x0110  ; valor_a_cm:_btemp245-->_bitbucket7:194
v__btemp246                    EQU 0x0110  ; valor_a_cm:_btemp246-->_bitbucket7:195
v__btemp247                    EQU 0x0110  ; valor_a_cm:_btemp247-->_bitbucket7:196
v__btemp248                    EQU 0x0110  ; valor_a_cm:_btemp248-->_bitbucket7:197
v__btemp249                    EQU 0x0110  ; valor_a_cm:_btemp249-->_bitbucket7:198
v__btemp250                    EQU 0x0110  ; valor_a_cm:_btemp250-->_bitbucket7:199
v__btemp251                    EQU 0x0110  ; valor_a_cm:_btemp251-->_bitbucket7:200
v__btemp252                    EQU 0x0110  ; valor_a_cm:_btemp252-->_bitbucket7:201
v__btemp253                    EQU 0x0110  ; valor_a_cm:_btemp253-->_bitbucket7:202
v__btemp254                    EQU 0x0110  ; valor_a_cm:_btemp254-->_bitbucket7:203
v__btemp255                    EQU 0x0110  ; valor_a_cm:_btemp255-->_bitbucket7:204
v__btemp256                    EQU 0x0110  ; valor_a_cm:_btemp256-->_bitbucket7:205
v__btemp257                    EQU 0x0110  ; valor_a_cm:_btemp257-->_bitbucket7:206
v__btemp258                    EQU 0x0110  ; valor_a_cm:_btemp258-->_bitbucket7:207
v__btemp259                    EQU 0x0110  ; valor_a_cm:_btemp259-->_bitbucket7:208
v__btemp260                    EQU 0x0110  ; valor_a_cm:_btemp260-->_bitbucket7:209
v__btemp261                    EQU 0x0110  ; valor_a_cm:_btemp261-->_bitbucket7:210
v__btemp262                    EQU 0x0110  ; valor_a_cm:_btemp262-->_bitbucket7:211
v__btemp263                    EQU 0x0110  ; valor_a_cm:_btemp263-->_bitbucket7:212
v__btemp264                    EQU 0x0110  ; valor_a_cm:_btemp264-->_bitbucket7:213
v__btemp265                    EQU 0x0110  ; valor_a_cm:_btemp265-->_bitbucket7:214
v__btemp266                    EQU 0x0110  ; valor_a_cm:_btemp266-->_bitbucket7:215
v__btemp267                    EQU 0x0110  ; valor_a_cm:_btemp267-->_bitbucket7:216
v__btemp268                    EQU 0x0110  ; valor_a_cm:_btemp268-->_bitbucket7:217
v__btemp269                    EQU 0x0110  ; valor_a_cm:_btemp269-->_bitbucket7:218
v__btemp270                    EQU 0x0110  ; valor_a_cm:_btemp270-->_bitbucket7:219
v__btemp271                    EQU 0x0110  ; valor_a_cm:_btemp271-->_bitbucket7:220
v__btemp272                    EQU 0x0110  ; valor_a_cm:_btemp272-->_bitbucket7:221
v__btemp273                    EQU 0x0110  ; valor_a_cm:_btemp273-->_bitbucket7:222
v__btemp274                    EQU 0x0110  ; valor_a_cm:_btemp274-->_bitbucket7:223
v__btemp275                    EQU 0x0110  ; valor_a_cm:_btemp275-->_bitbucket7:224
v__btemp276                    EQU 0x0110  ; valor_a_cm:_btemp276-->_bitbucket7:225
v__btemp277                    EQU 0x0110  ; valor_a_cm:_btemp277-->_bitbucket7:226
v__btemp278                    EQU 0x0110  ; valor_a_cm:_btemp278-->_bitbucket7:227
v__btemp279                    EQU 0x0110  ; valor_a_cm:_btemp279-->_bitbucket7:228
v__btemp280                    EQU 0x0110  ; valor_a_cm:_btemp280-->_bitbucket7:229
v__btemp281                    EQU 0x0110  ; valor_a_cm:_btemp281-->_bitbucket7:230
v__btemp282                    EQU 0x0110  ; valor_a_cm:_btemp282-->_bitbucket7:231
v__btemp283                    EQU 0x0110  ; valor_a_cm:_btemp283-->_bitbucket7:232
v__btemp284                    EQU 0x0110  ; valor_a_cm:_btemp284-->_bitbucket7:233
v__btemp285                    EQU 0x0110  ; valor_a_cm:_btemp285-->_bitbucket7:234
v__btemp286                    EQU 0x0110  ; valor_a_cm:_btemp286-->_bitbucket7:235
v__btemp287                    EQU 0x0110  ; valor_a_cm:_btemp287-->_bitbucket7:236
v__btemp288                    EQU 0x0110  ; valor_a_cm:_btemp288-->_bitbucket7:237
v__btemp289                    EQU 0x0110  ; valor_a_cm:_btemp289-->_bitbucket7:238
v__btemp290                    EQU 0x0110  ; valor_a_cm:_btemp290-->_bitbucket7:239
v__btemp291                    EQU 0x0110  ; valor_a_cm:_btemp291-->_bitbucket7:240
v__btemp292                    EQU 0x0110  ; valor_a_cm:_btemp292-->_bitbucket7:241
v__btemp293                    EQU 0x0110  ; valor_a_cm:_btemp293-->_bitbucket7:242
v__btemp294                    EQU 0x0110  ; valor_a_cm:_btemp294-->_bitbucket7:243
v__btemp295                    EQU 0x0110  ; valor_a_cm:_btemp295-->_bitbucket7:244
v__btemp296                    EQU 0x0110  ; valor_a_cm:_btemp296-->_bitbucket7:245
v__btemp297                    EQU 0x0110  ; valor_a_cm:_btemp297-->_bitbucket7:246
v__btemp298                    EQU 0x0110  ; valor_a_cm:_btemp298-->_bitbucket7:247
v__btemp299                    EQU 0x0110  ; valor_a_cm:_btemp299-->_bitbucket7:248
v__btemp300                    EQU 0x0110  ; valor_a_cm:_btemp300-->_bitbucket7:249
v__btemp301                    EQU 0x0110  ; valor_a_cm:_btemp301-->_bitbucket7:250
v__btemp302                    EQU 0x0110  ; valor_a_cm:_btemp302-->_bitbucket7:251
v__btemp303                    EQU 0x0110  ; valor_a_cm:_btemp303-->_bitbucket7:252
v__btemp304                    EQU 0x0110  ; valor_a_cm:_btemp304-->_bitbucket7:253
v__btemp305                    EQU 0x0110  ; valor_a_cm:_btemp305-->_bitbucket7:254
v__btemp306                    EQU 0x0110  ; valor_a_cm:_btemp306-->_bitbucket7:255
v__btemp307                    EQU 0x0110  ; valor_a_cm:_btemp307-->_bitbucket7:256
v__btemp308                    EQU 0x0110  ; valor_a_cm:_btemp308-->_bitbucket7:257
v__btemp309                    EQU 0x0110  ; valor_a_cm:_btemp309-->_bitbucket7:258
v__btemp310                    EQU 0x0110  ; valor_a_cm:_btemp310-->_bitbucket7:259
v__btemp311                    EQU 0x0110  ; valor_a_cm:_btemp311-->_bitbucket7:260
v__btemp312                    EQU 0x0110  ; valor_a_cm:_btemp312-->_bitbucket7:261
v__btemp313                    EQU 0x0110  ; valor_a_cm:_btemp313-->_bitbucket7:262
v__btemp314                    EQU 0x0110  ; valor_a_cm:_btemp314-->_bitbucket7:263
v__btemp315                    EQU 0x0110  ; valor_a_cm:_btemp315-->_bitbucket7:264
v__btemp316                    EQU 0x0110  ; valor_a_cm:_btemp316-->_bitbucket7:265
v__btemp317                    EQU 0x0110  ; valor_a_cm:_btemp317-->_bitbucket7:266
v__btemp318                    EQU 0x0110  ; valor_a_cm:_btemp318-->_bitbucket7:267
v__btemp319                    EQU 0x0110  ; valor_a_cm:_btemp319-->_bitbucket7:268
v__btemp320                    EQU 0x0110  ; valor_a_cm:_btemp320-->_bitbucket7:269
v__btemp321                    EQU 0x0110  ; valor_a_cm:_btemp321-->_bitbucket7:270
v__btemp322                    EQU 0x0110  ; valor_a_cm:_btemp322-->_bitbucket7:271
v__btemp323                    EQU 0x0110  ; valor_a_cm:_btemp323-->_bitbucket7:272
v__btemp324                    EQU 0x0110  ; valor_a_cm:_btemp324-->_bitbucket7:273
v__btemp325                    EQU 0x0110  ; valor_a_cm:_btemp325-->_bitbucket7:274
v____bitbucket_7               EQU 0x0110  ; valor_a_cm:_bitbucket
v___x_145                      EQU 0x0032  ; lcd_init:x-->_portb_shadow:4
v___value_15                   EQU 0x006e  ; lcd_init:value
v___x_146                      EQU 0x0032  ; lcd_init:x-->_portb_shadow:4
v____temp_89                   EQU 0x006f  ; lcd_init:_temp
v___value_16                   EQU 0x00dc  ; lcd_init:value
v___x_147                      EQU 0x0032  ; lcd_init:x-->_portb_shadow:4
v____temp_90                   EQU 0x00dd  ; lcd_init:_temp
v___value_17                   EQU 0x00de  ; lcd_init:value
v___x_148                      EQU 0x0032  ; lcd_init:x-->_portb_shadow:4
v____temp_91                   EQU 0x00df  ; lcd_init:_temp
v___value_18                   EQU 0x00e0  ; lcd_init:value
v___x_149                      EQU 0x0032  ; lcd_init:x-->_portb_shadow:4
v____temp_92                   EQU 0x00e1  ; lcd_init:_temp
v___str_3                      EQU 0       ; lcd_define(): str
v____temp_79                   EQU 0       ; lcd_progress(): _temp
v____temp_74                   EQU 0       ; lcd_clear_line(): _temp
v___value_12                   EQU 0x00e2  ; lcd_clear_screen:value
v___x_134                      EQU 0x0032  ; lcd_clear_screen:x-->_portb_shadow:4
v____temp_70                   EQU 0x00e3  ; lcd_clear_screen:_temp
v___line_3                     EQU 0x00e4  ; lcd_cursor_position:line
v___pos_1                      EQU 0x00e5  ; lcd_cursor_position:pos
v____temp_63                   EQU 0x00e6  ; lcd_cursor_position:_temp
v____rparam0_1                 EQU 0x00e7  ; lcd_cursor_position:_rparam0
v___x_129                      EQU 0x0032  ; lcd_cursor_position:x-->_portb_shadow:4
v____temp_65                   EQU 0x00e8  ; lcd_cursor_position:_temp
v___data_51                    EQU 0x002d  ; _lcd_put:data
v___x_128                      EQU 0x0032  ; _lcd_put:x-->_portb_shadow:4
v____temp_62                   EQU 0x002e  ; _lcd_put:_temp
v___line_1                     EQU 0x00e9  ; _lcd_line2index:line
v___value_1                    EQU 0x0031  ; __lcd_write_nibble:value
v_bit0                         EQU 0x0031  ; __lcd_write_nibble:bit0-->value1:0
v_bit1                         EQU 0x0031  ; __lcd_write_nibble:bit1-->value1:1
v_bit2                         EQU 0x0031  ; __lcd_write_nibble:bit2-->value1:2
v_bit3                         EQU 0x0031  ; __lcd_write_nibble:bit3-->value1:3
v___x_118                      EQU 0x0032  ; __lcd_write_nibble:x-->_portb_shadow:0
v___x_119                      EQU 0x0032  ; __lcd_write_nibble:x-->_portb_shadow:1
v___x_120                      EQU 0x0032  ; __lcd_write_nibble:x-->_portb_shadow:2
v___x_121                      EQU 0x0032  ; __lcd_write_nibble:x-->_portb_shadow:3
v___x_122                      EQU 0x0032  ; __lcd_write_nibble:x-->_portb_shadow:5
v___x_123                      EQU 0x0032  ; __lcd_write_nibble:x-->_portb_shadow:5
v___n_5                        EQU 0x00ea  ; delay_100ms:n
v__floop5                      EQU 0x00ec  ; delay_100ms:_floop5
v___n_3                        EQU 0x00ee  ; delay_1ms:n
v__floop4                      EQU 0x0133  ; delay_1ms:_floop4
v___n_1                        EQU 0x002f  ; delay_10us:n
v__floop3                      EQU 0x0030  ; delay_10us:_floop3
v___ack_1                      EQU 0x0136  ; i2c_receive_byte:ack-->_bitbucket43:0
v___data_47                    EQU 0x0135  ; i2c_receive_byte:data
v____bitbucket_43              EQU 0x0136  ; i2c_receive_byte:_bitbucket
v___data_46                    EQU 0x0137  ; i2c_transmit_byte:data
v____device_put_1              EQU 0x0138  ; print_string:_device_put
v__str_count                   EQU 0x013a  ; print_string:_str_count
v___str_1                      EQU 0x013c  ; print_string:str
v_len                          EQU 0x013e  ; print_string:len
v_i                            EQU 0x0140  ; print_string:i
;    7 include 16f877a
                               org      0
                               branchhi_clr l__main
                               branchlo_clr l__main
                               goto     l__main
                               addwf    v__pcl,f
l__data_msg_fuera_de_rango_inf
                               retlw    79
                               retlw    117
                               retlw    116
                               retlw    32
                               retlw    73
                               retlw    78
                               retlw    70
                               retlw    33
                               addwf    v__pcl,f
l__data_msg_fuera_de_rango_sup
                               retlw    79
                               retlw    117
                               retlw    116
                               retlw    32
                               retlw    83
                               retlw    85
                               retlw    80
                               retlw    33
                               addwf    v__pcl,f
l__data_msg_ok
                               retlw    79
                               retlw    75
                               addwf    v__pcl,f
l__data_msg_cm
                               retlw    99
                               retlw    109
l__pic_multiply
                               movlw    16
                               movwf    v__pic_loop
l__l1206
                               bcf      v__status, v__c
                               rlf      v__pic_mresult,f
                               rlf      v__pic_mresult+1,f
                               bcf      v__status, v__c
                               rlf      v__pic_multiplier,f
                               rlf      v__pic_multiplier+1,f
                               btfss    v__status, v__c
                               goto     l__l1207
                               movf     v__pic_multiplicand+1,w
                               addwf    v__pic_mresult+1,f
                               movf     v__pic_multiplicand,w
                               addwf    v__pic_mresult,f
                               btfsc    v__status, v__c
                               incf     v__pic_mresult+1,f
l__l1207
                               decfsz   v__pic_loop,f
                               goto     l__l1206
                               return   
l__pic_divide
                               movlw    16
                               movwf    v__pic_loop
                               clrf     v__pic_remainder
                               clrf     v__pic_remainder+1
l__l1208
                               bcf      v__status, v__c
                               rlf      v__pic_quotient,f
                               rlf      v__pic_quotient+1,f
                               bcf      v__status, v__c
                               rlf      v__pic_divaccum,f
                               rlf      v__pic_divaccum+1,f
                               rlf      v__pic_divaccum+2,f
                               rlf      v__pic_divaccum+3,f
                               movf     v__pic_remainder+1,w
                               subwf    v__pic_divisor+1,w
                               btfss    v__status, v__z
                               goto     l__l1211
                               movf     v__pic_remainder,w
                               subwf    v__pic_divisor,w
l__l1211
                               btfsc    v__status, v__z
                               goto     l__l1210
                               btfsc    v__status, v__c
                               goto     l__l1209
l__l1210
                               movf     v__pic_divisor+1,w
                               subwf    v__pic_remainder+1,f
                               movf     v__pic_divisor,w
                               subwf    v__pic_remainder,f
                               btfss    v__status, v__c
                               decf     v__pic_remainder+1,f
                               bsf      v__pic_quotient, 0
l__l1209
                               decfsz   v__pic_loop,f
                               goto     l__l1208
                               return   
l__pic_indirect
                               movwf    v__pclath
                               datahi_clr v__pic_pointer
                               movf     v__pic_pointer,w
                               movwf    v__pcl
l__main
;   14 enable_digital_io()
; 16f877a.jal
; 1046    ADCON0 = 0b0000_0000         -- disable ADC
                               clrf     v_adcon0
; 1047    ADCON1 = 0b0000_0111         -- digital I/O
                               movlw    7
                               datalo_set v_adcon1
                               movwf    v_adcon1
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;   14 enable_digital_io()
; 16f877a.jal
; 1061    adc_off()
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;   14 enable_digital_io()
; 16f877a.jal
; 1054    CMCON  = 0b0000_0111        -- disable comparator
                               movlw    7
                               movwf    v_cmcon
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;   14 enable_digital_io()
; 16f877a.jal
; 1062    comparator_off()
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;   14 enable_digital_io()
; print.jal
;   58 procedure print_crlf(volatile byte out device) is
                               goto     l__l299
;   63 procedure print_string(volatile byte out device, byte in str[]) is
l_print_string
;   64    var word len = count(str)
                               movf     v__str_count,w
                               movwf    v_len
                               movf     v__str_count+1,w
                               movwf    v_len+1
;   67    for len using i loop           
                               clrf     v_i
                               goto     l__l189
l__l188
;   71       device = str[i]
                               datahi_set v___str_1
                               movf     v___str_1+1,w
                               datahi_clr v__pic_pointer
                               movwf    v__pic_pointer+1
                               datahi_set v_i
                               movf     v_i,w
                               addwf    v___str_1,w
                               datahi_clr v__pic_pointer
                               movwf    v__pic_pointer
                               btfsc    v__status, v__c
                               incf     v__pic_pointer+1,f
                               bcf      v__pic_pointer+1, 6
                               movf     v__pic_pointer+1,w
                               call     l__pic_indirect
                               datalo_clr v__pic_temp
                               datahi_clr v__pic_temp
                               movwf    v__pic_temp
                               datahi_set v____device_put_1
                               movf     v____device_put_1,w
                               datahi_clr v__pic_pointer
                               movwf    v__pic_pointer
                               datahi_set v____device_put_1
                               movf     v____device_put_1+1,w
                               branchlo_clr l__pic_indirect
                               branchhi_clr l__pic_indirect
                               call     l__pic_indirect
;   72    end loop
                               datalo_clr v_i
                               datahi_set v_i
                               incf     v_i,f
l__l189
                               movf     v_i,w
                               subwf    v_len,w
                               datahi_clr v__pic_temp
                               movwf    v__pic_temp
                               datahi_set v_len
                               movf     v_len+1,w
                               datahi_clr v__pic_temp
                               iorwf    v__pic_temp,w
                               branchlo_clr l__l188
                               branchhi_clr l__l188
                               btfss    v__status, v__z
                               goto     l__l188
;   74 end procedure
                               return   
; i2c_hardware.jal
;   36 procedure i2c_initialize() is
l_i2c_initialize
;   41    pin_SCL_direction = input
                               bsf      v_trisc, 3 ; pin_c3_direction
;   42    pin_SDA_direction = input
                               bsf      v_trisc, 4 ; pin_c4_direction
;   44    sspcon  = 0b0010_1000   -- set up 16f87x as master device
                               movlw    40
                               datalo_clr v_sspcon
                               movwf    v_sspcon
;   45    sspcon2 = 0b0010_0000   -- sets default acknowledge bit value
                               movlw    32
                               datalo_set v_sspcon2
                               movwf    v_sspcon2
;   49    if    _i2c_bus_speed == 10 then sspadd = _i2c_1mhz
                               movlw    4
                               movwf    v_sspadd
;   57       sspstat = 0b_0000_0000   ;i2c bus levels, CKE=0
                               clrf     v_sspstat
;   61 end procedure
                               return   
;   68 procedure i2c_start() is
l_i2c_start
;   69    SSPCON2_SEN = high
                               datalo_set v_sspcon2 ; sspcon2_sen
                               bsf      v_sspcon2, 0 ; sspcon2_sen
;   70    while SSPCON2_SEN == high loop end loop
l__l279
                               btfss    v_sspcon2, 0 ; sspcon2_sen
                               goto     l__l280
                               goto     l__l279
l__l280
;   71 end procedure
                               return   
;   77 procedure i2c_restart() is
l_i2c_restart
;   78    SSPCON2_RSEN = high
                               datalo_set v_sspcon2 ; sspcon2_rsen
                               bsf      v_sspcon2, 1 ; sspcon2_rsen
;   79    while SSPCON2_RSEN == high loop end loop
l__l284
                               btfss    v_sspcon2, 1 ; sspcon2_rsen
                               goto     l__l285
                               goto     l__l284
l__l285
;   80 end procedure
                               return   
;   86 procedure i2c_stop() is
l_i2c_stop
;   87    SSPCON2_PEN = high
                               datalo_set v_sspcon2 ; sspcon2_pen
                               bsf      v_sspcon2, 2 ; sspcon2_pen
;   88    while SSPCON2_PEN == high loop end loop
l__l289
                               btfss    v_sspcon2, 2 ; sspcon2_pen
                               goto     l__l290
                               goto     l__l289
l__l290
;   89 end procedure
                               return   
;   96 function i2c_transmit_byte(byte in data) return bit is
l_i2c_transmit_byte
                               datalo_clr v___data_46
                               datahi_set v___data_46
                               movwf    v___data_46
;   98    PIR1_SSPIF = false  ; clear pending flag
                               datahi_clr v_pir1 ; pir1_sspif
                               bcf      v_pir1, 3 ; pir1_sspif
;   99    sspbuf = data       ; write data
                               datahi_set v___data_46
                               movf     v___data_46,w
                               datahi_clr v_sspbuf
                               movwf    v_sspbuf
;  102    while ! PIR1_SSPIF loop end loop
l__l294
                               btfsc    v_pir1, 3 ; pir1_sspif
                               goto     l__l295
                               goto     l__l294
l__l295
;  107    if SSPCON2_ACKSTAT == low  then
                               datalo_set v_sspcon2 ; sspcon2_ackstat
                               btfsc    v_sspcon2, 6 ; sspcon2_ackstat
                               goto     l__l298
;  108       return true -- okay
                               datalo_clr v__pic_temp ; _pic_temp
                               bsf      v__pic_temp, 0 ; _pic_temp
                               return   
;  109    else
l__l298
;  110       sspcon_sspen = false;
                               datalo_clr v_sspcon ; sspcon_sspen
                               bcf      v_sspcon, 5 ; sspcon_sspen
;  111       sspcon_sspen = true;
                               bsf      v_sspcon, 5 ; sspcon_sspen
;  113       return false -- no response
                               bcf      v__pic_temp, 0 ; _pic_temp
;  114    end if
;  115 end function
l__l293
                               return   
;  127 function i2c_receive_byte(bit in ACK ) return byte is
l_i2c_receive_byte
;  130    SSPCON2_RCEN = high
                               datalo_set v_sspcon2 ; sspcon2_rcen
                               datahi_clr v_sspcon2 ; sspcon2_rcen
                               bsf      v_sspcon2, 3 ; sspcon2_rcen
;  132    while SSPSTAT_BF == low loop  end loop
l__l301
                               btfsc    v_sspstat, 0 ; sspstat_bf
                               goto     l__l302
                               goto     l__l301
l__l302
;  136    SSPCON2_ACKDT = ! ACK
                               datalo_clr v____bitbucket_43 ; ack1
                               datahi_set v____bitbucket_43 ; ack1
                               btfss    v____bitbucket_43, 0 ; ack1
                               goto     l__l1213
                               datalo_set v_sspcon2 ; sspcon2_ackdt
                               datahi_clr v_sspcon2 ; sspcon2_ackdt
                               bcf      v_sspcon2, 5 ; sspcon2_ackdt
                               goto     l__l1212
l__l1213
                               datalo_set v_sspcon2 ; sspcon2_ackdt
                               datahi_clr v_sspcon2 ; sspcon2_ackdt
                               bsf      v_sspcon2, 5 ; sspcon2_ackdt
l__l1212
;  137    SSPCON2_ACKEN = high
                               bsf      v_sspcon2, 4 ; sspcon2_acken
;  138    while SSPCON2_ACKEN == high loop end loop
l__l304
                               btfss    v_sspcon2, 4 ; sspcon2_acken
                               goto     l__l305
                               goto     l__l304
l__l305
;  141    data = sspbuf
                               datalo_clr v_sspbuf
                               movf     v_sspbuf,w
                               datahi_set v___data_47
                               movwf    v___data_47
;  145    return data
                               movf     v___data_47,w
;  146 end function
                               return   
l__l299
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;   39 i2c_initialize()
                               call     l_i2c_initialize
;   53 portb_direction = all_output
                               datalo_set v_portb_direction
                               clrf     v_portb_direction
;   56 pin_b6_direction = output
                               bcf      v_trisb, 6 ; pin_b6_direction
;   57 pin_b0_direction = output
                               bcf      v_trisb, 0 ; pin_b0_direction
;   58 pin_b1_direction = output
                               bcf      v_trisb, 1 ; pin_b1_direction
;   59 pin_b2_direction = output
                               bcf      v_trisb, 2 ; pin_b2_direction
;   63 pin_c1_direction = output
                               datahi_clr v_trisc ; pin_c1_direction
                               bcf      v_trisc, 1 ; pin_c1_direction
;   66 pin_c2_direction = input
                               bsf      v_trisc, 2 ; pin_c2_direction
; delay.jal
;   27 procedure delay_1us() is
                               branchlo_clr l__l371
                               branchhi_clr l__l371
                               goto     l__l371
;   84 procedure delay_10us(byte in n) is
l_delay_10us
                               datalo_clr v___n_1
                               datahi_clr v___n_1
                               movwf    v___n_1
;   85    if n==0 then
                               movf     v___n_1,w
                               btfsc    v__status, v__z
;   86       return
                               return   
;   87    elsif n==1 then
l__l328
                               movlw    1
                               subwf    v___n_1,w
                               btfss    v__status, v__z
                               goto     l__l329
;   90        _usec_delay(_ten_us_delay1)
                               datalo_clr v__pic_temp
                               datahi_clr v__pic_temp
                               movlw    10
                               movwf    v__pic_temp
                               branchhi_clr l__l1214
                               branchlo_clr l__l1214
l__l1214
                               decfsz   v__pic_temp,f
                               goto     l__l1214
;   91      end if
                               return   
;   92    else     
l__l329
;   93       n = n - 1;
                               decf     v___n_1,f
;   96          _usec_delay(_ten_us_delay2)   
                               datalo_clr v__pic_temp
                               datahi_clr v__pic_temp
                               movlw    6
                               movwf    v__pic_temp
                               branchhi_clr l__l1215
                               branchlo_clr l__l1215
l__l1215
                               decfsz   v__pic_temp,f
                               goto     l__l1215
                               nop      
                               nop      
;  102       for n loop
                               clrf     v__floop3
                               goto     l__l335
l__l334
;  104             _usec_delay(_ten_us_delay3)
                               datalo_clr v__pic_temp
                               datahi_clr v__pic_temp
                               movlw    13
                               movwf    v__pic_temp
                               branchhi_clr l__l1216
                               branchlo_clr l__l1216
l__l1216
                               decfsz   v__pic_temp,f
                               goto     l__l1216
                               nop      
;  108       end loop
                               incf     v__floop3,f
l__l335
                               movf     v__floop3,w
                               subwf    v___n_1,w
                               btfss    v__status, v__z
                               goto     l__l334
;  109    end if
l__l327
;  111 end procedure
l__l326
                               return   
;  114 procedure delay_1ms(word in n) is
l_delay_1ms
;  116    for n loop
                               datalo_clr v__floop4
                               datahi_set v__floop4
                               clrf     v__floop4
                               clrf     v__floop4+1
                               goto     l__l342
l__l341
;  118          _usec_delay(_one_ms_delay)
                               datalo_clr v__pic_temp
                               datahi_clr v__pic_temp
                               movlw    6
                               movwf    v__pic_temp
l__l1217
                               movlw    165
                               movwf    v__pic_temp+1
l__l1218
                               branchhi_clr l__l1218
                               branchlo_clr l__l1218
                               decfsz   v__pic_temp+1,f
                               goto     l__l1218
                               branchhi_clr l__l1217
                               branchlo_clr l__l1217
                               decfsz   v__pic_temp,f
                               goto     l__l1217
                               nop      
;  122    end loop
                               datahi_set v__floop4
                               incf     v__floop4,f
                               btfsc    v__status, v__z
                               incf     v__floop4+1,f
l__l342
                               movf     v__floop4,w
                               datalo_set v___n_3
                               datahi_clr v___n_3
                               subwf    v___n_3,w
                               datalo_clr v__pic_temp
                               movwf    v__pic_temp
                               datahi_set v__floop4
                               movf     v__floop4+1,w
                               datalo_set v___n_3
                               datahi_clr v___n_3
                               subwf    v___n_3+1,w
                               datalo_clr v__pic_temp
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l341
;  123 end procedure
                               return   
;  126 procedure delay_100ms(word in n) is
l_delay_100ms
;  128    for n loop
                               clrf     v__floop5
                               clrf     v__floop5+1
                               goto     l__l349
l__l348
;  129       _usec_delay(_100_ms_delay)
                               datalo_clr v__pic_temp
                               datahi_clr v__pic_temp
                               movlw    94
                               movwf    v__pic_temp
l__l1219
                               movlw    253
                               movwf    v__pic_temp+1
l__l1220
                               movlw    3
                               movwf    v__pic_temp+2
l__l1221
                               branchhi_clr l__l1221
                               branchlo_clr l__l1221
                               decfsz   v__pic_temp+2,f
                               goto     l__l1221
                               branchhi_clr l__l1220
                               branchlo_clr l__l1220
                               decfsz   v__pic_temp+1,f
                               goto     l__l1220
                               branchhi_clr l__l1219
                               branchlo_clr l__l1219
                               decfsz   v__pic_temp,f
                               goto     l__l1219
                               nop      
;  130    end loop
                               datalo_set v__floop5
                               incf     v__floop5,f
                               btfsc    v__status, v__z
                               incf     v__floop5+1,f
l__l349
                               movf     v__floop5,w
                               subwf    v___n_5,w
                               datalo_clr v__pic_temp
                               movwf    v__pic_temp
                               datalo_set v__floop5
                               movf     v__floop5+1,w
                               subwf    v___n_5+1,w
                               datalo_clr v__pic_temp
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l348
;  131 end procedure
                               return   
; lcd_hd44780_4.jal
;   73 procedure __lcd_write_nibble(byte in value) is
l___lcd_write_nibble
                               datalo_clr v___value_1
                               datahi_clr v___value_1
                               movwf    v___value_1
;   85       lcd_d4 = bit0                             -- )
                               bcf      v__portb_shadow, 0 ; x118
                               btfsc    v___value_1, 0 ; bit0
                               bsf      v__portb_shadow, 0 ; x118
; 16f877a.jal
;  281    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_4.jal
;   85       lcd_d4 = bit0                             -- )
;   86       lcd_d5 = bit1                             -- )
                               bcf      v__portb_shadow, 1 ; x119
                               btfsc    v___value_1, 1 ; bit1
                               bsf      v__portb_shadow, 1 ; x119
; 16f877a.jal
;  272    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_4.jal
;   86       lcd_d5 = bit1                             -- )
;   87       lcd_d6 = bit2                             -- ) write databits
                               bcf      v__portb_shadow, 2 ; x120
                               btfsc    v___value_1, 2 ; bit2
                               bsf      v__portb_shadow, 2 ; x120
; 16f877a.jal
;  264    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_4.jal
;   87       lcd_d6 = bit2                             -- ) write databits
;   88       lcd_d7 = bit3                             -- )
                               bcf      v__portb_shadow, 3 ; x121
                               btfsc    v___value_1, 3 ; bit3
                               bsf      v__portb_shadow, 3 ; x121
; 16f877a.jal
;  256    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_4.jal
;   88       lcd_d7 = bit3                             -- )
;   91    lcd_en = HIGH                                -- trigger on
                               bsf      v__portb_shadow, 5 ; x122
; 16f877a.jal
;  239    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_4.jal
;   91    lcd_en = HIGH                                -- trigger on
;   92    _usec_delay(1)                               -- delay (> 400 ns)
                               nop      
                               nop      
                               nop      
                               nop      
                               nop      
;   93    lcd_en = LOW                                 -- trigger off
                               bcf      v__portb_shadow, 5 ; x123
; 16f877a.jal
;  239    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_4.jal
;   93    lcd_en = LOW                                 -- trigger off
;   95 end procedure
                               return   
;  137 end procedure
l__l371
; lcd_hd44780_common.jal
;   37 var volatile byte lcd_pos     = 0
                               datalo_clr v_lcd_pos
                               clrf     v_lcd_pos
;   42 function _lcd_line2index(byte in line) return byte is
                               goto     l__l524
l__lcd_line2index
                               movwf    v___line_1
;   45    if (line >= LCD_ROWS) then
                               movlw    2
                               subwf    v___line_1,w
                               btfsc    v__status, v__z
                               goto     l__l1223
                               btfss    v__status, v__c
                               goto     l__l378
l__l1223
;   46       line = 0
                               clrf     v___line_1
;   47    end if
l__l378
;   49    case line of
;   50       0: return 0x00
                               movf     v___line_1,w
                               btfsc    v__status, v__z
                               retlw    0
l__l379
;   51       1: return 0x40
                               movlw    1
                               subwf    v___line_1,w
                               btfsc    v__status, v__z
                               retlw    64
l__l382
;   52       2: return 0x00 + LCD_CHARS
                               movlw    2
                               subwf    v___line_1,w
                               btfsc    v__status, v__z
                               retlw    16
l__l384
;   53       3: return 0x40 + LCD_CHARS
                               movlw    3
                               subwf    v___line_1,w
                               btfsc    v__status, v__z
                               retlw    80
l__l386
;   56 end function
l__l376
                               return   
;   87 procedure lcd'put(byte in data) is
l__lcd_put
                               datalo_clr v__pic_temp
                               datahi_clr v__pic_temp
                               movf     v__pic_temp,w
                               movwf    v___data_51
;   89    _lcd_write_data(data)
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
                               bsf      v__portb_shadow, 4 ; x128
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_common.jal
;   89    _lcd_write_data(data)
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
; lcd_hd44780_common.jal
;   89    _lcd_write_data(data)
; lcd_hd44780_4.jal
;  106    __lcd_write_nibble(value >> 4)               -- write high nibble
                               swapf    v___data_51,w
                               andlw    15
                               movwf    v____temp_62
                               movf     v____temp_62,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  107    __lcd_write_nibble(value)                    -- write low nibble
                               datalo_clr v___data_51
                               datahi_clr v___data_51
                               movf     v___data_51,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  108    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               goto     l_delay_10us
; lcd_hd44780_common.jal
;   89    _lcd_write_data(data)
; lcd_hd44780_4.jal
;  121    __lcd_write(value)                           -- write byte
; lcd_hd44780_common.jal
;   89    _lcd_write_data(data)
;   91 end procedure
;  108 procedure lcd_cursor_position(byte in line, byte in pos) is
l_lcd_cursor_position
                               movwf    v___line_3
;  110    lcd_pos = pos + _lcd_line2index(line)
                               movf     v___line_3,w
                               call     l__lcd_line2index
                               datalo_set v____temp_63
                               datahi_clr v____temp_63
                               movwf    v____temp_63
                               movf     v____temp_63,w
                               addwf    v___pos_1,w
                               datalo_clr v_lcd_pos
                               movwf    v_lcd_pos
;  111    _lcd_restore_cursor()
                               movlw    128
                               iorwf    v_lcd_pos,w
                               datalo_set v____rparam0_1
                               movwf    v____rparam0_1
; lcd_hd44780_4.jal
;  134    lcd_rs = low                                 -- select command mode
                               datalo_clr v__portb_shadow ; x129
                               bcf      v__portb_shadow, 4 ; x129
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_common.jal
;  111    _lcd_restore_cursor()
; lcd_hd44780_4.jal
;  134    lcd_rs = low                                 -- select command mode
; lcd_hd44780_common.jal
;  111    _lcd_restore_cursor()
; lcd_hd44780_4.jal
;  106    __lcd_write_nibble(value >> 4)               -- write high nibble
                               datalo_set v____rparam0_1
                               swapf    v____rparam0_1,w
                               andlw    15
                               movwf    v____temp_65
                               movf     v____temp_65,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  107    __lcd_write_nibble(value)                    -- write low nibble
                               datalo_set v____rparam0_1
                               datahi_clr v____rparam0_1
                               movf     v____rparam0_1,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  108    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               goto     l_delay_10us
; lcd_hd44780_common.jal
;  111    _lcd_restore_cursor()
; lcd_hd44780_4.jal
;  135    __lcd_write(value)                           -- write byte
; lcd_hd44780_common.jal
;  111    _lcd_restore_cursor()
l_lcd_clear_screen
                               movlw    1
                               datalo_set v___value_12
                               datahi_clr v___value_12
                               movwf    v___value_12
; lcd_hd44780_4.jal
;  134    lcd_rs = low                                 -- select command mode
                               datalo_clr v__portb_shadow ; x134
                               bcf      v__portb_shadow, 4 ; x134
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_common.jal
;  177    _lcd_write_command(LCD_CLEAR_DISPLAY)
; lcd_hd44780_4.jal
;  134    lcd_rs = low                                 -- select command mode
; lcd_hd44780_common.jal
;  177    _lcd_write_command(LCD_CLEAR_DISPLAY)
; lcd_hd44780_4.jal
;  106    __lcd_write_nibble(value >> 4)               -- write high nibble
                               datalo_set v___value_12
                               swapf    v___value_12,w
                               andlw    15
                               movwf    v____temp_70
                               movf     v____temp_70,w
                               call     l___lcd_write_nibble
;  107    __lcd_write_nibble(value)                    -- write low nibble
                               datalo_set v___value_12
                               datahi_clr v___value_12
                               movf     v___value_12,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  108    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
; lcd_hd44780_common.jal
;  177    _lcd_write_command(LCD_CLEAR_DISPLAY)
; lcd_hd44780_4.jal
;  135    __lcd_write(value)                           -- write byte
; lcd_hd44780_common.jal
;  177    _lcd_write_command(LCD_CLEAR_DISPLAY)
;  178    delay_10us(180)
                               movlw    180
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               goto     l_delay_10us
;  180 end procedure
; lcd_hd44780_4.jal
;  146 procedure lcd_init() is
l_lcd_init
;  148    lcd_rs = LOW                                 -- set to control char mode
                               bcf      v__portb_shadow, 4 ; x145
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_4.jal
;  148    lcd_rs = LOW                                 -- set to control char mode
;  149    delay_1ms(25)                                -- power-up delay (> 15 ms)
                               movlw    25
                               datalo_set v___n_3
                               movwf    v___n_3
                               clrf     v___n_3+1
                               call     l_delay_1ms
;  150    __lcd_write_nibble(0b0000_0011)              -- function set
                               movlw    3
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  151    delay_1ms(5)                                 -- > 4.1 milliseconds
                               movlw    5
                               datalo_set v___n_3
                               datahi_clr v___n_3
                               movwf    v___n_3
                               clrf     v___n_3+1
                               branchlo_clr l_delay_1ms
                               branchhi_clr l_delay_1ms
                               call     l_delay_1ms
;  152    __lcd_write_nibble(0b0000_0011)              -- function set
                               movlw    3
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  153    delay_10us(10)                               -- > 100 us
                               movlw    10
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
;  154    __lcd_write_nibble(0b0000_0011)              -- function set
                               movlw    3
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  155    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
;  156    __lcd_write_nibble(0b0000_0010)              -- select 4-bits mode
                               movlw    2
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  157    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
;  158    _lcd_write_command(0b_0010_1000)             -- 2 lines, 5x8 dots font
                               movlw    40
                               datalo_clr v___value_15
                               datahi_clr v___value_15
                               movwf    v___value_15
                               bcf      v__portb_shadow, 4 ; x146
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_4.jal
;  158    _lcd_write_command(0b_0010_1000)             -- 2 lines, 5x8 dots font
                               swapf    v___value_15,w
                               andlw    15
                               movwf    v____temp_89
                               movf     v____temp_89,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
                               datalo_clr v___value_15
                               datahi_clr v___value_15
                               movf     v___value_15,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
                               movlw    28
                               datalo_set v___value_16
                               datahi_clr v___value_16
                               movwf    v___value_16
                               datalo_clr v__portb_shadow ; x147
                               bcf      v__portb_shadow, 4 ; x147
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_4.jal
;  159    _lcd_write_command(0b_0001_1100)             -- cursor (not data) move right
                               datalo_set v___value_16
                               swapf    v___value_16,w
                               andlw    15
                               movwf    v____temp_90
                               movf     v____temp_90,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
                               datalo_set v___value_16
                               datahi_clr v___value_16
                               movf     v___value_16,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
                               movlw    12
                               datalo_set v___value_17
                               datahi_clr v___value_17
                               movwf    v___value_17
                               datalo_clr v__portb_shadow ; x148
                               bcf      v__portb_shadow, 4 ; x148
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_4.jal
;  160    _lcd_write_command(0b_0000_1100)             -- display on, cursor off, no blink
                               datalo_set v___value_17
                               swapf    v___value_17,w
                               andlw    15
                               movwf    v____temp_91
                               movf     v____temp_91,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
                               datalo_set v___value_17
                               datahi_clr v___value_17
                               movf     v___value_17,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
                               movlw    6
                               datalo_set v___value_18
                               datahi_clr v___value_18
                               movwf    v___value_18
                               datalo_clr v__portb_shadow ; x149
                               bcf      v__portb_shadow, 4 ; x149
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; lcd_hd44780_4.jal
;  161    _lcd_write_command(0b_0000_0110)             -- cursor shift right, no data shift
                               datalo_set v___value_18
                               swapf    v___value_18,w
                               andlw    15
                               movwf    v____temp_92
                               movf     v____temp_92,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
                               datalo_set v___value_18
                               datahi_clr v___value_18
                               movf     v___value_18,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
                               branchlo_clr l_lcd_clear_screen
                               branchhi_clr l_lcd_clear_screen
                               goto     l_lcd_clear_screen
l__l524
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;   70 lcd_init()
                               call     l_lcd_init
; lib_murata_completa_mejorada.jal
;   12 procedure valor_a_cm(word in valor, word out cms) is
                               branchlo_set l__l539
                               branchhi_clr l__l539
                               goto     l__l539
l_valor_a_cm
;   14    if valor > 1000 then   ; fuera de rango
                               movlw    3
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1224
                               movlw    232
                               subwf    v___valor_1,w
l__l1224
                               btfsc    v__status, v__z
                               goto     l__l542
                               btfss    v__status, v__c
                               goto     l__l542
;   15       cms=2
                               movlw    2
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;   16       return
                               return   
;   17    end if
l__l542
;  555    if valor <= 368 & valor >= 363 then
                               movlw    1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1226
                               movlw    112
                               subwf    v___valor_1,w
l__l1226
                               datahi_set v____bitbucket_7 ; _btemp52
                               bcf      v____bitbucket_7, 1 ; _btemp52
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7, 1 ; _btemp52
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1227
                               movlw    107
                               subwf    v___valor_1,w
l__l1227
                               datahi_set v____bitbucket_7 ; _btemp53
                               bcf      v____bitbucket_7, 2 ; _btemp53
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7, 2 ; _btemp53
                               bsf      v____bitbucket_7, 3 ; _btemp54
                               btfsc    v____bitbucket_7, 1 ; _btemp52
                               btfss    v____bitbucket_7, 2 ; _btemp53
                               bcf      v____bitbucket_7, 3 ; _btemp54
                               btfss    v____bitbucket_7, 3 ; _btemp54
                               goto     l__l544
;  556       cms=149
                               movlw    149
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  557       return
                               return   
;  558    end if
l__l544
;  559    if valor <= 362 & valor >= 357 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1230
                               movlw    106
                               subwf    v___valor_1,w
l__l1230
                               datahi_set v____bitbucket_7 ; _btemp55
                               bcf      v____bitbucket_7, 4 ; _btemp55
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7, 4 ; _btemp55
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1231
                               movlw    101
                               subwf    v___valor_1,w
l__l1231
                               datahi_set v____bitbucket_7 ; _btemp56
                               bcf      v____bitbucket_7, 5 ; _btemp56
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7, 5 ; _btemp56
                               bsf      v____bitbucket_7, 6 ; _btemp57
                               btfsc    v____bitbucket_7, 4 ; _btemp55
                               btfss    v____bitbucket_7, 5 ; _btemp56
                               bcf      v____bitbucket_7, 6 ; _btemp57
                               btfss    v____bitbucket_7, 6 ; _btemp57
                               goto     l__l546
;  560       cms=148
                               movlw    148
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  561       return
                               return   
;  562    end if
l__l546
;  563    if valor <= 356 & valor >= 351 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1234
                               movlw    100
                               subwf    v___valor_1,w
l__l1234
                               datahi_set v____bitbucket_7 ; _btemp58
                               bcf      v____bitbucket_7, 7 ; _btemp58
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7, 7 ; _btemp58
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1235
                               movlw    95
                               subwf    v___valor_1,w
l__l1235
                               datahi_set v____bitbucket_7+1 ; _btemp59
                               bcf      v____bitbucket_7+1, 0 ; _btemp59
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+1, 0 ; _btemp59
                               bsf      v____bitbucket_7+1, 1 ; _btemp60
                               btfsc    v____bitbucket_7, 7 ; _btemp58
                               btfss    v____bitbucket_7+1, 0 ; _btemp59
                               bcf      v____bitbucket_7+1, 1 ; _btemp60
                               btfss    v____bitbucket_7+1, 1 ; _btemp60
                               goto     l__l548
;  564       cms=147
                               movlw    147
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  565       return
                               return   
;  566    end if
l__l548
;  567    if valor <= 350 & valor >= 345 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1238
                               movlw    94
                               subwf    v___valor_1,w
l__l1238
                               datahi_set v____bitbucket_7+1 ; _btemp61
                               bcf      v____bitbucket_7+1, 2 ; _btemp61
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+1, 2 ; _btemp61
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1239
                               movlw    89
                               subwf    v___valor_1,w
l__l1239
                               datahi_set v____bitbucket_7+1 ; _btemp62
                               bcf      v____bitbucket_7+1, 3 ; _btemp62
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+1, 3 ; _btemp62
                               bsf      v____bitbucket_7+1, 4 ; _btemp63
                               btfsc    v____bitbucket_7+1, 2 ; _btemp61
                               btfss    v____bitbucket_7+1, 3 ; _btemp62
                               bcf      v____bitbucket_7+1, 4 ; _btemp63
                               btfss    v____bitbucket_7+1, 4 ; _btemp63
                               goto     l__l550
;  568       cms=146
                               movlw    146
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  569       return
                               return   
;  570    end if
l__l550
;  571    if valor <= 344 & valor >= 339 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1242
                               movlw    88
                               subwf    v___valor_1,w
l__l1242
                               datahi_set v____bitbucket_7+1 ; _btemp64
                               bcf      v____bitbucket_7+1, 5 ; _btemp64
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+1, 5 ; _btemp64
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1243
                               movlw    83
                               subwf    v___valor_1,w
l__l1243
                               datahi_set v____bitbucket_7+1 ; _btemp65
                               bcf      v____bitbucket_7+1, 6 ; _btemp65
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+1, 6 ; _btemp65
                               bsf      v____bitbucket_7+1, 7 ; _btemp66
                               btfsc    v____bitbucket_7+1, 5 ; _btemp64
                               btfss    v____bitbucket_7+1, 6 ; _btemp65
                               bcf      v____bitbucket_7+1, 7 ; _btemp66
                               btfss    v____bitbucket_7+1, 7 ; _btemp66
                               goto     l__l552
;  572       cms=145
                               movlw    145
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  573       return
                               return   
;  574    end if
l__l552
;  575    if valor <= 338 & valor >= 332 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1246
                               movlw    82
                               subwf    v___valor_1,w
l__l1246
                               datahi_set v____bitbucket_7+2 ; _btemp67
                               bcf      v____bitbucket_7+2, 0 ; _btemp67
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+2, 0 ; _btemp67
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1247
                               movlw    76
                               subwf    v___valor_1,w
l__l1247
                               datahi_set v____bitbucket_7+2 ; _btemp68
                               bcf      v____bitbucket_7+2, 1 ; _btemp68
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+2, 1 ; _btemp68
                               bsf      v____bitbucket_7+2, 2 ; _btemp69
                               btfsc    v____bitbucket_7+2, 0 ; _btemp67
                               btfss    v____bitbucket_7+2, 1 ; _btemp68
                               bcf      v____bitbucket_7+2, 2 ; _btemp69
                               btfss    v____bitbucket_7+2, 2 ; _btemp69
                               goto     l__l554
;  576       cms=144
                               movlw    144
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  577       return
                               return   
;  578    end if
l__l554
;  579    if valor <= 331 & valor >= 326 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1250
                               movlw    75
                               subwf    v___valor_1,w
l__l1250
                               datahi_set v____bitbucket_7+2 ; _btemp70
                               bcf      v____bitbucket_7+2, 3 ; _btemp70
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+2, 3 ; _btemp70
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1251
                               movlw    70
                               subwf    v___valor_1,w
l__l1251
                               datahi_set v____bitbucket_7+2 ; _btemp71
                               bcf      v____bitbucket_7+2, 4 ; _btemp71
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+2, 4 ; _btemp71
                               bsf      v____bitbucket_7+2, 5 ; _btemp72
                               btfsc    v____bitbucket_7+2, 3 ; _btemp70
                               btfss    v____bitbucket_7+2, 4 ; _btemp71
                               bcf      v____bitbucket_7+2, 5 ; _btemp72
                               btfss    v____bitbucket_7+2, 5 ; _btemp72
                               goto     l__l556
;  580       cms=143
                               movlw    143
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  581       return
                               return   
;  582    end if
l__l556
;  583    if valor <= 325 & valor >= 320 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1254
                               movlw    69
                               subwf    v___valor_1,w
l__l1254
                               datahi_set v____bitbucket_7+2 ; _btemp73
                               bcf      v____bitbucket_7+2, 6 ; _btemp73
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+2, 6 ; _btemp73
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1255
                               movlw    64
                               subwf    v___valor_1,w
l__l1255
                               datahi_set v____bitbucket_7+2 ; _btemp74
                               bcf      v____bitbucket_7+2, 7 ; _btemp74
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+2, 7 ; _btemp74
                               bsf      v____bitbucket_7+3, 0 ; _btemp75
                               btfsc    v____bitbucket_7+2, 6 ; _btemp73
                               btfss    v____bitbucket_7+2, 7 ; _btemp74
                               bcf      v____bitbucket_7+3, 0 ; _btemp75
                               btfss    v____bitbucket_7+3, 0 ; _btemp75
                               goto     l__l558
;  584       cms=142
                               movlw    142
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  585       return
                               return   
;  586    end if
l__l558
;  587    if valor <= 319 & valor >= 314 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1258
                               movlw    63
                               subwf    v___valor_1,w
l__l1258
                               datahi_set v____bitbucket_7+3 ; _btemp76
                               bcf      v____bitbucket_7+3, 1 ; _btemp76
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+3, 1 ; _btemp76
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1259
                               movlw    58
                               subwf    v___valor_1,w
l__l1259
                               datahi_set v____bitbucket_7+3 ; _btemp77
                               bcf      v____bitbucket_7+3, 2 ; _btemp77
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+3, 2 ; _btemp77
                               bsf      v____bitbucket_7+3, 3 ; _btemp78
                               btfsc    v____bitbucket_7+3, 1 ; _btemp76
                               btfss    v____bitbucket_7+3, 2 ; _btemp77
                               bcf      v____bitbucket_7+3, 3 ; _btemp78
                               btfss    v____bitbucket_7+3, 3 ; _btemp78
                               goto     l__l560
;  588       cms=141
                               movlw    141
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  589       return
                               return   
;  590    end if
l__l560
;  591    if valor <= 313 & valor >= 310 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1262
                               movlw    57
                               subwf    v___valor_1,w
l__l1262
                               datahi_set v____bitbucket_7+3 ; _btemp79
                               bcf      v____bitbucket_7+3, 4 ; _btemp79
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+3, 4 ; _btemp79
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1263
                               movlw    54
                               subwf    v___valor_1,w
l__l1263
                               datahi_set v____bitbucket_7+3 ; _btemp80
                               bcf      v____bitbucket_7+3, 5 ; _btemp80
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+3, 5 ; _btemp80
                               bsf      v____bitbucket_7+3, 6 ; _btemp81
                               btfsc    v____bitbucket_7+3, 4 ; _btemp79
                               btfss    v____bitbucket_7+3, 5 ; _btemp80
                               bcf      v____bitbucket_7+3, 6 ; _btemp81
                               btfss    v____bitbucket_7+3, 6 ; _btemp81
                               goto     l__l562
;  592       cms=140
                               movlw    140
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  593       return
                               return   
;  594    end if
l__l562
;  595    if valor <= 309 & valor >= 306 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1266
                               movlw    53
                               subwf    v___valor_1,w
l__l1266
                               datahi_set v____bitbucket_7+3 ; _btemp82
                               bcf      v____bitbucket_7+3, 7 ; _btemp82
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+3, 7 ; _btemp82
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1267
                               movlw    50
                               subwf    v___valor_1,w
l__l1267
                               datahi_set v____bitbucket_7+4 ; _btemp83
                               bcf      v____bitbucket_7+4, 0 ; _btemp83
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+4, 0 ; _btemp83
                               bsf      v____bitbucket_7+4, 1 ; _btemp84
                               btfsc    v____bitbucket_7+3, 7 ; _btemp82
                               btfss    v____bitbucket_7+4, 0 ; _btemp83
                               bcf      v____bitbucket_7+4, 1 ; _btemp84
                               btfss    v____bitbucket_7+4, 1 ; _btemp84
                               goto     l__l564
;  596       cms=139
                               movlw    139
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  597       return
                               return   
;  598    end if
l__l564
;  599    if valor <= 305 & valor >= 302 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1270
                               movlw    49
                               subwf    v___valor_1,w
l__l1270
                               datahi_set v____bitbucket_7+4 ; _btemp85
                               bcf      v____bitbucket_7+4, 2 ; _btemp85
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+4, 2 ; _btemp85
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1271
                               movlw    46
                               subwf    v___valor_1,w
l__l1271
                               datahi_set v____bitbucket_7+4 ; _btemp86
                               bcf      v____bitbucket_7+4, 3 ; _btemp86
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+4, 3 ; _btemp86
                               bsf      v____bitbucket_7+4, 4 ; _btemp87
                               btfsc    v____bitbucket_7+4, 2 ; _btemp85
                               btfss    v____bitbucket_7+4, 3 ; _btemp86
                               bcf      v____bitbucket_7+4, 4 ; _btemp87
                               btfss    v____bitbucket_7+4, 4 ; _btemp87
                               goto     l__l566
;  600       cms=138
                               movlw    138
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  601       return
                               return   
;  602    end if
l__l566
;  603    if valor <= 301 & valor >= 297 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1274
                               movlw    45
                               subwf    v___valor_1,w
l__l1274
                               datahi_set v____bitbucket_7+4 ; _btemp88
                               bcf      v____bitbucket_7+4, 5 ; _btemp88
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+4, 5 ; _btemp88
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1275
                               movlw    41
                               subwf    v___valor_1,w
l__l1275
                               datahi_set v____bitbucket_7+4 ; _btemp89
                               bcf      v____bitbucket_7+4, 6 ; _btemp89
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+4, 6 ; _btemp89
                               bsf      v____bitbucket_7+4, 7 ; _btemp90
                               btfsc    v____bitbucket_7+4, 5 ; _btemp88
                               btfss    v____bitbucket_7+4, 6 ; _btemp89
                               bcf      v____bitbucket_7+4, 7 ; _btemp90
                               btfss    v____bitbucket_7+4, 7 ; _btemp90
                               goto     l__l568
;  604       cms=137
                               movlw    137
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  605       return
                               return   
;  606    end if
l__l568
;  607    if valor <= 296 & valor >= 294 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1278
                               movlw    40
                               subwf    v___valor_1,w
l__l1278
                               datahi_set v____bitbucket_7+5 ; _btemp91
                               bcf      v____bitbucket_7+5, 0 ; _btemp91
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+5, 0 ; _btemp91
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1279
                               movlw    38
                               subwf    v___valor_1,w
l__l1279
                               datahi_set v____bitbucket_7+5 ; _btemp92
                               bcf      v____bitbucket_7+5, 1 ; _btemp92
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+5, 1 ; _btemp92
                               bsf      v____bitbucket_7+5, 2 ; _btemp93
                               btfsc    v____bitbucket_7+5, 0 ; _btemp91
                               btfss    v____bitbucket_7+5, 1 ; _btemp92
                               bcf      v____bitbucket_7+5, 2 ; _btemp93
                               btfss    v____bitbucket_7+5, 2 ; _btemp93
                               goto     l__l570
;  608       cms=136
                               movlw    136
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  609       return
                               return   
;  610    end if
l__l570
;  611    if valor <= 293 & valor >= 288 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1282
                               movlw    37
                               subwf    v___valor_1,w
l__l1282
                               datahi_set v____bitbucket_7+5 ; _btemp94
                               bcf      v____bitbucket_7+5, 3 ; _btemp94
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+5, 3 ; _btemp94
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1283
                               movlw    32
                               subwf    v___valor_1,w
l__l1283
                               datahi_set v____bitbucket_7+5 ; _btemp95
                               bcf      v____bitbucket_7+5, 4 ; _btemp95
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+5, 4 ; _btemp95
                               bsf      v____bitbucket_7+5, 5 ; _btemp96
                               btfsc    v____bitbucket_7+5, 3 ; _btemp94
                               btfss    v____bitbucket_7+5, 4 ; _btemp95
                               bcf      v____bitbucket_7+5, 5 ; _btemp96
                               btfss    v____bitbucket_7+5, 5 ; _btemp96
                               goto     l__l572
;  612       cms=135
                               movlw    135
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  613       return
                               return   
;  614    end if
l__l572
;  615    if valor <= 287 & valor >= 284 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1286
                               movlw    31
                               subwf    v___valor_1,w
l__l1286
                               datahi_set v____bitbucket_7+5 ; _btemp97
                               bcf      v____bitbucket_7+5, 6 ; _btemp97
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+5, 6 ; _btemp97
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1287
                               movlw    28
                               subwf    v___valor_1,w
l__l1287
                               datahi_set v____bitbucket_7+5 ; _btemp98
                               bcf      v____bitbucket_7+5, 7 ; _btemp98
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+5, 7 ; _btemp98
                               bsf      v____bitbucket_7+6, 0 ; _btemp99
                               btfsc    v____bitbucket_7+5, 6 ; _btemp97
                               btfss    v____bitbucket_7+5, 7 ; _btemp98
                               bcf      v____bitbucket_7+6, 0 ; _btemp99
                               btfss    v____bitbucket_7+6, 0 ; _btemp99
                               goto     l__l574
;  616       cms=134
                               movlw    134
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  617       return
                               return   
;  618    end if
l__l574
;  619    if valor <= 283 & valor >= 279 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1290
                               movlw    27
                               subwf    v___valor_1,w
l__l1290
                               datahi_set v____bitbucket_7+6 ; _btemp100
                               bcf      v____bitbucket_7+6, 1 ; _btemp100
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+6, 1 ; _btemp100
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1291
                               movlw    23
                               subwf    v___valor_1,w
l__l1291
                               datahi_set v____bitbucket_7+6 ; _btemp101
                               bcf      v____bitbucket_7+6, 2 ; _btemp101
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+6, 2 ; _btemp101
                               bsf      v____bitbucket_7+6, 3 ; _btemp102
                               btfsc    v____bitbucket_7+6, 1 ; _btemp100
                               btfss    v____bitbucket_7+6, 2 ; _btemp101
                               bcf      v____bitbucket_7+6, 3 ; _btemp102
                               btfss    v____bitbucket_7+6, 3 ; _btemp102
                               goto     l__l576
;  620       cms=133
                               movlw    133
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  621       return
                               return   
;  622    end if
l__l576
;  623    if valor <= 278 & valor >= 274 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1294
                               movlw    22
                               subwf    v___valor_1,w
l__l1294
                               datahi_set v____bitbucket_7+6 ; _btemp103
                               bcf      v____bitbucket_7+6, 4 ; _btemp103
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+6, 4 ; _btemp103
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1295
                               movlw    18
                               subwf    v___valor_1,w
l__l1295
                               datahi_set v____bitbucket_7+6 ; _btemp104
                               bcf      v____bitbucket_7+6, 5 ; _btemp104
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+6, 5 ; _btemp104
                               bsf      v____bitbucket_7+6, 6 ; _btemp105
                               btfsc    v____bitbucket_7+6, 4 ; _btemp103
                               btfss    v____bitbucket_7+6, 5 ; _btemp104
                               bcf      v____bitbucket_7+6, 6 ; _btemp105
                               btfss    v____bitbucket_7+6, 6 ; _btemp105
                               goto     l__l578
;  624       cms=132
                               movlw    132
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  625       return
                               return   
;  626    end if
l__l578
;  627    if valor <= 273 & valor >= 269 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1298
                               movlw    17
                               subwf    v___valor_1,w
l__l1298
                               datahi_set v____bitbucket_7+6 ; _btemp106
                               bcf      v____bitbucket_7+6, 7 ; _btemp106
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+6, 7 ; _btemp106
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1299
                               movlw    13
                               subwf    v___valor_1,w
l__l1299
                               datahi_set v____bitbucket_7+7 ; _btemp107
                               bcf      v____bitbucket_7+7, 0 ; _btemp107
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+7, 0 ; _btemp107
                               bsf      v____bitbucket_7+7, 1 ; _btemp108
                               btfsc    v____bitbucket_7+6, 7 ; _btemp106
                               btfss    v____bitbucket_7+7, 0 ; _btemp107
                               bcf      v____bitbucket_7+7, 1 ; _btemp108
                               btfss    v____bitbucket_7+7, 1 ; _btemp108
                               goto     l__l580
;  628       cms=131
                               movlw    131
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  629       return
                               return   
;  630    end if
l__l580
;  631    if valor <= 268 & valor >= 266 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1302
                               movlw    12
                               subwf    v___valor_1,w
l__l1302
                               datahi_set v____bitbucket_7+7 ; _btemp109
                               bcf      v____bitbucket_7+7, 2 ; _btemp109
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+7, 2 ; _btemp109
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1303
                               movlw    10
                               subwf    v___valor_1,w
l__l1303
                               datahi_set v____bitbucket_7+7 ; _btemp110
                               bcf      v____bitbucket_7+7, 3 ; _btemp110
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+7, 3 ; _btemp110
                               bsf      v____bitbucket_7+7, 4 ; _btemp111
                               btfsc    v____bitbucket_7+7, 2 ; _btemp109
                               btfss    v____bitbucket_7+7, 3 ; _btemp110
                               bcf      v____bitbucket_7+7, 4 ; _btemp111
                               btfss    v____bitbucket_7+7, 4 ; _btemp111
                               goto     l__l582
;  632       cms=130
                               movlw    130
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  633       return
                               return   
;  634    end if
l__l582
;  635    if valor <= 265 & valor >= 263 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1306
                               movlw    9
                               subwf    v___valor_1,w
l__l1306
                               datahi_set v____bitbucket_7+7 ; _btemp112
                               bcf      v____bitbucket_7+7, 5 ; _btemp112
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+7, 5 ; _btemp112
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1307
                               movlw    7
                               subwf    v___valor_1,w
l__l1307
                               datahi_set v____bitbucket_7+7 ; _btemp113
                               bcf      v____bitbucket_7+7, 6 ; _btemp113
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+7, 6 ; _btemp113
                               bsf      v____bitbucket_7+7, 7 ; _btemp114
                               btfsc    v____bitbucket_7+7, 5 ; _btemp112
                               btfss    v____bitbucket_7+7, 6 ; _btemp113
                               bcf      v____bitbucket_7+7, 7 ; _btemp114
                               btfss    v____bitbucket_7+7, 7 ; _btemp114
                               goto     l__l584
;  636       cms=129
                               movlw    129
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  637       return
                               return   
;  638    end if
l__l584
;  639    if valor <= 262 & valor >= 260 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1310
                               movlw    6
                               subwf    v___valor_1,w
l__l1310
                               datahi_set v____bitbucket_7+8 ; _btemp115
                               bcf      v____bitbucket_7+8, 0 ; _btemp115
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+8, 0 ; _btemp115
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1311
                               movlw    4
                               subwf    v___valor_1,w
l__l1311
                               datahi_set v____bitbucket_7+8 ; _btemp116
                               bcf      v____bitbucket_7+8, 1 ; _btemp116
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+8, 1 ; _btemp116
                               bsf      v____bitbucket_7+8, 2 ; _btemp117
                               btfsc    v____bitbucket_7+8, 0 ; _btemp115
                               btfss    v____bitbucket_7+8, 1 ; _btemp116
                               bcf      v____bitbucket_7+8, 2 ; _btemp117
                               btfss    v____bitbucket_7+8, 2 ; _btemp117
                               goto     l__l586
;  640       cms=128
                               movlw    128
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  641       return
                               return   
;  642    end if
l__l586
;  643    if valor <= 259 & valor >= 257 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1314
                               movlw    3
                               subwf    v___valor_1,w
l__l1314
                               datahi_set v____bitbucket_7+8 ; _btemp118
                               bcf      v____bitbucket_7+8, 3 ; _btemp118
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+8, 3 ; _btemp118
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1315
                               movlw    1
                               subwf    v___valor_1,w
l__l1315
                               datahi_set v____bitbucket_7+8 ; _btemp119
                               bcf      v____bitbucket_7+8, 4 ; _btemp119
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+8, 4 ; _btemp119
                               bsf      v____bitbucket_7+8, 5 ; _btemp120
                               btfsc    v____bitbucket_7+8, 3 ; _btemp118
                               btfss    v____bitbucket_7+8, 4 ; _btemp119
                               bcf      v____bitbucket_7+8, 5 ; _btemp120
                               btfss    v____bitbucket_7+8, 5 ; _btemp120
                               goto     l__l588
;  644       cms=127
                               movlw    127
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  645       return
                               return   
;  646    end if
l__l588
;  647    if valor <= 256 & valor >= 254 then
                               movlw    1
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1318
                               movlw    0
                               subwf    v___valor_1,w
l__l1318
                               datahi_set v____bitbucket_7+8 ; _btemp121
                               bcf      v____bitbucket_7+8, 6 ; _btemp121
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+8, 6 ; _btemp121
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1319
                               movlw    254
                               subwf    v___valor_1,w
l__l1319
                               datahi_set v____bitbucket_7+8 ; _btemp122
                               bcf      v____bitbucket_7+8, 7 ; _btemp122
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+8, 7 ; _btemp122
                               bsf      v____bitbucket_7+9, 0 ; _btemp123
                               btfsc    v____bitbucket_7+8, 6 ; _btemp121
                               btfss    v____bitbucket_7+8, 7 ; _btemp122
                               bcf      v____bitbucket_7+9, 0 ; _btemp123
                               btfss    v____bitbucket_7+9, 0 ; _btemp123
                               goto     l__l590
;  648       cms=126
                               movlw    126
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  649       return
                               return   
;  650    end if
l__l590
;  651    if valor <= 253 & valor >= 251 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1322
                               movlw    253
                               subwf    v___valor_1,w
l__l1322
                               datahi_set v____bitbucket_7+9 ; _btemp124
                               bcf      v____bitbucket_7+9, 1 ; _btemp124
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+9, 1 ; _btemp124
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1323
                               movlw    251
                               subwf    v___valor_1,w
l__l1323
                               datahi_set v____bitbucket_7+9 ; _btemp125
                               bcf      v____bitbucket_7+9, 2 ; _btemp125
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+9, 2 ; _btemp125
                               bsf      v____bitbucket_7+9, 3 ; _btemp126
                               btfsc    v____bitbucket_7+9, 1 ; _btemp124
                               btfss    v____bitbucket_7+9, 2 ; _btemp125
                               bcf      v____bitbucket_7+9, 3 ; _btemp126
                               btfss    v____bitbucket_7+9, 3 ; _btemp126
                               goto     l__l592
;  652       cms=125
                               movlw    125
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  653       return
                               return   
;  654    end if
l__l592
;  655    if valor <= 250 & valor >= 248 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1326
                               movlw    250
                               subwf    v___valor_1,w
l__l1326
                               datahi_set v____bitbucket_7+9 ; _btemp127
                               bcf      v____bitbucket_7+9, 4 ; _btemp127
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+9, 4 ; _btemp127
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1327
                               movlw    248
                               subwf    v___valor_1,w
l__l1327
                               datahi_set v____bitbucket_7+9 ; _btemp128
                               bcf      v____bitbucket_7+9, 5 ; _btemp128
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+9, 5 ; _btemp128
                               bsf      v____bitbucket_7+9, 6 ; _btemp129
                               btfsc    v____bitbucket_7+9, 4 ; _btemp127
                               btfss    v____bitbucket_7+9, 5 ; _btemp128
                               bcf      v____bitbucket_7+9, 6 ; _btemp129
                               btfss    v____bitbucket_7+9, 6 ; _btemp129
                               goto     l__l594
;  656       cms=124
                               movlw    124
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  657       return
                               return   
;  658    end if
l__l594
;  659    if valor <= 247 & valor >= 245 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1330
                               movlw    247
                               subwf    v___valor_1,w
l__l1330
                               datahi_set v____bitbucket_7+9 ; _btemp130
                               bcf      v____bitbucket_7+9, 7 ; _btemp130
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+9, 7 ; _btemp130
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1331
                               movlw    245
                               subwf    v___valor_1,w
l__l1331
                               datahi_set v____bitbucket_7+10 ; _btemp131
                               bcf      v____bitbucket_7+10, 0 ; _btemp131
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+10, 0 ; _btemp131
                               bsf      v____bitbucket_7+10, 1 ; _btemp132
                               btfsc    v____bitbucket_7+9, 7 ; _btemp130
                               btfss    v____bitbucket_7+10, 0 ; _btemp131
                               bcf      v____bitbucket_7+10, 1 ; _btemp132
                               btfss    v____bitbucket_7+10, 1 ; _btemp132
                               goto     l__l596
;  660       cms=123
                               movlw    123
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  661       return
                               return   
;  662    end if
l__l596
;  663    if valor <= 244 & valor >= 242 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1334
                               movlw    244
                               subwf    v___valor_1,w
l__l1334
                               datahi_set v____bitbucket_7+10 ; _btemp133
                               bcf      v____bitbucket_7+10, 2 ; _btemp133
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+10, 2 ; _btemp133
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1335
                               movlw    242
                               subwf    v___valor_1,w
l__l1335
                               datahi_set v____bitbucket_7+10 ; _btemp134
                               bcf      v____bitbucket_7+10, 3 ; _btemp134
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+10, 3 ; _btemp134
                               bsf      v____bitbucket_7+10, 4 ; _btemp135
                               btfsc    v____bitbucket_7+10, 2 ; _btemp133
                               btfss    v____bitbucket_7+10, 3 ; _btemp134
                               bcf      v____bitbucket_7+10, 4 ; _btemp135
                               btfss    v____bitbucket_7+10, 4 ; _btemp135
                               goto     l__l598
;  664       cms=122
                               movlw    122
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  665       return
                               return   
;  666    end if
l__l598
;  667    if valor <= 241 & valor >= 239 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1338
                               movlw    241
                               subwf    v___valor_1,w
l__l1338
                               datahi_set v____bitbucket_7+10 ; _btemp136
                               bcf      v____bitbucket_7+10, 5 ; _btemp136
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+10, 5 ; _btemp136
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1339
                               movlw    239
                               subwf    v___valor_1,w
l__l1339
                               datahi_set v____bitbucket_7+10 ; _btemp137
                               bcf      v____bitbucket_7+10, 6 ; _btemp137
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+10, 6 ; _btemp137
                               bsf      v____bitbucket_7+10, 7 ; _btemp138
                               btfsc    v____bitbucket_7+10, 5 ; _btemp136
                               btfss    v____bitbucket_7+10, 6 ; _btemp137
                               bcf      v____bitbucket_7+10, 7 ; _btemp138
                               btfss    v____bitbucket_7+10, 7 ; _btemp138
                               goto     l__l600
;  668       cms=121
                               movlw    121
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  669       return
                               return   
;  670    end if
l__l600
;  671    if valor <= 238 & valor >= 233 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1342
                               movlw    238
                               subwf    v___valor_1,w
l__l1342
                               datahi_set v____bitbucket_7+11 ; _btemp139
                               bcf      v____bitbucket_7+11, 0 ; _btemp139
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+11, 0 ; _btemp139
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1343
                               movlw    233
                               subwf    v___valor_1,w
l__l1343
                               datahi_set v____bitbucket_7+11 ; _btemp140
                               bcf      v____bitbucket_7+11, 1 ; _btemp140
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+11, 1 ; _btemp140
                               bsf      v____bitbucket_7+11, 2 ; _btemp141
                               btfsc    v____bitbucket_7+11, 0 ; _btemp139
                               btfss    v____bitbucket_7+11, 1 ; _btemp140
                               bcf      v____bitbucket_7+11, 2 ; _btemp141
                               btfss    v____bitbucket_7+11, 2 ; _btemp141
                               goto     l__l602
;  672       cms=120
                               movlw    120
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  673       return
                               return   
;  674    end if
l__l602
;  675    if valor <= 232 & valor >= 228 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1346
                               movlw    232
                               subwf    v___valor_1,w
l__l1346
                               datahi_set v____bitbucket_7+11 ; _btemp142
                               bcf      v____bitbucket_7+11, 3 ; _btemp142
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+11, 3 ; _btemp142
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1347
                               movlw    228
                               subwf    v___valor_1,w
l__l1347
                               datahi_set v____bitbucket_7+11 ; _btemp143
                               bcf      v____bitbucket_7+11, 4 ; _btemp143
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+11, 4 ; _btemp143
                               bsf      v____bitbucket_7+11, 5 ; _btemp144
                               btfsc    v____bitbucket_7+11, 3 ; _btemp142
                               btfss    v____bitbucket_7+11, 4 ; _btemp143
                               bcf      v____bitbucket_7+11, 5 ; _btemp144
                               btfss    v____bitbucket_7+11, 5 ; _btemp144
                               goto     l__l604
;  676       cms=119
                               movlw    119
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  677       return
                               return   
;  678    end if
l__l604
;  679    if valor <= 227 & valor >= 223 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1350
                               movlw    227
                               subwf    v___valor_1,w
l__l1350
                               datahi_set v____bitbucket_7+11 ; _btemp145
                               bcf      v____bitbucket_7+11, 6 ; _btemp145
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+11, 6 ; _btemp145
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1351
                               movlw    223
                               subwf    v___valor_1,w
l__l1351
                               datahi_set v____bitbucket_7+11 ; _btemp146
                               bcf      v____bitbucket_7+11, 7 ; _btemp146
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+11, 7 ; _btemp146
                               bsf      v____bitbucket_7+12, 0 ; _btemp147
                               btfsc    v____bitbucket_7+11, 6 ; _btemp145
                               btfss    v____bitbucket_7+11, 7 ; _btemp146
                               bcf      v____bitbucket_7+12, 0 ; _btemp147
                               btfss    v____bitbucket_7+12, 0 ; _btemp147
                               goto     l__l606
;  680       cms=118
                               movlw    118
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  681       return
                               return   
;  682    end if
l__l606
;  683    if valor <= 222 & valor >= 218 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1354
                               movlw    222
                               subwf    v___valor_1,w
l__l1354
                               datahi_set v____bitbucket_7+12 ; _btemp148
                               bcf      v____bitbucket_7+12, 1 ; _btemp148
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+12, 1 ; _btemp148
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1355
                               movlw    218
                               subwf    v___valor_1,w
l__l1355
                               datahi_set v____bitbucket_7+12 ; _btemp149
                               bcf      v____bitbucket_7+12, 2 ; _btemp149
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+12, 2 ; _btemp149
                               bsf      v____bitbucket_7+12, 3 ; _btemp150
                               btfsc    v____bitbucket_7+12, 1 ; _btemp148
                               btfss    v____bitbucket_7+12, 2 ; _btemp149
                               bcf      v____bitbucket_7+12, 3 ; _btemp150
                               btfss    v____bitbucket_7+12, 3 ; _btemp150
                               goto     l__l608
;  684       cms=117
                               movlw    117
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  685       return
                               return   
;  686    end if
l__l608
;  687    if valor <= 217 & valor >= 214 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1358
                               movlw    217
                               subwf    v___valor_1,w
l__l1358
                               datahi_set v____bitbucket_7+12 ; _btemp151
                               bcf      v____bitbucket_7+12, 4 ; _btemp151
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+12, 4 ; _btemp151
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1359
                               movlw    214
                               subwf    v___valor_1,w
l__l1359
                               datahi_set v____bitbucket_7+12 ; _btemp152
                               bcf      v____bitbucket_7+12, 5 ; _btemp152
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+12, 5 ; _btemp152
                               bsf      v____bitbucket_7+12, 6 ; _btemp153
                               btfsc    v____bitbucket_7+12, 4 ; _btemp151
                               btfss    v____bitbucket_7+12, 5 ; _btemp152
                               bcf      v____bitbucket_7+12, 6 ; _btemp153
                               btfss    v____bitbucket_7+12, 6 ; _btemp153
                               goto     l__l610
;  688       cms=116
                               movlw    116
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  689       return
                               return   
;  690    end if
l__l610
;  691    if valor <= 213 & valor >= 210 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1362
                               movlw    213
                               subwf    v___valor_1,w
l__l1362
                               datahi_set v____bitbucket_7+12 ; _btemp154
                               bcf      v____bitbucket_7+12, 7 ; _btemp154
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+12, 7 ; _btemp154
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1363
                               movlw    210
                               subwf    v___valor_1,w
l__l1363
                               datahi_set v____bitbucket_7+13 ; _btemp155
                               bcf      v____bitbucket_7+13, 0 ; _btemp155
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+13, 0 ; _btemp155
                               bsf      v____bitbucket_7+13, 1 ; _btemp156
                               btfsc    v____bitbucket_7+12, 7 ; _btemp154
                               btfss    v____bitbucket_7+13, 0 ; _btemp155
                               bcf      v____bitbucket_7+13, 1 ; _btemp156
                               btfss    v____bitbucket_7+13, 1 ; _btemp156
                               goto     l__l612
;  692       cms=115
                               movlw    115
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  693       return
                               return   
;  694    end if
l__l612
;  695    if valor <= 209 & valor >= 205 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1366
                               movlw    209
                               subwf    v___valor_1,w
l__l1366
                               datahi_set v____bitbucket_7+13 ; _btemp157
                               bcf      v____bitbucket_7+13, 2 ; _btemp157
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+13, 2 ; _btemp157
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1367
                               movlw    205
                               subwf    v___valor_1,w
l__l1367
                               datahi_set v____bitbucket_7+13 ; _btemp158
                               bcf      v____bitbucket_7+13, 3 ; _btemp158
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+13, 3 ; _btemp158
                               bsf      v____bitbucket_7+13, 4 ; _btemp159
                               btfsc    v____bitbucket_7+13, 2 ; _btemp157
                               btfss    v____bitbucket_7+13, 3 ; _btemp158
                               bcf      v____bitbucket_7+13, 4 ; _btemp159
                               btfss    v____bitbucket_7+13, 4 ; _btemp159
                               goto     l__l614
;  696       cms=114
                               movlw    114
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  697       return
                               return   
;  698    end if
l__l614
;  699    if valor <= 204 & valor >= 200 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1370
                               movlw    204
                               subwf    v___valor_1,w
l__l1370
                               datahi_set v____bitbucket_7+13 ; _btemp160
                               bcf      v____bitbucket_7+13, 5 ; _btemp160
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+13, 5 ; _btemp160
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1371
                               movlw    200
                               subwf    v___valor_1,w
l__l1371
                               datahi_set v____bitbucket_7+13 ; _btemp161
                               bcf      v____bitbucket_7+13, 6 ; _btemp161
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+13, 6 ; _btemp161
                               bsf      v____bitbucket_7+13, 7 ; _btemp162
                               btfsc    v____bitbucket_7+13, 5 ; _btemp160
                               btfss    v____bitbucket_7+13, 6 ; _btemp161
                               bcf      v____bitbucket_7+13, 7 ; _btemp162
                               btfss    v____bitbucket_7+13, 7 ; _btemp162
                               goto     l__l616
;  700       cms=113
                               movlw    113
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  701       return
                               return   
;  702    end if
l__l616
;  703    if valor <= 199 & valor >= 195 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1374
                               movlw    199
                               subwf    v___valor_1,w
l__l1374
                               datahi_set v____bitbucket_7+14 ; _btemp163
                               bcf      v____bitbucket_7+14, 0 ; _btemp163
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+14, 0 ; _btemp163
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1375
                               movlw    195
                               subwf    v___valor_1,w
l__l1375
                               datahi_set v____bitbucket_7+14 ; _btemp164
                               bcf      v____bitbucket_7+14, 1 ; _btemp164
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+14, 1 ; _btemp164
                               bsf      v____bitbucket_7+14, 2 ; _btemp165
                               btfsc    v____bitbucket_7+14, 0 ; _btemp163
                               btfss    v____bitbucket_7+14, 1 ; _btemp164
                               bcf      v____bitbucket_7+14, 2 ; _btemp165
                               btfss    v____bitbucket_7+14, 2 ; _btemp165
                               goto     l__l618
;  704       cms=112
                               movlw    112
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  705       return
                               return   
;  706    end if
l__l618
;  707    if valor <= 194 & valor >= 191 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1378
                               movlw    194
                               subwf    v___valor_1,w
l__l1378
                               datahi_set v____bitbucket_7+14 ; _btemp166
                               bcf      v____bitbucket_7+14, 3 ; _btemp166
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+14, 3 ; _btemp166
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1379
                               movlw    191
                               subwf    v___valor_1,w
l__l1379
                               datahi_set v____bitbucket_7+14 ; _btemp167
                               bcf      v____bitbucket_7+14, 4 ; _btemp167
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+14, 4 ; _btemp167
                               bsf      v____bitbucket_7+14, 5 ; _btemp168
                               btfsc    v____bitbucket_7+14, 3 ; _btemp166
                               btfss    v____bitbucket_7+14, 4 ; _btemp167
                               bcf      v____bitbucket_7+14, 5 ; _btemp168
                               btfss    v____bitbucket_7+14, 5 ; _btemp168
                               goto     l__l620
;  708       cms=111
                               movlw    111
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  709       return
                               return   
;  710    end if
l__l620
;  711    if valor <= 190 & valor >= 184 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1382
                               movlw    190
                               subwf    v___valor_1,w
l__l1382
                               datahi_set v____bitbucket_7+14 ; _btemp169
                               bcf      v____bitbucket_7+14, 6 ; _btemp169
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+14, 6 ; _btemp169
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               branchlo_set l__l1383
                               btfss    v__status, v__z
                               goto     l__l1383
                               movlw    184
                               subwf    v___valor_1,w
l__l1383
                               datahi_set v____bitbucket_7+14 ; _btemp170
                               bcf      v____bitbucket_7+14, 7 ; _btemp170
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+14, 7 ; _btemp170
                               bsf      v____bitbucket_7+15, 0 ; _btemp171
                               btfsc    v____bitbucket_7+14, 6 ; _btemp169
                               btfss    v____bitbucket_7+14, 7 ; _btemp170
                               bcf      v____bitbucket_7+15, 0 ; _btemp171
                               btfss    v____bitbucket_7+15, 0 ; _btemp171
                               goto     l__l622
;  712       cms=110
                               movlw    110
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  713       return
                               return   
;  714    end if
l__l622
;  715    if valor == 183 then
                               movlw    183
                               datahi_clr v___valor_1
                               subwf    v___valor_1,w
                               movwf    v__pic_temp
                               movlw    0
                               subwf    v___valor_1+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l624
;  716       cms=109
                               movlw    109
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  717       return
                               return   
;  718    end if
l__l624
;  719    if valor == 182 then
                               movlw    182
                               subwf    v___valor_1,w
                               movwf    v__pic_temp
                               movlw    0
                               subwf    v___valor_1+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l626
;  720       cms=108
                               movlw    108
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  721       return
                               return   
;  722    end if
l__l626
;  723    if valor == 181 then
                               movlw    181
                               subwf    v___valor_1,w
                               movwf    v__pic_temp
                               movlw    0
                               subwf    v___valor_1+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l628
;  724       cms=107
                               movlw    107
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  725       return
                               return   
;  726    end if
l__l628
;  727    if valor == 180 then
                               movlw    180
                               subwf    v___valor_1,w
                               movwf    v__pic_temp
                               movlw    0
                               subwf    v___valor_1+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l630
;  728       cms=106
                               movlw    106
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  729       return
                               return   
;  730    end if
l__l630
;  731    if valor == 179 then
                               movlw    179
                               subwf    v___valor_1,w
                               movwf    v__pic_temp
                               movlw    0
                               subwf    v___valor_1+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l632
;  732       cms=105
                               movlw    105
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  733       return
                               return   
;  734    end if
l__l632
;  735    if valor == 178 then
                               movlw    178
                               subwf    v___valor_1,w
                               movwf    v__pic_temp
                               movlw    0
                               subwf    v___valor_1+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l634
;  736       cms=104
                               movlw    104
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  737       return
                               return   
;  738    end if
l__l634
;  739    if valor == 177 then
                               movlw    177
                               subwf    v___valor_1,w
                               movwf    v__pic_temp
                               movlw    0
                               subwf    v___valor_1+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l636
;  740       cms=103
                               movlw    103
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  741       return
                               return   
;  742    end if
l__l636
;  743    if valor == 176 then
                               movlw    176
                               subwf    v___valor_1,w
                               movwf    v__pic_temp
                               movlw    0
                               subwf    v___valor_1+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l638
;  744       cms=102
                               movlw    102
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  745       return
                               return   
;  746    end if
l__l638
;  747    if valor == 175 then
                               movlw    175
                               subwf    v___valor_1,w
                               movwf    v__pic_temp
                               movlw    0
                               subwf    v___valor_1+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l640
;  748       cms=102
                               movlw    102
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  749       return
                               return   
;  750    end if
l__l640
;  751    if valor == 174 then
                               movlw    174
                               subwf    v___valor_1,w
                               movwf    v__pic_temp
                               movlw    0
                               subwf    v___valor_1+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l642
;  752       cms=101
                               movlw    101
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  753       return
                               return   
;  754    end if
l__l642
;  755    if valor <= 173 & valor >= 171 then
                               movlw    0
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1386
                               movlw    173
                               subwf    v___valor_1,w
l__l1386
                               datahi_set v____bitbucket_7+16 ; _btemp182
                               bcf      v____bitbucket_7+16, 3 ; _btemp182
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+16, 3 ; _btemp182
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1387
                               movlw    171
                               subwf    v___valor_1,w
l__l1387
                               datahi_set v____bitbucket_7+16 ; _btemp183
                               bcf      v____bitbucket_7+16, 4 ; _btemp183
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+16, 4 ; _btemp183
                               bsf      v____bitbucket_7+16, 5 ; _btemp184
                               btfsc    v____bitbucket_7+16, 3 ; _btemp182
                               btfss    v____bitbucket_7+16, 4 ; _btemp183
                               bcf      v____bitbucket_7+16, 5 ; _btemp184
                               btfss    v____bitbucket_7+16, 5 ; _btemp184
                               goto     l__l644
;  756       cms=100
                               movlw    100
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  757       return
                               return   
;  758    end if
l__l644
;  759    if valor <= 170 & valor >= 167 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1390
                               movlw    170
                               subwf    v___valor_1,w
l__l1390
                               datahi_set v____bitbucket_7+16 ; _btemp185
                               bcf      v____bitbucket_7+16, 6 ; _btemp185
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+16, 6 ; _btemp185
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1391
                               movlw    167
                               subwf    v___valor_1,w
l__l1391
                               datahi_set v____bitbucket_7+16 ; _btemp186
                               bcf      v____bitbucket_7+16, 7 ; _btemp186
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+16, 7 ; _btemp186
                               bsf      v____bitbucket_7+17, 0 ; _btemp187
                               btfsc    v____bitbucket_7+16, 6 ; _btemp185
                               btfss    v____bitbucket_7+16, 7 ; _btemp186
                               bcf      v____bitbucket_7+17, 0 ; _btemp187
                               btfss    v____bitbucket_7+17, 0 ; _btemp187
                               goto     l__l646
;  760       cms=99
                               movlw    99
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  761       return
                               return   
;  762    end if
l__l646
;  763    if valor <= 166 & valor >= 163 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1394
                               movlw    166
                               subwf    v___valor_1,w
l__l1394
                               datahi_set v____bitbucket_7+17 ; _btemp188
                               bcf      v____bitbucket_7+17, 1 ; _btemp188
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+17, 1 ; _btemp188
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1395
                               movlw    163
                               subwf    v___valor_1,w
l__l1395
                               datahi_set v____bitbucket_7+17 ; _btemp189
                               bcf      v____bitbucket_7+17, 2 ; _btemp189
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+17, 2 ; _btemp189
                               bsf      v____bitbucket_7+17, 3 ; _btemp190
                               btfsc    v____bitbucket_7+17, 1 ; _btemp188
                               btfss    v____bitbucket_7+17, 2 ; _btemp189
                               bcf      v____bitbucket_7+17, 3 ; _btemp190
                               btfss    v____bitbucket_7+17, 3 ; _btemp190
                               goto     l__l648
;  764       cms=98
                               movlw    98
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  765       return
                               return   
;  766    end if
l__l648
;  767    if valor <= 162 & valor >= 159 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1398
                               movlw    162
                               subwf    v___valor_1,w
l__l1398
                               datahi_set v____bitbucket_7+17 ; _btemp191
                               bcf      v____bitbucket_7+17, 4 ; _btemp191
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+17, 4 ; _btemp191
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1399
                               movlw    159
                               subwf    v___valor_1,w
l__l1399
                               datahi_set v____bitbucket_7+17 ; _btemp192
                               bcf      v____bitbucket_7+17, 5 ; _btemp192
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+17, 5 ; _btemp192
                               bsf      v____bitbucket_7+17, 6 ; _btemp193
                               btfsc    v____bitbucket_7+17, 4 ; _btemp191
                               btfss    v____bitbucket_7+17, 5 ; _btemp192
                               bcf      v____bitbucket_7+17, 6 ; _btemp193
                               btfss    v____bitbucket_7+17, 6 ; _btemp193
                               goto     l__l650
;  768       cms=97
                               movlw    97
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  769       return
                               return   
;  770    end if
l__l650
;  771    if valor <= 158 & valor >= 155 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1402
                               movlw    158
                               subwf    v___valor_1,w
l__l1402
                               datahi_set v____bitbucket_7+17 ; _btemp194
                               bcf      v____bitbucket_7+17, 7 ; _btemp194
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+17, 7 ; _btemp194
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1403
                               movlw    155
                               subwf    v___valor_1,w
l__l1403
                               datahi_set v____bitbucket_7+18 ; _btemp195
                               bcf      v____bitbucket_7+18, 0 ; _btemp195
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+18, 0 ; _btemp195
                               bsf      v____bitbucket_7+18, 1 ; _btemp196
                               btfsc    v____bitbucket_7+17, 7 ; _btemp194
                               btfss    v____bitbucket_7+18, 0 ; _btemp195
                               bcf      v____bitbucket_7+18, 1 ; _btemp196
                               btfss    v____bitbucket_7+18, 1 ; _btemp196
                               goto     l__l652
;  772       cms=96
                               movlw    96
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  773       return
                               return   
;  774    end if
l__l652
;  775    if valor <= 154 & valor >= 151 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1406
                               movlw    154
                               subwf    v___valor_1,w
l__l1406
                               datahi_set v____bitbucket_7+18 ; _btemp197
                               bcf      v____bitbucket_7+18, 2 ; _btemp197
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+18, 2 ; _btemp197
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1407
                               movlw    151
                               subwf    v___valor_1,w
l__l1407
                               datahi_set v____bitbucket_7+18 ; _btemp198
                               bcf      v____bitbucket_7+18, 3 ; _btemp198
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+18, 3 ; _btemp198
                               bsf      v____bitbucket_7+18, 4 ; _btemp199
                               btfsc    v____bitbucket_7+18, 2 ; _btemp197
                               btfss    v____bitbucket_7+18, 3 ; _btemp198
                               bcf      v____bitbucket_7+18, 4 ; _btemp199
                               btfss    v____bitbucket_7+18, 4 ; _btemp199
                               goto     l__l654
;  776       cms=95
                               movlw    95
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  777       return
                               return   
;  778    end if
l__l654
;  779    if valor <= 150 & valor >= 147 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1410
                               movlw    150
                               subwf    v___valor_1,w
l__l1410
                               datahi_set v____bitbucket_7+18 ; _btemp200
                               bcf      v____bitbucket_7+18, 5 ; _btemp200
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+18, 5 ; _btemp200
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1411
                               movlw    147
                               subwf    v___valor_1,w
l__l1411
                               datahi_set v____bitbucket_7+18 ; _btemp201
                               bcf      v____bitbucket_7+18, 6 ; _btemp201
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+18, 6 ; _btemp201
                               bsf      v____bitbucket_7+18, 7 ; _btemp202
                               btfsc    v____bitbucket_7+18, 5 ; _btemp200
                               btfss    v____bitbucket_7+18, 6 ; _btemp201
                               bcf      v____bitbucket_7+18, 7 ; _btemp202
                               btfss    v____bitbucket_7+18, 7 ; _btemp202
                               goto     l__l656
;  780       cms=94
                               movlw    94
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  781       return
                               return   
;  782    end if
l__l656
;  783    if valor <= 146 & valor >= 143 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1414
                               movlw    146
                               subwf    v___valor_1,w
l__l1414
                               datahi_set v____bitbucket_7+19 ; _btemp203
                               bcf      v____bitbucket_7+19, 0 ; _btemp203
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+19, 0 ; _btemp203
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1415
                               movlw    143
                               subwf    v___valor_1,w
l__l1415
                               datahi_set v____bitbucket_7+19 ; _btemp204
                               bcf      v____bitbucket_7+19, 1 ; _btemp204
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+19, 1 ; _btemp204
                               bsf      v____bitbucket_7+19, 2 ; _btemp205
                               btfsc    v____bitbucket_7+19, 0 ; _btemp203
                               btfss    v____bitbucket_7+19, 1 ; _btemp204
                               bcf      v____bitbucket_7+19, 2 ; _btemp205
                               btfss    v____bitbucket_7+19, 2 ; _btemp205
                               goto     l__l658
;  784       cms=93
                               movlw    93
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  785       return
                               return   
;  786    end if
l__l658
;  787    if valor <= 142 & valor >= 139 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1418
                               movlw    142
                               subwf    v___valor_1,w
l__l1418
                               datahi_set v____bitbucket_7+19 ; _btemp206
                               bcf      v____bitbucket_7+19, 3 ; _btemp206
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+19, 3 ; _btemp206
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1419
                               movlw    139
                               subwf    v___valor_1,w
l__l1419
                               datahi_set v____bitbucket_7+19 ; _btemp207
                               bcf      v____bitbucket_7+19, 4 ; _btemp207
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+19, 4 ; _btemp207
                               bsf      v____bitbucket_7+19, 5 ; _btemp208
                               btfsc    v____bitbucket_7+19, 3 ; _btemp206
                               btfss    v____bitbucket_7+19, 4 ; _btemp207
                               bcf      v____bitbucket_7+19, 5 ; _btemp208
                               btfss    v____bitbucket_7+19, 5 ; _btemp208
                               goto     l__l660
;  788       cms=92
                               movlw    92
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  789       return
                               return   
;  790    end if
l__l660
;  791    if valor <= 138 & valor >= 136 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1422
                               movlw    138
                               subwf    v___valor_1,w
l__l1422
                               datahi_set v____bitbucket_7+19 ; _btemp209
                               bcf      v____bitbucket_7+19, 6 ; _btemp209
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+19, 6 ; _btemp209
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1423
                               movlw    136
                               subwf    v___valor_1,w
l__l1423
                               datahi_set v____bitbucket_7+19 ; _btemp210
                               bcf      v____bitbucket_7+19, 7 ; _btemp210
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+19, 7 ; _btemp210
                               bsf      v____bitbucket_7+20, 0 ; _btemp211
                               btfsc    v____bitbucket_7+19, 6 ; _btemp209
                               btfss    v____bitbucket_7+19, 7 ; _btemp210
                               bcf      v____bitbucket_7+20, 0 ; _btemp211
                               btfss    v____bitbucket_7+20, 0 ; _btemp211
                               goto     l__l662
;  792       cms=91
                               movlw    91
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  793       return
                               return   
;  794    end if
l__l662
;  795    if valor <= 135 & valor >= 132 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1426
                               movlw    135
                               subwf    v___valor_1,w
l__l1426
                               datahi_set v____bitbucket_7+20 ; _btemp212
                               bcf      v____bitbucket_7+20, 1 ; _btemp212
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+20, 1 ; _btemp212
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1427
                               movlw    132
                               subwf    v___valor_1,w
l__l1427
                               datahi_set v____bitbucket_7+20 ; _btemp213
                               bcf      v____bitbucket_7+20, 2 ; _btemp213
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+20, 2 ; _btemp213
                               bsf      v____bitbucket_7+20, 3 ; _btemp214
                               btfsc    v____bitbucket_7+20, 1 ; _btemp212
                               btfss    v____bitbucket_7+20, 2 ; _btemp213
                               bcf      v____bitbucket_7+20, 3 ; _btemp214
                               btfss    v____bitbucket_7+20, 3 ; _btemp214
                               goto     l__l664
;  796       cms=90
                               movlw    90
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  797       return
                               return   
;  798    end if
l__l664
;  799    if valor <= 131 & valor >= 128 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1430
                               movlw    131
                               subwf    v___valor_1,w
l__l1430
                               datahi_set v____bitbucket_7+20 ; _btemp215
                               bcf      v____bitbucket_7+20, 4 ; _btemp215
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+20, 4 ; _btemp215
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1431
                               movlw    128
                               subwf    v___valor_1,w
l__l1431
                               datahi_set v____bitbucket_7+20 ; _btemp216
                               bcf      v____bitbucket_7+20, 5 ; _btemp216
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+20, 5 ; _btemp216
                               bsf      v____bitbucket_7+20, 6 ; _btemp217
                               btfsc    v____bitbucket_7+20, 4 ; _btemp215
                               btfss    v____bitbucket_7+20, 5 ; _btemp216
                               bcf      v____bitbucket_7+20, 6 ; _btemp217
                               btfss    v____bitbucket_7+20, 6 ; _btemp217
                               goto     l__l666
;  800       cms=89
                               movlw    89
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  801       return
                               return   
;  802    end if
l__l666
;  803    if valor <= 127 & valor >= 124 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1434
                               movlw    127
                               subwf    v___valor_1,w
l__l1434
                               datahi_set v____bitbucket_7+20 ; _btemp218
                               bcf      v____bitbucket_7+20, 7 ; _btemp218
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+20, 7 ; _btemp218
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1435
                               movlw    124
                               subwf    v___valor_1,w
l__l1435
                               datahi_set v____bitbucket_7+21 ; _btemp219
                               bcf      v____bitbucket_7+21, 0 ; _btemp219
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+21, 0 ; _btemp219
                               bsf      v____bitbucket_7+21, 1 ; _btemp220
                               btfsc    v____bitbucket_7+20, 7 ; _btemp218
                               btfss    v____bitbucket_7+21, 0 ; _btemp219
                               bcf      v____bitbucket_7+21, 1 ; _btemp220
                               btfss    v____bitbucket_7+21, 1 ; _btemp220
                               goto     l__l668
;  804       cms=88
                               movlw    88
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  805       return
                               return   
;  806    end if
l__l668
;  807    if valor <= 123 & valor >= 121 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1438
                               movlw    123
                               subwf    v___valor_1,w
l__l1438
                               datahi_set v____bitbucket_7+21 ; _btemp221
                               bcf      v____bitbucket_7+21, 2 ; _btemp221
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+21, 2 ; _btemp221
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1439
                               movlw    121
                               subwf    v___valor_1,w
l__l1439
                               datahi_set v____bitbucket_7+21 ; _btemp222
                               bcf      v____bitbucket_7+21, 3 ; _btemp222
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+21, 3 ; _btemp222
                               bsf      v____bitbucket_7+21, 4 ; _btemp223
                               btfsc    v____bitbucket_7+21, 2 ; _btemp221
                               btfss    v____bitbucket_7+21, 3 ; _btemp222
                               bcf      v____bitbucket_7+21, 4 ; _btemp223
                               btfss    v____bitbucket_7+21, 4 ; _btemp223
                               goto     l__l670
;  808       cms=87
                               movlw    87
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  809       return
                               return   
;  810    end if
l__l670
;  811    if valor <= 120 & valor >= 118 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1442
                               movlw    120
                               subwf    v___valor_1,w
l__l1442
                               datahi_set v____bitbucket_7+21 ; _btemp224
                               bcf      v____bitbucket_7+21, 5 ; _btemp224
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+21, 5 ; _btemp224
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1443
                               movlw    118
                               subwf    v___valor_1,w
l__l1443
                               datahi_set v____bitbucket_7+21 ; _btemp225
                               bcf      v____bitbucket_7+21, 6 ; _btemp225
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+21, 6 ; _btemp225
                               bsf      v____bitbucket_7+21, 7 ; _btemp226
                               btfsc    v____bitbucket_7+21, 5 ; _btemp224
                               btfss    v____bitbucket_7+21, 6 ; _btemp225
                               bcf      v____bitbucket_7+21, 7 ; _btemp226
                               btfss    v____bitbucket_7+21, 7 ; _btemp226
                               goto     l__l672
;  812       cms=86
                               movlw    86
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  813       return
                               return   
;  814    end if
l__l672
;  815    if valor <= 117 & valor >= 114 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1446
                               movlw    117
                               subwf    v___valor_1,w
l__l1446
                               datahi_set v____bitbucket_7+22 ; _btemp227
                               bcf      v____bitbucket_7+22, 0 ; _btemp227
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+22, 0 ; _btemp227
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1447
                               movlw    114
                               subwf    v___valor_1,w
l__l1447
                               datahi_set v____bitbucket_7+22 ; _btemp228
                               bcf      v____bitbucket_7+22, 1 ; _btemp228
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+22, 1 ; _btemp228
                               bsf      v____bitbucket_7+22, 2 ; _btemp229
                               btfsc    v____bitbucket_7+22, 0 ; _btemp227
                               btfss    v____bitbucket_7+22, 1 ; _btemp228
                               bcf      v____bitbucket_7+22, 2 ; _btemp229
                               btfss    v____bitbucket_7+22, 2 ; _btemp229
                               goto     l__l674
;  816       cms=85
                               movlw    85
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  817       return
                               return   
;  818    end if
l__l674
;  819    if valor <= 113 & valor >= 110 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1450
                               movlw    113
                               subwf    v___valor_1,w
l__l1450
                               datahi_set v____bitbucket_7+22 ; _btemp230
                               bcf      v____bitbucket_7+22, 3 ; _btemp230
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+22, 3 ; _btemp230
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1451
                               movlw    110
                               subwf    v___valor_1,w
l__l1451
                               datahi_set v____bitbucket_7+22 ; _btemp231
                               bcf      v____bitbucket_7+22, 4 ; _btemp231
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+22, 4 ; _btemp231
                               bsf      v____bitbucket_7+22, 5 ; _btemp232
                               btfsc    v____bitbucket_7+22, 3 ; _btemp230
                               btfss    v____bitbucket_7+22, 4 ; _btemp231
                               bcf      v____bitbucket_7+22, 5 ; _btemp232
                               btfss    v____bitbucket_7+22, 5 ; _btemp232
                               goto     l__l676
;  820       cms=84
                               movlw    84
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  821       return
                               return   
;  822    end if
l__l676
;  823    if valor <= 109 & valor >= 106 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1454
                               movlw    109
                               subwf    v___valor_1,w
l__l1454
                               datahi_set v____bitbucket_7+22 ; _btemp233
                               bcf      v____bitbucket_7+22, 6 ; _btemp233
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+22, 6 ; _btemp233
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1455
                               movlw    106
                               subwf    v___valor_1,w
l__l1455
                               datahi_set v____bitbucket_7+22 ; _btemp234
                               bcf      v____bitbucket_7+22, 7 ; _btemp234
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+22, 7 ; _btemp234
                               bsf      v____bitbucket_7+23, 0 ; _btemp235
                               btfsc    v____bitbucket_7+22, 6 ; _btemp233
                               btfss    v____bitbucket_7+22, 7 ; _btemp234
                               bcf      v____bitbucket_7+23, 0 ; _btemp235
                               btfss    v____bitbucket_7+23, 0 ; _btemp235
                               goto     l__l678
;  824       cms=83
                               movlw    83
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  825       return
                               return   
;  826    end if
l__l678
;  827    if valor <= 105 & valor >= 102 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1458
                               movlw    105
                               subwf    v___valor_1,w
l__l1458
                               datahi_set v____bitbucket_7+23 ; _btemp236
                               bcf      v____bitbucket_7+23, 1 ; _btemp236
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+23, 1 ; _btemp236
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1459
                               movlw    102
                               subwf    v___valor_1,w
l__l1459
                               datahi_set v____bitbucket_7+23 ; _btemp237
                               bcf      v____bitbucket_7+23, 2 ; _btemp237
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+23, 2 ; _btemp237
                               bsf      v____bitbucket_7+23, 3 ; _btemp238
                               btfsc    v____bitbucket_7+23, 1 ; _btemp236
                               btfss    v____bitbucket_7+23, 2 ; _btemp237
                               bcf      v____bitbucket_7+23, 3 ; _btemp238
                               btfss    v____bitbucket_7+23, 3 ; _btemp238
                               goto     l__l680
;  828       cms=82
                               movlw    82
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  829       return
                               return   
;  830    end if
l__l680
;  831    if valor <= 101 & valor >= 98 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1462
                               movlw    101
                               subwf    v___valor_1,w
l__l1462
                               datahi_set v____bitbucket_7+23 ; _btemp239
                               bcf      v____bitbucket_7+23, 4 ; _btemp239
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+23, 4 ; _btemp239
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1463
                               movlw    98
                               subwf    v___valor_1,w
l__l1463
                               datahi_set v____bitbucket_7+23 ; _btemp240
                               bcf      v____bitbucket_7+23, 5 ; _btemp240
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+23, 5 ; _btemp240
                               bsf      v____bitbucket_7+23, 6 ; _btemp241
                               btfsc    v____bitbucket_7+23, 4 ; _btemp239
                               btfss    v____bitbucket_7+23, 5 ; _btemp240
                               bcf      v____bitbucket_7+23, 6 ; _btemp241
                               btfss    v____bitbucket_7+23, 6 ; _btemp241
                               goto     l__l682
;  832       cms=81
                               movlw    81
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  833       return
                               return   
;  834    end if
l__l682
;  835    if valor <= 97 & valor >= 94 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1466
                               movlw    97
                               subwf    v___valor_1,w
l__l1466
                               datahi_set v____bitbucket_7+23 ; _btemp242
                               bcf      v____bitbucket_7+23, 7 ; _btemp242
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+23, 7 ; _btemp242
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1467
                               movlw    94
                               subwf    v___valor_1,w
l__l1467
                               datahi_set v____bitbucket_7+24 ; _btemp243
                               bcf      v____bitbucket_7+24, 0 ; _btemp243
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+24, 0 ; _btemp243
                               bsf      v____bitbucket_7+24, 1 ; _btemp244
                               btfsc    v____bitbucket_7+23, 7 ; _btemp242
                               btfss    v____bitbucket_7+24, 0 ; _btemp243
                               bcf      v____bitbucket_7+24, 1 ; _btemp244
                               btfss    v____bitbucket_7+24, 1 ; _btemp244
                               goto     l__l684
;  836       cms=80
                               movlw    80
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  837       return
                               return   
;  838    end if
l__l684
;  839    if valor <= 93 & valor >= 90 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1470
                               movlw    93
                               subwf    v___valor_1,w
l__l1470
                               datahi_set v____bitbucket_7+24 ; _btemp245
                               bcf      v____bitbucket_7+24, 2 ; _btemp245
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+24, 2 ; _btemp245
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1471
                               movlw    90
                               subwf    v___valor_1,w
l__l1471
                               datahi_set v____bitbucket_7+24 ; _btemp246
                               bcf      v____bitbucket_7+24, 3 ; _btemp246
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+24, 3 ; _btemp246
                               bsf      v____bitbucket_7+24, 4 ; _btemp247
                               btfsc    v____bitbucket_7+24, 2 ; _btemp245
                               btfss    v____bitbucket_7+24, 3 ; _btemp246
                               bcf      v____bitbucket_7+24, 4 ; _btemp247
                               btfss    v____bitbucket_7+24, 4 ; _btemp247
                               goto     l__l686
;  840       cms=79
                               movlw    79
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  841       return
                               return   
;  842    end if
l__l686
;  843    if valor <= 87 & valor >= 84 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1474
                               movlw    87
                               subwf    v___valor_1,w
l__l1474
                               datahi_set v____bitbucket_7+24 ; _btemp248
                               bcf      v____bitbucket_7+24, 5 ; _btemp248
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+24, 5 ; _btemp248
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1475
                               movlw    84
                               subwf    v___valor_1,w
l__l1475
                               datahi_set v____bitbucket_7+24 ; _btemp249
                               bcf      v____bitbucket_7+24, 6 ; _btemp249
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+24, 6 ; _btemp249
                               bsf      v____bitbucket_7+24, 7 ; _btemp250
                               btfsc    v____bitbucket_7+24, 5 ; _btemp248
                               btfss    v____bitbucket_7+24, 6 ; _btemp249
                               bcf      v____bitbucket_7+24, 7 ; _btemp250
                               btfss    v____bitbucket_7+24, 7 ; _btemp250
                               goto     l__l688
;  844       cms=78
                               movlw    78
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  845       return
                               return   
;  846    end if
l__l688
;  847    if valor <= 81 & valor >= 78 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1478
                               movlw    81
                               subwf    v___valor_1,w
l__l1478
                               datahi_set v____bitbucket_7+25 ; _btemp251
                               bcf      v____bitbucket_7+25, 0 ; _btemp251
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+25, 0 ; _btemp251
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1479
                               movlw    78
                               subwf    v___valor_1,w
l__l1479
                               datahi_set v____bitbucket_7+25 ; _btemp252
                               bcf      v____bitbucket_7+25, 1 ; _btemp252
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+25, 1 ; _btemp252
                               bsf      v____bitbucket_7+25, 2 ; _btemp253
                               btfsc    v____bitbucket_7+25, 0 ; _btemp251
                               btfss    v____bitbucket_7+25, 1 ; _btemp252
                               bcf      v____bitbucket_7+25, 2 ; _btemp253
                               btfss    v____bitbucket_7+25, 2 ; _btemp253
                               goto     l__l690
;  848       cms=77
                               movlw    77
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  849       return
                               return   
;  850    end if
l__l690
;  851    if valor <= 77 & valor >= 74 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1482
                               movlw    77
                               subwf    v___valor_1,w
l__l1482
                               datahi_set v____bitbucket_7+25 ; _btemp254
                               bcf      v____bitbucket_7+25, 3 ; _btemp254
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+25, 3 ; _btemp254
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1483
                               movlw    74
                               subwf    v___valor_1,w
l__l1483
                               datahi_set v____bitbucket_7+25 ; _btemp255
                               bcf      v____bitbucket_7+25, 4 ; _btemp255
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+25, 4 ; _btemp255
                               bsf      v____bitbucket_7+25, 5 ; _btemp256
                               btfsc    v____bitbucket_7+25, 3 ; _btemp254
                               btfss    v____bitbucket_7+25, 4 ; _btemp255
                               bcf      v____bitbucket_7+25, 5 ; _btemp256
                               btfss    v____bitbucket_7+25, 5 ; _btemp256
                               goto     l__l692
;  852       cms=76
                               movlw    76
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  853       return
                               return   
;  854    end if
l__l692
;  855    if valor <= 87 & valor >= 84 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1486
                               movlw    87
                               subwf    v___valor_1,w
l__l1486
                               datahi_set v____bitbucket_7+25 ; _btemp257
                               bcf      v____bitbucket_7+25, 6 ; _btemp257
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+25, 6 ; _btemp257
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1487
                               movlw    84
                               subwf    v___valor_1,w
l__l1487
                               datahi_set v____bitbucket_7+25 ; _btemp258
                               bcf      v____bitbucket_7+25, 7 ; _btemp258
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+25, 7 ; _btemp258
                               bsf      v____bitbucket_7+26, 0 ; _btemp259
                               btfsc    v____bitbucket_7+25, 6 ; _btemp257
                               btfss    v____bitbucket_7+25, 7 ; _btemp258
                               bcf      v____bitbucket_7+26, 0 ; _btemp259
                               btfss    v____bitbucket_7+26, 0 ; _btemp259
                               goto     l__l694
;  856       cms=75
                               movlw    75
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  857       return
                               return   
;  858    end if
l__l694
;  859    if valor <= 81 & valor >= 78 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1490
                               movlw    81
                               subwf    v___valor_1,w
l__l1490
                               datahi_set v____bitbucket_7+26 ; _btemp260
                               bcf      v____bitbucket_7+26, 1 ; _btemp260
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+26, 1 ; _btemp260
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1491
                               movlw    78
                               subwf    v___valor_1,w
l__l1491
                               datahi_set v____bitbucket_7+26 ; _btemp261
                               bcf      v____bitbucket_7+26, 2 ; _btemp261
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+26, 2 ; _btemp261
                               bsf      v____bitbucket_7+26, 3 ; _btemp262
                               btfsc    v____bitbucket_7+26, 1 ; _btemp260
                               btfss    v____bitbucket_7+26, 2 ; _btemp261
                               bcf      v____bitbucket_7+26, 3 ; _btemp262
                               btfss    v____bitbucket_7+26, 3 ; _btemp262
                               goto     l__l696
;  860       cms=74
                               movlw    74
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  861       return
                               return   
;  862    end if
l__l696
;  863    if valor <= 75 & valor >= 72 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1494
                               movlw    75
                               subwf    v___valor_1,w
l__l1494
                               datahi_set v____bitbucket_7+26 ; _btemp263
                               bcf      v____bitbucket_7+26, 4 ; _btemp263
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+26, 4 ; _btemp263
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1495
                               movlw    72
                               subwf    v___valor_1,w
l__l1495
                               datahi_set v____bitbucket_7+26 ; _btemp264
                               bcf      v____bitbucket_7+26, 5 ; _btemp264
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+26, 5 ; _btemp264
                               bsf      v____bitbucket_7+26, 6 ; _btemp265
                               btfsc    v____bitbucket_7+26, 4 ; _btemp263
                               btfss    v____bitbucket_7+26, 5 ; _btemp264
                               bcf      v____bitbucket_7+26, 6 ; _btemp265
                               btfss    v____bitbucket_7+26, 6 ; _btemp265
                               goto     l__l698
;  864       cms=73
                               movlw    73
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  865       return
                               return   
;  866    end if
l__l698
;  867    if valor <= 69 & valor >= 66 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1498
                               movlw    69
                               subwf    v___valor_1,w
l__l1498
                               datahi_set v____bitbucket_7+26 ; _btemp266
                               bcf      v____bitbucket_7+26, 7 ; _btemp266
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+26, 7 ; _btemp266
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1499
                               movlw    66
                               subwf    v___valor_1,w
l__l1499
                               datahi_set v____bitbucket_7+27 ; _btemp267
                               bcf      v____bitbucket_7+27, 0 ; _btemp267
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+27, 0 ; _btemp267
                               bsf      v____bitbucket_7+27, 1 ; _btemp268
                               btfsc    v____bitbucket_7+26, 7 ; _btemp266
                               btfss    v____bitbucket_7+27, 0 ; _btemp267
                               bcf      v____bitbucket_7+27, 1 ; _btemp268
                               btfss    v____bitbucket_7+27, 1 ; _btemp268
                               goto     l__l700
;  868       cms=72
                               movlw    72
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  869       return
                               return   
;  870    end if
l__l700
;  871    if valor <= 65 & valor >= 62 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1502
                               movlw    65
                               subwf    v___valor_1,w
l__l1502
                               datahi_set v____bitbucket_7+27 ; _btemp269
                               bcf      v____bitbucket_7+27, 2 ; _btemp269
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+27, 2 ; _btemp269
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1503
                               movlw    62
                               subwf    v___valor_1,w
l__l1503
                               datahi_set v____bitbucket_7+27 ; _btemp270
                               bcf      v____bitbucket_7+27, 3 ; _btemp270
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+27, 3 ; _btemp270
                               bsf      v____bitbucket_7+27, 4 ; _btemp271
                               btfsc    v____bitbucket_7+27, 2 ; _btemp269
                               btfss    v____bitbucket_7+27, 3 ; _btemp270
                               bcf      v____bitbucket_7+27, 4 ; _btemp271
                               btfss    v____bitbucket_7+27, 4 ; _btemp271
                               goto     l__l702
;  872       cms=71
                               movlw    71
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  873       return
                               return   
;  874    end if
l__l702
;  875    if valor <= 61 & valor >= 57 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1506
                               movlw    61
                               subwf    v___valor_1,w
l__l1506
                               datahi_set v____bitbucket_7+27 ; _btemp272
                               bcf      v____bitbucket_7+27, 5 ; _btemp272
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+27, 5 ; _btemp272
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1507
                               movlw    57
                               subwf    v___valor_1,w
l__l1507
                               datahi_set v____bitbucket_7+27 ; _btemp273
                               bcf      v____bitbucket_7+27, 6 ; _btemp273
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+27, 6 ; _btemp273
                               bsf      v____bitbucket_7+27, 7 ; _btemp274
                               btfsc    v____bitbucket_7+27, 5 ; _btemp272
                               btfss    v____bitbucket_7+27, 6 ; _btemp273
                               bcf      v____bitbucket_7+27, 7 ; _btemp274
                               btfss    v____bitbucket_7+27, 7 ; _btemp274
                               goto     l__l704
;  876       cms=70
                               movlw    70
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  877       return
                               return   
;  878    end if
l__l704
;  879    if valor <= 56 & valor >= 53 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1510
                               movlw    56
                               subwf    v___valor_1,w
l__l1510
                               datahi_set v____bitbucket_7+28 ; _btemp275
                               bcf      v____bitbucket_7+28, 0 ; _btemp275
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+28, 0 ; _btemp275
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1511
                               movlw    53
                               subwf    v___valor_1,w
l__l1511
                               datahi_set v____bitbucket_7+28 ; _btemp276
                               bcf      v____bitbucket_7+28, 1 ; _btemp276
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+28, 1 ; _btemp276
                               bsf      v____bitbucket_7+28, 2 ; _btemp277
                               btfsc    v____bitbucket_7+28, 0 ; _btemp275
                               btfss    v____bitbucket_7+28, 1 ; _btemp276
                               bcf      v____bitbucket_7+28, 2 ; _btemp277
                               btfss    v____bitbucket_7+28, 2 ; _btemp277
                               goto     l__l706
;  880       cms=69
                               movlw    69
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  881       return
                               return   
;  882    end if
l__l706
;  883    if valor <= 52 & valor >= 49 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1514
                               movlw    52
                               subwf    v___valor_1,w
l__l1514
                               datahi_set v____bitbucket_7+28 ; _btemp278
                               bcf      v____bitbucket_7+28, 3 ; _btemp278
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+28, 3 ; _btemp278
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1515
                               movlw    49
                               subwf    v___valor_1,w
l__l1515
                               datahi_set v____bitbucket_7+28 ; _btemp279
                               bcf      v____bitbucket_7+28, 4 ; _btemp279
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+28, 4 ; _btemp279
                               bsf      v____bitbucket_7+28, 5 ; _btemp280
                               btfsc    v____bitbucket_7+28, 3 ; _btemp278
                               btfss    v____bitbucket_7+28, 4 ; _btemp279
                               bcf      v____bitbucket_7+28, 5 ; _btemp280
                               btfss    v____bitbucket_7+28, 5 ; _btemp280
                               goto     l__l708
;  884       cms=68
                               movlw    68
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  885       return
                               return   
;  886    end if
l__l708
;  887    if valor <= 48 & valor >= 45 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1518
                               movlw    48
                               subwf    v___valor_1,w
l__l1518
                               datahi_set v____bitbucket_7+28 ; _btemp281
                               bcf      v____bitbucket_7+28, 6 ; _btemp281
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+28, 6 ; _btemp281
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1519
                               movlw    45
                               subwf    v___valor_1,w
l__l1519
                               datahi_set v____bitbucket_7+28 ; _btemp282
                               bcf      v____bitbucket_7+28, 7 ; _btemp282
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+28, 7 ; _btemp282
                               bsf      v____bitbucket_7+29, 0 ; _btemp283
                               btfsc    v____bitbucket_7+28, 6 ; _btemp281
                               btfss    v____bitbucket_7+28, 7 ; _btemp282
                               bcf      v____bitbucket_7+29, 0 ; _btemp283
                               btfss    v____bitbucket_7+29, 0 ; _btemp283
                               goto     l__l710
;  888       cms=67
                               movlw    67
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  889       return
                               return   
;  890    end if
l__l710
;  891    if valor <= 44 & valor >= 42 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1522
                               movlw    44
                               subwf    v___valor_1,w
l__l1522
                               datahi_set v____bitbucket_7+29 ; _btemp284
                               bcf      v____bitbucket_7+29, 1 ; _btemp284
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+29, 1 ; _btemp284
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1523
                               movlw    42
                               subwf    v___valor_1,w
l__l1523
                               datahi_set v____bitbucket_7+29 ; _btemp285
                               bcf      v____bitbucket_7+29, 2 ; _btemp285
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+29, 2 ; _btemp285
                               bsf      v____bitbucket_7+29, 3 ; _btemp286
                               btfsc    v____bitbucket_7+29, 1 ; _btemp284
                               btfss    v____bitbucket_7+29, 2 ; _btemp285
                               bcf      v____bitbucket_7+29, 3 ; _btemp286
                               btfss    v____bitbucket_7+29, 3 ; _btemp286
                               goto     l__l712
;  892       cms=66
                               movlw    66
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  893       return
                               return   
;  894    end if
l__l712
;  895    if valor <= 41 & valor >= 39 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1526
                               movlw    41
                               subwf    v___valor_1,w
l__l1526
                               datahi_set v____bitbucket_7+29 ; _btemp287
                               bcf      v____bitbucket_7+29, 4 ; _btemp287
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+29, 4 ; _btemp287
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1527
                               movlw    39
                               subwf    v___valor_1,w
l__l1527
                               datahi_set v____bitbucket_7+29 ; _btemp288
                               bcf      v____bitbucket_7+29, 5 ; _btemp288
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+29, 5 ; _btemp288
                               bsf      v____bitbucket_7+29, 6 ; _btemp289
                               btfsc    v____bitbucket_7+29, 4 ; _btemp287
                               btfss    v____bitbucket_7+29, 5 ; _btemp288
                               bcf      v____bitbucket_7+29, 6 ; _btemp289
                               btfss    v____bitbucket_7+29, 6 ; _btemp289
                               goto     l__l714
;  896       cms=65
                               movlw    65
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  897       return
                               return   
;  898    end if
l__l714
;  899    if valor <= 38 & valor >= 36 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1530
                               movlw    38
                               subwf    v___valor_1,w
l__l1530
                               datahi_set v____bitbucket_7+29 ; _btemp290
                               bcf      v____bitbucket_7+29, 7 ; _btemp290
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+29, 7 ; _btemp290
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1531
                               movlw    36
                               subwf    v___valor_1,w
l__l1531
                               datahi_set v____bitbucket_7+30 ; _btemp291
                               bcf      v____bitbucket_7+30, 0 ; _btemp291
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+30, 0 ; _btemp291
                               bsf      v____bitbucket_7+30, 1 ; _btemp292
                               btfsc    v____bitbucket_7+29, 7 ; _btemp290
                               btfss    v____bitbucket_7+30, 0 ; _btemp291
                               bcf      v____bitbucket_7+30, 1 ; _btemp292
                               btfss    v____bitbucket_7+30, 1 ; _btemp292
                               goto     l__l716
;  900       cms=64
                               movlw    64
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  901       return
                               return   
;  902    end if
l__l716
;  903    if valor <= 35 & valor >= 33 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1534
                               movlw    35
                               subwf    v___valor_1,w
l__l1534
                               datahi_set v____bitbucket_7+30 ; _btemp293
                               bcf      v____bitbucket_7+30, 2 ; _btemp293
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+30, 2 ; _btemp293
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1535
                               movlw    33
                               subwf    v___valor_1,w
l__l1535
                               datahi_set v____bitbucket_7+30 ; _btemp294
                               bcf      v____bitbucket_7+30, 3 ; _btemp294
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+30, 3 ; _btemp294
                               bsf      v____bitbucket_7+30, 4 ; _btemp295
                               btfsc    v____bitbucket_7+30, 2 ; _btemp293
                               btfss    v____bitbucket_7+30, 3 ; _btemp294
                               bcf      v____bitbucket_7+30, 4 ; _btemp295
                               btfss    v____bitbucket_7+30, 4 ; _btemp295
                               goto     l__l718
;  904       cms=63
                               movlw    63
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  905       return
                               return   
;  906    end if
l__l718
;  907    if valor <= 32 & valor >= 30 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1538
                               movlw    32
                               subwf    v___valor_1,w
l__l1538
                               datahi_set v____bitbucket_7+30 ; _btemp296
                               bcf      v____bitbucket_7+30, 5 ; _btemp296
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+30, 5 ; _btemp296
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1539
                               movlw    30
                               subwf    v___valor_1,w
l__l1539
                               datahi_set v____bitbucket_7+30 ; _btemp297
                               bcf      v____bitbucket_7+30, 6 ; _btemp297
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+30, 6 ; _btemp297
                               bsf      v____bitbucket_7+30, 7 ; _btemp298
                               btfsc    v____bitbucket_7+30, 5 ; _btemp296
                               btfss    v____bitbucket_7+30, 6 ; _btemp297
                               bcf      v____bitbucket_7+30, 7 ; _btemp298
                               btfss    v____bitbucket_7+30, 7 ; _btemp298
                               goto     l__l720
;  908       cms=62
                               movlw    62
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  909       return
                               return   
;  910    end if
l__l720
;  911    if valor <= 29 & valor >= 27 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1542
                               movlw    29
                               subwf    v___valor_1,w
l__l1542
                               datahi_set v____bitbucket_7+31 ; _btemp299
                               bcf      v____bitbucket_7+31, 0 ; _btemp299
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+31, 0 ; _btemp299
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1543
                               movlw    27
                               subwf    v___valor_1,w
l__l1543
                               datahi_set v____bitbucket_7+31 ; _btemp300
                               bcf      v____bitbucket_7+31, 1 ; _btemp300
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+31, 1 ; _btemp300
                               bsf      v____bitbucket_7+31, 2 ; _btemp301
                               btfsc    v____bitbucket_7+31, 0 ; _btemp299
                               btfss    v____bitbucket_7+31, 1 ; _btemp300
                               bcf      v____bitbucket_7+31, 2 ; _btemp301
                               btfss    v____bitbucket_7+31, 2 ; _btemp301
                               goto     l__l722
;  912       cms=61
                               movlw    61
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  913       return
                               return   
;  914    end if
l__l722
;  915    if valor <= 26 & valor >= 19 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1546
                               movlw    26
                               subwf    v___valor_1,w
l__l1546
                               datahi_set v____bitbucket_7+31 ; _btemp302
                               bcf      v____bitbucket_7+31, 3 ; _btemp302
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+31, 3 ; _btemp302
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1547
                               movlw    19
                               subwf    v___valor_1,w
l__l1547
                               datahi_set v____bitbucket_7+31 ; _btemp303
                               bcf      v____bitbucket_7+31, 4 ; _btemp303
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+31, 4 ; _btemp303
                               bsf      v____bitbucket_7+31, 5 ; _btemp304
                               btfsc    v____bitbucket_7+31, 3 ; _btemp302
                               btfss    v____bitbucket_7+31, 4 ; _btemp303
                               bcf      v____bitbucket_7+31, 5 ; _btemp304
                               btfss    v____bitbucket_7+31, 5 ; _btemp304
                               goto     l__l724
;  916       cms=60
                               movlw    60
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  917       return
                               return   
;  918    end if
l__l724
;  919    if valor <= 18 & valor >= 15 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1550
                               movlw    18
                               subwf    v___valor_1,w
l__l1550
                               datahi_set v____bitbucket_7+31 ; _btemp305
                               bcf      v____bitbucket_7+31, 6 ; _btemp305
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+31, 6 ; _btemp305
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1551
                               movlw    15
                               subwf    v___valor_1,w
l__l1551
                               datahi_set v____bitbucket_7+31 ; _btemp306
                               bcf      v____bitbucket_7+31, 7 ; _btemp306
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+31, 7 ; _btemp306
                               bsf      v____bitbucket_7+32, 0 ; _btemp307
                               btfsc    v____bitbucket_7+31, 6 ; _btemp305
                               btfss    v____bitbucket_7+31, 7 ; _btemp306
                               bcf      v____bitbucket_7+32, 0 ; _btemp307
                               btfss    v____bitbucket_7+32, 0 ; _btemp307
                               goto     l__l726
;  920       cms=59
                               movlw    59
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  921       return
                               return   
;  922    end if
l__l726
;  923    if valor <= 14 & valor >= 9 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1554
                               movlw    14
                               subwf    v___valor_1,w
l__l1554
                               datahi_set v____bitbucket_7+32 ; _btemp308
                               bcf      v____bitbucket_7+32, 1 ; _btemp308
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+32, 1 ; _btemp308
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1555
                               movlw    9
                               subwf    v___valor_1,w
l__l1555
                               datahi_set v____bitbucket_7+32 ; _btemp309
                               bcf      v____bitbucket_7+32, 2 ; _btemp309
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+32, 2 ; _btemp309
                               bsf      v____bitbucket_7+32, 3 ; _btemp310
                               btfsc    v____bitbucket_7+32, 1 ; _btemp308
                               btfss    v____bitbucket_7+32, 2 ; _btemp309
                               bcf      v____bitbucket_7+32, 3 ; _btemp310
                               btfss    v____bitbucket_7+32, 3 ; _btemp310
                               goto     l__l728
;  924       cms=58
                               movlw    58
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  925       return
                               return   
;  926    end if
l__l728
;  927    if valor <= 8 & valor >= 6 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1558
                               movlw    8
                               subwf    v___valor_1,w
l__l1558
                               datahi_set v____bitbucket_7+32 ; _btemp311
                               bcf      v____bitbucket_7+32, 4 ; _btemp311
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+32, 4 ; _btemp311
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1559
                               movlw    6
                               subwf    v___valor_1,w
l__l1559
                               datahi_set v____bitbucket_7+32 ; _btemp312
                               bcf      v____bitbucket_7+32, 5 ; _btemp312
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+32, 5 ; _btemp312
                               bsf      v____bitbucket_7+32, 6 ; _btemp313
                               btfsc    v____bitbucket_7+32, 4 ; _btemp311
                               btfss    v____bitbucket_7+32, 5 ; _btemp312
                               bcf      v____bitbucket_7+32, 6 ; _btemp313
                               btfss    v____bitbucket_7+32, 6 ; _btemp313
                               goto     l__l730
;  928       cms=57
                               movlw    57
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  929       return
                               return   
;  930    end if
l__l730
;  932    if valor <= 18 & valor >= 17 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1562
                               movlw    18
                               subwf    v___valor_1,w
l__l1562
                               datahi_set v____bitbucket_7+32 ; _btemp314
                               bcf      v____bitbucket_7+32, 7 ; _btemp314
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+32, 7 ; _btemp314
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1563
                               movlw    17
                               subwf    v___valor_1,w
l__l1563
                               datahi_set v____bitbucket_7+33 ; _btemp315
                               bcf      v____bitbucket_7+33, 0 ; _btemp315
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+33, 0 ; _btemp315
                               bsf      v____bitbucket_7+33, 1 ; _btemp316
                               btfsc    v____bitbucket_7+32, 7 ; _btemp314
                               btfss    v____bitbucket_7+33, 0 ; _btemp315
                               bcf      v____bitbucket_7+33, 1 ; _btemp316
                               btfss    v____bitbucket_7+33, 1 ; _btemp316
                               goto     l__l732
;  933       cms=56
                               movlw    56
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  934       return
                               return   
;  935    end if
l__l732
;  936    if valor <= 16 & valor >= 15 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1566
                               movlw    16
                               subwf    v___valor_1,w
l__l1566
                               datahi_set v____bitbucket_7+33 ; _btemp317
                               bcf      v____bitbucket_7+33, 2 ; _btemp317
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+33, 2 ; _btemp317
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1567
                               movlw    15
                               subwf    v___valor_1,w
l__l1567
                               datahi_set v____bitbucket_7+33 ; _btemp318
                               bcf      v____bitbucket_7+33, 3 ; _btemp318
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+33, 3 ; _btemp318
                               bsf      v____bitbucket_7+33, 4 ; _btemp319
                               btfsc    v____bitbucket_7+33, 2 ; _btemp317
                               btfss    v____bitbucket_7+33, 3 ; _btemp318
                               bcf      v____bitbucket_7+33, 4 ; _btemp319
                               btfss    v____bitbucket_7+33, 4 ; _btemp319
                               goto     l__l734
;  937       cms=55
                               movlw    55
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  938       return
                               return   
;  939    end if
l__l734
;  940    if valor <= 14 & valor >= 13 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1570
                               movlw    14
                               subwf    v___valor_1,w
l__l1570
                               datahi_set v____bitbucket_7+33 ; _btemp320
                               bcf      v____bitbucket_7+33, 5 ; _btemp320
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+33, 5 ; _btemp320
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1571
                               movlw    13
                               subwf    v___valor_1,w
l__l1571
                               datahi_set v____bitbucket_7+33 ; _btemp321
                               bcf      v____bitbucket_7+33, 6 ; _btemp321
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+33, 6 ; _btemp321
                               bsf      v____bitbucket_7+33, 7 ; _btemp322
                               btfsc    v____bitbucket_7+33, 5 ; _btemp320
                               btfss    v____bitbucket_7+33, 6 ; _btemp321
                               bcf      v____bitbucket_7+33, 7 ; _btemp322
                               btfss    v____bitbucket_7+33, 7 ; _btemp322
                               goto     l__l736
;  941       cms=54
                               movlw    54
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  942       return
                               return   
;  943    end if
l__l736
;  944    if valor <= 12 & valor >= 11 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1574
                               movlw    12
                               subwf    v___valor_1,w
l__l1574
                               datahi_set v____bitbucket_7+34 ; _btemp323
                               bcf      v____bitbucket_7+34, 0 ; _btemp323
                               btfss    v__status, v__z
                               btfss    v__status, v__c
                               bsf      v____bitbucket_7+34, 0 ; _btemp323
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1575
                               movlw    11
                               subwf    v___valor_1,w
l__l1575
                               datahi_set v____bitbucket_7+34 ; _btemp324
                               bcf      v____bitbucket_7+34, 1 ; _btemp324
                               btfss    v__status, v__z
                               btfsc    v__status, v__c
                               bsf      v____bitbucket_7+34, 1 ; _btemp324
                               bsf      v____bitbucket_7+34, 2 ; _btemp325
                               btfsc    v____bitbucket_7+34, 0 ; _btemp323
                               btfss    v____bitbucket_7+34, 1 ; _btemp324
                               bcf      v____bitbucket_7+34, 2 ; _btemp325
                               btfss    v____bitbucket_7+34, 2 ; _btemp325
                               goto     l__l738
;  945       cms=54
                               movlw    54
                               datahi_clr v___cms_1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  946       return
                               return   
;  947    end if
l__l738
;  949    if valor <= 5 then
                               movlw    0
                               datahi_clr v___valor_1
                               subwf    v___valor_1+1,w
                               btfss    v__status, v__z
                               goto     l__l1578
                               movlw    5
                               subwf    v___valor_1,w
l__l1578
                               btfsc    v__status, v__z
                               goto     l__l1579
                               btfsc    v__status, v__c
                               goto     l__l740
l__l1579
;  950       cms = 1         ; fuera de rango
                               movlw    1
                               movwf    v___cms_1
                               clrf     v___cms_1+1
;  952    end if
l__l740
;  953 end procedure
l__l540
                               return   
l__l539
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;   80 pin_d1_direction = input
                               datalo_set v_trisd ; pin_d1_direction
                               datahi_clr v_trisd ; pin_d1_direction
                               bsf      v_trisd, 1 ; pin_d1_direction
;   89 var byte digi4 = 0
                               datalo_clr v_digi4
                               clrf     v_digi4
;   90 var byte digi3 = 0
                               clrf     v_digi3
;   91 var byte digi2 = 0
                               clrf     v_digi2
;   92 var byte digi1 = 0
                               clrf     v_digi1
;   93 var byte digi0 = 0
                               clrf     v_digi0
;  102 var word contador = 0
                               clrf     v_contador
                               clrf     v_contador+1
;  105 var word promedio = 0
                               clrf     v_promedio
                               clrf     v_promedio+1
;  107 var word centimetros = 0
                               clrf     v_centimetros
                               clrf     v_centimetros+1
;  134 function digi2bin(byte in di2,byte in di1,byte in di0) return byte is
                               branchlo_clr l__l753
                               branchhi_set l__l753
                               goto     l__l753
;  160 procedure word2digits( byte out digi4, byte out digi3, byte out digi2, byte out digi1, byte out digi0, word in numero ) is
l_word2digits
;  162    var word dec_miles = 0
                               clrf     v_dec_miles
                               clrf     v_dec_miles+1
;  163    var word miles = 0
                               clrf     v_miles
                               clrf     v_miles+1
;  164    var word centena = 0
                               clrf     v___centena_1
                               clrf     v___centena_1+1
;  165    var byte decena = 0
                               clrf     v___decena_1
;  167    dec_miles = numero/10000
                               movlw    16
                               movwf    v__pic_divisor
                               movlw    39
                               movwf    v__pic_divisor+1
                               movf     v___numero_3,w
                               movwf    v__pic_dividend
                               movf     v___numero_3+1,w
                               movwf    v__pic_dividend+1
                               branchlo_clr l__pic_divide
                               call     l__pic_divide
                               datalo_clr v__pic_quotient
                               datahi_clr v__pic_quotient
                               movf     v__pic_quotient,w
                               movwf    v_dec_miles
                               movf     v__pic_quotient+1,w
                               movwf    v_dec_miles+1
;  168    digi4 = byte(dec_miles)
                               movf     v_dec_miles,w
                               movwf    v___digi4_2
;  169    dec_miles = dec_miles * 10000
                               movf     v_dec_miles,w
                               movwf    v__pic_multiplier
                               movf     v_dec_miles+1,w
                               movwf    v__pic_multiplier+1
                               movlw    16
                               movwf    v__pic_multiplicand
                               movlw    39
                               movwf    v__pic_multiplicand+1
                               branchlo_clr l__pic_multiply
                               branchhi_clr l__pic_multiply
                               call     l__pic_multiply
                               datalo_clr v__pic_mresult
                               datahi_clr v__pic_mresult
                               movf     v__pic_mresult,w
                               movwf    v_dec_miles
                               movf     v__pic_mresult+1,w
                               movwf    v_dec_miles+1
;  170    numero = numero - dec_miles
                               movf     v_dec_miles+1,w
                               subwf    v___numero_3+1,f
                               movf     v_dec_miles,w
                               subwf    v___numero_3,f
                               btfss    v__status, v__c
                               decf     v___numero_3+1,f
;  171    miles = numero / 1000
                               movlw    232
                               movwf    v__pic_divisor
                               movlw    3
                               movwf    v__pic_divisor+1
                               movf     v___numero_3,w
                               movwf    v__pic_dividend
                               movf     v___numero_3+1,w
                               movwf    v__pic_dividend+1
                               branchlo_clr l__pic_divide
                               branchhi_clr l__pic_divide
                               call     l__pic_divide
                               datalo_clr v__pic_quotient
                               datahi_clr v__pic_quotient
                               movf     v__pic_quotient,w
                               movwf    v_miles
                               movf     v__pic_quotient+1,w
                               movwf    v_miles+1
;  172    digi3 = byte(miles)
                               movf     v_miles,w
                               movwf    v___digi3_2
;  173    miles = miles * 1000
                               movf     v_miles,w
                               movwf    v__pic_multiplier
                               movf     v_miles+1,w
                               movwf    v__pic_multiplier+1
                               movlw    232
                               movwf    v__pic_multiplicand
                               movlw    3
                               movwf    v__pic_multiplicand+1
                               branchlo_clr l__pic_multiply
                               branchhi_clr l__pic_multiply
                               call     l__pic_multiply
                               datalo_clr v__pic_mresult
                               datahi_clr v__pic_mresult
                               movf     v__pic_mresult,w
                               movwf    v_miles
                               movf     v__pic_mresult+1,w
                               movwf    v_miles+1
;  174    numero = numero - miles
                               movf     v_miles+1,w
                               subwf    v___numero_3+1,f
                               movf     v_miles,w
                               subwf    v___numero_3,f
                               btfss    v__status, v__c
                               decf     v___numero_3+1,f
;  175    centena = numero / 100
                               movlw    100
                               movwf    v__pic_divisor
                               clrf     v__pic_divisor+1
                               movf     v___numero_3,w
                               movwf    v__pic_dividend
                               movf     v___numero_3+1,w
                               movwf    v__pic_dividend+1
                               branchlo_clr l__pic_divide
                               branchhi_clr l__pic_divide
                               call     l__pic_divide
                               datalo_clr v__pic_quotient
                               datahi_clr v__pic_quotient
                               movf     v__pic_quotient,w
                               movwf    v___centena_1
                               movf     v__pic_quotient+1,w
                               movwf    v___centena_1+1
;  176    digi2 = byte(centena)
                               movf     v___centena_1,w
                               movwf    v___digi2_4
;  177    centena = digi2 * 100
                               movf     v___digi2_4,w
                               movwf    v__pic_multiplier
                               clrf     v__pic_multiplier+1
                               movlw    100
                               movwf    v__pic_multiplicand
                               clrf     v__pic_multiplicand+1
                               branchlo_clr l__pic_multiply
                               branchhi_clr l__pic_multiply
                               call     l__pic_multiply
                               datalo_clr v__pic_mresult
                               datahi_clr v__pic_mresult
                               movf     v__pic_mresult,w
                               movwf    v___centena_1
                               movf     v__pic_mresult+1,w
                               movwf    v___centena_1+1
;  178    numero = numero - centena
                               movf     v___centena_1+1,w
                               subwf    v___numero_3+1,f
                               movf     v___centena_1,w
                               subwf    v___numero_3,f
                               btfss    v__status, v__c
                               decf     v___numero_3+1,f
;  179    decena = byte(numero / 10)
                               movlw    10
                               movwf    v__pic_divisor
                               clrf     v__pic_divisor+1
                               movf     v___numero_3,w
                               movwf    v__pic_dividend
                               movf     v___numero_3+1,w
                               movwf    v__pic_dividend+1
                               branchlo_clr l__pic_divide
                               branchhi_clr l__pic_divide
                               call     l__pic_divide
                               datalo_clr v__pic_quotient
                               datahi_clr v__pic_quotient
                               movf     v__pic_quotient,w
                               movwf    v___decena_1
;  180    digi1 = decena
                               movf     v___decena_1,w
                               movwf    v___digi1_4
;  181    decena = digi1 * 10
                               movf     v___digi1_4,w
                               movwf    v__pic_multiplier
                               clrf     v__pic_multiplier+1
                               movlw    10
                               movwf    v__pic_multiplicand
                               clrf     v__pic_multiplicand+1
                               branchlo_clr l__pic_multiply
                               branchhi_clr l__pic_multiply
                               call     l__pic_multiply
                               datalo_clr v__pic_mresult
                               datahi_clr v__pic_mresult
                               movf     v__pic_mresult,w
                               movwf    v___decena_1
;  182    numero = numero - decena
                               movf     v___decena_1,w
                               subwf    v___numero_3,f
                               btfss    v__status, v__c
                               decf     v___numero_3+1,f
;  183    digi0 = byte(numero)
                               movf     v___numero_3,w
                               movwf    v___digi0_4
;  185 end procedure
                               movf     v___digi4_2,w
                               return   
;  361 procedure medir is
l_medir
;  362    var byte y = 0
                               datalo_clr v_y
                               datahi_clr v_y
                               clrf     v_y
;  364    var word total = 0
                               clrf     v_total
                               clrf     v_total+1
;  368    for count(arreglo_mediciones) using y loop
                               clrf     v_y
l__l755
;  369       control = on
                               bsf      v__portc_shadow, 1 ; x150
; 16f877a.jal
;  380    _PORTC = _PORTC_shadow
                               movf     v__portc_shadow,w
                               movwf    v__portc
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  369       control = on
;  370       delay_10us(100)         ; ajustar duración del pulso?
                               movlw    100
                               branchlo_clr l_delay_10us
                               call     l_delay_10us
;  371       control = off
                               datalo_clr v__portc_shadow ; x151
                               datahi_clr v__portc_shadow ; x151
                               bcf      v__portc_shadow, 1 ; x151
; 16f877a.jal
;  380    _PORTC = _PORTC_shadow
                               movf     v__portc_shadow,w
                               movwf    v__portc
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  371       control = off
;  373       delay_10us(230)         ; espacio de protección contra detección espúrea (no rebote), ajustado via scope
                               movlw    230
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
;  374       while deteccion != on loop
l__l760
                               datalo_clr v__portc ; pin_c2
                               datahi_clr v__portc ; pin_c2
                               branchlo_clr l__l761
                               branchhi_set l__l761
                               btfsc    v__portc, 2 ; pin_c2
                               goto     l__l761
;  375          contador = contador + 1
                               incf     v_contador,f
                               btfsc    v__status, v__z
                               incf     v_contador+1,f
;  376          delay_10us(1)
                               movlw    1
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
;  378            if contador >= 1000 then
                               movlw    3
                               datalo_clr v_contador
                               datahi_clr v_contador
                               subwf    v_contador+1,w
                               branchlo_clr l__l1580
                               branchhi_set l__l1580
                               btfss    v__status, v__z
                               goto     l__l1580
                               movlw    232
                               subwf    v_contador,w
l__l1580
                               btfsc    v__status, v__z
                               goto     l__l1581
                               branchlo_set l__l760
                               branchhi_clr l__l760
                               btfss    v__status, v__c
                               goto     l__l760
l__l1581
;  379               contador = 0
                               clrf     v_contador
                               clrf     v_contador+1
;  382       end loop
l__l761
;  383       arreglo_mediciones[y] =  contador
                               bcf      v__status, v__c
                               rlf      v_y,w
                               movwf    v____temp_98
                               movlw    v_arreglo_mediciones
                               addwf    v____temp_98,w
                               movwf    v__fsr
                               irp_clr  
                               movf     v_contador,w
                               movwf    v__ind
                               incf     v__fsr,f
                               movf     v_contador+1,w
                               movwf    v__ind
;  384       delay_1ms(10)                            ; ATENCIÓN: 10 ms parece ser el mejor valor!!
                               movlw    10
                               datalo_set v___n_3
                               movwf    v___n_3
                               clrf     v___n_3+1
                               branchlo_clr l_delay_1ms
                               branchhi_clr l_delay_1ms
                               call     l_delay_1ms
;  385       contador = 0
                               datalo_clr v_contador
                               datahi_clr v_contador
                               clrf     v_contador
                               clrf     v_contador+1
;  386    end loop
                               incf     v_y,f
                               movlw    30
                               subwf    v_y,w
                               branchlo_set l__l755
                               branchhi_clr l__l755
                               btfss    v__status, v__z
                               goto     l__l755
;  388    y = 0
                               clrf     v_y
;  390    cantidad = count(arreglo_mediciones)
                               movlw    30
                               movwf    v_cantidad
;  391    for cantidad using y loop
                               clrf     v_y
                               branchlo_clr l__l766
                               branchhi_set l__l766
                               goto     l__l766
l__l765
;  392        total = total + arreglo_mediciones[y]
                               bcf      v__status, v__c
                               rlf      v_y,w
                               movwf    v____temp_98
                               movlw    v_arreglo_mediciones+1
                               addwf    v____temp_98,w
                               movwf    v__fsr
                               irp_clr  
                               movf     v__ind,w
                               addwf    v_total+1,f
                               decf     v__fsr,f
                               movf     v__ind,w
                               addwf    v_total,f
                               btfsc    v__status, v__c
                               incf     v_total+1,f
;  393    end loop
                               incf     v_y,f
l__l766
                               movf     v_y,w
                               subwf    v_cantidad,w
                               btfss    v__status, v__z
                               goto     l__l765
;  394    promedio = (total/cantidad)   ; recordar que la división es entera
                               movf     v_cantidad,w
                               movwf    v__pic_divisor
                               clrf     v__pic_divisor+1
                               movf     v_total,w
                               movwf    v__pic_dividend
                               movf     v_total+1,w
                               movwf    v__pic_dividend+1
                               branchhi_clr l__pic_divide
                               call     l__pic_divide
                               datalo_clr v__pic_quotient
                               datahi_clr v__pic_quotient
                               movf     v__pic_quotient,w
                               movwf    v_promedio
                               movf     v__pic_quotient+1,w
                               movwf    v_promedio+1
;  396    contador = 0
                               clrf     v_contador
                               clrf     v_contador+1
;  397 end procedure
                               return   
l__l753
;  429 testigo = on
                               bsf      v__portb_shadow, 7 ; x152
; 16f877a.jal
;  222    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  429 testigo = on
;  430 delay_100ms(15)
                               movlw    15
                               datalo_set v___n_5
                               movwf    v___n_5
                               clrf     v___n_5+1
                               branchhi_clr l_delay_100ms
                               call     l_delay_100ms
;  431 testigo = off
                               datalo_clr v__portb_shadow ; x153
                               datahi_clr v__portb_shadow ; x153
                               bcf      v__portb_shadow, 7 ; x153
; 16f877a.jal
;  222    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  431 testigo = off
;  434 print_string(lcd,msg_ok)
                               movlw    l__lcd_put
                               datahi_set v____device_put_1
                               movwf    v____device_put_1
                               movlw    HIGH l__lcd_put
                               movwf    v____device_put_1+1
                               movlw    2
                               movwf    v__str_count
                               clrf     v__str_count+1
                               movlw    l__data_msg_ok
                               movwf    v___str_1
                               movlw    HIGH l__data_msg_ok
                               iorlw    64
                               movwf    v___str_1+1
                               branchlo_clr l_print_string
                               branchhi_clr l_print_string
                               call     l_print_string
;  438 var word valor_tabla = 0
                               datalo_clr v_valor_tabla
                               datahi_clr v_valor_tabla
                               clrf     v_valor_tabla
                               clrf     v_valor_tabla+1
;  439 var word direcc = 0
                               clrf     v_direcc
                               clrf     v_direcc+1
;  440 var byte dire[2] at direcc = {0,0}
                               clrf     v_dire
                               clrf     v_dire+1
;  441 var byte valores[2] at valor_tabla = {0,0}
                               clrf     v_valores
                               clrf     v_valores+1
;  446 forever loop
l__l770
;  461    medir
                               branchlo_set l_medir
                               branchhi_clr l_medir
                               call     l_medir
;  463    valor_a_cm(promedio,centimetros)
                               datalo_clr v_promedio
                               datahi_clr v_promedio
                               movf     v_promedio,w
                               movwf    v___valor_1
                               movf     v_promedio+1,w
                               movwf    v___valor_1+1
                               branchlo_clr l_valor_a_cm
                               branchhi_clr l_valor_a_cm
                               call     l_valor_a_cm
                               datalo_clr v___cms_1
                               datahi_clr v___cms_1
                               movf     v___cms_1,w
                               movwf    v_centimetros
                               movf     v___cms_1+1,w
                               movwf    v_centimetros+1
;  468    while promedio > valor_tabla loop
l__l772
                               movf     v_promedio+1,w
                               subwf    v_valor_tabla+1,w
                               branchlo_clr l__l1582
                               branchhi_set l__l1582
                               btfss    v__status, v__z
                               goto     l__l1582
                               movf     v_promedio,w
                               subwf    v_valor_tabla,w
l__l1582
                               btfsc    v__status, v__z
                               goto     l__l773
                               btfsc    v__status, v__c
                               goto     l__l773
;  470       i2c_start()
                               branchhi_clr l_i2c_start
                               call     l_i2c_start
;  473       resul = i2c_transmit_byte(0xA2)
                               movlw    162
                               branchlo_clr l_i2c_transmit_byte
                               branchhi_clr l_i2c_transmit_byte
                               call     l_i2c_transmit_byte
                               datalo_clr v__bitbucket ; resul1
                               datahi_clr v__bitbucket ; resul1
                               bcf      v__bitbucket, 0 ; resul1
                               btfsc    v__pic_temp, 0 ; _pic_temp
                               bsf      v__bitbucket, 0 ; resul1
;  475       resul = resul & i2c_transmit_byte(dire[1])
                               movf     v_dire+1,w
                               branchlo_clr l_i2c_transmit_byte
                               branchhi_clr l_i2c_transmit_byte
                               call     l_i2c_transmit_byte
                               datalo_clr v__bitbucket ; _btemp337
                               datahi_clr v__bitbucket ; _btemp337
                               bcf      v__bitbucket, 3 ; _btemp337
                               btfsc    v__pic_temp, 0 ; _pic_temp
                               bsf      v__bitbucket, 3 ; _btemp337
                               btfss    v__bitbucket, 3 ; _btemp337
                               bcf      v__bitbucket, 0 ; resul1
;  477       resul = resul & i2c_transmit_byte(dire[0])
                               movf     v_dire,w
                               branchlo_clr l_i2c_transmit_byte
                               branchhi_clr l_i2c_transmit_byte
                               call     l_i2c_transmit_byte
                               datalo_clr v__bitbucket ; _btemp339
                               datahi_clr v__bitbucket ; _btemp339
                               bcf      v__bitbucket, 5 ; _btemp339
                               btfsc    v__pic_temp, 0 ; _pic_temp
                               bsf      v__bitbucket, 5 ; _btemp339
                               btfss    v__bitbucket, 5 ; _btemp339
                               bcf      v__bitbucket, 0 ; resul1
;  479       i2c_restart()
                               branchlo_clr l_i2c_restart
                               branchhi_clr l_i2c_restart
                               call     l_i2c_restart
;  481       resul = resul & i2c_transmit_byte(0xA3)
                               movlw    163
                               branchlo_clr l_i2c_transmit_byte
                               branchhi_clr l_i2c_transmit_byte
                               call     l_i2c_transmit_byte
                               datalo_clr v__bitbucket ; _btemp341
                               datahi_clr v__bitbucket ; _btemp341
                               bcf      v__bitbucket, 7 ; _btemp341
                               btfsc    v__pic_temp, 0 ; _pic_temp
                               bsf      v__bitbucket, 7 ; _btemp341
                               btfss    v__bitbucket, 7 ; _btemp341
                               bcf      v__bitbucket, 0 ; resul1
;  483       valores[1] = i2c_receive_byte(true)
                               datahi_set v____bitbucket_43 ; ack1
                               bsf      v____bitbucket_43, 0 ; ack1
                               branchlo_clr l_i2c_receive_byte
                               branchhi_clr l_i2c_receive_byte
                               call     l_i2c_receive_byte
                               datalo_clr v_valores+1
                               datahi_clr v_valores+1
                               movwf    v_valores+1
;  484       valores[0] = i2c_receive_byte(false)
                               datahi_set v____bitbucket_43 ; ack1
                               bcf      v____bitbucket_43, 0 ; ack1
                               branchlo_clr l_i2c_receive_byte
                               branchhi_clr l_i2c_receive_byte
                               call     l_i2c_receive_byte
                               datalo_clr v_valores
                               datahi_clr v_valores
                               movwf    v_valores
;  488       direcc = direcc + 2
                               movlw    2
                               addwf    v_direcc,f
                               btfsc    v__status, v__c
                               incf     v_direcc+1,f
;  493    end loop
                               branchlo_clr l__l772
                               branchhi_set l__l772
                               goto     l__l772
l__l773
;  494    i2c_stop()
                               branchhi_clr l_i2c_stop
                               call     l_i2c_stop
;  495    centimetros = direcc/2 + 57
                               bcf      v__status, v__c
                               datalo_clr v_direcc
                               datahi_clr v_direcc
                               rrf      v_direcc+1,w
                               movwf    v____temp_99+1
                               rrf      v_direcc,w
                               movwf    v____temp_99
                               movf     v____temp_99+1,w
                               movwf    v_centimetros+1
                               movlw    57
                               addwf    v____temp_99,w
                               movwf    v_centimetros
                               btfsc    v__status, v__c
                               incf     v_centimetros+1,f
;  496    direcc = 0
                               clrf     v_direcc
                               clrf     v_direcc+1
;  497    valor_tabla = 0
                               clrf     v_valor_tabla
                               clrf     v_valor_tabla+1
;  522    if (promedio >= 3) then
                               movlw    0
                               subwf    v_promedio+1,w
                               branchlo_clr l__l1590
                               branchhi_set l__l1590
                               btfss    v__status, v__z
                               goto     l__l1590
                               movlw    3
                               subwf    v_promedio,w
l__l1590
                               btfsc    v__status, v__z
                               goto     l__l1591
                               btfss    v__status, v__c
                               goto     l__l776
l__l1591
;  524       word2digits(digi4,digi3,digi2,digi1,digi0, centimetros)
                               movf     v_centimetros,w
                               movwf    v___numero_3
                               movf     v_centimetros+1,w
                               movwf    v___numero_3+1
                               branchlo_set l_word2digits
                               branchhi_clr l_word2digits
                               call     l_word2digits
                               datalo_clr v_digi4
                               datahi_clr v_digi4
                               movwf    v_digi4
                               movf     v___digi3_2,w
                               movwf    v_digi3
                               movf     v___digi2_4,w
                               movwf    v_digi2
                               movf     v___digi1_4,w
                               movwf    v_digi1
                               movf     v___digi0_4,w
                               movwf    v_digi0
;  526       lcd_clear_screen()
                               branchlo_clr l_lcd_clear_screen
                               branchhi_clr l_lcd_clear_screen
                               call     l_lcd_clear_screen
;  527       lcd_write_char(digi2+48)
                               movlw    48
                               datalo_clr v_digi2
                               datahi_clr v_digi2
                               addwf    v_digi2,w
                               movwf    v__rparam3
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
                               bsf      v__portb_shadow, 4 ; x154
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  527       lcd_write_char(digi2+48)
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  527       lcd_write_char(digi2+48)
; lcd_hd44780_4.jal
;  106    __lcd_write_nibble(value >> 4)               -- write high nibble
                               swapf    v__rparam3,w
                               andlw    15
                               movwf    v____temp_100
                               movf     v____temp_100,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  107    __lcd_write_nibble(value)                    -- write low nibble
                               datalo_clr v__rparam3
                               datahi_clr v__rparam3
                               movf     v__rparam3,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  108    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  527       lcd_write_char(digi2+48)
; lcd_hd44780_4.jal
;  121    __lcd_write(value)                           -- write byte
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  527       lcd_write_char(digi2+48)
; lcd_hd44780_common.jal
;   79    _lcd_write_data(data)
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  527       lcd_write_char(digi2+48)
;  528       lcd_write_char(digi1+48)
                               movlw    48
                               datalo_clr v_digi1
                               datahi_clr v_digi1
                               addwf    v_digi1,w
                               movwf    v__rparam4
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
                               bsf      v__portb_shadow, 4 ; x155
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  528       lcd_write_char(digi1+48)
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  528       lcd_write_char(digi1+48)
; lcd_hd44780_4.jal
;  106    __lcd_write_nibble(value >> 4)               -- write high nibble
                               swapf    v__rparam4,w
                               andlw    15
                               movwf    v____temp_101
                               movf     v____temp_101,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  107    __lcd_write_nibble(value)                    -- write low nibble
                               datalo_clr v__rparam4
                               datahi_clr v__rparam4
                               movf     v__rparam4,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  108    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  528       lcd_write_char(digi1+48)
; lcd_hd44780_4.jal
;  121    __lcd_write(value)                           -- write byte
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  528       lcd_write_char(digi1+48)
; lcd_hd44780_common.jal
;   79    _lcd_write_data(data)
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  528       lcd_write_char(digi1+48)
;  529       lcd_write_char(digi0+48)
                               movlw    48
                               datalo_clr v_digi0
                               datahi_clr v_digi0
                               addwf    v_digi0,w
                               movwf    v__rparam5
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
                               bsf      v__portb_shadow, 4 ; x156
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  529       lcd_write_char(digi0+48)
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  529       lcd_write_char(digi0+48)
; lcd_hd44780_4.jal
;  106    __lcd_write_nibble(value >> 4)               -- write high nibble
                               swapf    v__rparam5,w
                               andlw    15
                               movwf    v____temp_102
                               movf     v____temp_102,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  107    __lcd_write_nibble(value)                    -- write low nibble
                               datalo_clr v__rparam5
                               datahi_clr v__rparam5
                               movf     v__rparam5,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  108    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  529       lcd_write_char(digi0+48)
; lcd_hd44780_4.jal
;  121    __lcd_write(value)                           -- write byte
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  529       lcd_write_char(digi0+48)
; lcd_hd44780_common.jal
;   79    _lcd_write_data(data)
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  529       lcd_write_char(digi0+48)
;  530       print_string(lcd,msg_cm)
                               movlw    l__lcd_put
                               datalo_clr v____device_put_1
                               datahi_set v____device_put_1
                               movwf    v____device_put_1
                               movlw    HIGH l__lcd_put
                               movwf    v____device_put_1+1
                               movlw    2
                               movwf    v__str_count
                               clrf     v__str_count+1
                               movlw    l__data_msg_cm
                               movwf    v___str_1
                               movlw    HIGH l__data_msg_cm
                               iorlw    64
                               movwf    v___str_1+1
                               branchlo_clr l_print_string
                               branchhi_clr l_print_string
                               call     l_print_string
;  531       word2digits(digi4,digi3,digi2,digi1,digi0, promedio)
                               datalo_clr v_promedio
                               datahi_clr v_promedio
                               movf     v_promedio,w
                               movwf    v___numero_3
                               movf     v_promedio+1,w
                               movwf    v___numero_3+1
                               branchlo_set l_word2digits
                               branchhi_clr l_word2digits
                               call     l_word2digits
                               datalo_clr v_digi4
                               datahi_clr v_digi4
                               movwf    v_digi4
                               movf     v___digi3_2,w
                               movwf    v_digi3
                               movf     v___digi2_4,w
                               movwf    v_digi2
                               movf     v___digi1_4,w
                               movwf    v_digi1
                               movf     v___digi0_4,w
                               movwf    v_digi0
;  533       lcd_cursor_position(1,0)
                               datalo_set v___pos_1
                               clrf     v___pos_1
                               movlw    1
                               branchlo_clr l_lcd_cursor_position
                               branchhi_clr l_lcd_cursor_position
                               call     l_lcd_cursor_position
;  534       lcd_write_char(digi4+48)
                               movlw    48
                               datalo_clr v_digi4
                               datahi_clr v_digi4
                               addwf    v_digi4,w
                               movwf    v__rparam6
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
                               bsf      v__portb_shadow, 4 ; x157
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  534       lcd_write_char(digi4+48)
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  534       lcd_write_char(digi4+48)
; lcd_hd44780_4.jal
;  106    __lcd_write_nibble(value >> 4)               -- write high nibble
                               swapf    v__rparam6,w
                               andlw    15
                               movwf    v____temp_103
                               movf     v____temp_103,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  107    __lcd_write_nibble(value)                    -- write low nibble
                               datalo_clr v__rparam6
                               datahi_clr v__rparam6
                               movf     v__rparam6,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  108    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  534       lcd_write_char(digi4+48)
; lcd_hd44780_4.jal
;  121    __lcd_write(value)                           -- write byte
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  534       lcd_write_char(digi4+48)
; lcd_hd44780_common.jal
;   79    _lcd_write_data(data)
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  534       lcd_write_char(digi4+48)
;  535       lcd_write_char(digi3+48)
                               movlw    48
                               datalo_clr v_digi3
                               datahi_clr v_digi3
                               addwf    v_digi3,w
                               movwf    v__rparam7
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
                               bsf      v__portb_shadow, 4 ; x158
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  535       lcd_write_char(digi3+48)
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  535       lcd_write_char(digi3+48)
; lcd_hd44780_4.jal
;  106    __lcd_write_nibble(value >> 4)               -- write high nibble
                               swapf    v__rparam7,w
                               andlw    15
                               movwf    v____temp_104
                               movf     v____temp_104,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  107    __lcd_write_nibble(value)                    -- write low nibble
                               datalo_clr v__rparam7
                               datahi_clr v__rparam7
                               movf     v__rparam7,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  108    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  535       lcd_write_char(digi3+48)
; lcd_hd44780_4.jal
;  121    __lcd_write(value)                           -- write byte
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  535       lcd_write_char(digi3+48)
; lcd_hd44780_common.jal
;   79    _lcd_write_data(data)
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  535       lcd_write_char(digi3+48)
;  536       lcd_write_char(digi2+48)
                               movlw    48
                               datalo_clr v_digi2
                               datahi_clr v_digi2
                               addwf    v_digi2,w
                               movwf    v__rparam8
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
                               bsf      v__portb_shadow, 4 ; x159
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  536       lcd_write_char(digi2+48)
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  536       lcd_write_char(digi2+48)
; lcd_hd44780_4.jal
;  106    __lcd_write_nibble(value >> 4)               -- write high nibble
                               swapf    v__rparam8,w
                               andlw    15
                               movwf    v____temp_105
                               movf     v____temp_105,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  107    __lcd_write_nibble(value)                    -- write low nibble
                               datalo_clr v__rparam8
                               datahi_clr v__rparam8
                               movf     v__rparam8,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  108    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  536       lcd_write_char(digi2+48)
; lcd_hd44780_4.jal
;  121    __lcd_write(value)                           -- write byte
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  536       lcd_write_char(digi2+48)
; lcd_hd44780_common.jal
;   79    _lcd_write_data(data)
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  536       lcd_write_char(digi2+48)
;  537       lcd_write_char(digi1+48)
                               movlw    48
                               datalo_clr v_digi1
                               datahi_clr v_digi1
                               addwf    v_digi1,w
                               movwf    v__rparam9
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
                               bsf      v__portb_shadow, 4 ; x160
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  537       lcd_write_char(digi1+48)
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  537       lcd_write_char(digi1+48)
; lcd_hd44780_4.jal
;  106    __lcd_write_nibble(value >> 4)               -- write high nibble
                               swapf    v__rparam9,w
                               andlw    15
                               movwf    v____temp_106
                               movf     v____temp_106,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  107    __lcd_write_nibble(value)                    -- write low nibble
                               datalo_clr v__rparam9
                               datahi_clr v__rparam9
                               movf     v__rparam9,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  108    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  537       lcd_write_char(digi1+48)
; lcd_hd44780_4.jal
;  121    __lcd_write(value)                           -- write byte
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  537       lcd_write_char(digi1+48)
; lcd_hd44780_common.jal
;   79    _lcd_write_data(data)
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  537       lcd_write_char(digi1+48)
;  538       lcd_write_char(digi0+48)
                               movlw    48
                               datalo_clr v_digi0
                               datahi_clr v_digi0
                               addwf    v_digi0,w
                               movwf    v__rparam10
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
                               bsf      v__portb_shadow, 4 ; x161
; 16f877a.jal
;  247    _PORTB = _PORTB_shadow
                               movf     v__portb_shadow,w
                               movwf    v__portb
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  538       lcd_write_char(digi0+48)
; lcd_hd44780_4.jal
;  120    lcd_rs = high                                -- select data mode
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  538       lcd_write_char(digi0+48)
; lcd_hd44780_4.jal
;  106    __lcd_write_nibble(value >> 4)               -- write high nibble
                               swapf    v__rparam10,w
                               andlw    15
                               movwf    v____temp_107
                               movf     v____temp_107,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  107    __lcd_write_nibble(value)                    -- write low nibble
                               datalo_clr v__rparam10
                               datahi_clr v__rparam10
                               movf     v__rparam10,w
                               branchlo_clr l___lcd_write_nibble
                               branchhi_clr l___lcd_write_nibble
                               call     l___lcd_write_nibble
;  108    delay_10us(4)                                -- > 37 us
                               movlw    4
                               branchlo_clr l_delay_10us
                               branchhi_clr l_delay_10us
                               call     l_delay_10us
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  538       lcd_write_char(digi0+48)
; lcd_hd44780_4.jal
;  121    __lcd_write(value)                           -- write byte
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  538       lcd_write_char(digi0+48)
; lcd_hd44780_common.jal
;   79    _lcd_write_data(data)
; C:\Windows\Escritorio\test_murata_distancias\con_ame2\midiendo_con_dudas\Abr25-1015_muratas_ame2.jal
;  538       lcd_write_char(digi0+48)
;  539    else
                               branchlo_clr l__l775
                               branchhi_set l__l775
                               goto     l__l775
l__l776
;  540       if centimetros == 2 then
                               movlw    2
                               subwf    v_centimetros,w
                               movwf    v__pic_temp
                               movlw    0
                               subwf    v_centimetros+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l810
;  541          lcd_clear_screen()
                               branchhi_clr l_lcd_clear_screen
                               call     l_lcd_clear_screen
;  542          print_string(lcd,msg_fuera_de_rango_sup)
                               movlw    l__lcd_put
                               datalo_clr v____device_put_1
                               datahi_set v____device_put_1
                               movwf    v____device_put_1
                               movlw    HIGH l__lcd_put
                               movwf    v____device_put_1+1
                               movlw    8
                               movwf    v__str_count
                               clrf     v__str_count+1
                               movlw    l__data_msg_fuera_de_rango_sup
                               movwf    v___str_1
                               movlw    HIGH l__data_msg_fuera_de_rango_sup
                               iorlw    64
                               movwf    v___str_1+1
                               branchlo_clr l_print_string
                               branchhi_clr l_print_string
                               call     l_print_string
;  543       elsif centimetros == 1 then
                               branchlo_clr l__l809
                               branchhi_set l__l809
                               goto     l__l809
l__l810
                               movlw    1
                               subwf    v_centimetros,w
                               movwf    v__pic_temp
                               movlw    0
                               subwf    v_centimetros+1,w
                               iorwf    v__pic_temp,w
                               btfss    v__status, v__z
                               goto     l__l811
;  544          lcd_clear_screen()
                               branchhi_clr l_lcd_clear_screen
                               call     l_lcd_clear_screen
;  545          print_string(lcd,msg_fuera_de_rango_inf)
                               movlw    l__lcd_put
                               datalo_clr v____device_put_1
                               datahi_set v____device_put_1
                               movwf    v____device_put_1
                               movlw    HIGH l__lcd_put
                               movwf    v____device_put_1+1
                               movlw    8
                               movwf    v__str_count
                               clrf     v__str_count+1
                               movlw    l__data_msg_fuera_de_rango_inf
                               movwf    v___str_1
                               movlw    HIGH l__data_msg_fuera_de_rango_inf
                               iorlw    64
                               movwf    v___str_1+1
                               branchlo_clr l_print_string
                               branchhi_clr l_print_string
                               call     l_print_string
;  546       end if
l__l811
l__l809
;  547    end if
l__l775
;  548    delay_100ms(10)         ; cada segundo
                               movlw    10
                               datalo_set v___n_5
                               datahi_clr v___n_5
                               movwf    v___n_5
                               clrf     v___n_5+1
                               branchlo_clr l_delay_100ms
                               branchhi_clr l_delay_100ms
                               call     l_delay_100ms
;  559 end loop
                               branchlo_clr l__l770
                               branchhi_set l__l770
                               goto     l__l770
                               end
