vim.keymap.set("n", "<leader>C", function()
  local filename = vim.fn.expand("%:t")

  vim.api.nvim_put({
    "/* ============================= */",
    "/* File: " .. filename .. " */",
    "/* ============================= */",
  }, "l", true, true)
end, { desc = "Insert comment with filename" })
