return {
  {
    "sourcegraph/amp.nvim",
    event = "VeryLazy",
    config = function()
      require("amp").setup()

      -- Send quick message to Amp
      vim.api.nvim_create_user_command("AmpSend", function(opts)
        require("amp").send_message(opts.args)
      end, { nargs = 1, desc = "Send message to Amp" })

      -- Send buffer contents to Amp (for longer messages)
      vim.api.nvim_create_user_command("AmpSendBuffer", function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        require("amp").send_message(table.concat(lines, "\n"))
      end, { desc = "Send buffer contents to Amp" })
    end,
  },
}
