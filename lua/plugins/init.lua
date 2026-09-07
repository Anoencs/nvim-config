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
    	use { "modocache/move.vim"}

    	-- Native LSP stack (no lsp-zero)
    	use { 'neovim/nvim-lspconfig' }
    	use { 'williamboman/mason.nvim' }
    	use { 'williamboman/mason-lspconfig.nvim' } -- v2 for Neovim 0.11+
    	use { 'hrsh7th/cmp-nvim-lsp' } -- needs Neovim 0.11+ (client:request)
    	use { 'hrsh7th/nvim-cmp' }
    	use { 'hrsh7th/cmp-buffer' }
    	use { 'hrsh7th/cmp-path' }
    	use { 'hrsh7th/cmp-nvim-lua' }
    	use { 'saadparwaiz1/cmp_luasnip' }
    	use {
    		'L3MON4D3/LuaSnip',
    		tag = 'v2.*',
    		run = 'make install_jsregexp',
    	}
    	use { 'rafamadriz/friendly-snippets' }
    	use {"akinsho/toggleterm.nvim", tag = '*' }
    	use "terrortylor/nvim-comment"
    	use "CreaturePhil/vim-handmade-hero"
        use {
            'akinsho/git-conflict.nvim',
            tag = "*",
        }
    	--use "lervag/vimtex"
    	use "mattn/emmet-vim"
    	-- install without yarn or npm
    	-- markdown preview
    	use({
    		"iamcco/markdown-preview.nvim",
    		run = function() vim.fn["mkdp#util#install"]() end,
    	})
    
    	
    	 use {
    	   'nvim-tree/nvim-tree.lua',
    	   requires = {
    	 	'nvim-tree/nvim-web-devicons', -- optional
    	   },
    	 }
    
    	use {'christoomey/vim-tmux-navigator', lazy = false,}
    	use { "nvim-neotest/nvim-nio" }
    	use { "mfussenegger/nvim-dap" }
    	use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
    	use {'ray-x/go.nvim', 
    		requires = {
    			'ray-x/guihua.lua' 
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
		use 'folke/flash.nvim'
		use 'karb94/neoscroll.nvim'
		use {
		    "ThePrimeagen/refactoring.nvim",
		    -- Latest needs nvim 0.12 + lewis6991/async.nvim; keep plenary-based API
		    commit = "fa781bd",
		    requires = {
		        {"nvim-lua/plenary.nvim"},
		        {"nvim-treesitter/nvim-treesitter"}
		    }
		}
		use 'nomnivore/ollama.nvim'
		use 'mg979/vim-visual-multi'
  		
		use {
			 "epwalsh/obsidian.nvim",
  			tag = "*",  
  			requires = {
    			"nvim-lua/plenary.nvim",
			}
		}

		use 'RRethy/vim-illuminate'
		

		use {
		    'anuvyklack/pretty-fold.nvim',
			after = {'nvim-treesitter'},
		    requires = {
		        'anuvyklack/fold-preview.nvim',
		        'anuvyklack/keymap-amend.nvim', -- Required for fold-preview
		    },
		    config = function()
		        require("plugins.configs.fold").setup()
		    end
		}
		use "github/copilot.vim"
		use {
			"deathbeam/CopilotChat.nvim",
			branch = "tools",
			requires = {
				{ "nvim-lua/plenary.nvim" },
			},
			run = "make tiktoken",
		}
		use {
  			"windwp/nvim-ts-autotag",
  			config = function()
    			require("nvim-ts-autotag").setup()
  			end
		}


		-- use {
		-- 	"echaya/neowiki.nvim",
		-- 	config = function()
		-- 	require('neowiki').setup({
		--  		     wiki_dirs = {
		--    			     { name = "Work", path = "~/wiki/work" },
		--    			     { name = "Personal", path = "~/wiki/personal" },
		--    			   },
		--    			 })
		--    			
		--    			 vim.keymap.set('n', '<leader>ww', '<cmd>lua require("neowiki").open_wiki()<cr>', { desc = "Open Wiki" })
		--    			 vim.keymap.set('n', '<leader>wW', '<cmd>lua require("neowiki").open_wiki_floating()<cr>', { desc = "Open Wiki in Floating Window" })
		--    			 vim.keymap.set('n', '<leader>wT', '<cmd>lua require("neowiki").open_wiki_new_tab()<cr>', { desc = "Open Wiki in Tab" })
		-- 	end
		-- }
		    
	-- lsp (mason before lsp)
    local function safe_require(mod)
      local ok, err = pcall(require, mod)
      if not ok then
        vim.schedule(function()
          vim.notify("Failed to load " .. mod .. ": " .. tostring(err), vim.log.levels.WARN)
        end)
      end
    end

    safe_require("plugins.configs.theme")
    safe_require("plugins.configs.mason")
    safe_require("plugins.configs.lsp")
    safe_require("plugins.configs.completion")
    safe_require("plugins.configs.comment")
    safe_require("plugins.configs.obsidians")
    safe_require("plugins.configs.illuminate")
    safe_require("plugins.configs.dap")
    safe_require("plugins.configs.git-conflicts")
    safe_require("plugins.configs.gitsigns")
    safe_require("plugins.configs.lualine")
    safe_require("plugins.configs.markdown")
    safe_require("plugins.configs.nvim-tree")
    safe_require("plugins.configs.rust")
    safe_require("plugins.configs.surround")
    safe_require("plugins.configs.telescope")
    safe_require("plugins.configs.terminal")
    safe_require("plugins.configs.treesitter")
    safe_require("plugins.configs.todo")
    safe_require("plugins.configs.go-struct")
    safe_require("plugins.configs.flash")
    safe_require("plugins.configs.util")
    safe_require("plugins.configs.refactorings")
end)
