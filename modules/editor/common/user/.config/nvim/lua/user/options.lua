-- :help options

-- Base Settings {{{

vim.opt.shell = '/bin/zsh'
vim.opt.mouse = 'a'
vim.opt.termguicolors = true
-- do not load $runtime/filetype.vim files
vim.cmd('filetype off')
-- auto load plugin filetypes and indent specs
vim.cmd('filetype plugin indent on')
-- enable syntax highlighting
vim.cmd('syntax on')
-- no beeps
vim.opt.errorbells = false
-- makes backspace key more powerful.
vim.opt.backspace = { 'indent', 'eol', 'start' }
-- use X11 Clipboard
vim.opt.clipboard = 'unnamedplus'
-- automatically reread changed files without asking me anything
vim.opt.autoread = true
-- prefer Unix over Windows over OS 9 formats
vim.opt.fileformats = { 'unix', 'dos', 'mac' }
-- set default encoding to UTF-8
vim.opt.encoding = 'utf-8'
-- improves performance of redrawing by signalizing a fast terminal connection
vim.opt.ttyfast = true
-- show a menu for tab completion
vim.opt.wildmenu = true
-- allow lines on extremities to contain vim config - `vim:foldmethod=marker:foldlevel=0`
vim.opt.modeline = true
-- amount of lines to check on extremities for modelines - 2 at least because of shebang
vim.opt.modelines = 2
-- allow to change buffers without writing changes
vim.opt.hidden = true
-- prevents double spaces after punctuation when joining with `J`
vim.opt.joinspaces = false
-- makes vim break line only on whitespaces
vim.opt.linebreak = true
-- start next line at same level as current
vim.opt.autoindent = true
-- guess the next indenting and start the line correctly
vim.opt.smartindent = true
-- what to persist on :mksession
vim.opt.sessionoptions = { 'blank', 'curdir', 'folds', 'help', 'tabpages', 'winsize' }
-- merge signcolumn and number column into one
vim.opt.signcolumn = 'number'

-- }}}

-- Backups {{{

-- prevents lsp server errors coc.vim#649
-- don't write backup for current buffer
vim.opt.backup = false
-- don't write backups befory overwriting the actual file
vim.opt.writebackup = false

-- lower value for swap write wait threshold
-- vim.opt.updatetime = 300
-- allow undos even after file has been closed and reopened
vim.opt.undofile = true
vim.opt.backupdir = { '/var/tmp', '/tmp' }
vim.opt.backupskip = { '/tmp/*', '/private/tmp/*' }

-- }}}

-- Rendering Settings {{{

-- show line numbers
vim.opt.number = true
-- show line numbers relative to cursor position
vim.opt.relativenumber = true
-- show me what I'm typing
vim.opt.showcmd = true
-- show current mode.
vim.opt.showmode = false
-- do not wrap long lines
vim.opt.wrap = false
-- disables unnecessary redrawings, like on middle of macros
vim.opt.lazyredraw = true
-- controls whether to show the bottom status line
vim.opt.laststatus = 2
-- shows tabline when there's more than one tab
vim.opt.showtabline = 1
-- show invisible characters
vim.opt.list = true
-- invisible characters representation
vim.opt.listchars = { tab = '<->', eol = '¬', trail = '~', extends = '>', precedes = '<', nbsp = '%' }
-- vim.opt.listchars:append({ space = "·" })
---- more space for displaying messages.
vim.opt.cmdheight = 2
-- don't display messages about completions
vim.opt.shortmess:append('c')
-- always show sign column
vim.opt.signcolumn = 'yes'

-- vertical/horizontal scroll off settings
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 7
vim.opt.sidescroll = 1

-- }}}

-- Split Settings {{{

-- split vertical windows right to the current windows
vim.opt.splitright = true
-- split horizontal windows below to the current windows
vim.opt.splitbelow = true

-- }}}

-- Tab & Folding Settings {{{

-- tabs are spaces
vim.opt.expandtab = true
-- number of spaces by indent
vim.opt.shiftwidth = 2
-- number of visual spaces per TAB
vim.opt.tabstop = 2
-- number of spaces in tab when editing
vim.opt.softtabstop = 2
-- enable folding
vim.opt.foldenable = true
-- omit the foldcolumn
vim.opt.foldcolumn = '0'
-- using ufo provider need a large value
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]

-- }}}

-- Searching Settings {{{

-- do not show matching brackets by flickering
vim.opt.showmatch = false
-- shows the match while typing
vim.opt.incsearch = true
-- highlight found searches
vim.opt.hlsearch = true
-- search case insensitive...
vim.opt.ignorecase = true
-- ... but not when search pattern contains upper case characters
vim.opt.smartcase = true

-- }}}

-- Completion Settings {{{

vim.opt.completeopt = { 'menuone', 'noinsert', 'preview' }

-- }}}
