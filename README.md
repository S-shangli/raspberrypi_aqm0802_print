# raspberrypi_aqm0802_print
Shellscript for the AQM0802 charactor LCD on RaspberryPi.

# settings
|item|descriptions|
|---|---|
|I2C_BUS=1|I2C bus No.|
|LCD_ADDR="0x3e"|LCD I2C slave address|

# usage
execute with one arg that is strings.

    [pi@raspberrypi]% ./print_aqm0802.sh "hello   world"

you can see "hello world" in the LCD.

# software requirements
* bash
* od
* head
* sed
* cut
* i2cset , i2cget

# hardware list
* RaspberryPi, OrangePi C.H.I.P. and i2cget/i2cset working environment.
* AQM0802 , AQM1602
* 2SA1015 (or other PNP tr)

# hardware connection
     AQM0802                                 RaspberryPi
    +--------+                                +-------+
    |        |                                |       |
    |      VDD---*----------------------------3.3V    |
    |        |   |                            |       |
    |    RESET---+                            |       |
    |        |                                |       |
    |      SCL--------------------------------SCL     |
    |        |                                |       |
    |      SDA--------*                 +-----SDA     |
    |        |        |                 |     |       |
    |      GND---*----+-----------------+-----GND     |
    |        |   |    |                 |     |       |
    +--------+   |    |                 |     +-------+
                 |    |                 |
    2SA1015      |    |                 |
    +------+     |    *--[R 100k Ohm]---*
    |      C-----+    |                 |
    |      B----------+                 |
    |      E----------------------------+
    +------+
    (PNP Tr)
    
    + corner/cross-over
    * connect

## PNP Tr wrokings
AQM0802, AQM1602 is lower sink power at SDA. they can't drive-L at I2C bus (SDA). 
Therefore I2C communication will fail.  
PNP tr is help this problem.
