# Installation Guide

## Creating the bootable media

- Download an ISO for [Arch Linux](https://archlinux.org/download/)

- Verify its signature

```
$ sha1sum archlinux-version-x86_64.iso
```

- Create a bootable USB with

```
$ dd bs=4M conv=fsync oflag=direct status=progress \
  if=path/to/archlinux-version-x86_64.iso \
  of=/dev/sdx 
```

- Insert the USB stick and let's start the installation process

## Preparing for installation

- Tip: You can use a TMUX session so you can run multiple commands in case you get stuck

```
# tmux new -s shell -c $HOME
```

- Set up the correct keyboard layout by loading it using

```
# localectl list-keymaps | grep -i <keymap>
# loadkeys <keymap> # it's us-acentos for us international
```

- Make sure you're running on EFI

```
# ls /sys/firmware/efi
```

- Connect to Wi-Fi if there's no wired connection

```
# iwctl
[iwd]# device list
[iwd]# station <device> scan
[iwd]# station <device> get-networks
[iwd]# station <device> connect <SSID> # or `connect-hidden` for hidden networks
[iwd]# station <device> show
```

- Check network connectivity

```
# ping -c 3 -n -w 1000 1.1.1.1
```

- Update your mirrors for speed

```
# reflector --protocol https \
  --latest 100 \
  --fastest 50 \
  --save /etc/pacman.d/mirrorlist
```

## Formatting the hard drive

We're going to create our partitions while following the recommendations below:

- Leave a space at the beginning, usually 1MiB, for [alignment](https://rainbow.chard.org/2013/01/30/how-to-align-partitions-for-best-performance-using-parted/)
- Use multiples of disk sectors when specifying partition sizes. As they're typically 512B, we'll be using IEC binary units of at least [1MiB](https://wiki.archlinux.org/title/Parted#Rounding)
- Create a partition of [550MiB](https://superuser.com/a/1310938) for EFI
- Create one partition for swap according to your [requirements](https://itsfoss.com/swap-size/)
- Create another partition for your system with the remaining space

With your numbers at hand, start cracking:

- Create a GPT partition table on the target disk

```
# fdisk -l
# DISK=/dev/sdx
# parted "$DISK" -- mklabel gpt
```

- Create the EFI 550 MiB partition after the first 1 MiB

```
# parted -a opt "$DISK" -- unit MiB mkpart primary fat32 1 551
# parted "$DISK" -- set 1 esp on
```

- Create the swap partition with size x

```
# SWAP_SIZE="x" # in GiB
# SWAP_END=$(bc <<<"$SWAP_SIZE * 1024 + 551")
# parted -a opt "$DISK" -- unit MiB mkpart primary linux-swap 551 $SWAP_END
```

- Create the root partition starting after swap that spans until 100%

```
# parted -a opt "$DISK" -- unit MiB mkpart primary btrfs $SWAP_END 100%
```

- Format the partitions with their corresponding file systems


```
# mkfs.fat -F 32 -n boot "${DISK}1"
# mkswap -L swap "${DISK}2"
# mkfs.btrfs -L arch "${DISK}3"
```

- Activate the swap partition

```
# swapon "${DISK}2"
```

## Installing the base system

- Mount the system and EFI partitions on /mnt and bootstrap the minimal packages on it

```
# mount "${DISK}3" /mnt
# mkdir /mnt/boot
# mount "${DISK}1" /mnt/boot
# pacstrap /mnt linux linux-firmware base base-devel zsh tmux neovim
```

- Enter the mount for your hard drive and start the process in another tmux session

```
# arch-chroot /mnt
# echo <hostname> > /etc/hostname
```

- Configure the language and timezone

```
# nvim /etc/locale.gen # uncomment en_US.UTF-8
# locale-gen
# echo LANG=en_US.UTF-8 > /etc/locale.conf
# export LANG=en_US.UTF-8
# ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
# hwclock --systohc --utc
```

- Set up users, passwords, groups, and sudo

```
# passwd
# groupadd <you> && useradd -mg <you> -G wheel -s /bin/zsh <you>
# passwd <you>
# nvim /etc/sudoers # enable the wheel group
```

- Configure a bootloader for your architecture in the boot directory

```
# pacman -S grub efibootmgr mkinitcpio
# grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id="Linux Boot Manager" --recheck
# mkinitcpio -p linux
# grub-mkconfig -o /boot/grub/grub.cfg
```

- Enable networking for next boot

```
# pacman -S networkmanager iwd
# systemctl enable NetworkManager.service
```

- Generate fstab and wrap up

```
# exit
# genfstab /mnt >> /mnt/etc/fstab
# umount /mnt/boot
# umount /mnt
```

Now reboot the system and check if everything is working!

## Installing your customizations

- Reconfigure your keyboard (you rebooted, remember?)

```
$ loadkeys <keymap>
```

- Start a network connection with the network manager

```
$ nmtui
```

- Clone the repository to get started

```
$ sudo pacman -S git
$ mkdir -p ~/Repositories/github.com/bruno-delfino1995
$ cd ~/Repositories/github.com/bruno-delfino1995
$ git clone https://github.com/bruno-delfino1995/kickstart.git
$ cd kickstart
```

- Initialize the runtimes with mise

```
$ sudo pacman -S mise
$ eval "$(mise activate zsh)" 
$ mise trust
$ mise install
$ uv sync
```

- Copy the example configuration to your local customization

```
$ cp host_data/example.py host_data/local.py
$ nvim host_data/local.py
```

- Run pyinfra to install everything for you

```
$ pyinfra inventory.py deploy.py
```
