--Inactive
-- if true then return {} end

-- return {
--   "olimorris/codecompanion.nvim",
--   dependencies = {
--     "nvim-lua/plenary.nvim",
--     "nvim-telescope/telescope.nvim", -- optional
--     "MunifTanjim/nui.nvim",          -- required
--   },
--   cmd = "CodeCompanionChat",
--   config = function()
--     require("codecompanion").setup({
--       adapters = {
--         openai = {
--           enabled = true,
--           api_key = os.getenv("GROQ_API_KEY"),
--           model = "llama3-70b-8192",
--           base_url = "https://api.groq.com/openai/v1",
--         },
--       },
--       default_adapter = "openai",
--     })
--   end,
-- }
--

return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    -- -- Test with blink.cmp (delete if not required)
    -- {
    --   "saghen/blink.cmp",
    --   lazy = false,
    --   version = "*",
    --   opts = {
    --     keymap = {
    --       preset = "enter",
    --       ["<S-Tab>"] = { "select_prev", "fallback" },
    --       ["<Tab>"] = { "select_next", "fallback" },
    --     },
    --     cmdline = { sources = { "cmdline" } },
    --     sources = {
    --       default = { "lsp", "path", "buffer", "codecompanion" },
    --     },
    --   },
    -- },
  },
  opts = {
    --Refer to: https://github.com/olimorris/codecompanion.nvim/blob/main/lua/codecompanion/config.lua
    strategies = {
      --NOTE: Change the adapter as required
      chat = { adapter = "copilot" },
      -- inline = { adapter = "copilot" },
    },
    opts = {
      log_level = "DEBUG",
    },
  },
}
