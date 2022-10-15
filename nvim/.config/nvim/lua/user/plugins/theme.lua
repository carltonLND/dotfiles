if not packer_plugins["zephyr-nvim"] then
  vim.cmd "colorscheme slate"
  return
end

vim.cmd "colorscheme zephyr"

vim.api.nvim_create_autocmd("TermOpen", {
  group = UserGroup,
  callback = function()
    vim.g.terminal_color_7 = "white"
  end,
})
