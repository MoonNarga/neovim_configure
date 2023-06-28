require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "bash", "c_sharp", "cmake", "cpp", "dockerfile", "gitignore", "go", "gomod", "haskell", "html", "java", "javascript", "json", "json5", "kotlin", "llvm", "make", "markdown", "markdown_inline", "nix", "perl", "python", "rust", "toml", "typescript", "vue", "yaml", "tsx", "vim", "vimdoc", "query" },

  highlight = { enable = true },
  indent = { enable = true },
  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}
