--[ FUNCTIONS ]]--

-- get highlight group colors
local function get_hl(group)
    return vim.api.nvim_get_hl(0, { name = group, link = false})
end

-- set highlight group colors
local function set_hl(group, colors)
    vim.api.nvim_set_hl(0, group, colors)
end

-- generic mapping function
local function map(mode, key, action, desc)
    vim.keymap.set(
        mode,
        key,
        action,
        { noremap = true, silent = true , desc = desc}
    )
end


--[[ MAPPINGS ]]--

-- mapleader set to spaces
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- update live configuration
map("n", "<leader>u", ":update | source<CR>", "update configuration")

-- list buffers
map("n", "<leader>l", ":ls<CR>", "list open buffers")

-- list buffers
map(
    "n",
    "<leader>c",
    function()
        if vim.o.colorcolumn == "0" then
            vim.o.colorcolumn = "79"
        elseif vim.o.colorcolumn == "79" then
            vim.o.colorcolumn = "119"
        else
            vim.o.colorcolumn = "0"
        end
    end,
    "toggle between none, 79 and 119 char columncolor"
)

-- debuging
-- map("n", "<leader>h", function() print("hello world") end, "")

-- xdg-open word under cursor
map("n", "<leader>o", ":silent !xdg-open '<cWORD>' &<CR>", "xdg-open")

-- makes executable
map("n", "<leader>x", ":!chmod +x %<CR>", "chmod +x current file")

-- toggle background visibility
map(
    "n",
    "<leader>t",
    function()
        if get_hl("Normal").bg == nil then
            set_hl("Normal", { bg = vim.g.bg_color })
        else
            set_hl("Normal", { bg = "none" })
        end
    end,
    "toggle background visibility"
)

-- xxd
map(
    "n",
    "<leader>b",
    ":setlocal binary | %!xxd<CR>",
    "set binary content"
)

map(
    "n",
    "<leader>B",
    ":setlocal nobinary | %!xxd -r<CR>",
    "unset binary content"
)

-- buffer position nav
map("n", "<C-S-h>", ":bnext<CR>")
map("n", "<C-S-l>", ":bprevious<CR>")

for buffer_number=1,9 do
    map(
        {"n", "i"},
        string.format("<C-A-%i>", buffer_number),
        string.format(":buffer%i<CR>", buffer_number),
        string.format("goto buffer %i", buffer_number)
    )
end

--[[ PUT STATIC TEXT ]]--

vim.keymap.set("n", "<leader>C", function()
  local filename = vim.fn.expand("%:t")

  vim.api.nvim_put({
    "# " .. filename,
    "#   - ...",
    "#   - license: ...",
    "# rodrigo-pariente",
    "#   - github: github.com/rodrigo-pariente",
    "#   - email : rodrigo_pariente@proton.me",
    "# credits",
    "#   - ...",
    "#   - ...",

  }, "l", true, true)
end, { desc = "Insert comment with filename" })

--[[ PLUGIN MAPPINGS ]]--

-- open oil file explorer
map("n", "<leader>e", ":Oil<CR>", "open file explorer")

-- open term
map("n", "<leader>z", ":lua require('FTerm').open()<CR>", "open terminal")
