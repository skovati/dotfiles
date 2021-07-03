require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "go",
    "python",
    "yaml",
    "lua",
    "bash",
    "c",
    "cpp",
  },
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  }
}
