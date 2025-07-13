-- (~/.config/nvim/lua/nconf/remap.lua)

-- common mappings
-- * set current working directory
vim.keymap.set("n", "<leader>cd", ":cd %:p:h<CR>:pwd<CR>")
-- * navigate between buffers (left/right)
vim.keymap.set("n", "<leader>l", ":bn<CR>")
vim.keymap.set("n", "<leader>h", ":bp<CR>")
-- replace cword
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- save buffer
vim.keymap.set("n", "<leader>w", ":w<CR>")
-- exit insert mode
vim.keymap.set("i", "jj", "<ESC>")

-- briefly highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlights text when yanking",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- trim white space before saving a file
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})
