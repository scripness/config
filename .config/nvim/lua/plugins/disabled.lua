-- Disable features not supported in ghostty terminal
return {
  -- Disable snacks.image (requires kitty graphics protocol)
  {
    "folke/snacks.nvim",
    opts = {
      image = { enabled = false },
    },
  },
}
