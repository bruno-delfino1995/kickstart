return {
  -- fix responsiveness of vim for cursor events
  'antoinemadec/FixCursorHold.nvim',

  -- better buffer grim reaper
  'moll/vim-bbye',

  -- enable repeating supported plugin maps with "."
  'tpope/vim-repeat',

  -- commands for unix shell
  'tpope/vim-eunuch',

  -- no more linear undo
  'mbbill/undotree',

  -- seamless navigation between tmux and vim panes
  {
    'numToStr/Navigator.nvim',
    config = true,
  },

  -- jump around your finds like a kangaroo
  {
    'ggandor/flit.nvim',
    dependencies = 'ggandor/leap.nvim',
    config = true,
  },

  -- basic configs for better experience
  'tpope/vim-sensible',

  -- go light when it's big
  {
    'LunarVim/bigfile.nvim',
    config = true,
  },
}
