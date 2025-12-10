vim.g.mapleader = " "

-- Navigation
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { desc = "Directory listing" })
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { silent = true })
vim.keymap.set("n", "<S-Tab>", ":bprevious<CR>", { silent = true })
vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { silent = true })

-- Formatting
vim.keymap.set("n", "<leader>p", function()
	require("conform").format({ async = true })
end, { desc = "Format buffer" })
vim.keymap.set("n", "<leader>w", function()
	vim.wo.wrap = not vim.wo.wrap
end, { desc = "Toggle word wrap" })

-- Spell check
vim.api.nvim_set_keymap("n", "<leader>s", ":setlocal spell!<CR>", {
	noremap = true,
	silent = true,
	desc = "Toggle spell check (en/fr)",
})
