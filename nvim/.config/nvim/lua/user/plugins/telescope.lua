local telescope_deps = {
  "plenary.nvim",
  "telescope-ui-select.nvim",
  "telescope-fzf-native.nvim",
  "telescope-file-browser.nvim",
  "telescope.nvim",
  "telescope-dap.nvim",
}

for _, dep in ipairs(telescope_deps) do
  if not packer_plugins[dep] then
    return
  end
end

local telescope = require "telescope"

telescope.setup {
  defaults = {
    winblend = 10,
  },
  pickers = {
    ["buffers"] = {
      ["cwd_only"] = true,
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
    file_browser = {
      path = "%:p:h",
      cwd_to_path = true,
      quiet = true,
      theme = "ivy",
      hijack_netrw = true,
      hide_parent_dir = true,
      hidden = true,
    },
  },
}

M.n("<leader>?", require("telescope.builtin").oldfiles)
M.n("<leader><space>", require("telescope.builtin").buffers)
M.n("<leader>/", function()
  require("telescope.builtin").current_buffer_fuzzy_find(
    require("telescope.themes").get_dropdown {
      previewer = false,
    }
  )
end)
M.n("<leader>sf", require("telescope.builtin").find_files)
M.n("<leader>sh", require("telescope.builtin").help_tags)
M.n("<leader>sw", require("telescope.builtin").grep_string)
M.n("<leader>sg", require("telescope.builtin").live_grep)
M.n("<leader>sd", require("telescope.builtin").diagnostics)

local extensions = {
  "ui-select",
  "fzf",
  "file_browser",
  "dap",
}

for _, extension in ipairs(extensions) do
  telescope.load_extension(extension)
end

M.n("<leader>sb", require("telescope").extensions.file_browser.file_browser)
