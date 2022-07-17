----------------------------------------
-- bootstrap packer
----------------------------------------
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local bootstrap = vim.fn.empty(vim.fn.glob(install_path)) > 0
if bootstrap then
    vim.opt.guicursor = ""      -- don"t change cursor on first boot
    vim.fn.system({
        "git", "clone",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    vim.cmd[[packadd packer.nvim]]
end

----------------------------------------
-- plugin declaration
----------------------------------------
require("packer").startup(function(use)
        use("wbthomason/packer.nvim")
        use("kylechui/nvim-surround")
        use({
            "nvim-telescope/telescope.nvim",
            requires = {
                "nvim-lua/plenary.nvim", {
                    "nvim-telescope/telescope-fzf-native.nvim",
                    run = "make", cond = vim.fn.executable "make" == 1
                }
            },
        })
        use("numToStr/Comment.nvim")
        use("neovim/nvim-lspconfig")
        use({
            "nvim-treesitter/nvim-treesitter",
            requires = "nvim-treesitter/nvim-treesitter-textobjects"
        })
        use({
            "hrsh7th/nvim-cmp",
            requires = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
        }})
        use({
            "L3MON4D3/LuaSnip",
            requires = "saadparwaiz1/cmp_luasnip"
        })
        use("nvim-lualine/lualine.nvim")
        use("lewis6991/gitsigns.nvim")
        use("lukas-reineke/indent-blankline.nvim")
        use("akinsho/toggleterm.nvim")
        use({
            "TimUntersberger/neogit",
            opt = true, cmd = "Neogit"
        })
        use("lewis6991/impatient.nvim")
        use("skovati/cmp-zk")
        use("sainnhe/gruvbox-material")
        if bootstrap then
            require("packer").sync()
        end
    end
)

if bootstrap then
    print("Installing plugins, restart nvim after packer sync completes")
    return
end

pcall(require("impatient"))

vim.api.nvim_create_autocmd("BufWritePost", {
    command = "PackerCompile",
    pattern = "init.lua",
    group = vim.api.nvim_create_augroup("Packer", {}),
})

----------------------------------------
-- sets
----------------------------------------
vim.opt.relativenumber = true          -- number line shows relative
vim.opt.number = true                  -- and current line shows actual line nr
vim.opt.smartindent = true             -- indent according to lang
vim.opt.tabstop = 4                    -- 4 space tabs
vim.opt.shiftwidth = 0                 -- >> shifts by tabstop amount
vim.opt.softtabstop = -1               -- backspace removes $tabstop spaces
vim.opt.expandtab = true               -- insert tabs as spaces
vim.opt.clipboard = "unnamedplus"      -- use system clipboard
vim.opt.ignorecase = true              -- ignore case in searches
vim.opt.smartcase = true               -- ^ unless capital query
vim.opt.guicursor = ""                 -- fixes alacritty changing cursor
vim.opt.signcolumn = "number"          -- combines the signcolumn and number columns
vim.opt.timeoutlen = 600               -- decrease timeout length for keymaps
vim.opt.showmode = false               -- hide current mode, it"s in statusline
vim.opt.updatetime = 250               -- decrease update time
vim.opt.lazyredraw = true              -- dont redraw screen when exec macros
vim.opt.nrformats:append("alpha")      -- let <Ctrl-a> do letters as well
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.completeopt = { "menuone", "noselect", "preview" } -- set for cmp
vim.opt.shortmess:append("c")          -- dont show eg "1 out of 20 matches"
vim.opt.conceallevel = 0
vim.opt.mouse = "a"                    -- only used when pair programming dont judge
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.swapfile = false               -- disable swapfiles
vim.opt.backup = false                 -- and auto backps, to instead use
vim.opt.undofile = true                -- enable auto save of undos
vim.opt.foldmethod = "expr"            -- syntax folding: zc, zo, zr, zR
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.spelllang = "en_us"            -- spell check
vim.opt.complete:append("kspell")
vim.opt.listchars:append("trail:·")    -- show trailing spaces
vim.opt.list = true                    -- show things in listchars
-- turn off relativenumber when in insert mode
local toggle_rel_num = vim.api.nvim_create_augroup("ToggleRelNum", {})
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        vim.opt.relativenumber = false
    end,
    group = toggle_rel_num,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        vim.opt.relativenumber = true
    end,
    group = toggle_rel_num,
})
-- use new filetype.lua
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

----------------------------------------
-- maps
----------------------------------------
-- set leader as space
vim.keymap.set({ "n", "v" }, "<space>", "<nop>", { silent = true })
vim.g.mapleader = " "

-- add wq esc remap
vim.keymap.set({ "i", "v" }, "wq", "<esc>", { silent = true })
vim.keymap.set("t", "wq", "<C-\\><C-n>", { silent = true })

-- fix sticky shift
vim.keymap.set("c", "W", "w", { silent = true })
vim.keymap.set("c", "Q", "q", { silent = true })
vim.keymap.set("c", "Wq", "wq", { silent = true })
vim.keymap.set("c", "WQ", "wq", { silent = true })
vim.keymap.set("c", "wQ", "wq", { silent = true })

vim.keymap.set("i", "{<CR>", "{<CR>}<Esc>O", { silent = true }) -- autoclose
vim.keymap.set("n", "<leader>ng", ":Neogit<cr>", { silent = true })
vim.keymap.set("n", "<leader>s", ":setlocal spell!<CR>", { silent = true })

-- telescope
local telescope = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", telescope.find_files)
vim.keymap.set("n", "<leader>fi", telescope.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>fg", telescope.git_files)
vim.keymap.set("n", "<leader><space>", telescope.buffers)
vim.keymap.set("n", "<leader>fa", telescope.live_grep)

----------------------------------------
-- color
----------------------------------------
-- small highlight fixes, autocmd to load after colorscheme so we overwrite
vim.api.nvim_create_autocmd("ColorScheme", {
    command = [[
        hi Normal ctermbg=none guibg=none
        hi LineNr ctermbg=none ctermfg=9 guibg=none
        hi EndOfBuffer guibg=none
        hi GitGutterAdd    ctermbg=none guibg=none
        hi GitGutterChange ctermbg=none guibg=none
        hi GitGutterDelete ctermbg=none guibg=none
    ]],
    group = vim.api.nvim_create_augroup("ColorFixes", {}),
})
-- set colorscheme
vim.g.gruvbox_material_better_performance = 1
vim.g.gruvbox_material_foreground = "mix"
vim.cmd([[ colorscheme gruvbox-material ]])

-- highlight selection on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual" })
    end,
    group = vim.api.nvim_create_augroup("YankHighlight", {}),
})

----------------------------------------
-- plugin config
----------------------------------------
-- disable builtins
vim.g.loaded_fzf = 1
vim.g.loaded_gzip = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zipPlugin = 1

vim.g.indent_blankline_char = "¦"
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_use_treesitter = true

require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "gruvbox-material",
        component_separators = "|",
        section_separators = "",
        globalstatus = true,
    },
})

require("gitsigns").setup({ signcolumn = false, numhl = true, })

require("toggleterm").setup({ open_mapping = [[<c-\>]] })

require("Comment").setup()

require("telescope").setup({
    defaults = {
        prompt_title = false,
        results_title = false,
        preview_title = false,
        layout_strategy = "horizontal",
        layout_config = { width = 0.80, },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└", },
        mappings = {
            i = { ["<esc>"] = require("telescope.actions").close },
        },
    },
})

pcall(require("telescope").load_extension, "fzf")

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
        swap = {
            enable = true,
            swap_next = {
                ['<leader>a'] = '@parameter.inner',
            },
            swap_previous = {
                ['<leader>A'] = '@parameter.inner',
            },
        },
    },
})

----------------------------------------
-- lsp
----------------------------------------
local lspconfig = require("lspconfig")
local on_attach = function(_, bufnr)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
    vim.keymap.set("n", "gd", telescope.lsp_definitions, { buffer = bufnr })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set("n", "gi", telescope.lsp_implementations, { buffer = bufnr })
    vim.keymap.set( "n", "<leader>D", telescope.lsp_type_definitions, { buffer = bufnr })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set( "n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set("n", "gr", telescope.lsp_references, { buffer = bufnr })
    vim.keymap.set( "n", "<leader>e", vim.diagnostic.open_float, { buffer = bufnr })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr })
    vim.keymap.set("n", "<leader>fd", telescope.lsp_document_symbols, { buffer = bufnr })
    vim.keymap.set("n", "<leader>fD", telescope.lsp_workspace_symbols, { buffer = bufnr })
    vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})

    -- configure how lsp diagnostics are shown
    vim.diagnostic.config({
        virtual_text = true, signs = false,
        underline = true, update_in_insert = false,
    })
end

-- setup specific LSPs
local servers = {
    "pyright", "rust_analyzer", "gopls", "clangd",
    "tsserver", "svls", "jdtls", "bashls", "hls",
    "zls", "sumneko_lua"
}

local get_lua_settings = function()
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    return {
        settings = {
            Lua = {
                runtime = { version = "LuaJIT", path = runtime_path, },
                diagnostics = { globals = { "vim" }, },
                workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                telemetry = { enable = false, },
            },
        },
    }
end

local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in ipairs(servers) do
    local opts =  {
        capabilities = capabilities,
        on_attach = on_attach,
    }
    if lsp == "sumneko_lua" then
        opts = vim.tbl_extend("error", opts, get_lua_settings())
    end
    lspconfig[lsp].setup(opts)
end

-- auto-completion setup
local cmp = require("cmp")
local ls = require("luasnip")
cmp.setup({
    mapping = cmp.mapping.preset.insert({
        ["<c-d>"] = cmp.mapping.scroll_docs(-4),
        ["<c-u>"] = cmp.mapping.scroll_docs(4),
        ["<c-y>"] = cmp.mapping.complete(),
        ["<c-space>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
        }),
        ["<c-k>"] = cmp.mapping(function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { "i" }),
    }),
    sources = {
        { name = "nvim_lsp" },  { name = "luasnip" },
        { name = "path" },      { name = "calc" },
        { name = "buffer" },    { name = "zk" },
    },
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end,
    },
})

----------------------------------------
-- luasnip
----------------------------------------
ls.add_snippets(nil, {
    tex = {
        ls.parser.parse_snippet(
            "be",
            "\\begin{equation}\n\t$0\n\\end{equation}"
        ),
        ls.parser.parse_snippet("bm", "\\($0\\)"),
    },
})
