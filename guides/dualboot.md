# Dual boot using GRUB

- Install `os-prober`

```
$ sudo pacman -S os-prober
```

- Enable it in GRUB by "undisabling" it. You'll need to edit the following in `/etc/default/grub`:

```
GRUB_DISABLE_OS_PROBER=false
```

- Mount the EFI or BIOS partition of another system

```
$ sudo mount /dev/sdxy /mnt/other
```

- Regenerate your grub config so `os-prober` can detect systems and generate entries for them

```
$ sudo grub-mkconfig -o /boot/grub/grub.cfg
```

- Enable remembering in GRUB so updates over reboots don't need intervention. You'll need to edit the following in `/etc/default/grub`:

```
GRUB_DEFAULT=saved
GRUB_SAVEDEFAULT=true
```
