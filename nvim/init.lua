-- Automatically install packer.nvim if it doesn't exist
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim' if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- disable netrw at the very start of your init.lua
--vim.g.loaded_netrw = 1
--vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Add packer.nvim to the runtime path
-- Set the packpath to include the packer.nvim directory
print("Welcome Anoencs! How are you doing today?")
vim.g.mapleader = " "

require("packer").startup(function(use)
	use { "wbthomason/packer.nvim" }
	use { "ellisonleao/gruvbox.nvim" }
	use {"ur4ltz/surround.nvim"}
	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.5',
		 requires = { {'nvim-lua/plenary.nvim'} }
	}
	use {
	  'nvim-lualine/lualine.nvim',
	   requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use { "fatih/vim-go" }
	use {
		'VonHeikemen/lsp-zero.nvim',
  		branch = 'v3.x',
  		requires = {
			{'neovim/nvim-lspconfig'},             -- Required
			{'nvim-lua/completion-nvim'},
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
			{'L3MON4D3/LuaSnip'},             -- Required
			{'rafamadriz/friendly-snippets'}, -- Optional
		}
	}
	use {"akinsho/toggleterm.nvim", tag = '*' }
	use "terrortylor/nvim-comment"
	use "CreaturePhil/vim-handmade-hero"
	use({
      "hrsh7th/nvim-cmp",
      requires = {
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-nvim-lua" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "hrsh7th/cmp-cmdline" },
        { "hrsh7th/vim-vsnip" },
        { "hrsh7th/cmp-vsnip" },
        { "hrsh7th/vim-vsnip-integ" },
        { "f3fora/cmp-spell", { "hrsh7th/cmp-calc" }, { "hrsh7th/cmp-emoji" } },
      },
    })
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
                    incoming = 'DiffAdd',
                    current = 'DiffText',
                }
            }
        end
    }
	use "lervag/vimtex"
	use "mattn/emmet-vim"
-- install without yarn or npm
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
end)

----tmux ------

vim.keymap.set("n", "C-h", ":TmuxNavigateLeft<CR>")
vim.keymap.set("n", "C-l", ":TmuxNavigateRight<CR>")
vim.keymap.set("n", "C-j", ":TmuxNavigateDown<CR>")
vim.keymap.set("n", "C-k", ":TmuxNavigateUp<CR>")
--- mason ----
require("mason").setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require("mason-lspconfig").setup()
-- nvim-tree 
-- mapping for nvim-tree
local function my_nvim_tree_on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- BEGIN_DEFAULT_ON_ATTACH
  ----- copy, cut, delete file 
  vim.keymap.set('n', 'x',       api.fs.cut,                          opts('Cut'))
  vim.keymap.set('n', 'c',       api.fs.copy.node,                    opts('Copy'))
  vim.keymap.set('n', 'd',       api.fs.remove,                       opts('Delete'))
  vim.keymap.set('n', 'p',       api.fs.paste,                        opts('Paste'))

  ----- usefull
  vim.keymap.set('n', 'a',       api.fs.create,                       opts('Create'))
  vim.keymap.set('n', 'e',       api.fs.rename_basename,              opts('Rename: Basename'))
  vim.keymap.set('n', 'r',       api.fs.rename,                       opts('Rename'))
  vim.keymap.set('n', 'R',       api.tree.reload,                     opts('Refresh'))
  vim.keymap.set('n', '<CR>',    api.node.open.edit,                  opts('Open'))
  vim.keymap.set('n', '<Tab>',   api.node.open.preview,               opts('Open Preview'))
  vim.keymap.set('n', '<C-v>',   api.node.open.vertical,              opts('Open: Vertical Split'))

  ----- navigation
  vim.keymap.set('n', '<C-o>',   api.tree.change_root_to_node,        opts('CD'))
  vim.keymap.set('n', '-',       api.tree.change_root_to_parent,      opts('Up'))
  vim.keymap.set('n', '>',       api.node.navigate.sibling.next,      opts('Next Sibling'))
  vim.keymap.set('n', '<',       api.node.navigate.sibling.prev,      opts('Previous Sibling'))


  ----- filter
  vim.keymap.set('n', 'f',       api.live_filter.start,               opts('Filter'))
  vim.keymap.set('n', 'F',       api.live_filter.clear,               opts('Clean Filter'))
  vim.keymap.set('n', 'H',       api.tree.toggle_hidden_filter,       opts('Toggle Filter: Dotfiles'))
  vim.keymap.set('n', 'I',       api.tree.toggle_gitignore_filter,    opts('Toggle Filter: Git Ignore'))
  ----- bookmark
  --jk
  vim.keymap.set('n', 'bd',      api.marks.bulk.delete,               opts('Delete Bookmarked'))
  vim.keymap.set('n', 'bmv',     api.marks.bulk.move,                 opts('Move Bookmarked'))
  vim.keymap.set('n', 'm',       api.marks.toggle,                    opts('Toggle Bookmark'))

  ---- Something 
  vim.keymap.set('n', '.',       api.node.run.cmd,                    opts('Run Command'))
  ----- Expand and collapse folder
  vim.keymap.set('n', 'E',       api.tree.expand_all,                 opts('Expand All'))
  vim.keymap.set('n', 'W',       api.tree.collapse_all,               opts('Collapse'))
  ----- helper
  vim.keymap.set('n', 'g?',      api.tree.toggle_help,                opts('Help'))


  -- vim.keymap.set('n', 'bt',      api.marks.bulk.trash,                opts('Trash Bookmarked'))
  -- vim.keymap.set('n', 'D',       api.fs.trash,                        opts('Trash'))
  -- vim.keymap.set('n', '<C-e>',   api.node.open.replace_tree_buffer,   opts('Open: In Place'))
  -- vim.keymap.set('n', '<C-k>',   api.node.show_info_popup,            opts('Info'))
  -- vim.keymap.set('n', '<C-r>',   api.fs.rename_sub,                   opts('Rename: Omit Filename'))
  -- vim.keymap.set('n', '<C-t>',   api.node.open.tab,                   opts('Open: New Tab'))
  -- vim.keymap.set('n', '<C-x>',   api.node.open.horizontal,            opts('Open: Horizontal Split'))
  -- vim.keymap.set('n', '<BS>',    api.node.navigate.parent_close,      opts('Close Directory'))
  -- vim.keymap.set('n', 'B',       api.tree.toggle_no_buffer_filter,    opts('Toggle Filter: No Buffer'))
  -- vim.keymap.set('n', 'C',       api.tree.toggle_git_clean_filter,    opts('Toggle Filter: Git Clean'))
  -- vim.keymap.set('n', '[c',      api.node.navigate.git.prev,          opts('Prev Git'))
  -- vim.keymap.set('n', ']c',      api.node.navigate.git.next,          opts('Next Git'))
  -- vim.keymap.set('n', ']e',      api.node.navigate.diagnostics.next,  opts('Next Diagnostic'))
  -- vim.keymap.set('n', '[e',      api.node.navigate.diagnostics.prev,  opts('Prev Diagnostic'))
  -- vim.keymap.set('n', 'gy',      api.fs.copy.absolute_path,           opts('Copy Absolute Path'))
  -- vim.keymap.set('n', 'J',       api.node.navigate.sibling.last,      opts('Last Sibling'))
  -- vim.keymap.set('n', 'K',       api.node.navigate.sibling.first,     opts('First Sibling'))
  -- vim.keymap.set('n', 'o',       api.node.open.edit,                  opts('Open'))
  -- vim.keymap.set('n', 'O',       api.node.open.no_window_picker,      opts('Open: No Window Picker'))
  -- vim.keymap.set('n', 'P',       api.node.navigate.parent,            opts('Parent Directory'))
  -- vim.keymap.set('n', 'q',       api.tree.close,                      opts('Close'))
  -- vim.keymap.set('n', 's',       api.node.run.system,                 opts('Run System'))
  -- vim.keymap.set('n', 'S',       api.tree.search_node,                opts('Search'))
  -- vim.keymap.set('n', 'u',       api.fs.rename_full,                  opts('Rename: Full Path'))
  -- vim.keymap.set('n', 'U',       api.tree.toggle_custom_filter,       opts('Toggle Filter: Hidden'))
  -- vim.keymap.set('n', 'y',       api.fs.copy.filename,                opts('Copy Name'))
  -- vim.keymap.set('n', 'Y',       api.fs.copy.relative_path,           opts('Copy Relative Path'))
  -- END_DEFAULT_ON_ATTACH
end

require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS
  on_attach = my_nvim_tree_on_attach,
  hijack_cursor = false,
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  root_dirs = {},
  prefer_startup_root = false,
  sync_root_with_cwd = false,
  reload_on_bufenter = false,
  respect_buf_cwd = false,
  select_prompts = false,
  sort = {
	sorter = "name",
	folders_first = true,
	files_first = false,
  },
  view = {
	centralize_selection = false,
	cursorline = true,
	debounce_delay = 15,
	side = "left",
	preserve_window_proportions = false,
	number = false,
	relativenumber = false,
	signcolumn = "yes",
	width = 35,
	float = {
	  enable = false,
	  quit_on_focus_loss = true,
	  open_win_config = {
		relative = "editor",
		border = "rounded",
		width = 30,
		height = 30,
		row = 1,
		col = 1,
	  },
	},
  },
  renderer = {
	add_trailing = false,
	group_empty = false,
	full_name = false,
	root_folder_label = ":~:s?$?/..?",
	indent_width = 2,
	special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
	symlink_destination = true,
	highlight_git = false,
	highlight_diagnostics = false,
	highlight_opened_files = "none",
	highlight_modified = "none",
	highlight_bookmarks = "none",
	highlight_clipboard = "name",
	indent_markers = {
	  enable = false,
	  inline_arrows = true,
	  icons = {
		corner = "└",
		edge = "│",
		item = "│",
		bottom = "─",
		none = " ",
	  },
	},
	icons = {
	  web_devicons = {
		file = {
		  enable = true,
		  color = true,
		},
		folder = {
		  enable = false,
		  color = true,
		},
	  },
	  git_placement = "before",
	  modified_placement = "after",
	  diagnostics_placement = "signcolumn",
	  bookmarks_placement = "signcolumn",
	  padding = " ",
	  symlink_arrow = " ➛ ",
	  show = {
		file = true,
		folder = true,
		folder_arrow = true,
		git = true,
		modified = true,
		diagnostics = true,
		bookmarks = true,
	  },
	  glyphs = {
		default = "",
		symlink = "",
		bookmark = "󰆤",
		modified = "●",
		folder = {
		  arrow_closed = "",
		  arrow_open = "",
		  default = "",
		  open = "",
		  empty = "",
		  empty_open = "",
		  symlink = "",
		  symlink_open = "",
		},
		git = {
		  unstaged = "✗",
		  staged = "✓",
		  unmerged = "",
		  renamed = "➜",
		  untracked = "★",
		  deleted = "",
		  ignored = "◌",
		},
	  },
	},
  },
  hijack_directories = {
	enable = true,
	auto_open = true,
  },
  update_focused_file = {
	enable = false,
	update_root = false,
	ignore_list = {},
  },
  system_open = {
	cmd = "",
	args = {},
  },
  git = {
	enable = true,
	show_on_dirs = true,
	show_on_open_dirs = true,
	disable_for_dirs = {},
	timeout = 400,
	cygwin_support = false,
  },
  diagnostics = {
	enable = false,
	show_on_dirs = false,
	show_on_open_dirs = true,
	debounce_delay = 50,
	severity = {
	  min = vim.diagnostic.severity.HINT,
	  max = vim.diagnostic.severity.ERROR,
	},
	icons = {
	  hint = "",
	  info = "",
	  warning = "",
	  error = "",
	},
  },
  modified = {
	enable = false,
	show_on_dirs = true,
	show_on_open_dirs = true,
  },
  filters = {
	git_ignored = true,
	dotfiles = false,
	git_clean = false,
	no_buffer = false,
	custom = {},
	exclude = {},
  },
  live_filter = {
	prefix = "[FILTER]: ",
	always_show_folders = true,
  },
  filesystem_watchers = {
	enable = true,
	debounce_delay = 50,
	ignore_dirs = {},
  },
  actions = {
	use_system_clipboard = true,
	change_dir = {
	  enable = true,
	  global = false,
	  restrict_above_cwd = false,
	},
	expand_all = {
	  max_folder_discovery = 300,
	  exclude = {},
	},
	file_popup = {
	  open_win_config = {
		col = 1,
		row = 1,
		relative = "cursor",
		border = "shadow",
		style = "minimal",
	  },
	},
	open_file = {
	  quit_on_open = false,
	  eject = true,
	  resize_window = true,
	  window_picker = {
		enable = true,
		picker = "default",
		chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
		exclude = {
		  filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
		  buftype = { "nofile", "terminal", "help" },
		},
	  },
	},
	remove_file = {
	  close_window = true,
	},
  },
  trash = {
	cmd = "gio trash",
  },
  tab = {
	sync = {
	  open = false,
	  close = false,
	  ignore = {},
	},
  },
  notify = {
	threshold = vim.log.levels.INFO,
	absolute_path = true,
  },
  help = {
	sort_by = "key",
  },
  ui = {
	confirm = {
	  remove = true,
	  trash = true,
	  default_yes = false,
	},
  },
  experimental = {},
  log = {
	enable = false,
	truncate = false,
	types = {
	  all = false,
	  config = false,
	  copy_paste = false,
	  dev = false,
	  diagnostics = false,
	  git = false,
	  profile = false,
	  watcher = false,
	},
  },
} -- END_DEFAULT_OPTS

-- some
--vim.keymap.set("n", "<M-b>", ":Ex<CR>")
vim.keymap.set("n", "<M-b>", ":NvimTreeToggle<CR>")

-- split screen and navigation
vim.keymap.set("n", "<leader>v", ":vsplit<CR><C-w>l", { noremap = true })
vim.keymap.set("n", "<leader>h", ":wincmd h<CR>", { noremap = true })
vim.keymap.set("n", "<leader>l", ":wincmd l<CR>", { noremap = true })
vim.keymap.set("n", "<leader>j", ":wincmd j<CR>", { noremap = true })
vim.keymap.set("n", "<leader>k", ":wincmd k<CR>", { noremap = true })
-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>f', function()
	require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
		winblend = 10,
  		previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer' })


vim.keymap.set('n', '<leader>p', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<M-p>', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- TREESITTER
require'nvim-treesitter.configs'.setup {
	ensure_installed = {"c", "lua", "vim", "go", "javascript", "typescript", "rust","html"},
	highlight = {
		enable = true,
	}
}

-- GRUVBOX
require("gruvbox").setup({
	contrast = "hard",
	palette_overrides = {
		gray = "#2ea542",
	}
})

-- LUALINE
require("lualine").setup{
	options = {
		icons_enabled = false,
		theme = "onedark",
		component_separators = "|",
		section_separators = "",
	},
}

-- LSP
local lsp = require("lsp-zero")

lsp.preset("recommended")
-- lsp.ensure_installed({
-- 	"gopls",
-- 	"eslint",
-- 	"rust_analyzer",
-- 	"html",
-- 	"cssls",
-- 	"pylsp",
-- 	"emmet_language_server"
-- })


lsp.setup_servers({
	"gopls",
	"eslint",
	"rust_analyzer",
	"html",
	"cssls",
	"pylsp",
	"emmet_language_server"
})

lsp.set_preferences({
	sign_icons = {}
})

--- config rust analyzer
local nvim_lsp = require("lspconfig")

local on_attach = function(client)
    require'completion'.on_attach(client)
end

nvim_lsp.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
        }
    }
})
--------------

local augroup = vim.api.nvim_create_augroup('LspFormatting', {})
local lsp_format_on_save = function(bufnr)
  vim.api.nvim_clear_autocmds({group = augroup, buffer = bufnr})
  vim.api.nvim_create_autocmd('BufWritePre', {
    group = augroup,
    buffer = bufnr,
    callback = function()
      vim.lsp.buf.format()
    end,
  })
end

lsp.on_attach(function(client, bufnr)
	lsp_format_on_save(bufnr)
	local opts = {buffer = bufnr, remap = false}
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
end)



lsp.setup()

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics, {
		signs = false,
		virtual_text = true,
		underline = false,
	}
)

-- rust config
local rt = require("rust-tools")

rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})

-- COMMENT
require("nvim_comment").setup({
	operator_mapping = "<leader>/"
})

-- TERMINAL SETUP
require("toggleterm").setup{
	direction = "horizontal",
	size = 15,
	open_mapping = [[<M-j>]]
}

-- COLORSCHEME
vim.cmd("colorscheme gruvbox")
-- Adding the same comment color in each theme
vim.cmd([[
	augroup CustomCommentCollor
		autocmd!
		autocmd VimEnter * hi Comment guifg=#2ea542
	augroup END
]])

-- Disable annoying match brackets and all the jaz
vim.cmd([[
	augroup CustomHI
		autocmd!
		autocmd VimEnter * NoMatchParen 
	augroup END
]])

vim.o.background = "dark"

vim.keymap.set("i", "jj", "<Esc>")

vim.opt.guicursor = "i:block"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.number = false
vim.opt.relativenumber = true
vim.opt.swapfile = false

vim.o.hlsearch = true
vim.o.mouse = 'a'
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300
--vim.o.completeopt = 'menuone,noselect'
vim.o.termguicolors = true



-- Completion Plugin Setup
local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  -- Installed sources:
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300) 

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

vim.api.nvim_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.implementation()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', '1gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', 'g0', '<cmd>lua vim.lsp.buf.document_symbol()<CR>', {silent = true}) 
vim.api.nvim_set_keymap('n', 'gW', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', {silent = true})
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {silent = true})

config = function()
    require"surround".setup {mappings_style = "sandwich"}
end

require"surround".setup {
  context_offset = 100,
  load_autogroups = false,
  mappings_style = "sandwich",
  map_insert_mode = true,
  quotes = {"'", '"'},
  brackets = {"(", '{', '['},
  space_on_closing_char = false,
  pairs = {
    nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
    linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' } }
  },
  prefix = "s"
}
