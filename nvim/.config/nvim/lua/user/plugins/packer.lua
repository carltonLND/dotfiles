local installed, packer = pcall(require, "packer")
if not installed then
  return
end

vim.cmd [[
  augroup user_packer
    autocmd!
    autocmd User PackerComplete lua if packer_plugins["nvim-treesitter"] then pcall(vim.api.nvim_command, "TSUpdate") end
    autocmd User PackerComplete lua vim.notify("Please restart neovim for plugin changes to take place!", vim.log.levels.WARN, {})
    autocmd BufWritePost packer.lua source <afile> | PackerCompile
  augroup end
]]

return packer.startup {
  function(use)
    -- Packer
    use "wbthomason/packer.nvim"

    -- Plugins
    use "lewis6991/impatient.nvim"
    use "lewis6991/gitsigns.nvim"
    use "nvim-treesitter/nvim-treesitter"
    use "nvim-treesitter/nvim-treesitter-textobjects"
    use "williamboman/mason.nvim"
    use "williamboman/mason-lspconfig.nvim"
    use "neovim/nvim-lspconfig"
    use { "glepnir/lspsaga.nvim", branch = "main" }
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "L3MON4D3/LuaSnip"
    use "onsails/lspkind.nvim"
    use "nvim-telescope/telescope.nvim"
    use "nvim-lua/plenary.nvim"
    use "nvim-telescope/telescope-ui-select.nvim"
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
    use "nvim-telescope/telescope-file-browser.nvim"
    use "windwp/nvim-autopairs"
    use "windwp/nvim-ts-autotag"
    use "numToStr/Comment.nvim"
    use "airblade/vim-rooter"
    use "nvim-lualine/lualine.nvim"
    use "kyazdani42/nvim-web-devicons"
    use "voldikss/vim-floaterm"
    use "rcarriga/nvim-notify"
    use "glepnir/dashboard-nvim"
    use "mhartington/formatter.nvim"
    use "mfussenegger/nvim-dap"
    use "nvim-telescope/telescope-dap.nvim"
    use "NvChad/nvim-colorizer.lua"
    use {
      "glepnir/galaxyline.nvim",
      branch = "main",
      requires = { "kyazdani42/nvim-web-devicons", opt = true },
    }

    -- Themes
    use "glepnir/zephyr-nvim"

    if _G.PACKER_BOOTSTRAP then
      packer.sync()
    end
  end,
  config = {
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
    autoremove = true,
    compile_path = vim.fn.stdpath "config" .. "/lua/user/plugins/compiled.lua",
  },
}
