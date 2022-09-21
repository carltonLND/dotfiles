pcall(require, "user.plugins.compiled")
pcall(require, "user.plugins.packer")

local plugins = {
  "notify",
  "theme",
  "treesitter",
  "telescope",
  "lualine",
  "autopairs",
  "rooter",
  "dashboard",
  "term",
  "comment",
  "lsp",
  "git",
}

if not packer_plugins then
  return
end

for _, plugin in ipairs(plugins) do
  require("user.plugins." .. plugin)
end
