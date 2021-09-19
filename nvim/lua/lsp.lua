-- references
local lsp = require('lspconfig')
local compe = require('compe')
local remap = function(type, key, value)
    vim.api.nvim_set_keymap(type,key,value,{noremap = true, silent = true});
end

-- config
compe.setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    preselect = 'enable';
    throttle_time = 80;
    source_timeout = 200;
    resolve_timeout = 800;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = {
        border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
        winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
        max_width = 120,
        min_width = 60,
        max_height = math.floor(vim.o.lines * 0.3),
        min_height = 1,
    };

    source = {
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        vsnip = true;
        ultisnips = true;
        luasnip = true;
    };
}

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        -- Disable signs
        -- virtual_text = false,
        underline = true,
        signs = false,
    }
)

vim.cmd([[
    highlight LspDiagnosticsDefaultError ctermfg=grey
]])

vim.o.completeopt = "menuone,noselect"

-- keymaps

vim.cmd([[
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })
]])

remap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
remap('n', '<leader>d', '<cmd>lua vim.lsp.buf.declaration()<CR>')
remap('n', '<leader>s', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
remap('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')

-- require lsps
lsp.gopls.setup{}
lsp.rls.setup{}
lsp.pyright.setup{}
