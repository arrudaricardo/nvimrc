local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
    install_path })
end

---@diagnostic disable: undefined-global
require('packer').init({
  max_jobs = 20,
})

return require('packer').startup(function()
  use_rocks({ 'penlight', 'promise-lua' })

  use 'wbthomason/packer.nvim'

  use({
    'williamboman/nvim-lsp-installer',
    rocks = { 'promise-lua' },
    requires = {
      'neovim/nvim-lspconfig',
      'onsails/lspkind-nvim', -- vscode-like pictograms for neovim lsp completion items
      'MunifTanjim/nui.nvim',
    },
    config = function()
      require("nvim.plugins.lsp-installer")
      require("nvim.plugins.lsp")
    end,
  })

  -- A completion plugin for neovim coded in Lua.
  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-buffer", -- nvim-cmp source for buffer words.
      "hrsh7th/cmp-nvim-lsp", -- nvim-cmp source for neovim's built-in language server client.
      'hrsh7th/cmp-nvim-lua', -- nvim-cmp source for nvim lua
      'octaltree/cmp-look',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-calc', -- nvim-cmp source for math calculation.
      'f3fora/cmp-spell',-- spell source for nvim-cmp based on vim's spellsuggest.
      'hrsh7th/cmp-emoji',
      --
      'saadparwaiz1/cmp_luasnip',
      'quangnguyen30192/cmp-nvim-ultisnips',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
       require("nvim.plugins.cmp")
    end,
  })


  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
  use({
    'jose-elias-alvarez/null-ls.nvim',
    config = function()
      require('null-ls').setup({
        sources = {
          require("null-ls").builtins.formatting.stylua,
          require("null-ls").builtins.diagnostics.eslint,
          require("null-ls").builtins.completion.spell,
          require("null-ls").builtins.diagnostics.luacheck,
          require("null-ls").builtins.diagnostics.mypy,
          require("null-ls").builtins.diagnostics.tsc,
        },
      })
    end,
  })

  -- markdown preview
  -- use({
  --     'iamcco/markdown-preview.nvim',
  --     run = 'cd app && yarn install',
  --     config = function()
  --         require('nvim.plugins.markdown-preview')
  --     end,
  -- })

  ----------------------------------------------------------------------
  --                            DEBUGGING                             --
  ----------------------------------------------------------------------
  -- use({
  --     'mfussenegger/nvim-dap',
  --     requires = {
  --         {
  --             'rcarriga/nvim-dap-ui',
  --             config = function()
  --                 require('nvim.plugins.nvim-dap-ui')
  --             end,
  --         },
  --         'theHamsta/nvim-dap-virtual-text',
  --     },
  --     config = function()
  --         require('dap').set_log_level('TRACE')
  --     end,
  -- })

  -- File explorer and its icons
  use({
    'nvim-neo-tree/neo-tree.nvim',
    branch = "v2.x",
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
      {
        's1n7ax/nvim-window-picker',
        tag = 'v1.*',
        config = function()
          require 'window-picker'.setup()
        end,
      }
    },
    config = function()
      require("nvim.plugins.neotree")
    end,
  })



  -- git file changes
  use({
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('nvim.plugins.gitsigns')
    end,
  })

  use({ "folke/which-key.nvim", config = function() require('nvim.plugins.whichkey') end })

  use({
    's1n7ax/nvim-lazy-inner-block',
    config = function()
      require('nvim-lazy-inner-block').setup()
    end
  })

  -- -- auto pair brackets
  use({
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  })

  -- handle pairs of text objects
  use({ 'tpope/vim-surround' })

  -- syntax highlighting
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require 'nvim-treesitter.configs'.setup {
        -- A list of parser names, or "all"
        ensure_installed = { "lua", "rust", "typescript", 'javascript', 'python' },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,


        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
      }
    end,
  })

  -- The neovim tabline plugin.
  use {
    'romgrk/barbar.nvim',
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function ()
     require("nvim.plugins.barbar") 
    end
  }

  -- -- treesitter text objects
  use({
    'nvim-treesitter/nvim-treesitter-textobjects',
    require = {
      'nvim-treesitter/nvim-treesitter',
    },
  })

  --A neovim lua plugin to help easily manage multiple terminal windows
  use {"akinsho/toggleterm.nvim", tag = 'v2.*',
    config = function()
      require("nvim.plugins.toggleterm")
    end
  }

  use({
    'winston0410/commented.nvim',
    requires = 'JoosepAlviste/nvim-ts-context-commentstring',
    config = function()
      require("commented").setup({
        enable_autocmd = true,
        comment_padding = " ", -- padding between starting and ending comment symbols
        keybindings = { n = "gc", v = "gc", nl = "gcc" }, -- what key to toggle comment, nl is for mapping <leader>c$, just like dd for d
        prefer_block_comment = false, -- Set it to true to automatically use block comment when multiple lines are selected
        set_keybindings = true, -- whether or not keybinding is set on setup
        ex_mode_cmd = "Comment" -- command for commenting in ex-mode, set it null to not set the command initially.
      })
    end,
  })

  use({
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup()
    end,
  })

  -- An always-on highlight for a unique character in every word on a line to help you use f, F and family.
  --  use({ 'unblevable/quick-scope' })

  -- use({ 'psliwka/vim-smoothie' })

  -- -- motion
  -- use({
  --     'phaazon/hop.nvim',
  --     as = 'hop',
  --     config = function()
  --         require('nvim.plugins.hop')
  --     end,
  -- })


--  use { "beauwilliams/focus.nvim", config = function() require("focus").setup() end }

  -- use({
  --     'sindrets/winshift.nvim',
  --     config = function()
  --         require('nvim.plugins.winshift')
  --     end,
  -- })

  -- -- status line
  use({
    'hoob3rt/lualine.nvim',
    requires = {
      'kyazdani42/nvim-web-devicons',
      opt = true,
    },
    config = function()
      require('lualine').setup()
    end,
    })

  -- -- lib to pick window from currently opened windows
  -- use({
  --     's1n7ax/nvim-window-picker',
  --     -- tag = 'v1.*',
  --     config = function()
  --         require('nvim.plugins.window-picker')
  --     end,
  -- })

  -- -- notification popup library
  -- use({
  --     'rcarriga/nvim-notify',
  --     config = function()
  --         require('nvim.plugins.notify')
  --     end,
  -- })

  -- sets the indentation automatically
  use({ 'zsugabubus/crazy8.nvim' })

  -- beautiful vim.ui alternatives
  use({
    'stevearc/dressing.nvim',
    requires = { 'nvim-telescope/telescope.nvim', 'MunifTanjim/nui.nvim' },
    config = function()
      require('dressing').setup({})
    end,
  })

  -- highlights the colors defined in the buffer with actual color
  use({
    'norcalli/nvim-colorizer.lua',
    opt = true,
    cmd = {
      'ColorizerAttachToBuffer',
      'ColorizerDetachFromBuffer',
      'ColorizerReloadAllBuffers',
      'ColorizerToggle',
    },
  })

  -- popup menu
  -- use({ 'meznaric/conmenu' })

  -- spell check diagnostic
  use({
    'lewis6991/spellsitter.nvim',
    requires = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('spellsitter').setup()
    end,
  })


  use({
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      {
       'nvim-telescope/telescope-fzf-native.nvim',
        run = 'make',
      },
    },
    config = function()
     require('nvim.plugins.telescope')
    end,
  })


  use {
    'tiagovla/tokyodark.nvim',
    config = function()
      vim.cmd("colorscheme tokyodark")
    end
  }

  -- magit for neovim
  --
  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function ()
     require('neogit').setup({})
    end
  }


  -- reduce the start up time
  use({ 'lewis6991/impatient.nvim' })

  -- startup time tracker
  use({ 'dstein64/vim-startuptime' })
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins

  if packer_bootstrap then
    require('packer').sync()
  end

end)
