-- Basic settings
vim.cmd("syntax on")
vim.opt.mouse = ""
vim.opt.exrc = true
vim.opt.secure = true
vim.opt.ttyfast = true
vim.opt.lazyredraw = true
vim.opt.cursorline = true

vim.g.mapleader = " "

vim.opt.backupdir = vim.fn.expand("~/.config/nvim/backup//")
vim.opt.directory = vim.fn.expand("~/.config/nvim/swp//")

-- Encoding
vim.opt.encoding = "utf-8"

-- Vim-Plug (still works in Lua)
--vim.cmd([[
--call plug#begin('~/.config/nvim/plugged')
--Plug 'scrooloose/nerdcommenter'
--Plug 'kien/ctrlp.vim', { 'on': 'CtrlP' }
--Plug 'Yggdroot/indentLine'
--Plug 'vim-scripts/vcscommand.vim'
--Plug 'jeetsukumaran/vim-buffergator'
--Plug 'prettier/vim-prettier', {
--  \ 'do': 'npm install',
--  \ 'for': ['javascript','typescript','css','less','scss','json','graphql','markdown','vue','html'] }

--" Themes
--Plug 'xiyaowong/transparent.nvim'
--Plug 'arcticicestudio/nord-vim'
--Plug 'folke/tokyonight.nvim'
--call plug#end()
--]])

vim.pack.add({
  {
    src = 'https://github.com/nvim-mini/mini.nvim'
  },
  { 
    src ='https://github.com/neovim/nvim-lspconfig'
  },
  { 
    src = 'https://github.com/nvim-treesitter/nvim-treesitter'
  },
  { 
    src = 'https://github.com/folke/tokyonight.nvim.git'
  },
  {
    src = 'https://github.com/nvim-lua/plenary.nvim'
  },
  {
    src = 'https://github.com/nvim-telescope/telescope.nvim'
  }
})
vim.lsp.enable({ 'lua_ls' })
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Theme selection
vim.cmd("colorscheme tokyonight")

-- Tabs & indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python", "go", "cpp" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

-- General editor settings
vim.opt.number = true
vim.opt.showcmd = true
vim.opt.hidden = false
vim.opt.wrap = false
vim.opt.backup = true
vim.opt.autoindent = true
vim.opt.sidescroll = 5
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.wildmenu = true
vim.opt.laststatus = 2

-- Search: * without jumping
vim.keymap.set("n", "*", "*N")

-- Ctrl+c to escape
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Tab autocomplete
function _G.InsertTabWrapper()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%w") == nil then
    return "\t"
  else
    return vim.api.nvim_replace_termcodes("<C-p>", true, true, true)
  end
end
vim.keymap.set("i", "<Tab>", "v:lua.InsertTabWrapper()", { expr = true })
vim.opt.complete = { ".", "k", "b", "t" }

-- Buffergator
vim.keymap.set("n", "<C-b>", ":BuffergatorOpen<CR>")
vim.g.buffergator_show_full_directory_path = 0


