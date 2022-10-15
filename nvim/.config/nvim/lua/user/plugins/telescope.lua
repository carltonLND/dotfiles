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
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  require("plenary.job")
    :new({
      command = "file",
      args = { "--mime-type", "-b", filepath },
      on_exit = function(j)
        local mime_type = vim.split(j:result()[1], "/")[1]
        if mime_type == "text" then
          require("telescope.previewers").buffer_previewer_maker(
            filepath,
            bufnr,
            opts
          )
        else
          vim.schedule(function()
            vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
          end)
        end
      end,
    })
    :sync()
end

telescope.setup {
  defaults = {
    winblend = 10,
    path_display = { "tail" },
    buffer_previewer_maker = new_maker,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--trim",
    },
  },
  pickers = {
    ["buffers"] = {
      ["cwd_only"] = true,
      mappings = {
        n = {
          ["<M-d>"] = require("telescope.actions").delete_buffer,
        },
        i = {
          ["<M-d>"] = require("telescope.actions").delete_buffer,
        },
      },
    },
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {},
    },
    file_browser = {
      path = "%:p:h",
      path_display = {},
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
M.n("<leader>sF", function()
  require("telescope.builtin").find_files { hidden = true }
end)
M.n("<leader>sh", require("telescope.builtin").help_tags)
M.n("<leader>sw", require("telescope.builtin").grep_string)
M.n("<leader>sg", require("telescope.builtin").live_grep)
M.n("<leader>sd", require("telescope.builtin").diagnostics)
M.n("<leader>sc", function()
  require("telescope.builtin").find_files {
    cwd = "~/.config/nvim",
  }
end)

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
