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
