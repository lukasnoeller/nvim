return {
  -- 1. LSP Configuration (The new v0.11+ way)
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Configure gopls using the modern API
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true, -- Use a stricter formatter if you have it installed
          },
        },
      })

      -- Explicitly enable gopls for Go files
      vim.lsp.enable("gopls")

      -- LSP Keybindings
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
        end,
      })
    end,
  },

  -- 2. Formatting (gofmt and goimports)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },

  -- 3. Syntax Highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        table.insert(opts.ensure_installed, "go")
        table.insert(opts.ensure_installed, "gomod")
        table.insert(opts.ensure_installed, "gowork")
      end
    end,
  },
}
