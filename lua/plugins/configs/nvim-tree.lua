local function my_nvim_tree_on_attach(bufnr)
    local api = require('nvim-tree.api')

    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Define all your key mappings
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

    -- ... [rest of your nvim-tree key mappings]
end

require("nvim-tree").setup {
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
		width = 25,
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
			default = "",
			symlink = "",
			bookmark = "󰆤",
			modified = "●",
			folder = {
	--		  arrow_closed = "",
			  arrow_closed = "",
		--	  arrow_open = "",
			  arrow_open = "",
			  default = "",
			  open = "",
			  empty = "",
			  empty_open = "",
			  symlink = "",
			  symlink_open = "",
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
	    -- ... [rest of your nvim-tree configuration]
}


