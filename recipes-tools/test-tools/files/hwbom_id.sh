#!/bin/bash
##########################
# Author: Po Cheng       #
# Date: 24/06/2021       #
##########################

if [ $# -gt 0 -a $# -le 4 ]; then
  echo "syntax: powerled.sh <I2C_BUS> <I2C_ADDR> <REG_DATA> <REG_DATA_MASK>"
  exit 1
fi

I2C_BUS=${1:-4}
I2C_ADDR=${2:-0x70}
REG_DATA=${4:-0x10}
REG_DATA_MASK=${5:-0x1F}

# value on iopexpander
# i2cget -f -y 4 0x70 0x10
VALUE=$( i2cget -f -y $I2C_BUS $I2C_ADDR $REG_DATA )
# from e1 => 1
BOMID=$(( ( $VALUE & 0x1C ) >> 2))
HWID=$(( $VALUE & 0x03 ))
CONFID=$(( $BOMID | ( $HWID << 3 ) ))
VALUE=$(( $VALUE & $REG_DATA_MASK ))
printf "hw: id 0x%02X, bom id: 0x%02X, id: %d, gpio: 0x%02X\n" $HWID $BOMID $CONFID $VALUE

