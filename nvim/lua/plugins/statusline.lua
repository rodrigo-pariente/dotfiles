return {
    'beauwilliams/statusline.lua',
    dependencies = {
        'nvim-lua/lsp-status.nvim',
    },
    config = function()
        require('statusline').setup({
            match_colorscheme = true, -- Enable colorscheme inheritance (Default: false)
            lsp_diagnostics = false, -- Enable Native LSP diagnostics (Default: true)
        })
        vim.o.laststatus=3
    end,
}
