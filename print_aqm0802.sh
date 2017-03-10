#!/bin/bash -f
I2C_BUS=1                      # I2C bus No.
LCD_ADDR="0x3e"                # LCD I2C slave address
DATA_STR="0x40"                # Data    stream(Co=0,RS=1)
CTRL_STR="0x00"                # Control stream(Co=0,RS=0)
MES="${1:- }                "  # Message_Strings with filler

### create data value
DATA=` echo -n "${MES}"  | od -A n -t x1 -w16 | head -1 | sed -e 's/ / 0x/g' -e 's/^ //g'`
LINE1=`echo -n "${DATA}" | cut -d " " -f 1-8`
LINE2=`echo -n "${DATA}" | cut -d " " -f 9-16`

### LCD initialize
i2cset -y ${I2C_BUS} ${LCD_ADDR} ${CTRL_STR} 0x38 0x39 0x14 0x70 0x56 0x6c i
i2cset -y ${I2C_BUS} ${LCD_ADDR} ${CTRL_STR} 0x38 0x0c 0x01 i

### LCD output
i2cset -y ${I2C_BUS} ${LCD_ADDR} ${CTRL_STR} 0x01 i       # Clear Display(move to line 1)
i2cset -y ${I2C_BUS} ${LCD_ADDR} ${DATA_STR} ${LINE1} i   # data values of line 1
i2cset -y ${I2C_BUS} ${LCD_ADDR} ${CTRL_STR} 0xc0 i       # Set DDRAM address(move to line 2)
i2cset -y ${I2C_BUS} ${LCD_ADDR} ${DATA_STR} ${LINE2} i   # data values of line 2
