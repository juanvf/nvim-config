require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "ts_ls", "clangd", "sqlls", "rust_analyzer", "terraformls" }
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
  on_attach = nvlsp.on_attach,
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

require("nvim-treesitter.configs").setup({
  ensure_installed = {
   "astro",
  },
})

