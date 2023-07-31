require'nvim-treesitter.configs'.setup {

  ensure_installed = { "help", "java", "kotlin", "javascript", "typescript", "lua", "rust" },
  sync_install = false,
  auto_install = true,
  ignore_install = { "help" },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}

