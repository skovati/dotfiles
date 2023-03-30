return {

    {
        "echasnovski/mini.nvim",
        event = "InsertEnter",
        config = function()
            require("mini.pairs").setup({})
            require("mini.comment").setup({})
            require("mini.surround").setup({})
        end
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost",
        config = function()
            vim.g.indent_blankline_char = "¦"
            vim.g.indent_blankline_show_trailing_blankline_indent = false
            vim.g.indent_blankline_use_treesitter = true
        end
    },

    {
        "sainnhe/gruvbox-material",
        priority = 999,
        event = "UIEnter",
        config = function()
            vim.g.gruvbox_material_better_performance = 1
            vim.g.gruvbox_material_foreground = "original"
            vim.g.gruvbox_material_colors_override = {
                bg0 = { "none", "none" }
            }
            vim.cmd([[ colorscheme gruvbox-material ]])
        end
    },

    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            require("lualine").setup({
                options = {
                    icons_enabled = false,
                    theme = "gruvbox-material",
                    component_separators = "|",
                    section_separators = "",
                    globalstatus = true,
                },
            })
        end
    },

    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("gitsigns").setup({ signcolumn = false, numhl = true, })
        end
    },

    {
        "akinsho/toggleterm.nvim",
        keys = "<C-\\>",
        config = function()
            require("toggleterm").setup({ open_mapping = [[<c-\>]] })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = "hrsh7th/cmp-nvim-lsp",
        config = function()
            local lspconfig = require("lspconfig")
            local on_attach = function(_, bufnr)
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
                vim.keymap.set( "n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
                vim.keymap.set( "n", "<leader>e", vim.diagnostic.open_float, { buffer = bufnr })
                vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
                vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr })
                vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", { buffer = bufnr })
                vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<cr>", { buffer = bufnr })
                vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { buffer = bufnr })
                vim.keymap.set( "n", "<leader>D", "Telescope lsp_type_definitions<cr>", { buffer = bufnr })
                vim.keymap.set("n", "<leader>fd", "Telescope lsp_document_symbols<cr>", { buffer = bufnr })
                vim.keymap.set("n", "<leader>fD", "Telescope lsp_dynamic_workspace_symbols<cr>", { buffer = bufnr })
                vim.api.nvim_create_user_command("Format", vim.lsp.buf.format, {})

                -- configure how lsp diagnostics are shown
                vim.diagnostic.config({
                    virtual_text = true, signs = false,
                    underline = true, update_in_insert = false,
                })
            end

            -- setup specific LSPs
            local servers = {
                "pyright", "rust_analyzer", "gopls", "clangd",
                "tsserver", "jdtls", "bashls", "lua_ls",
                "texlab", "elixirls", "hls",
            }

            local runtime_path = vim.split(package.path, ";")
            table.insert(runtime_path, "lua/?.lua")
            table.insert(runtime_path, "lua/?/init.lua")
            local settings = {
                Lua = {
                    runtime = { version = "LuaJIT", path = runtime_path, },
                    diagnostics = { globals = { "vim" }, },
                    workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                    telemetry = { enable = false, },
                },
                ["rust-analyzer"] = {
                    checkOnSave = { command = "clippy" },
                },
            }

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            for _, lsp in ipairs(servers) do
                local opts =  {
                    capabilities = capabilities,
                    on_attach = on_attach,
                    settings = settings,
                }
                lspconfig[lsp].setup(opts)
            end
        end
    },

    {
        "lervag/vimtex",
        ft = "tex",
        config = function()
            vim.g.vimtex_quickfix_mode = 0
            vim.g.tex_flavor = "latex"
            vim.g.vimtex_view_method = "zathura"
        end
    },

    {
        "nvim-telescope/telescope.nvim",
        cmd = { "Telescope" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
        },
        keys = {
            { "<leader>ff", "<cmd> Telescope find_files<cr>" },
            { "<leader>fi", "<cmd> Telescope current_buffer_fuzzy_find<cr>" },
            { "<leader>fg", "<cmd> Telescope git_files<cr>" },
            { "<leader><space>", "<cmd> Telescope buffers<cr>" },
            { "<leader>fa", "<cmd> Telescope live_grep<cr>" },
        },
        config = function()
            local telescope = require("telescope")
            telescope.setup({
                defaults = {
                    prompt_title = false,
                    results_title = false,
                    preview_title = false,
                    layout_strategy = "horizontal",
                    layout_config = { width = 0.80, },
                    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└", },
                    mappings = {
                        i = {
                            ["<esc>"] = require("telescope.actions").close,
                            ['<C-p>'] = require('telescope.actions.layout').toggle_preview,
                        },
                    },
                },
            })
            telescope.load_extension("fzf")
        end
    },

    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = "BufReadPost",
        dependencies = "nvim-treesitter/nvim-treesitter-textobjects",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = "all",
                ignore_install = { "phpdoc" },
                sync_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                        },
                    },
                },
            })
        end
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            local ls = require("luasnip")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<c-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<c-d>"] = cmp.mapping.scroll_docs(4),
                    ["<c-y>"] = cmp.mapping.complete({}),
                    ["<c-space>"] = cmp.mapping.confirm({
                        behavior = cmp.ConfirmBehavior.Insert,
                        select = true,
                    }),
                }),
                sources = {
                    { name = "nvim_lsp" },  { name = "luasnip" },
                    { name = "buffer" }, { name = "zk" },
                    { max_item_count = 10 }, { keyword_length = 2 },
                },
                snippet = {
                    expand = function(args)
                        ls.lsp_expand(args.body)
                    end,
                },
            })
        end
    },

    {
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
            local ls = require("luasnip")
            ls.setup({
                options = {
                    icons_enabled = false,
                    theme = "gruvbox-material",
                    component_separators = "|",
                    section_separators = "",
                    globalstatus = true,
                },
            })
            ls.add_snippets(nil, {
                tex = {
                    ls.parser.parse_snippet(
                    "be",
                    "\\begin{equation}\n\t$0\n\\end{equation}"
                    ),
                    ls.parser.parse_snippet("bm", "\\($0\\)"),
                },
            })
        end
    },

    {
        "TimUntersberger/neogit",
        dependencies = "nvim-lua/plenary.nvim",
        cmd = { "Neogit" },
        keys = {
            { "<leader>ng", "<cmd>Neogit<cr>" },
        }
    },

    {
        "skovati/telekasten.nvim",
        dependencies = "nvim-telescope/telescope.nvim",
        cmd = "Telekasten",
        branch = "refactor_defaults",
        keys = {
            { "<leader>zj", "<cmd>Telekasten goto_today<cr>"    },
            { "<leader>zf", "<cmd>Telekasten find_notes<cr>"    },
            { "<leader>zg", "<cmd>Telekasten search_notes<cr>"  },
            { "<leader>zn", "<cmd>Telekasten new_note<cr>"      },
            { "<leader>zt", "<cmd>Telekasten show_tags<cr>"     },
            { "<leader>z",  "<cmd>Telekasten panel<cr>"         },
        },
        config = function()
            local home = vim.fn.expand("$HOME/dev/git/vault")
            require("telekasten").setup({
                home = home .. "/zk",
                dailies = home .. "/journal",
                weeklies = home .. "/journal/weekly",
                template_new_note = home .. "/templates/zk.md",
                template_new_daily = home .. "/templates/journal.md",
                template_new_weekly = home .. "/templates/weekly.md",
                new_note_filename = "uuid-title",
                journal_auto_open = true,
                uuid_sep = "_",
                filename_space_subst = "_",
                tag_notation = "yaml-bare",
                insert_after_inserting = false,
                plug_into_calendar = false,
            })
        end,
    },

    {
        "github/copilot.vim",
        cmd = "Copilot"
    },

    {
        "folke/zen-mode.nvim",
        config = function()
            require("zen-mode").setup({
                window = {
                    width = 0.8,
                    height = 0.9,
                },
                plugins = {
                    gitsigns = {
                        enabled = true
                    }
                }
            })
        end,
        cmd = "ZenMode"
    }


}
