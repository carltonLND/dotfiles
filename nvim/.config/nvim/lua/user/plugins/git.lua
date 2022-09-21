if not packer_plugins["gitsigns.nvim"] then
  return
end

require("gitsigns").setup()
