local wk = require("which-key")

wk.setup({})

wk.register({
  ["<leader>e"] = { "<cmd>NeoTreeFocusToggle<cr>", "Toggle Explorer" },
})

wk.register({
  ["<leader>f"] = {
    name = "Telescope",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
    g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
  },
})


wk.register({
  ["<leader>t"] = {
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
  },
})
