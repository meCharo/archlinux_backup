# configure the system

# 1. time zone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc

# 2. language
cp -f ./locale.gen /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

# 3. network
echo "CharoPC" > /etc/hostname
cp -f ./hosts /etc/hosts
pacman -S dhcpcd
systemctl enable dhcpcd

# 4. bootloader grub
pacman -S grub efibootmgr
mkdir /boot/efi
mount /dev/sda2 /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg

# 5. post-installation
# 1) add user and user group
useradd -m -G wheel -s /bin/bash charo

# 2) sudo configuration
# pacman -S sudo
# vim /etc/sudoers
# charo ALL=(ALL) ALL

# 3) ssh
# systemctl enable sshd
# pacman -S openssh

# 4) gpu driver and bumblebee
# lspci -k | grep -A 2 -E "(VGA|3D)"
# enable in /etc/pacman.conf
# pacman -Syu
# pacman -S nvidia lib32-nvidia-utils bumblebee mesa xf86-video-intel lib32-virtualgl lib32-nvidia-utils
# gpasswd -a charo bumblebee
# systemctl enable bumblebeed
# reboot

echo -e "need: passwd then passwd charo\n"
echo -e "Ctrl+d then umount -R /mnt then reboot"

