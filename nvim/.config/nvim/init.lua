require("impatient")                        -- gotta go fast
----------------------------------------
-- shortcut definitions
----------------------------------------
local opt = vim.opt                         -- set options
local g = vim.g                             -- access global vars
local fn = vim.fn                           -- run vimL func
local cmd = vim.cmd                         -- run : cmd

----------------------------------------
-- install packer
----------------------------------------
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
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
require("packer").startup(
    function()
        -- actually useful
        use "tpope/vim-surround"            -- cs"" ysiw)
        use {"tpope/vim-fugitive", opt = true, cmd = "Git"} -- !Git integration
        use "nvim-lua/plenary.nvim"
        use "nvim-telescope/telescope.nvim" -- fuzzy finder
        use {
            -- gcc Vgc
            "numToStr/Comment.nvim",
            config = function()
                require("Comment").setup()
            end
        }

        -- meta
        use "wbthomason/packer.nvim"        -- packer manages itself
        use "nathom/filetype.nvim"          -- faster filetype parsing
        use "rktjmp/lush.nvim"              -- colorscheme
        use "lewis6991/impatient.nvim"      -- faster nvim loading

        -- language specific
        use {"hashivim/vim-terraform", ft = "hcl"} -- pretty terraform
        use {"vimwiki/vimwiki", ft = "markdown"} -- notes/wiki plugin
        use {"lervag/vimtex", ft = "tex"}   -- latex integration

        -- nvim specific
        use {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"}
        use "nvim-lualine/lualine.nvim"     -- statusline

        -- lsp/completion
        use "neovim/nvim-lspconfig"
        use "hrsh7th/nvim-cmp"
        use "hrsh7th/cmp-buffer"
        use "hrsh7th/cmp-path"
        use "hrsh7th/cmp-nvim-lsp"
        use {
            "hrsh7th/cmp-calc",
            ft = {"tex", "markdown"}
        }
        use "L3MON4D3/LuaSnip"              -- snippets
        use "saadparwaiz1/cmp_luasnip"

        -- rice
        use "lukas-reineke/indent-blankline.nvim" -- show indents w/ virtual text
        use {
            "mbbill/undotree",              -- undo tree visualization
            opt = true,
            cmd = "UndotreeToggle"
        }
        use "chriskempson/base16-vim"       -- base16 colorschemes
        use "skovati/cybrpnk.vim"
        use {
            "junegunn/goyo.vim",            -- distraction free writing
            opt = true,
            cmd = "Goyo"
        }
        config = {
            compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua"
        }
    end
)

----------------------------------------
-- plugin config
----------------------------------------
require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "cybrpnk",
        component_separators = {left = "|", right = "|"},
        section_separators = {left = "", right = ""},
        disabled_filetypes = {},
        always_divide_middle = false,
    },
    sections = {
        lualine_a = {"mode"},
        lualine_b = {
            "branch",
            "diff",
            {"diagnostics", sources = {"nvim_diagnostic"}}
        },
        lualine_c = {"filename"},
        lualine_x = {"encoding", "filetype"},
        lualine_y = {"progress"},
        lualine_z = {"location"},
    },
})

require("telescope").setup({
    defaults = {
        layout_config = {
            horizontal = {width = 0.75, height = 0.75}
        },
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        mappings = {
            i = {["<esc>"] = require("telescope.actions").close}
        }
    }
})

g.netrw_banner = 0                          -- disable annoying banner
g.netrw_browse_split = 3                    -- open in prior window
g.netrw_altv = 1                            -- open splits to the right
g.netrw_liststyle = 3                       -- tree view
g.netrw_winsize = 20                        -- limit split size

-- vimwiki
g.vimwiki_list = { {
    path = "/tmp/notes/",                   -- make it use markdown syntax
    syntax = "markdown",
    ext = ".md"
} }

g.vimwiki_global_ext = 0                    -- and not treat every markdown as vimwiki
g.vimwiki_markdown_link_ext = 1             -- makes markdown linkes like [text](text.md) instead of [text](text)

-- vimtex
g.vimtex_quickfix_mode = 0
g.tex_flavor = "latex"
g.vimtex_view_method = "zathura"

-- indent
g.indent_blankline_char = "¦"
g.indent_blankline_show_trailing_blankline_indent = false

----------------------------------------
-- color
----------------------------------------
opt.cursorline = true
opt.termguicolors = true

-- let terminal determine background
cmd [[
    au ColorScheme * hi Normal ctermbg=none guibg=none
    au ColorScheme * hi LineNr ctermbg=none ctermfg=9 guibg=none
    au ColorScheme * hi Visual ctermbg=237 ctermfg=none guibg=Grey23
]]

-- set colorscheme
cmd [[ colorscheme base16-tomorrow-night ]]

----------------------------------------
-- sets
----------------------------------------
opt.relativenumber = true                   -- number line shows relative
opt.number = true                           -- and current line shows actual line nrl
opt.smartindent = true                      -- indent according to lang
opt.autoindent = true                       -- use current indentation for next
opt.tabstop = 4                             -- 4 space tabs
opt.softtabstop = 4                         -- backspace removes all spaces
opt.shiftwidth = 4                          -- >> shifts by 4
opt.expandtab = true                        -- insert tabs as spaces
opt.clipboard = "unnamedplus"               -- use system clipboard
opt.ignorecase = true                       -- ignore case in searches
opt.smartcase = true                        -- unless capital query
opt.showmatch = true                        -- highlight matching brackets
opt.shortmess:append("Fc")                  -- don"t show "1 of 20 matches" etc for completion
opt.guicursor = ""                          -- fixes alacritty changing cursor
opt.signcolumn = "number"                   -- combines the signcolumn and number columns
-- better backups (~/.local/share/nvim/undo)
opt.swapfile = false                        -- disable swapfiles
opt.backup = false                          -- and auto backps, to instead use
opt.undofile = true                         -- enable auto save of undos

-- syntax folding: zc, zo, zr, zR
opt.foldmethod = "syntax"
opt.foldnestmax = 10
opt.foldenable = false

-- spell check
opt.spelllang = "en_us"
opt.complete:append("kspell")

-- for custom statusline
opt.laststatus = 2                          -- Always display the status line
opt.showmode = false                        -- hide current mode

opt.updatetime = 250                        -- decrease update time
opt.lazyredraw = true                       -- dont redraw screen when exec macros
opt.nrformats:append("alpha")               -- let <Ctrl-a> do letters as well
opt.splitbelow = true
opt.splitright = true

----------------------------------------
-- maps
----------------------------------------
-- local func to set keybinds
local remap = function(type, key, value)
    vim.api.nvim_set_keymap(type, key, value, {noremap = true, silent = true})
end

-- set leader as space
remap("", "<Space>", "<Nop>")
g.mapleader = " "

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

remap("i", "{<CR>", "{<CR>}<Esc>O")         -- autoclose {}

-- Split Navigation shortcuts
remap("n", "<C-h>", "<C-w>h")
remap("n", "<C-j>", "<C-w>j")
remap("n", "<C-k>", "<C-w>k")
remap("n", "<C-l>", "<C-w>l")

-- telescope
remap("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
remap("n", "<leader>fg", "<cmd>Telescope git_files<cr>")
remap("n", "<leader>fb", "<cmd>Telescope buffers<cr>")

remap("n", "<leader>g", ":Goyo<CR>")        -- Goyo
remap("n", "<leader>gs", ":Git status<CR>") -- git
remap("n", "<leader>n", ":Vexplore<CR>")    -- netrw
remap("n", "<leader>s", ":setlocal spell!<CR>") -- toggle spellcheck quickly
remap("n", "<leader>u", ":UndotreeToggle<CR>") -- undotree

remap("n", "<C-L>", "<Cmd>nohlsearch<Bar>diffupdate<CR><C-L>") -- clear prev search results

----------------------------------------
-- treesitter
----------------------------------------
require("nvim-treesitter.configs").setup {
    ensure_installed = "maintained",
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    indent = {
        enable = false
    }
}

----------------------------------------
-- lsp
----------------------------------------
-- references
local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end
    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Mappings.
    local opts = {noremap = true, silent = true}

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    -- configure how lsp diagnostics are shown
    vim.diagnostic.config({virtual_text = true, signs = false, underline = true, update_in_insert = false})
end

-- other
cmd([[
    highlight DiagnosticError ctermfg=grey guifg=Grey
]])
opt.completeopt = "menuone,noselect"

-- setup specific LSPs
local servers = {"pyright", "rust_analyzer", "gopls", "clangd", "tsserver", "svls", "texlab"}
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150
        }
    }
end

-- auto-completion setup
local cmp = require("cmp")
local ls = require("luasnip")
cmp.setup {
    mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.close(),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true
        },
        ["<C-k>"] = cmp.mapping(
            function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end,
            {"i"}
        )
    },
    sources = {
        {name = "nvim_lua"},
        {name = "luasnip"},
        {name = "nvim_lsp"},
        {name = "path"},
        {name = "calc"},
        {name = "buffer"}
    },
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end
    }
}

----------------------------------------
-- luasnip
----------------------------------------
ls.snippets = {
    tex = {
        ls.parser.parse_snippet("be", "\\begin{equation}\n\t$0\n\\end{equation}"),
        ls.parser.parse_snippet("bm", "\\($0\\)")
    }
}
