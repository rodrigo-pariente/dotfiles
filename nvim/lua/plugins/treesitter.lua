return{
    'nvim-treesitter/nvim-treesitter',
    opts = {
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
        "python",
        "c",
        "bash",
        "zsh",
        "html",
        "markdown",
        "markdown_inline",
        "lua",
        "vim",
        "json"
        },
    },
    lazy = false,
    build = ':TSUpdate'
}

