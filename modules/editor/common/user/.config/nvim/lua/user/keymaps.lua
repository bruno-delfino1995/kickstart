local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Remap space as leader key
keymap('', '<space>', '<nop>', opts)

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Cutlass
keymap('n', 'x', 'd', opts)
keymap('x', 'x', 'd', opts)

keymap('n', 'xx', 'dd', opts)
keymap('n', 'X', 'D', opts)

-- Normal --
keymap('n', '<leader>y', ':let @+ = expand("%")<cr>', opts)

-- Better window navigation
keymap('n', '<C-h>', ':NavigatorLeft<cr>', opts)
keymap('n', '<C-j>', ':NavigatorDown<cr>', opts)
keymap('n', '<C-k>', ':NavigatorUp<cr>', opts)
keymap('n', '<C-l>', ':NavigatorRight<cr>', opts)

-- Consistency
keymap('n', 'U', '<C-r>', opts) -- make `U` behave as redo
keymap('n', 'Y', 'y$', opts)    -- make `Y` more consistent when related to `D` and `C`
keymap('n', 'S', 'hs', opts)    -- make `S` behave like `X`, and keep `s` as `x`

-- Resize with arrows
keymap('n', '<C-Up>', ':resize +2<cr>', opts)
keymap('n', '<C-Down>', ':resize -2<cr>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<cr>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<cr>', opts)

-- Navigate buffers
keymap('n', 'L', ':bnext<cr>', opts)
keymap('n', 'H', ':bprevious<cr>', opts)

-- Visual --
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)

-- Move text up and down
keymap('v', '<A-j>', ':m .+1<cr>==', opts)
keymap('v', '<A-k>', ':m .-2<cr>==', opts)

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":move '>+1<cr>gv-gv", opts)
keymap('x', 'K', ":move '<-2<cr>gv-gv", opts)
keymap('x', '<A-j>', ":move '>+1<cr>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<cr>gv-gv", opts)

-- File browser
keymap('n', '-', ':Carbon!<cr>', opts)
