-- Use plugin 'impatient' to speed up loading
pcall(require, "impatient")

-- Current version of Neovim for this config
local V = "0.8.0"

-- Version checking
if vim.api.nvim_call_function("has", { "nvim-" .. V }) ~= 1 then
  vim.notify(
    "Neovim version must be at least " .. V .. "!",
    vim.log.levels.ERROR,
    {}
  )
  if not next(vim.api.nvim_list_uis()) then
    vim.cmd "quitall!"
  end
  return
end

-- Packer plugin manager bootstrap for first load
local path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(path)) > 0 then
  _G.PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    "--depth",
    "1",
    path,
  }

  vim.cmd "packadd packer.nvim"
end

-- General Settings
local settings = {
  tabstop = 2,
  softtabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smartindent = true,
  number = true,
  relativenumber = true,
  signcolumn = "yes:1",
  swapfile = false,
  backup = false,
  undodir = vim.fn.stdpath "config" .. "/undodir/",
  undofile = true,
  updatetime = 300,
  incsearch = true,
  hlsearch = false,
  ignorecase = true,
  smartcase = true,
  wrap = false,
  splitbelow = true,
  splitright = true,
  hidden = true,
  scrolloff = 12,
  sidescrolloff = 12,
  showmode = false,
  completeopt = "menu,menuone,noselect",
  pumheight = 10,
  lazyredraw = true,
  mouse = "a",
  formatoptions = vim.opt.formatoptions - "cro",
  iskeyword = vim.opt.iskeyword + "-",
  clipboard = "",
}

for option, value in pairs(settings) do
  vim.opt[option] = value
end

-- Provider Settings
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0

-- Keymaps
require "user.map"

vim.g.mapleader = " "

M.n("<Space>", "<Nop>")
M.n("<C-h>", "<cmd>wincmd h<cr>")
M.n("<C-j>", "<cmd>wincmd j<cr>")
M.n("<C-k>", "<cmd>wincmd k<cr>")
M.n("<C-l>", "<cmd>wincmd l<cr>")
M.n("<S-h>", "<cmd>bp<cr>")
M.n("<S-l>", "<cmd>bn<cr>")
M.n("<C-Up>", "<cmd>resize +2<cr>")
M.n("<C-Down>", "<cmd>resize -2<cr>")
M.n("<C-Left>", "<cmd>vertical resize -2<cr>")
M.n("<C-Right>", "<cmd>vertical resize +2<cr>")
M.n("<leader>y", '"+y')

M.v("<Space>", "<Nop>")
M.v("<", "<gv")
M.v(">", ">gv")
M.v("p", '"_dP')
M.v("<leader>y", '"+y')

M.x("<leader>p", '"_dP')

-- Autocommands
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

_G.UserGroup = augroup("UserGroup", { clear = true })

-- autocmd("TextYankPost", {
--   group = UserGroup,
--   pattern = "*",
--   callback = function()
--     vim.highlight.on_yank {
--       higroup = "IncSearch",
--       timeout = 40,
--     }
--   end,
-- })

-- Load plugins
require "user.plugins"
