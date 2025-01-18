-- Automatically install packer.nvim if not exists
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require("packer").startup(function(use)
    -- Packer can manage itself
    use { "wbthomason/packer.nvim" }
    
    -- Your plugin list
    use { "ellisonleao/gruvbox.nvim" }
    use { "ur4ltz/surround.nvim" }
    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.5',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use { 'kyazdani42/nvim-web-devicons'}
    use {
    	  'nvim-lualine/lualine.nvim',
    	   requires = { 'kyazdani42/nvim-web-devicons'}
    	}
    	use { "fatih/vim-go" }
    	use { "modocache/move.vim"}
    	use {
    		'VonHeikemen/lsp-zero.nvim',
      		branch = 'v3.x',
      		requires = {
    		--	{'neovim/nvim-lspconfig', commit = '5e54173da4e0ffd8e9559c0a1fddfb3b7df97bec'},             -- Required
    			{'neovim/nvim-lspconfig'},             -- Required
 --   			{'nvim-lua/completion-nvim'},
    		--	{'mrcjkb/rustaceanvim'},
    			{'simrat39/rust-tools.nvim'},
    			{'williamboman/mason.nvim'},           -- Optional
    			{'williamboman/mason-lspconfig.nvim'}, -- Optional
    			{'hrsh7th/nvim-cmp'},         -- Required
    			{'hrsh7th/cmp-nvim-lsp'},     -- Required
    			{'hrsh7th/cmp-buffer'},       -- Optional
    			{'hrsh7th/vim-vsnip'},
    			{'hrsh7th/cmp-vsnip'},
    			{'hrsh7th/cmp-path'},         -- Optional
    			{'saadparwaiz1/cmp_luasnip'}, -- Optional
    			{'hrsh7th/cmp-nvim-lua'},     -- Optional
    			{
    				"L3MON4D3/LuaSnip",
    				-- follow latest release.
    				tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    				-- install jsregexp (optional!:).
    				run = "make install_jsregexp"
    			},
    			{'rafamadriz/friendly-snippets'}, -- Optional
    		}
    	}
    	use {
    	  'hrsh7th/vim-vsnip',
    	  requires = {
    		{'hrsh7th/vim-vsnip-integ'}
    	  }
    	}
    	use {"akinsho/toggleterm.nvim", tag = '*' }
    	use "terrortylor/nvim-comment"
    	use "CreaturePhil/vim-handmade-hero"
    	use "rafamadriz/friendly-snippets"
    	-- use({
    	--       "hrsh7th/nvim-cmp",
    	--       requires = {
    	--         { "hrsh7th/cmp-nvim-lsp" },
    	--         { "hrsh7th/cmp-nvim-lua" },
    	--         { "hrsh7th/cmp-buffer" },
    	--         { "hrsh7th/cmp-path" },
    	--         { "hrsh7th/cmp-cmdline" },
    	--         { "hrsh7th/vim-vsnip" },
    	--         { "hrsh7th/cmp-vsnip" },
    	-- 	{'Thomashighbaugh/nvim-forge'},
    	--         { "hrsh7th/vim-vsnip-integ" },
    	--         { "f3fora/cmp-spell", { "hrsh7th/cmp-calc" }, { "hrsh7th/cmp-emoji" } },
    	--       },
    	--     })
    
        use {
            'akinsho/git-conflict.nvim',
            tag = "*",
            config = function()
                require('git-conflict').setup {
                    default_mappings = true,
                    default_commands = true,
                    disable_diagnostics = false,
                    list_opener = 'copen',
                    highlights = {
                        incoming = 'MyIncoming',
                        current = 'MyCurrent',
                    }
                }
            end
        }
    	--use "lervag/vimtex"
    	use "mattn/emmet-vim"
    	-- install without yarn or npm
    	-- markdown preview
    	use({
    		"iamcco/markdown-preview.nvim",
    		run = function() vim.fn["mkdp#util#install"]() end,
    	})
    
    	 -- use  
    	 --   {
    	 --       "zbirenbaum/copilot-cmp",
    	 --       config = function()
    	 --           require("copilot_cmp").setup()
    	 --       end,
    	 --   }
    	 --   use "CopilotC-Nvim/CopilotChat.nvim"
    	
    	 use {
    	   'nvim-tree/nvim-tree.lua',
    	   requires = {
    	 	'nvim-tree/nvim-web-devicons', -- optional
    	   },
    	 }
    
    	use {'christoomey/vim-tmux-navigator', lazy = false,}
    	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
    	use {'ray-x/go.nvim', 
    		requires = {
    			'ray-x/guihua.lua' -- recommended if need floating window support
    	}}
    	use {
    		'lewis6991/gitsigns.nvim'
    	}
		use {
			'folke/todo-comments.nvim',
			requires = {
				'nvim-lua/plenary.nvim',
 				'ibhagwan/fzf-lua'
			}
		}

		use({
		    'maxandron/goplements.nvim',
		    requires = 'nvim-treesitter/nvim-treesitter',
		    ft = 'go',
		    config = function()
		        require('goplements').setup({
		            prefix = {
		                interface = "implemented by: ",
		                struct = "implements: "
		            },
		            display_package = false,
		            namespace_name = "goplements",
		            hl = "Goplements"
		        })
		    end
		})
		use {
			'crusj/structrue-go.nvim',
			branch = "main"
		}
	--	use 'ggandor/leap.nvim'
		use 'folke/flash.nvim'
		use 'karb94/neoscroll.nvim'
		use {
		    "ThePrimeagen/refactoring.nvim",
		    requires = {
		        {"nvim-lua/plenary.nvim"},
		        {"nvim-treesitter/nvim-treesitter"}
		    }
		}
 		use 'mg979/vim-visual-multi'
    -- ... [Rest of your plugin declarations]

    -- After declaring plugins, configure them
    --require("plugins.configs.lsp").setup()
	-- lsp
    require("plugins.configs.lsp")
	-- plugin
    require("plugins.configs.cmp-setup")
    require("plugins.configs.comment")
    require("plugins.configs.completion")
 --   require("plugins.configs.copilot")
    require("plugins.configs.dap")
    require("plugins.configs.git-conflicts")
    require("plugins.configs.gitsigns")
    require("plugins.configs.vim-visual-multi")
    require("plugins.configs.lualine")
    require("plugins.configs.markdown")
    require("plugins.configs.mason")
    require("plugins.configs.nvim-tree")
    require("plugins.configs.rust")
    require("plugins.configs.surround")
    require("plugins.configs.telescope")
    require("plugins.configs.terminal")
    require("plugins.configs.theme")
    require("plugins.configs.treesitter")
	require("plugins.configs.todo")
	require("plugins.configs.go-struct")
	require("plugins.configs.flash")
	require("plugins.configs.util")
	require("plugins.configs.refactorings")
	--require("plugins.configs.leap")
end)
