return {
    "rktjmp/lush.nvim",
    {
        "metalelf0/jellybeans-nvim",
        lazy = false,
        priority = 1000,
        enabled = true,
        config = function()
            vim.cmd.colorscheme("jellybeans-nvim")
        end,
    },
}
