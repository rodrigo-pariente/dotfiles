-- init.lua
--   - my neovim init configuration file
--   - ...
-- rodrigo-pariente
--   - github: github.com/rodrigo-pariente
--   - email : rodrigo_pariente@proton.me

--[[  REQUIREMENTS ]]--

-- user keybindings
require("config.mappings")

-- lazy plugins manager
require("config.lazy")


--[[ APPEARENCE ]]--

-- rounded something
vim.opt.winborder = "rounded"

-- transparent background
vim.g.bg_color = vim.api.nvim_get_hl(
    0, { name = "Normal", link = false}
).bg -- store colorscheme background
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "StatusLine", { bg = "none" })

-- colorcolumn appearence
vim.opt.colorcolumn = "0"
vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#181818" })

-- hide intro message
vim.opt.shortmess:append({ I = true })

-- show relative numbers for each line besides the cursors line
vim.opt.relativenumber = true
vim.opt.number = true

-- hide tildes in end-of-buffer
vim.opt.fillchars = { eob = " " }

-- show updated listchars
vim.opt.listchars = { trail = '·', tab = ' \\ ', nbsp = '+' }
vim.opt.list = true

-- hide netrw banner
vim.g.netrw_banner = 0


--[[ SYNTAX ]]--

-- space>tab configuration
local tabwidth = 4

-- spaces instead of tabs
vim.opt.expandtab = true

-- shiftwidth of 4; bo = buffer options
vim.bo.shiftwidth = tabwidth

-- size of a hard tabstop
vim.bo.tabstop = tabwidth

-- size of a soft tabstop
vim.bo.softtabstop = tabwidth

-- disable automatic comment on newline
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
        vim.opt_local.formatoptions:remove({ "c", "r", "o" })
        end,
})


--[[ BEHAVIOUR ]]--

-- vim has netrw directory as user directory
vim.g.netrw_keepdir = 0
