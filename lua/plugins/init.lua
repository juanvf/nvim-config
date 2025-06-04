return {
  {
    "stevearc/conform.nvim",
    opts = require "configs.conform",
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
   dependencies = {
      "williamboman/mason-lspconfig.nvim"
    },
    opts = {
      ensure_installed = {
        "ts_ls",
        "clangd",
        "sqlls",
        "terraformls",
        "astro",
        "html",
        "cssls",
        "tailwindcss"
      }
    },
    config = function (_, opts)
      require("mason").setup(opts)
      require("mason-lspconfig").setup({
        ensure_installed = opts.ensure_installed,
        automatic_installation = true
      })
    end
  },
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true,
        ts_config = {
          javascript = {'template_string'},
          javascriptreact = {'template_string'},
          typescriptreact = {'template_string'},
        }
      })
      -- Make it work with JSX/TSX
      require("nvim-autopairs").add_rules(require("nvim-autopairs.rules.endwise-lua"))
    end,
  }
}
