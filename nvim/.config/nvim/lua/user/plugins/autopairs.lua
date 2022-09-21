local autopairs_deps = {
  "nvim-treesitter",
  "nvim-autopairs",
  "nvim-ts-autotag",
}

for _, dep in ipairs(autopairs_deps) do
  if not packer_plugins[dep] then
    return
  end
end

require("nvim-autopairs").setup {}
require("nvim-ts-autotag").setup()

if packer_plugins["nvim-cmp"] then
  require("cmp").event:on(
    "confirm_done",
    require("nvim-autopairs.completion.cmp").on_confirm_done()
  )
end
