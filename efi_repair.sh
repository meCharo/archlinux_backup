# macOS dd

diskutil list

diskutil unmountDisk /dev/disk2

sudo dd if=/Users/charo/Downloads/archlinux-2022.09.03-x86_64.iso/archlinux-2022.09.03-x86_64.iso of=/dev/rdisk2 bs=1m

# in ios

# 来自其他网站
## 先用 chroot 命令改变程序执行时所参考的根目录位置：
mount /dev/sdb4 /mnt
chroot /mnt

## 安装 GRUB
grub-install /dev/sdb
grub-install --recheck /dev/sdb
update-grub

# 来自官网

mount /dev/sdb4 /mnt
arch-chroot /mnt

mount /dev/sdb2 /boot/efi
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=grub
grub-mkconfig -o /boot/grub/grub.cfg
