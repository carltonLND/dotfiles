if not packer_plugins["nvim-notify"] then
  return
end

vim.notify = require "notify"
