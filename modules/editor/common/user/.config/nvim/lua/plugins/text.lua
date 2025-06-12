return {
  -- manipulate surroundings with ease
  'tpope/vim-surround',

  -- delete means delete, not cut
  'svermeulen/vim-cutlass',

  -- better free writing experience
  'reedes/vim-pencil',

  -- change word casing with ease
  'arthurxavierx/vim-caser',

  -- create your own text objects
  'kana/vim-textobj-user',

  -- text object for foldings
  {
    'kana/vim-textobj-fold',
    dependencies = 'kana/vim-textobj-user',
  },

  -- text object for entire buffer
  {
    'kana/vim-textobj-entire',
    dependencies = 'kana/vim-textobj-user',
  },
}
