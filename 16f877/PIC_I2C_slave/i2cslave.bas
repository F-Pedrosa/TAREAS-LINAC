' PicBasic Pro I2C slave program - PIC16F877/PIC-X1

DEFINE	ONINT_USED	1			' For use with melabs Loader

' Alias pins
scl     VAR     PORTC.3         ' I2C clock input
sda     VAR     PORTC.4         ' I2C data input


' Define used register flags
SSPIF   VAR     PIR1.3          ' SSP (I2C) interrupt flag
BF      VAR     SSPSTAT.0       ' SSP (I2C) Buffer Full
R_W     VAR     SSPSTAT.2       ' SSP (I2C) Read/Write
D_A     VAR     SSPSTAT.5       ' SSP (I2C) Data/Address
CKP     VAR     SSPCON.4        ' SSP (I2C) SCK Release Control
SSPEN   VAR     SSPCON.5        ' SSP (I2C) Enable
SSPOV   VAR     SSPCON.6        ' SSP (I2C) Receive Overflow Indicator
WCOL    VAR     SSPCON.7        ' SSP (I2C) Write Collision Detect


' Define constants
I2Caddress CON	2				' Make our address 2


' Allocate RAM
result	VAR		BYTE			' ADC result
datain 	VAR     BYTE			' Data in 
dataout	VAR     BYTE[8]			' Data out array
readcnt	VAR     BYTE            ' I2C read count



' Initialize ports and directions
        ADCON1 = $0e			' PORTA.0 analog, rest PORTA and PORTE pins to digital

' Initialize I2C slave mode
        SSPADD = I2Caddress		' Set our address
        SSPCON2 = 0 			' General call address disabled
        SSPCON = $36 			' Set to I2C slave with 7-bit address

        readcnt = 0				' Zero counter

        dataout[0] = "A"		' Preset output data to "ADC=    "
        dataout[1] = "D"
        dataout[2] = "C"
        dataout[3] = "="
        dataout[4] = " "
        dataout[5] = " "
        dataout[6] = " "
        dataout[7] = " "


        GoTo mainloop 			' Skip over subroutines



i2cslave:						' I2C slave subroutine

		SSPIF = 0				' Clear interrupt flag
		
        IF R_W = 1 Then i2crd   ' Read data from us

        IF BF = 0 Then i2cexit  ' Nothing in buffer so exit

        IF D_A = 1 Then i2cwr   ' Data for us (not address)

        IF SSPBUF != I2Caddress Then i2cexit	' Clear the address from the buffer
        
        readcnt = 0				' Mark as first read
        
        GoTo i2cexit


i2cwr:							' I2C write data to us

        datain = SSPBUF			' Put data into array
        GoTo i2cexit


i2crd:							' I2C read data from us

        IF D_A = 0 Then
                readcnt = 0		' Mark as first read
        EndIF

        SSPBUF = dataout[readcnt]	' Get data from array
        CKP = 1                 	' Release SCL line
        readcnt = readcnt + 1   	' Move along read count
        
        GoTo i2cexit            	' That's it


i2cexit:

		Return



mainloop:						' Main program loop
        

        IF SSPIF Then			' Check for I2C interrupt flag
                GoSub i2cslave
        EndIF

		ADCIN 0, result			' Read ADC channel 0
	
		dataout[5] = datain[0] - result		' Add offset to result value


        GoTo mainloop           ' Do it all forever

