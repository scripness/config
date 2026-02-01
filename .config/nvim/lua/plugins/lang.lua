return {
  -- TypeScript/JavaScript support (LazyVim extra)
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- JSON support
  { import = "lazyvim.plugins.extras.lang.json" },

  -- Tailwind CSS support
  { import = "lazyvim.plugins.extras.lang.tailwind" },

  -- Markdown support
  { import = "lazyvim.plugins.extras.lang.markdown" },

  -- YAML support
  { import = "lazyvim.plugins.extras.lang.yaml" },

  -- Use Biome for formatting/linting (you use biome.json)
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
