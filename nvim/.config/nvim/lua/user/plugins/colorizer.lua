if not packer_plugins["nvim-colorizer.lua"] then
  return
end

require("colorizer").setup()
