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
-- Buffers created during the session may hold an absolute name, so always resolve it against the cwd
local function relative_path()
  return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ':.')
end

keymap('n', '<leader>y', '', vim.tbl_extend('force', opts, {
  callback = function() vim.fn.setreg('+', relative_path()) end,
}))

-- Copy `<path>:<lines>` of the selection. Columns are only included when the selection
-- doesn't cover whole lines, e.g. `file:10-20`, `file:10:4-10:9`, `file:10:4-12:7`
local function copy_selection_ref()
  local a, b = vim.fn.getpos('v'), vim.fn.getpos('.')
  if a[2] > b[2] or (a[2] == b[2] and a[3] > b[3]) then a, b = b, a end

  local function line_len(l) return vim.fn.strchars(vim.fn.getline(l)) end
  local sl, el = a[2], b[2]
  local sc = vim.fn.charidx(vim.fn.getline(sl), a[3] - 1) + 1
  local ec = math.min(vim.fn.charidx(vim.fn.getline(el), b[3] - 1) + 1, line_len(el))
  if vim.fn.mode() == 'V' then sc, ec = 1, line_len(el) end

  local first_col = vim.fn.match(vim.fn.getline(sl), '\\S') + 1
  local whole = sc <= math.max(first_col, 1) and ec >= line_len(el)

  local ref = relative_path()
  if whole then
    ref = ref .. ':' .. sl .. (el ~= sl and '-' .. el or '')
  else
    ref = ref .. ':' .. sl .. ':' .. sc .. '-' .. el .. ':' .. ec
  end

  vim.fn.setreg('+', ref)
  vim.api.nvim_feedkeys(vim.keycode('<esc>'), 'nx', false)
  vim.notify(ref)
end

keymap('x', '<leader>y', '', vim.tbl_extend('force', opts, { callback = copy_selection_ref }))

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
