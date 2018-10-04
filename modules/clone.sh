#!/bin/bash

function clone {
    a=$(fdisk -l |grep /dev/mmcblk0: | grep -P '\d+ (?=bytes)' -o)
    #echo "$a - /dev/mmcblk0"

    b=$(fdisk -l |grep /dev/sdb: | grep -P '\d+ (?=bytes)' -o)
    #echo "$b - /dev/sdb"

    if [ -z "$a" ] || [ -z "$b" ]; then
        echo "error getting the sizes of the devices"
        return 1
    fi



    if [ $b -lt $a ]; then
        echo "you can only clone to an sd card that has atleast"
        echo "as much capacity as the current filesystem"
        return 1
    fi

    if [ $a -eq $b ] || [ $a -lt $b ]; then

        echo "copying...."
        echo u > /proc/sysrq-trigger
        dd if=/dev/mmcblk0 bs=1M of=/dev/sdb

    fi

}

function clone_help {
  echo ""
  echo "Usage: $(basename "$0")"
  echo ""
  echo "clones your entire filesystem to an SD CARD"
  echo ""
}
