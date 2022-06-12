pcall(require("impatient")) -- gotta go fast
----------------------------------------
-- install packer
----------------------------------------
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
end

vim.api.nvim_create_autocmd("BufWritePost", {
    command = "PackerCompile",
    pattern = "init.lua",
    group = vim.api.nvim_create_augroup("Packer", {}),
})

----------------------------------------
-- plugin declaration
----------------------------------------
require("packer").startup(function(use)
    use("wbthomason/packer.nvim") -- packer manages itself
    use("tpope/vim-surround") -- cs"" ysiw)
    use({ "tpope/vim-fugitive", opt = true, cmd = "Git" }) -- !Git integration
    use("nvim-lua/plenary.nvim") -- nvim lua stdlib
    use("nvim-telescope/telescope.nvim") -- fuzzy finder
    use({ "numToStr/Comment.nvim", config = require("Comment").setup() }) -- gcc Vgc
    use("rktjmp/lush.nvim") -- colorscheme
    use("lewis6991/impatient.nvim") -- faster nvim loading
    use({ "hashivim/vim-terraform", ft = "hcl" })
    use({ "lervag/vimtex", ft = "tex" }) -- latex integration
    use("neovim/nvim-lspconfig")
    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-nvim-lsp")
    use({ "hrsh7th/cmp-calc", ft = { "tex", "markdown" }, })
    use("L3MON4D3/LuaSnip")
    use("saadparwaiz1/cmp_luasnip")
    use("lewis6991/gitsigns.nvim")
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    use("nvim-lualine/lualine.nvim")
    use("lukas-reineke/indent-blankline.nvim") -- show indents w/ virtual text
    use("chriskempson/base16-vim")
    use("skovati/cybrpnk.vim")
    use("skovati/cmp-zk")
    use({ "junegunn/goyo.vim", opt = true, cmd = "Goyo", }) -- distraction free writing
    config = { compile_path = vim.fn.stdpath("config") .. "/lua/packer_compiled.lua" }
end)
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
vim.opt.timeoutlen = 600 -- decrease timeout length for keymaps
vim.opt.showmode = false -- hide current mode
vim.opt.updatetime = 250 -- decrease update time
vim.opt.lazyredraw = true -- dont redraw screen when exec macros
vim.opt.nrformats:append("alpha") -- let <Ctrl-a> do letters as well
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.completeopt = { "menuone", "noselect", "preview" } -- set for cmp
vim.opt.shortmess:append("c") -- dont show eg "1 out of 20 matches"
vim.opt.conceallevel = 0
vim.opt.mouse = "a" -- only used when pair programming dont judge
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.swapfile = false -- disable swapfiles
vim.opt.backup = false -- and auto backps, to instead use
vim.opt.undofile = true -- enable auto save of undos
vim.opt.foldmethod = "expr" -- syntax folding: zc, zo, zr, zR
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldnestmax = 10
vim.opt.foldenable = false
vim.opt.spelllang = "en_us" -- spell check
vim.opt.complete:append("kspell")
vim.opt.listchars:append("trail:·")     -- show trailing spaces
vim.opt.list = true -- show things in listchars
local toggle_rel_num = vim.api.nvim_create_augroup("ToggleRelNum", {})
vim.api.nvim_create_autocmd("InsertEnter", {
    command = "set norelativenumber",
    group = toggle_rel_num,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    command = "set relativenumber",
    group = toggle_rel_num,
})
-- use new filetype.lua
vim.g.do_filetype_lua = 1
vim.g.did_load_filetypes = 0

----------------------------------------
-- maps
----------------------------------------
-- set leader as space
vim.keymap.set({"n", "v"}, "<space>", "<nop>", { silent = true })
vim.g.mapleader = " "

-- add wq esc remap
vim.keymap.set({"i", "v"}, "wq", "<esc>", { silent = true })
vim.keymap.set("t", "wq", "<C-\\><C-n>", { silent = true })

-- fix sticky shift
vim.keymap.set("c", "W", "w", { silent = true })
vim.keymap.set("c", "Q", "q", { silent = true })
vim.keymap.set("c", "Wq", "wq", { silent = true })
vim.keymap.set("c", "WQ", "wq", { silent = true })
vim.keymap.set("c", "wQ", "wq", { silent = true })

vim.keymap.set("i", "{<CR>", "{<CR>}<Esc>O", { silent = true }) -- autoclose

-- telescope
local tele = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", tele.find_files)
vim.keymap.set("n", "<leader>fi", tele.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>fg", tele.git_files)
vim.keymap.set("n", "<leader><space>", tele.buffers)
vim.keymap.set("n", "<leader>fa", tele.live_grep)
vim.keymap.set("n", "<leader>?", tele.oldfiles)
vim.keymap.set("n", "<leader>gg", ":Goyo<CR>", { silent = true })
vim.keymap.set("n", "<leader>gs", ":Git status<CR>", { silent = true })
vim.keymap.set("n", "<leader>s", ":setlocal spell!<CR>", { silent = true })

----------------------------------------
-- color
----------------------------------------
-- small highlight fixes, autocmd to load after colorscheme so we overwrite
vim.api.nvim_create_autocmd("ColorScheme", {
    command = [[
        hi Normal ctermbg=none guibg=none
        hi Visual ctermbg=237 ctermfg=none guibg=Grey23
        hi LineNr ctermbg=none ctermfg=9 guibg=none
        hi MatchParen gui=bold guifg=white guibg=Grey23
        hi DiagnosticError ctermfg=grey guifg=grey
        hi GitGutterAdd    ctermbg=none guibg=none
        hi GitGutterChange ctermbg=none guibg=none
        hi GitGutterDelete ctermbg=none guibg=none
    ]],
    group = vim.api.nvim_create_augroup("ColorFixes", {}),
})
-- set colorscheme
vim.cmd([[ colorscheme base16-tomorrow-night ]])

-- highlight selection on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual" })
    end,
    group = vim.api.nvim_create_augroup("YankHighlight", {})
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
require("lualine").setup({
    options = {
        icons_enabled = false,
        theme = "cybrpnk",
        component_separators = "|",
        section_separators = "",
        globalstatus = true,
    },
})

require("gitsigns").setup({ signcolumn = false, numhl = true, })

require("telescope").setup({
    defaults = {
        prompt_title = false,
        results_title = false,
        preview_title = false,
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.80,
        },
        borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└", },
        mappings = {
            i = { ["<esc>"] = require("telescope.actions").close },
        },
    },
})

-- vimwiki
vim.g.vimwiki_list = {{
        path = "/tmp/notes/", -- make it use markdown syntax
        syntax = "markdown",
        ext = ".md",
    }}

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
vim.g.indent_blankline_use_treesitter = true

----------------------------------------
-- treesitter
----------------------------------------
require("nvim-treesitter.configs").setup({
    ensure_installed = "all",
    sync_install = false,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true,
    },
})

----------------------------------------
-- lsp
----------------------------------------
local lspconfig = require("lspconfig")
local on_attach = function(client , bufnr)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr })
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = bufnr })
    vim.keymap.set( "n", "<leader>D", vim.lsp.buf.type_definition, { buffer = bufnr })
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr })
    vim.keymap.set( "n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = bufnr })
    vim.keymap.set( "n", "<leader>e", vim.diagnostic.open_float, { buffer = bufnr })
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr })
    vim.api.nvim_create_user_command("Format", vim.lsp.buf.formatting, {})

    -- configure how lsp diagnostics are shown
    vim.diagnostic.config({
        virtual_text = true,
        signs = false,
        underline = true,
        update_in_insert = false,
    })
end

-- setup specific LSPs
local servers = {
    "pyright", "rust_analyzer", "gopls", "clangd",
    "tsserver", "svls", "texlab", "jdtls"
}
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
        capabilities = capabilities,
        on_attach = on_attach,
        flags = { debounce_text_changes = 150 },
    })
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
        ["<c-k>"] = cmp.mapping(
            function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { "i" }
        ),
    }),
    sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "calc" },
        { name = "buffer" },
        { name = "zk" },
    },
    snippet = {
        expand = function(args)
            ls.lsp_expand(args.body)
        end
    },
})

----------------------------------------
-- luasnip
----------------------------------------
ls.add_snippets(nil, {
    tex = {
        ls.parser.parse_snippet("be", "\\begin{equation}\n\t$0\n\\end{equation}"),
        ls.parser.parse_snippet("bm", "\\($0\\)"),
    },
})
