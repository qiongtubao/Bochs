#!/bin/bash

RED_COLOR='\E[1;31m'
RESET='\E[0m'

echo -e "${RED_COLOR}=== env check  ===${RESET}"

if [ ! -e latte.bochsrc ];then
    echo "no latte.bochsrc,please checkout!"
    exit 1
fi

if [ -e ../../../build/bin/bochs ];then
    echo "find /usr/local/bin/bochs!"
else
    echo "no bochs find!,Please check your bochs environment" 
fi

if [ -e ../../../build/bin/bximage ];then
    echo "find /usr/local/bin/bximage!"
else
    echo "no bximge find!,Please check your bochs environment" 
fi

if [ -e boot.img ];then
    echo "find boot.img !"
else
    echo "no boot.img! generating..."
    echo -e  "1\nfd\n\nboot.img\n" | bximage
fi

if [ ! -e  ../../../build/share/bochs/BIOS-bochs-latest ];then
    echo " /usr/local/share/bochs/BIOS-bochs-latest does not exist..."
    exit 1
else
    file /usr/local/share/bochs/BIOS-bochs-latest
fi

if [ ! -e  ../../../build/share/bochs/VGABIOS-lgpl-latest ];then
    echo "/usr/local/share/bochs/VGABIOS-lgpl-latest does not exist..."
    exit 1
else
    file /usr/local/share/bochs/VGABIOS-lgpl-latest
fi

echo -e "${RED_COLOR}=== gen boot.bin ===${RESET}"
nasm boot.asm -o boot.bin
echo -e "${RED_COLOR}=== write boot.bin  to boot.img ===${RESET}"
dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc
echo -e "${RED_COLOR}=== running..PS:emulator will stop at beinging,press 'c' to running ===${RESET}"

if [ -e ../../../build/bin/bochs ];then
   ../../../build/bin/bochs -qf latte.bochsrc
else
    echo "Please check your bochs environment!!!"
    exit 1
fi