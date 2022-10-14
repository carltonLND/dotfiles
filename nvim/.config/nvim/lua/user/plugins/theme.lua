if not packer_plugins["zephyr-nvim"] then
  vim.cmd "colorscheme slate"
  return
end

vim.cmd "colorscheme zephyr"
