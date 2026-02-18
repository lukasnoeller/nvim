return {
  -- 1. LSP Configuration
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- The NEW way (v0.11 / v3.0.0 style)
      -- We no longer 'require' lspconfig to index the server
      
      -- Setup Pyright
      vim.lsp.config("pyright", {
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              typeCheckingMode = "basic",
            },
          },
        },
      })

      -- Setup Ruff
      vim.lsp.config("ruff", {})

      -- Start the servers for the current buffer
      vim.lsp.enable("pyright")
      vim.lsp.enable("ruff")

      -- Keybindings (Traditional LspAttach still works fine)
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        end,
      })
    end,
  },

  -- 2. Formatting (Remains the same, works with the new LSP core)
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format", "black" },
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
        table.insert(opts.ensure_installed, "python")
      end
    end,
  },
}
