require("nvchad.mappings")

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map({ "n", "v" }, "<C-s>", "<cmd> w <cr>")
map({ "i" }, "<C-s>", "<Esc><cmd> w <cr>")

-- Move lines up/down
map("n", "<A-Down>", ":m .+1<CR>", { desc = "Move line down" })
map("n", "<A-j>", ":m .+1<CR>", { desc = "Move line down" })
map("n", "<A-Up>", ":m .-2<CR>", { desc = "Move line up" })
map("n", "<A-k>", ":m .-2<CR>", { desc = "Move line up" })
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move line up" })

-- code runner
map({ "n", "i" }, "<A-S-n>", function()
    require("nvchad.term").runner({
        id = "boo",
        pos = "sp",

        cmd = function()
            local file = vim.fn.expand("%")

            local ft_cmds = {
                python = "python3 " .. file,
                cpp = "clear && g++ -o out " .. file .. " && ./out",
            }

            return ft_cmds[vim.bo.ft]
        end,
    })
end, { desc = "Run code file" })

-- code snap
map("v", "<leader>sc", function()
    require("nvim-silicon").clip()
end, { desc = "Code snap to clipboard" })
map("v", "<leader>sf", function()
    require("nvim-silicon").file()
end, { desc = "Code snap to file" })
