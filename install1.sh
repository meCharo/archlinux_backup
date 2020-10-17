#!/bin/bash

# pre-installation
# fdisk -l
# mkdir temp && mount /dev ./temp && cd ./temp
# haven't checked the internet yet

# 1. partition the disk
fdisk -l
echo -e "\n"
read -p "enter the disk which you want to empty(default:/dev/sda):" disk
disk=${disk:-/dev/sda}
parted $disk print
read -p "continue?(y/n default:n)" continue_parted
continue_parted=${continue_parted:-n}
#echo $continue_tmp
if [ "$continue_parted" == "n" ]; then
        exit
fi
parted $disk <<ESXU
rm 1
rm 2
rm 3
rm 4
mklabel gpt
unit mib
mkpart primary 1 3
name 1 grub
set 1 bios_grub on
mkpart primary 3 515
name 2 boot
mkpart primary 515 4611
name 3 swap
mkpart primary 4611 -1
name 4 rootfs
set 2 boot on
quit
ESXU
parted $disk print
read -p "finish?(y/n default:n)" finish_parted
finish_parted=${finish_parted:-n}
if [ "$finish_parted" == "n" ]; then
        exit
fi

mkfs.ext4 ${disk}4
mkfs.fat -F32 ${disk}2
mkswap ${disk}3
swapon ${disk}3
mount ${disk}4 /mnt

# 2. select the mirror then install the requirement
cp -f ./mirrorlist /etc/pacman.d/mirrorlist
pacstrap /mnt base base-devel linux linux-firmware

# 3.configure the system
genfstab -U /mnt >> /mnt/etc/fstab
#arch-chroot /mnt

echo -e "need: umount u disk then arch-chroot /mnt\n"

