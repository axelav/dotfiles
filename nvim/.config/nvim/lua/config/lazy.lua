local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Colorscheme
    {
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000,
      opts = {
        dim_inactive = {
          enabled = true,
          percentage = 0.15,
        },
        transparent_background = true,
      },
    },
    {
      "LazyVim/LazyVim",
      opts = {
        colorscheme = "catppuccin-frappe",
      },
    },

    -- Plugins
    {
      "hrsh7th/nvim-cmp",
      -- NOTE: this seems useful but ended up being annoying as it overrode other completions
      -- dependencies = {
      --   "f3fora/cmp-spell",
      -- },
      opts = function(_, opts)
        local cmp = require("cmp")
        local compare = require("cmp.config.compare")

        -- Merge with existing opts
        opts.name = "nvim_lsp"
        opts.option = {
          markdown_oxide = {
            keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
          },
        }

        opts.sorting = {
          priority_weight = 2,
          comparators = {
            -- Deprioritize Copilot
            function(entry1, entry2)
              local copilot1 = entry1.source.name == "copilot"
              local copilot2 = entry2.source.name == "copilot"
              if copilot1 and not copilot2 then
                return false
              elseif not copilot1 and copilot2 then
                return true
              end
            end,
            -- Prioritize in order: event, file, keyword, reference
            function(entry1, entry2)
              local kind1 = entry1:get_kind()
              local kind2 = entry2:get_kind()
              local kinds = cmp.lsp.CompletionItemKind

              -- Define priority order (lower number = higher priority)
              local priority_map = {
                [kinds.Event] = 1, -- 23
                [kinds.File] = 2, -- 17
                [kinds.Keyword] = 3, -- 14
                [kinds.Reference] = 4, -- 18
              }

              local priority1 = priority_map[kind1] or 99
              local priority2 = priority_map[kind2] or 99

              if priority1 ~= priority2 then
                return priority1 < priority2
              end
            end,
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
          },
        }

        -- Add spell completion source (disabled - was polluting suggestions)
        -- table.insert(opts.sources, { name = "spell", keyword_length = 3 })

        return opts
      end,
    },

    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        ensure_installed = {
          "bash",
          "css",
          "html",
          "javascript",
          "json",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "rust",
          "toml",
          "tsx",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
        },
      },
    },

    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          marksman = false,
        },
      },
      init = function()
        -- An example nvim-lspconfig capabilities setting
        local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
        local lspconfig = require("lspconfig")
        local on_attach = lspconfig.util.on_attach

        lspconfig.markdown_oxide.setup({
          -- Ensure that dynamicRegistration is enabled! This allows the LS to take into account actions like the
          -- Create Unresolved File code action, resolving completions for unindexed code blocks, ...
          capabilities = vim.tbl_deep_extend("force", capabilities, {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          }),
          on_attach = on_attach, -- configure your on attach config
        })
      end,
    },

    {
      {
        "mason-org/mason.nvim",
        opts = {
          ensure_installed = {
            "eslint-lsp",
            "json-lsp",
            "lua-language-server",
            "markdown-oxide",
            "markdown-toc",
            "markdownlint-cli2",
            "prettier",
            "shfmt",
            "stylua",
            "vtsls",
          },
        },
      },
    },

    {
      "folke/noice.nvim",
      event = "VeryLazy",
      opts = {
        presets = {
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        routes = {
          {
            filter = {
              event = "notify",
              find = "Conversion failed at step `identify`",
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = "notify",
              find = "copilot.*workspace/executeCommand.*Unknown command",
            },
            opts = { skip = true },
          },
          {
            filter = {
              event = "notify",
              find = "copilot.*-32603.*Request workspace/executeCommand failed",
            },
            opts = { skip = true },
          },
        },

        views = {
          cmdline_popup = {
            border = {
              style = "none",
              padding = { 2, 3 },
            },
            filter_options = {},
            win_options = {
              winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
            },
          },
        },
      },
    },

    {
      "folke/flash.nvim",
      event = "VeryLazy",
      ---@type Flash.Config
      opts = {
        modes = {
          search = {
            enabled = true,
            highlight = { backdrop = true },
          },
        },
      },
      keys = {
        -- Use 'f' for flash
        s = false,
        f = true,
        {
          "S",
          mode = { "n", "x", "o" },
          function()
            require("flash").treesitter()
          end,
          desc = "Flash Treesitter",
        },
      },
    },

    {
      "folke/snacks.nvim",
      opts = {
        terminal = {
          win = {
            height = 0.5, -- 50% of editor height for terminals
          },
        },
        lazygit = {
          win = {
            height = 0.9, -- Restore lazygit to 90% height
            width = 0.9,
          },
        },
        zen = {
          win = {
            width = 150,
          },
          toggles = {
            dim = false,
            git_signs = true,
            wrap = true,
            -- mini_diff_signs = false,
            -- diagnostics = false,
            inlay_hints = true,
          },
          show = {
            statusline = false,
          },
        },
      },
    },

    {
      "ibhagwan/fzf-lua",
      opts = {
        defaults = {
          formatter = "path.filename_first",
          actions = {
            ["ctrl-y"] = function(selected)
              local content = selected[1]:match(":%d+:%d+:(.+)$") or selected[1]
              vim.fn.setreg("+", content)
              vim.notify("Yanked: " .. content)
            end,
          },
        },
        lsp = {
          async_or_timeout = 30000, -- 30 seconds timeout for LSP requests (default is 10000)
        },
      },
    },

    {
      "stevearc/oil.nvim",
      opts = {
        view_options = {
          show_hidden = true,
        },
      },
      config = function(_, opts)
        require("oil").setup(opts)

        local augroup = vim.api.nvim_create_augroup("OilOpenPreview", { clear = true })

        vim.api.nvim_create_autocmd("User", {
          pattern = "OilEnter",
          group = augroup,
          callback = function()
            vim.schedule(function()
              require("oil").open_preview()
            end)
          end,
        })
      end,
      dependencies = { { "nvim-mini/mini.icons", opts = {} } },
      lazy = false,
    },

    {
      "lewis6991/gitsigns.nvim",
      opts = {
        current_line_blame = true,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 500,
        },
      },
    },

    {
      "zbirenbaum/copilot.lua",
      enabled = true,
      cmd = "Copilot",
      build = ":Copilot auth",
      opts = {
        filetypes = {
          gitcommit = true,
          gitrebase = true,
          help = true,
          markdown = false, -- Disabled for markdown to not interfere with markdown-oxide
          yaml = true,
        },
      },
    },

    {
      "yorickpeterse/nvim-window",
      keys = {
        { "<leader>wj", "<cmd>lua require('nvim-window').pick()<cr>", desc = "Jump to window" },
      },
      config = true,
    },

    {
      "greggh/claude-code.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim", -- Required for git operations
      },
      config = function()
        require("claude-code").setup()
      end,
    },

    {
      "nvim-mini/mini.surround",
      opts = {
        custom_surroundings = {
          -- Strikethrough markdown
          s = {
            input = { "~~().-()~~" },
            output = { left = "~~", right = "~~" },
          },
          -- Bold markdown
          b = {
            input = { "%*%*().-()%*%*" },
            output = { left = "**", right = "**" },
          },
          -- Italic markdown
          i = {
            input = { "%_().-()%_" },
            output = { left = "_", right = "_" },
          },
          -- Inline code
          c = {
            input = { "`().-()'" },
            output = { left = "`", right = "`" },
          },

          -- Markdown link
          l = {
            input = { "%[().-()%]%(.-%)%" },
            output = {
              left = "[",
              right = "]()",
            },
          },
        },
      },
    },

    -- import/override with your plugins
    { import = "plugins" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  ui = {
    border = "rounded",
  },
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
