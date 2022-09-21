if not packer_plugins["nightfox.nvim"] then
  vim.cmd "colorscheme slate"
  return
end

vim.cmd "colorscheme nightfox"
