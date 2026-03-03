local tabwidth = 2

 -- always uses spaces instead of tab characters (et).
vim.bo.expandtab = true

-- size of a hard tabstop (ts).
vim.bo.tabstop = tabwidth

-- size of an indentation (sw).
vim.bo.shiftwidth = tabwidth

-- number of spaces a <Tab> counts for. When 0, feature is off (sts).
vim.bo.softtabstop = tabwidth
