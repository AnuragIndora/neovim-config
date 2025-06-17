return {
    -- Colorscheme
    {
        "nyoom-engineering/oxocarbon.nvim",
        lazy = false,  -- This ensures the theme is loaded immediately
        priority = 1000,  -- High priority to load the theme first
        config = function()
            vim.cmd("colorscheme oxocarbon")  -- Set the colorscheme
        end
    },

    -- LSP & Mason
    {
        "williamboman/mason.nvim",
        config = true
    },

    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({automatic_installation = true})
        end
    },

    -- Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets"
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            require("luasnip.loaders.from_vscode").lazy_load()

            cmp.setup(
                {
                    snippet = {
                        expand = function(args)
                            luasnip.lsp_expand(args.body)
                        end
                    },
                    mapping = cmp.mapping.preset.insert(
                        {
                            ["<Tab>"] = cmp.mapping.select_next_item(),
                            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                            ["<CR>"] = cmp.mapping.confirm({select = true})
                        }
                    ),
                    sources = {
                        {name = "nvim_lsp"},
                        {name = "luasnip"}
                    }
                }
            )
        end
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = {"c", "cpp", "lua", "python", "java", "html", "css", "javascript", "typescript"},
            highlight = {enable = true},
            indent = {enable = true},
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    },

    -- Auto Tag
    {
        "windwp/nvim-ts-autotag",
        ft = { "html", "xml", "javascript", "typescript", "javascriptreact", "typescriptreact" },
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require("nvim-ts-autotag").setup()
        end
    },

    -- Java
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = function()
            local jdtls = require("jdtls")
            local home = os.getenv("HOME")
            local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
            jdtls.start_or_attach(
                {
                    cmd = {"jdtls"},
                    root_dir = require("jdtls.setup").find_root({".git", "mvnw", "gradlew"}),
                    workspace_folder = workspace_dir
                }
            )
        end
    },

    -- C++ Competitive Programming
    {
        "p00f/clangd_extensions.nvim",
        config = function()
            require("clangd_extensions").setup({})
        end
    },

    {
        "xeluxee/competitest.nvim",
        dependencies = {"MunifTanjim/nui.nvim"},
        config = function()
            require("competitest").setup({runner_ui = {interface = "split"}})
        end
    },

    -- TypeScript tools
    {
        "pmizio/typescript-tools.nvim",
        dependencies = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"},
        opts = {
            settings = {
                tsserver_file_preferences = {
                    includeInlayParameterNameHints = "all",
                    includeCompletionsForModuleExports = true
                }
            }
        }
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
        require("telescope").setup{}
        end,
    },

    -- Auto Paring 
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    },

    -- lua line configration 
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", opt = true },  -- Optional, for file icons
        config = function()
            require('lualine').setup {
                options = {
                    theme = 'oxocarbon',  -- Use the Oxocarbon theme for lualine
                    section_separators = '',
                    component_separators = '',
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff' },
                    lualine_c = { 'filename' },
                    lualine_x = { 'encoding', 'fileformat', 'filetype' },
                    lualine_y = { 'location' },
                    lualine_z = { 'progress' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
                extensions = {},
            }
        end
    }
}
