vim.g.mapleader = " "

function toggleRelative() 
    vim.opt.relativenumber = not vim.opt.relativenumber:get()
end

vim.keymap.set("n", "<leader>r", toggleRelative)
