require("impatient") -- gotta go fast
----------------------------------------
-- install packer
----------------------------------------
local install_path = vim.fn.stdpath("data")
    .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

vim.api.nvim_exec(
    [[
        augroup Packer
        autocmd!
        autocmd BufWritePost init.lua PackerCompile
        augroup end
    ]],
    false
)

----------------------------------------
-- plugin declaration
----------------------------------------
local use = require("packer").use
require("packer").startup(function()
    -- actually useful
    use("tpope/vim-surround") -- cs"" ysiw)
    use({ "tpope/vim-fugitive", opt = true, cmd = "Git" }) -- !Git integration
    use("nvim-lua/plenary.nvim")
    use("nvim-telescope/telescope.nvim") -- fuzzy finder
    use({ -- gcc Vgc
        "numToStr/Comment.nvim",
        config = require("Comment").setup(),
    })

    -- meta
    use("wbthomason/packer.nvim") -- packer manages itself
    use("nathom/filetype.nvim") -- faster filetype parsing
    use("rktjmp/lush.nvim") -- colorscheme
    use("lewis6991/impatient.nvim") -- faster nvim loading

    -- language specific
    use({ "hashivim/vim-terraform", ft = "hcl" }) -- pretty terraform
    use({ "vimwiki/vimwiki", ft = "markdown" }) -- notes/wiki plugin
    use({ "lervag/vimtex", ft = "tex" }) -- latex integration

    -- nvim specific
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-lualine/lualine.nvim") -- statusline

    -- lsp/completion
    use("neovim/nvim-lspconfig")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lsp")
    use({
        "hrsh7th/cmp-calc",
        ft = { "tex", "markdown" },
    })
    use("L3MON4D3/LuaSnip") -- snippets
    use("saadparwaiz1/cmp_luasnip")

    -- rice
    use("lukas-reineke/indent-blankline.nvim") -- show indents w/ virtual text
    use("chriskempson/base16-vim") -- base16 colorschemes
    use({
        "mbbill/undotree", -- undo tree visualization
        opt = true,
        cmd = "UndotreeToggle",
    })
    use("skovati/cybrpnk.vim")
    use({
        "junegunn/goyo.vim", -- distraction free writing
        opt = true,
        cmd = "Goyo",
    })
    config = {
        compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua",
    }
end)

----------------------------------------
-- plugin config
----------------------------------------
require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "cybrpnk",
        component_separators = "|",
        section_separators = "",
    },
    sections = {
        lualine_x = { "encoding", "filetype" },
    },
})

require("telescope").setup({
    defaults = {
        prompt_title = false,
        results_title = false,
        preview_title = false,
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.80,
        },
        borderchars = {
            "─",
            "│",
            "─",
            "│",
            "┌",
            "┐",
            "┘",
            "└",
        },
        mappings = {
            i = { ["<esc>"] = require("telescope.actions").close },
        },
    },
})

vim.g.netrw_banner = 0 -- disable annoying banner
vim.g.netrw_browse_split = 3 -- open in prior window
vim.g.netrw_altv = 1 -- open splits to the right
vim.g.netrw_liststyle = 3 -- tree view
vim.g.netrw_winsize = 20 -- limit split size

-- vimwiki
vim.g.vimwiki_list = {
    {
        path = "/tmp/notes/", -- make it use markdown syntax
        syntax = "markdown",
        ext = ".md",
    },
}

vim.g.vimwiki_global_ext = 0 -- and not treat every markdown as vimwiki
vim.g.vimwiki_markdown_link_ext = 1 -- makes markdown linkes like [text](text.md) instead of [text](text)
vim.g.vimwiki_conceallevel = 0

-- vimtex
vim.g.vimtex_quickfix_mode = 0
vim.g.tex_flavor = "latex"
vim.g.vimtex_view_method = "zathura"

-- indent
vim.g.indent_blankline_char = "¦"
vim.g.indent_blankline_show_trailing_blankline_indent = false

----------------------------------------
-- color
----------------------------------------
vim.opt.cursorline = true
vim.opt.termguicolors = true

-- let terminal determine background (except a sane grey visual hi)
vim.cmd([[
    au ColorScheme * hi Normal ctermbg=none guibg=none
    au ColorScheme * hi LineNr ctermbg=none ctermfg=9 guibg=none
    au ColorScheme * hi Visual ctermbg=237 ctermfg=none guibg=Grey23
]])

-- set colorscheme
vim.cmd([[ colorscheme base16-tomorrow-night ]])

-- highlight selection on yank
vim.cmd([[
    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual"})
    augroup end
]])

----------------------------------------
-- sets
----------------------------------------
vim.opt.relativenumber = true -- number line shows relative
vim.opt.number = true -- and current line shows actual line nrl
vim.opt.smartindent = true -- indent according to lang
vim.opt.tabstop = 4 -- 4 space tabs
vim.opt.shiftwidth = 0 -- >> shifts by tabstop amount
vim.opt.softtabstop = -1 -- backspace removes $tabstop spaces
vim.opt.expandtab = true -- insert tabs as spaces
vim.opt.clipboard = "unnamedplus" -- use system clipboard
vim.opt.ignorecase = true -- ignore case in searches
vim.opt.smartcase = true -- unless capital query
vim.opt.guicursor = "" -- fixes alacritty changing cursor
vim.opt.signcolumn = "number" -- combines the signcolumn and number columns
vim.opt.timeoutlen = 400 -- decrease timeout length for keymaps
vim.opt.showmode = false -- hide current mode
vim.opt.updatetime = 250 -- decrease update time
vim.opt.lazyredraw = true -- dont redraw screen when exec macros
vim.opt.nrformats:append("alpha") -- let <Ctrl-a> do letters as well
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.completeopt = { "menuone", "noselect" } -- set for cmp
vim.opt.shortmess:append("c") -- dont show eg "1 out of 20 matches"
vim.opt.conceallevel = 0

-- better backups (~/.local/share/nvim/undo)
vim.opt.swapfile = false -- disable swapfiles
vim.opt.backup = false -- and auto backps, to instead use
vim.opt.undofile = true -- enable auto save of undos

-- syntax folding: zc, zo, zr, zR
vim.opt.foldmethod = "syntax"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false

-- spell check
vim.opt.spelllang = "en_us"
vim.opt.complete:append("kspell")

vim.cmd([[
    augroup ToggleRelNum
        autocmd InsertEnter * :set norelativenumber
        autocmd InsertLeave * :set relativenumber 
    augroup end
]])

----------------------------------------
-- maps
----------------------------------------
-- local func to set keybinds
local remap = function(type, key, value)
    vim.api.nvim_set_keymap(type, key, value, { noremap = true, silent = true })
end

-- set leader as space
remap("", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- add wq esc remap
remap("i", "wq", "<esc>")
remap("v", "wq", "<esc>")
remap("t", "wq", "<C-\\><C-n>")

-- fix sticky shift
remap("c", "W", "w")
remap("c", "Q", "q")
remap("c", "Wq", "wq")
remap("c", "WQ", "wq")
remap("c", "wQ", "wq")

remap("i", "{<CR>", "{<CR>}<Esc>O") -- autoclose {}

-- Split Navigation shortcuts
remap("n", "<C-h>", "<C-w>h")
remap("n", "<C-j>", "<C-w>j")
remap("n", "<C-k>", "<C-w>k")
remap("n", "<C-l>", "<C-w>l")

-- telescope
remap("n", "<leader>ff", "<cmd>Telescope find_files <cr>")
remap("n", "<leader>fg", "<cmd>Telescope git_files<cr>")
remap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
remap("n", "<leader><leader>", "<cmd>Telescope live_grep<cr>")

remap("n", "<leader>gg", ":Goyo<CR>") -- Goyo
remap("n", "<leader>gs", ":Git status<CR>") -- git
remap("n", "<leader>n", ":Vexplore<CR>") -- netrw
remap("n", "<leader>s", ":setlocal spell!<CR>") -- toggle spellcheck quickly
remap("n", "<leader>u", ":UndotreeToggle<CR>") -- undotree

remap("n", "<C-L>", "<Cmd>nohlsearch<Bar>diffupdate<CR><C-L>") -- clear prev search results

----------------------------------------
-- treesitter
----------------------------------------
require("nvim-treesitter.configs").setup({
    ensure_installed = "maintained",
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { -- still kinda broken for me
        enable = false,
    },
})

----------------------------------------
-- lsp
----------------------------------------
local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end
    local opts = { noremap = true, silent = true }

    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap(
        "n",
        "<leader>D",
        "<cmd>lua vim.lsp.buf.type_definition()<CR>",
        opts
    )
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap(
        "n",
        "<leader>ca",
        "<cmd>lua vim.lsp.buf.code_action()<CR>",
        opts
    )
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap(
        "n",
        "<leader>e",
        "<cmd>lua vim.diagnostic.open_float()<CR>",
        opts
    )
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap(
        "n",
        "<leader>fm",
        "<cmd>lua vim.lsp.buf.formatting()<CR>",
        opts
    )

    -- configure how lsp diagnostics are shown
    vim.diagnostic.config({
        virtual_text = true,
        signs = false,
        underline = true,
        update_in_insert = false,
    })
end

-- other
vim.cmd([[
    highlight DiagnosticError ctermfg=grey guifg=Grey
]])

-- setup specific LSPs
local servers = {
    "pyright",
    "rust_analyzer",
    "gopls",
    "clangd",
    "tsserver",
    "svls",
    "texlab",
}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        },
    })
end

-- auto-completion setup
local cmp = require("cmp")
local ls = require("luasnip")
cmp.setup({
    mapping = {
        ["<c-d>"] = cmp.mapping.scroll_docs(-4),
        ["<c-u>"] = cmp.mapping.scroll_docs(4),
        ["<c-e>"] = cmp.mapping.close(),
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
    },
    sources = {
        { name = "nvim_lua" },
        { name = "luasnip" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "calc" },
        { name = "buffer" },
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
ls.snippets = {
    tex = {
        ls.parser.parse_snippet(
            "be",
            "\\begin{equation}\n\t$0\n\\end{equation}"
        ),
        ls.parser.parse_snippet("bm", "\\($0\\)"),
    },
}
