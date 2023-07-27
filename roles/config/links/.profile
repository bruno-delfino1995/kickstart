# vim: set ft=sh:

for cfg in ~/.config/profile.d/*; do
  source "$cfg"
done
