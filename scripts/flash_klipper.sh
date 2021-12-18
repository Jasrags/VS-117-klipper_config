#!/bin/bash
sudo service klipper stop
cd ~/klipper

# Flash MCU (SKR 1.4s)
make clean KCONFIG_CONFIG=config.skr14
make menuconfig KCONFIG_CONFIG=config.skr14
make KCONFIG_CONFIG=config.skr14
read -p "SKR 1.4 firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
./scripts/flash-sdcard.sh /dev/serial/by-id/usb-Klipper_lpc1768_0D50010EA0A447AF02B0155DC62000F5-if00 btt-skr-v1.4
./scripts/flash-sdcard.sh /dev/serial/by-id/usb-Klipper_lpc1768_1A10001848104AAF00CF675DC32000F5-if00 btt-skr-v1.4
read -p "SKR 1.4 firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

# Flash MCU (Linux)
make clean KCONFIG_CONFIG=config.rpi
make menuconfig KCONFIG_CONFIG=config.rpi
make KCONFIG_CONFIG=config.rpi
read -p "RPi firmware built, please check above for any errors. Press [Enter] to continue flashing, or [Ctrl+C] to abort"
make flash KCONFIG_CONFIG=config.rpi
read -p "RPi firmware flashed, please check above for any errors. Press [Enter] to continue, or [Ctrl+C] to abort"

sudo service klipper start
