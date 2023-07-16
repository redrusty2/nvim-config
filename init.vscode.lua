require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use 'tpope/vim-commentary'
  use 'morhetz/gruvbox'
  use 'xiyaowong/nvim-transparent'

  -- LSP
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  }
end)

require("transparent").setup({
  enable = true, -- boolean: enable transparent
})

local lsp = require('lsp-zero').preset({
  name = 'minimal',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

require 'lspconfig'.jedi.setup {
}

-- (Optional) Configure lua language server for neovim
-- lsp.nvim_workspace()

lsp.setup()

-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.opt.signcolumn = 'yes'
vim.g.mapleader = " "
vim.o.background = "dark"
vim.g.gruvbox_contrast_dark = 'medium'
vim.g.gruvbox_transparent_bg = 1
local ok, _ = pcall(vim.cmd, "colorscheme gruvbox")
if not ok then
  vim.notify("colorscheme gruvbox not found!")
  return
end

if vim.g.vscode then
  -- VSCode extension
  map("n", "<Leader>c", ":call VSCodeNotify('editor.action.commentLine')<CR>", { silent = true })
  map("v", "<Leader>c", ":call VSCodeNotifyVisual('editor.action.commentLine')<CR>", { silent = true })
  map("n", "<Leader>pp", ":call VSCodeNotify('workbench.action.quickOpen')<CR>", { silent = true })
  map("n", "<Leader>ss", ":call VSCodeNotify('workbench.action.files.save')<CR>", { silent = true })
else
  -- ordinary Neovim
  map("n", "<Leader>ss", ":w<CR>", { silent = true })
end

--vim.o.guicursor = "n-v-c-sm-i-ci-ve:block,r-cr-o:hor20,a:blinkwait700-blinkoff100-blinkon150-Cursor/lCursor";
map("n", "<C-d>", "<C-d>zz", { silent = true })
map("n", "<C-u>", "<C-u>zz", { silent = true })
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10

-- use global status line
vim.opt.laststatus = 3

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4

-- use number of spaces to insert a <Tab>
vim.opt.expandtab = true

vim.opt.swapfile = false

vim.opt.splitright = true
vim.opt.splitbelow = true

-- highlight the line number of the cursor
vim.opt.cursorline = true
--vim.opt.cursorlineopt = "number"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- disable cursor-styling
vim.opt.guicursor = ""

vim.opt.mouse = ""

vim.opt.termguicolors = true
