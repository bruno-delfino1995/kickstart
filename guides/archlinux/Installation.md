# Installation Guide

## Creating the bootable media

Download an iso for [Arch](https://archlinux.org/download/)

Verify its signature<br />
`sha1sum archlinux-version-x86_64.iso`

Create a bootable USB with<br />
`dd bs=4M if=path/to/archlinux-version-x86_64.iso of=/dev/sdx conv=fsync oflag=direct status=progress`

Insert the USB stick and let start the installation process

## Foundation for ease of installation

Setup the correct keyboard layout by loading it using<br />
`loadkeys <layout>`

Make sure you're running on EFI<br />
`ls /sys/firmware/efi`

Check network connectivity<br />
`ping -c 3 -n -w 1000 1.1.1.1`

Update your mirrors for speed with<br />
`reflector --protocol https --age 48 --latest 100 --fastest 50 --save /etc/pacman.d/mirrorlist`

## Partitioning and Formatting the Hard Drive

We're going to create our partitions while following the below recommendations

- Leave an empty space at the beginning, usually 1MiB, for [alignment](https://rainbow.chard.org/2013/01/30/how-to-align-partitions-for-best-performance-using-parted/)
- Use multiples of disk sectors when specifying partition sizes. As they're normally 512B, we'll be using IEC binary units of at least [1MiB](https://wiki.archlinux.org/title/Parted#Rounding)
- Create a partition of [550MiB](https://superuser.com/a/1310938) for EFI
- Create one partition for swap according to your [requirements](https://itsfoss.com/swap-size/)
- Create another partition for your system with remaining space

Find your disk with `fdisk -l` and save it to a variable<br />
`DISK=/dev/sdx`

Define end of your swap partition<br />
`SWAP_END=$(bc <<<'x * 1024 + 551')`

Create a GPT partition table<br />
`parted "$DISK" -- mklabel gpt`

Create the EFI partition after the first 1MiB<br />
`parted -a opt "$DISK" -- unit MiB mkpart primary fat32 1 551 set 1 esp on`

Create the swap partition with size x<br />
`parted -a opt "$DISK" -- unit MiB mkpart primary linux-swap 551 $SWAP_END`

Create the root partition starting at x until 100%<br />
`parted -a opt "$DISK" -- unit MiB mkpart primary btrfs $SWAP_END 100%`

Set boot flag to EFI partition<br />
`parted "$DISK" -- set 1 esp on`

Format the EFI partition<br />
`mkfs.fat -F 32 -n boot "${DISK}1"`

Format the swap partition<br />
`mkswap -L swap "${DISK}2"`

Format the system partition<br />
`mkfs.btrfs -L arch "${DISK}3`

Activate the swap partition<br />
`swapon "${DISK}2"`

## Installing the System

Mount the root on /mnt<br />
`mount "${DISK}3" /mnt`

Use pacstrap to install the base system, along with things that you'll need after the first boot, into your mount point<br />
`pacstrap /mnt mkinitcpio linux base base-devel zsh neovim networkmanager iwd git python ansible`

Mount EFI patition on boot directory<br />
`mount "${DISK}1" /mnt/boot`

Enter the system's partition<br />
`arch-chroot /mnt`

Create a password to the root user<br />
`passwd`

Create a group and user<br />
`groupadd youruser && useradd -mg your_user -G wheel -s /bin/zsh your_user`

Change your user password<br />
`passwd your_user`

Enable wheel group<br />
`nvim /etc/sudoers`

Set language by unncomenting your it on locale.gen<br />
`nvim /etc/locale.gen`

Create the locale file and config language<br />
`locale-gen`
`echo LANG=en_US.UTF-8 > /etc/locale.conf`
`export LANG=en_US.UTF-8`

Create a link between the timezone file and localtime file and set hwclock to store UTC<br />
`ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime`<br />
`hwclock --systohc --utc`

Choose your hostname<br />
`echo hostname > /etc/hostname`

Install the bootloader (grub) and EFI manager<br />
`pacman -S grub efibootmgr`

Install grub for the given architecture and EFI directory<br />
`grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --recheck`

Generate an init file which grub uses to load linux<br />
`mkinitcpio -p linux`

Create the grub configuration file<br />
`grub-mkconfig -o /boot/grub/grub.cfg`

Enable networking for next boot<br />
`systemctl enable NetworkManager.service`

Disconnect from chroot session<br />
`exit`

Generate fstab file based on the hard drive<br />
`genfstab /mnt >> /mnt/etc/fstab`

Unmount the hard drive but first unmount everything mounted on top of it, as the boot
directory<br />
`umount /mnt/boot`<br />
`umount /mnt`

Now reboot the system and check if everything is working.
