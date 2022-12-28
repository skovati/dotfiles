-- set leader as space (for some reason this has to be done first)
vim.keymap.set({ "n", "v" }, "<space>", "<nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.guicursor = ""    -- fixes alacritty changing cursor

----------------------------------------
-- bootstrap
----------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup(require("plugins"), {
    defaults = { lazy = true },
    install = { colorscheme = { "gruvbox-material", "slate" } },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "netrwPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
                "fzf",
                "nvim-treesitter-textobjects",
                "rplugin",
            },
        }
    }
})

----------------------------------------
-- sets
----------------------------------------
vim.o.relativenumber = true             -- number line shows relative
vim.o.number = true                     -- and current line shows actual line nr
vim.o.smartindent = true                -- indent according to lang
vim.o.tabstop = 4                       -- 4 space tabs
vim.o.shiftwidth = 0                    -- >> shifts by tabstop amount
vim.o.softtabstop = -1                  -- backspace removes $tabstop spaces
vim.o.expandtab = true                  -- insert tabs as spaces
vim.o.clipboard = "unnamedplus"         -- use system clipboard
vim.o.ignorecase = true                 -- ignore case in searches
vim.o.smartcase = true                  -- ^ unless capital query
vim.o.signcolumn = "number"             -- combines the signcolumn and number columns
vim.o.timeoutlen = 600                  -- decrease timeout length for keymaps
vim.o.showmode = false                  -- hide current mode, it"s in statusline
vim.o.updatetime = 250                  -- decrease update time
vim.o.lazyredraw = true                 -- dont redraw screen when exec macros
vim.opt.nrformats:append("alpha")       -- let <Ctrl-a> do letters as well
vim.o.splitbelow = true
vim.o.splitright = true
vim.opt.completeopt = { "menuone", "noselect", "preview" } -- set for cmp
vim.opt.shortmess:append("c")           -- don't show eg "1 out of 20 matches"
vim.o.mouse = "nvch"                    -- only used when pair programming dont judge
vim.o.mousemodel = "extend"
vim.o.cursorline = true
vim.o.termguicolors = true
vim.o.swapfile = false                  -- disable swapfiles
vim.o.undofile = true                   -- enable auto save of undos
vim.o.foldmethod = "expr"               -- syntax folding: zc, zo, zr, zR
vim.o.foldexpr = "nvim_treesitter#foldexpr()"
vim.o.foldenable = false
vim.o.spelllang = "en_us"               -- spell check
vim.opt.complete:append("kspell")
vim.opt.listchars:append("trail:·")     -- show trailing spaces
vim.o.list = true                       -- show things in listchars
vim.o.cmdheight = 0

----------------------------------------
-- maps
----------------------------------------

vim.keymap.set({ "i", "v" }, "wq", "<esc>", { silent = true })
vim.keymap.set("t", "wq", "<C-\\><C-n>", { silent = true })
vim.keymap.set("n", "<leader>s", ":setlocal spell!<CR>", { silent = true })
vim.keymap.set("x", "<leader>p", "\"_dP", { silent = true })

----------------------------------------
-- autocommands
----------------------------------------

-- turn off relativenumber when in insert mode
local toggle_rel_num = vim.api.nvim_create_augroup("ToggleRelNum", {})
vim.api.nvim_create_autocmd("InsertEnter", {
    callback = function()
        vim.o.relativenumber = false
    end,
    group = toggle_rel_num,
})
vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function()
        vim.o.relativenumber = true
    end,
    group = toggle_rel_num,
})

-- highlight selection on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual" })
    end,
    group = vim.api.nvim_create_augroup("YankHighlight", {}),
})
