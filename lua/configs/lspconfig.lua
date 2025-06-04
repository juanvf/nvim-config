require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "ts_ls", "clangd", "sqlls", "rust_analyzer", "terraformls", "pylsp", "gopls" }
local nvlsp = require "nvchad.configs.lspconfig"

vim.lsp.enable(servers)

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.ts_ls.setup {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { timeout_ms = 2000 }
      end,
    })
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities, -- Use enhanced capabilities
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "tsx", "jsx" },
  settings = {
    typescript = {
      preferences = {
        includePackageJsonAutoImports = "auto",
      }
    }
  }
}

-- astro configuration
lspconfig.astro.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities, -- Use enhanced capabilities
  filetypes = { "astro" },
}

-- Rust personalized config
lspconfig.rust_analyzer.setup {
  on_attach = function(client, bufnr)
    nvlsp.on_attach(client, bufnr)
    -- Set up format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format { timeout_ms = 2000 }
      end,
    })
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    ["rust-analyzer"] = {
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
      checkOnSave = {
        command = "clippy",
      },
      diagnostics = {
        enable = true,
      },
    },
  },
}

require("nvim-treesitter.configs").setup({
  ensure_installed = {
   "astro",
  },
})

