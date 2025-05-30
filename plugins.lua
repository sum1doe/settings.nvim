return {
    {
"adigitoleo/haunt.nvim",
"ggandor/leap.nvim",
"neovim/nvim-lspconfig",
"rcarriga/nvim-notify",
"Mofiqul/vscode.nvim",
"folke/which-key.nvim",
{
    "rachartier/tiny-glimmer.nvim",
    event = "VeryLazy",
    priority = 10, -- Needs to be a really low priority, to catch others plugins keybindings.
    opts = {
        -- your configuration
    },
},
        "forest-nvim/maple.nvim",
        config = function()
            require("maple").setup({
                    --config
            })
        end
        },
    {
        'stevearc/oil.nvim',
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = {{"echasnovski/mini.icons", opts = {}}}
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.8',
        -- or                              , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = function()
            require("nvim-treesitter.install").update({ with_sync = true })()
        end,
    },
  {'stevearc/conform.nvim', opts = {}}
}
