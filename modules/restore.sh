



#make sure /dev/sdb0 exists

function restore() {

    fdisk -l | grep -q /dev/sdb:
    if [ $? -ne 0 ]; then 
        echo "no device detected, exiting"
        return 1
    fi
    echo "copying...."
    echo u > /proc/sysrq-trigger
    dd if=/dev/mmcblk0 bs=1M of=/dev/sdb
}
