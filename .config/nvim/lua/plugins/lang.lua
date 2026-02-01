return {
  -- Use Biome for formatting/linting
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        typescript = { "biome" },
        typescriptreact = { "biome" },
        javascript = { "biome" },
        javascriptreact = { "biome" },
        json = { "biome" },
        jsonc = { "biome" },
      },
    },
  },

  -- Ensure biome is installed
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "biome",
        "typescript-language-server",
        "tailwindcss-language-server",
        "html-lsp",
        "css-lsp",
      },
    },
  },
}
