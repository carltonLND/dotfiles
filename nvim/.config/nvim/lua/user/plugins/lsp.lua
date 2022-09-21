local lsp_deps = {
  "plenary.nvim",
  "mason.nvim",
  "mason-lspconfig.nvim",
  "nvim-lspconfig",
  "LuaSnip",
  "nvim-cmp",
  "cmp-nvim-lsp",
  "cmp-buffer",
  "cmp-cmdline",
  "cmp_luasnip",
  "lspkind.nvim",
  "formatter.nvim",
}

for _, dep in ipairs(lsp_deps) do
  if not packer_plugins[dep] then
    return
  end
end

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

local on_attach = function(client, bufnr)
  M.n("[d", vim.diagnostic.goto_prev, bufnr)
  M.n("]d", vim.diagnostic.goto_next, bufnr)
  M.n("<leader>e", vim.diagnostic.open_float, bufnr)
  M.n("<leader>q", vim.diagnostic.setloclist, bufnr)

  M.n("<leader>rn", vim.lsp.buf.rename, bufnr)
  M.n("<leader>ca", vim.lsp.buf.code_action, bufnr)
  M.n("gd", vim.lsp.buf.definition, bufnr)
  M.n("gi", vim.lsp.buf.implementation, bufnr)
  M.n("gr", require("telescope.builtin").lsp_references, bufnr)
  M.n("<leader>ds", require("telescope.builtin").lsp_document_symbols, bufnr)
  M.n(
    "<leader>ws",
    require("telescope.builtin").lsp_dynamic_workspace_symbols,
    bufnr
  )
  M.n("K", vim.lsp.buf.hover, bufnr)
  M.n("<C-k>", vim.lsp.buf.signature_help, bufnr)
  M.n("gD", vim.lsp.buf.declaration, bufnr)
  M.n("<leader>D", vim.lsp.buf.type_definition, bufnr)
  M.n("<leader>wa", vim.lsp.buf.add_workspace_folder, bufnr)
  M.n("<leader>wr", vim.lsp.buf.remove_workspace_folder, bufnr)
  M.n("<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufnr)
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(
  vim.lsp.protocol.make_client_capabilities()
)

local default = {
  on_attach = on_attach,
  capabilities = capabilities,
}

local servers = {
  ["sumneko_lua"] = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim", "packer_plugins" },
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
}

local lsp = require "lspconfig"

for server, settings in pairs(servers) do
  lsp[server].setup(vim.tbl_extend("force", default, settings))
end

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
    ghost_text = true,
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
    ["*"] = {
      fmt.any.remove_trailing_whitespace,
    },
  },
}

M.n("<leader>f", "<cmd>FormatLock<cr>")
