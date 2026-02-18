return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp", -- Tells cmp how to get data from gopls
    "hrsh7th/cmp-buffer",   -- Suggestions from the current file
    "hrsh7th/cmp-path",     -- Suggestions for file paths
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(), -- Trigger manually
        ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept with Enter
        ["<Tab>"] = cmp.mapping.select_next_item(),        -- Cycle with Tab
      }),
      sources = cmp.config.sources({
        { name = "nvim_lsp" }, -- This pulls the Go info from gopls!
      }, {
        { name = "buffer" },
      }),
    })
  end,
}
