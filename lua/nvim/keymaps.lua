-- Import & assign the map() function from the utils module
local map = require("nvim.utils").map

-- Insert Mode
map("i", "jj", "<ESC>")
map("i", "jk", "<ESC>")
map("i", "kj", "<ESC>")

-- Move current line / block with Alt-j/k ala vscode.
map("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("i", "<A-k>", "<Esc>:m .-2<CR>==gi")
-- Move current line / block with Alt-j/k ala vscode.

-- navigation
map("i", "<A-Up>",  "<C-\\><C-N><C-w>k")
map("i", "<A-Down>", "<C-\\><C-N><C-w>j")
map("i", "<A-Left>", "<C-\\><C-N><C-w>h")
map("i", "<A-Right>", "<C-\\><C-N><C-w>l")


-- Visual Block Mode
--
-- Move selected line / block of text in visual mode
map("x", "K", ":move '<-2<CR>gv-gv")
map("x", "J", ":move '>+1<CR>gv-gv")
-- Move current line / block with Alt-j/k ala vscode.
map("x", "<A-j>", ":m '>+1<CR>gv-gv")
map("x", "<A-k>", ":m '<-2<CR>gv-gv")


-- Normal Mode
--
-- Better window movement
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Resize with arrows
map("n", "<C-Up>" , ":resize -2<CR>")
map("n", "<C-Down>" , ":resize +2<CR>")
map("n", "<C-Left>" , ":vertical resize -2<CR")
map("n", "<C-Right>" , ":vertical resize +2<CR>")


-- Tab switch buffer
map("n", "<S-l>" , ":BufferLineCycleNext<CR>")
map("n", "<S-h>" , ":BufferLineCyclePrev<CR>")

-- Move current line / block with Alt-j/k a la vscode.
map("n", "<A-j>" , ":m .+1<CR>==")
map("n", "<A-k>" , ":m .-2<CR>==")

-- QuickFix
map("n", "]q" , ":cnext<CR>")
map("n", "[q" , ":cprev<CR>")
-- map("n", "<C-q>" , ":call QuickFixToggle()<CR>")

map("n", "<Leader>n", ":nohlsearch<CR>", { silent = true })
map("n", "<Leader>?", ":WhichKey <CR>")
