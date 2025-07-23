local wezterm = require 'wezterm'

return {
  default_prog = { '/bin/zsh', '--login' },
  font = wezterm.font({
    family = 'Monaspace Argon',
    weight = 400,
    harfbuzz_features = {
      'calt',
      'clig=0',
      'liga',
      'ss01=0',
      'ss02=0',
      'ss03=0',
      'ss04=0',
      'ss05=0',
      'ss06',
      'ss07',
      'ss08=0',
      'ss09=0',
    },
  }),
  font_size = 20,
  color_scheme = "Unikitty Light (base16)",
  use_fancy_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  native_macos_fullscreen_mode = true,
  -- TODO: disable and remap all bindings with SUPER in it
  disable_default_key_bindings = false,
  disable_default_mouse_bindings = false,
  scrollback_lines = 10000,
}
