----------------------------------------
-- shortcut definitions
----------------------------------------
local opt = vim.opt                     -- set options
local g = vim.g                         -- access global vars
local fn = vim.fn                       -- run vimL func
local cmd = vim.cmd                     -- run : cmd

----------------------------------------
-- install packer
----------------------------------------
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
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

local use = require("packer").use
require("packer").startup(function()
    use "wbthomason/packer.nvim" 		    -- package manager

    -- actually useful
    use 'tpope/vim-commentary'         -- gcc Vgc
    use 'tpope/vim-surround'           -- cs\"' 
    use 'tpope/vim-fugitive'           -- !Git integration

    -- rice
    use 'Yggdroot/indentLine'          -- display indents :IndentLineToggle
    use 'skovati/skovati.vim'          -- colorscheme
    use 'preservim/tagbar'             -- tmp ctags display
    use 'mbbill/undotree'              -- undo tree visualization
    use 'morhetz/gruvbox'              -- gruvbox
    use 'junegunn/goyo.vim'            -- distraction free writing
    use 'vimwiki/vimwiki'              -- note-taking, wiki
    use 'lervag/vimtex'                -- LaTeX

    -- language specific
    use 'hashivim/vim-terraform'

    -- neovim specific
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-lualine/lualine.nvim'

    -- lsp completion
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-nvim-lua'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-calc'
end)

----------------------------------------
-- plugins
----------------------------------------
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = '16color',
        component_separators = { left = '|', right = '|'},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {},
        always_divide_middle = true,
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff',
        {'diagnostics', sources={'nvim_lsp'}}},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {'filename'},
        lualine_x = {'location'},
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}
----------------------------------------
-- color
----------------------------------------
opt.cursorline = true
-- opt.termguicolors = true

-- gruvbox
cmd"colorscheme gruvbox"

-- let terminal determine background
-- override the horrible gruvbox visual colors
cmd[[
au ColorScheme * hi Normal ctermbg=none guibg=none
au ColorScheme * hi Visual ctermbg=237 ctermfg=none cterm=none
]]

----------------------------------------
-- sets
----------------------------------------
opt.number = true                       -- line nums
opt.relativenumber = true

opt.smartindent = true                  -- indent according to lang 

opt.tabstop = 4			                -- 4 space tabs
opt.softtabstop = 4			            -- backspace removes all spaces
opt.shiftwidth = 4			            -- >> shifts by 4
opt.expandtab = true			        -- insert tabs as spaces

opt.clipboard = "unnamedplus"           -- use system clipboard

opt.ignorecase = true                   -- ignore case in searches
opt.smartcase = true                    -- unless capital query

opt.showmatch = true                    -- highlight matching brackets

opt.path:append("**")                   --enable fuzzy :find ing
opt.shortmess:append("F")
opt.guicursor = ""                  -- fixes alacritty changing cursor
opt.signcolumn= "number"

-- better backups (~/.local/share/nvim/undo)
opt.swapfile = false                    -- disable swapfiles
opt.backup = false                      -- and auto backps, to instead use
opt.undofile = true                     -- enable auto save of undos

-- syntax folding: zc, zo, zr, zR
opt.foldmethod = "syntax"
opt.foldnestmax = 10
opt.foldenable = false

-- spell check
opt.spelllang = "en_us"
opt.complete:append("kspell")

-- for custom statusline
opt.laststatus = 2                      -- Always display the status line
opt.showmode = false                    -- hide current mode

opt.updatetime = 250                    -- decrease update time

opt.hidden = true                       -- dont save when switching buffers
opt.inccommand = 'nosplit'              -- incremental live completion
----------------------------------------
-- maps
----------------------------------------
-- local func to set keybinds
local remap = function(type, key, value)
    vim.api.nvim_set_keymap(type,key,value,{noremap = true, silent = true});
end

-- set leader as space
remap("", "<Space>", "<Nop>")
vim.g.mapleader = " "

-- add wq esc remap
remap("i", "wq", "<esc>")
remap("v", "wq", "<esc>")

-- fix sticky shift
remap("c", "W", "w")
remap("c", "Q", "q")
remap("c", "Wq", "wq")
remap("c", "WQ", "wq")
remap("c", "wQ", "wq")

-- fuck arrow keys
remap("n", "<Up>", "<Nop>")
remap("n", "<Down>", "<Nop>")
remap("n", "<Left>", "<Nop>")
remap("n", "<Right>", "<Nop>")
remap("i", "<Up>", "<Nop>")
remap("i", "<Down>", "<Nop>")
remap("i", "<Left>", "<Nop>")
remap("i", "<Right>", "<Nop>")

-- autoclose {}
remap("i", "{<CR>", "{<CR>}<Esc>O")

-- LaTeX
remap("n", "<leader>be", "i\\begin{equation}<CR>\\end{equation}<ESC>O")
remap("n", "<leader>bm", "i\\(\\)<ESC>hi")

-- Split Navigation shortcuts
remap("n", "<C-h>", "<C-w>h")
remap("n", "<C-j>", "<C-w>j")
remap("n", "<C-k>", "<C-w>k")
remap("n", "<C-l>", "<C-w>l")

-- Goyo
remap("n", "<leader>g", ":Goyo<CR>")

-- fzf
remap("n", "<leader>ff", ":Files<CR>")
remap("n", "<leader>fg", ":GFiles<CR>")

-- tagbar
remap("n", "<leader>t", ":TagbarToggle<CR>")

-- undotree
remap("n", "<leader>u", ":UndotreeToggle<CR>")

-- neovim defaults that rock
remap("n", "Y", "y$")
remap("n", "<C-L>", "<Cmd>nohlsearch<Bar>diffupdate<CR><C-L>")

-- toggle spellcheck quickly
remap("n", "<leader>s", ":setlocal spell!<CR>")

remap("n", "<leader>c", ":lua ToggleConcealLevel()<CR>")
function ToggleConcealLevel()
    if vim.opt.conceallevel:get() == 2 then
        opt.conceallevel = 0
    else
        opt.conceallevel = 2
    end
end

----------------------------------------
-- treesitter
----------------------------------------
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "go",
    "python",
    "yaml",
    "lua",
    "bash",
    "c",
    "cpp",
    "rust",
    "verilog",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}

----------------------------------------
-- lsp
----------------------------------------
-- references
local nvim_lsp = require("lspconfig")

local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    local opts = { noremap=true, silent=true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            -- virtual_text = false,
            underline = true,
            signs = false,
        }
    )

end

-- other 
vim.cmd([[
highlight LspDiagnosticsDefaultError ctermfg=grey
]])
vim.o.completeopt = "menuone,noselect"

-- Use a loop to conveniently call "setup" on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "pyright", "rust_analyzer", "gopls", "clangd" }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        flags = {
            debounce_text_changes = 150,
        }
    }
end

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },
  sources = {
    { name = 'nvim_lua' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'calc' },
    { name = 'buffer' },
  },
}
