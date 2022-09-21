if not packer_plugins["Comment.nvim"] then
  return
end

require("Comment").setup()
