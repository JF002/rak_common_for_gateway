#! /bin/bash

SCRIPT_COMMON_FILE=/usr/local/rak/shell_script/rak_common.sh
source $SCRIPT_COMMON_FILE
pinedio_model=`do_get_pinedio_model`

# Reset iC880a PIN
if [ $pinedio_model -eq 0 ]; then
  SX1301_RESET_BCM_PIN=71
else
  SX1301_RESET_BCM_PIN=17
fi
echo "$SX1301_RESET_BCM_PIN"  > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$SX1301_RESET_BCM_PIN/direction
echo "0"   > /sys/class/gpio/gpio$SX1301_RESET_BCM_PIN/value
sleep 0.1
echo "1"   > /sys/class/gpio/gpio$SX1301_RESET_BCM_PIN/value
sleep 0.1
echo "0"   > /sys/class/gpio/gpio$SX1301_RESET_BCM_PIN/value
sleep 0.1
echo "$SX1301_RESET_BCM_PIN" > /sys/class/gpio/unexport
./set_eui.sh
sleep 0.2
#./update_gwid.sh ./local_conf.json
sleep 0.5
./lora_pkt_fwd
