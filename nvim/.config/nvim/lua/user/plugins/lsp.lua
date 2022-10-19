local lsp_deps = {
  "plenary.nvim",
  "mason.nvim",
  "mason-lspconfig.nvim",
  "nvim-lspconfig",
  "lspsaga.nvim",
  "LuaSnip",
  "nvim-cmp",
  "cmp-nvim-lsp",
  "cmp-buffer",
  "cmp-cmdline",
  "cmp_luasnip",
  "lspkind.nvim",
  "formatter.nvim",
  "nvim-lint",
}

for _, dep in ipairs(lsp_deps) do
  if not packer_plugins[dep] then
    return
  end
end

-- Lsp Setup
vim.diagnostic.config {
  underline = false,
  virtual_text = false,
  update_in_insert = false,
  signs = {
    severity = { min = vim.diagnostic.severity.WARN },
  },
  float = {
    focusable = false,
    style = "minimal",
    border = "rounded",
    header = "",
    prefix = "",
  },
}

require("mason").setup()
require("mason-lspconfig").setup {
  automatic_installation = true,
}
require("lspsaga").init_lsp_saga {
  code_action_lightbulb = {
    enable = false,
  },
  symbol_in_winbar = {
    in_custom = true,
  },
}

M.n("[d", function()
  require("lspsaga.diagnostic").goto_prev {
    severity = vim.diagnostic.severity.ERROR,
  }
end)
M.n("]d", function()
  require("lspsaga.diagnostic").goto_next {
    severity = vim.diagnostic.severity.ERROR,
  }
end)
M.n("[D", function()
  require("lspsaga.diagnostic").goto_prev()
end)
M.n("]D", function()
  require("lspsaga.diagnostic").goto_next()
end)

local default = {
  capabilities = require("cmp_nvim_lsp").default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  ),

  on_attach = function(_, bufnr)
    M.n("<leader>ca", "<cmd>Lspsaga code_action<CR>", bufnr)
    M.n("<leader>e", "<cmd>Lspsaga show_line_diagnostics<CR>", bufnr)
    M.n("<leader>e", "<cmd>Lspsaga show_cursor_diagnostics<CR>", bufnr)
    M.n("gr", "<cmd>Lspsaga rename<CR>", bufnr)
    M.n("gd", "<cmd>Lspsaga peek_definition<CR>", bufnr)
    M.n("K", "<cmd>Lspsaga hover_doc<CR>", bufnr)
    M.n("gh", "<cmd>Lspsaga lsp_finder<CR>", bufnr)
  end,
}

local servers = {
  ["sumneko_lua"] = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "packer_plugins" },
        },
        workspace = {
          ignoreDir = { "undodir" },
        },
      },
    },
  },
  ["rust_analyzer"] = {
    assist = {
      importGranularity = "module",
      importPrefix = "self",
    },
    cargo = {
      loadOutDirsFromCheck = true,
    },
    procMacro = {
      enable = true,
    },
  },
  ["pyright"] = {},
  ["tsserver"] = {},
  -- ["grammarly"] = {},
}

local lsp = require "lspconfig"

for server, settings in pairs(servers) do
  lsp[server].setup(vim.tbl_extend("force", default, settings))
end

-- Code completion
vim.api.nvim_set_hl(0, "PmenuThumb", { link = "Search" })

local cmp = require "cmp"
local snip = require "luasnip"
local kind = require "lspkind"
local completion_window = cmp.config.window.bordered()

cmp.setup {
  formatting = {
    format = kind.cmp_format {
      mode = "symbol",
      maxwidth = 50,
      before = function(_, vim_item)
        return vim_item
      end,
    },
  },
  snippet = {
    expand = function(args)
      snip.lsp_expand(args.body)
    end,
  },
  window = {
    completion = completion_window,
    documentation = completion_window,
  },
  mapping = cmp.mapping.preset.insert {
    ["<TAB>"] = cmp.mapping.confirm { select = true },
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
  experimental = {
    ghost_text = false,
  },
}

cmp.setup.cmdline("/", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "cmdline" },
  },
})

-- Formatting
M.n("<leader>f", "<cmd>Format<cr>")
M.n("<leader>F", "<cmd>FormatWrite<cr>")

local fmt = require "formatter.filetypes"
require("formatter").setup {
  filetype = {
    lua = {
      fmt.lua.stylua,
    },
    python = {
      fmt.python.isort,
      fmt.python.black,
    },
    rust = {
      fmt.rust.rustfmt,
    },
    javascript = {
      fmt.javascript.prettierd,
    },
    html = {
      fmt.html.prettierd,
    },
    css = {
      fmt.css.prettierd,
    },
    json = {
      fmt.json.prettierd,
    },
    toml = {
      fmt.toml.taplo,
    },
    sh = {
      fmt.sh.shfmt,
    },
    fish = {
      fmt.fish.fishindent,
    },
    -- TODO: Throws error on Mac OS X
    -- ["*"] = {
    --   fmt.any.remove_trailing_whitespace,
    -- },
  },
}

-- Linting

-- vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--   group = UserGroup,
--   pattern = { "*.py" },
--   callback = function()
--     require("lint").try_lint()
--   end,
-- })
--
-- require("lint").linters_by_ft = {
--   python = { "flake8" },
-- }
