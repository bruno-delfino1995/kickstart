for cfg in ~/.config/zshrc.d/*; do
  source "$cfg"
done

# Prompt
eval "$(starship init zsh)"
