return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function () 
    local configs = require("nvim-treesitter.configs")

    configs.setup({
        ensure_installed = { "c", "lua", "bash", "c_sharp", "cmake", "cpp", "dockerfile", "gitignore", "go", "gomod", "haskell", "html", "java", "javascript", "json", "json5", "kotlin", "llvm", "make", "markdown", "markdown_inline", "nix", "perl", "python", "rust", "toml", "typescript", "vue", "yaml", "tsx", "vim", "vimdoc", "query" },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
    })
  end
}
