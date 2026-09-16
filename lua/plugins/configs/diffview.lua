local ok, diffview = pcall(require, "diffview")
if not ok then return end

local actions = require("diffview.actions")

diffview.setup({
  enhanced_diff_hl = true,
  view = {
    default = { layout = "diff2_horizontal" },   -- side-by-side, like VSCode
    merge_tool = { layout = "diff3_mixed", disable_diagnostics = true },
    file_history = { layout = "diff2_horizontal" },
  },
  file_panel = {
    listing_style = "tree",
    tree_options = { flatten_dirs = true, folder_statuses = "only_folded" },
    win_config = { position = "left", width = 35 },
  },
  keymaps = {
    view = {
      { "n", "<leader>gq", actions.close,              { desc = "Close diffview" } },
      { "n", "<leader>gf", actions.toggle_files,       { desc = "Toggle file panel" } },
      { "n", "<tab>",      actions.select_next_entry,  { desc = "Next file" } },
      { "n", "<s-tab>",    actions.select_prev_entry,  { desc = "Prev file" } },
    },
    file_panel = {
      { "n", "<cr>",       actions.select_entry,       { desc = "Open diff for entry" } },
      { "n", "s",          actions.toggle_stage_entry, { desc = "Stage / unstage entry" } },
      { "n", "S",          actions.stage_all,          { desc = "Stage all" } },
      { "n", "U",          actions.unstage_all,        { desc = "Unstage all" } },
      { "n", "X",          actions.restore_entry,      { desc = "Discard changes in entry" } },
      { "n", "R",          actions.refresh_files,      { desc = "Refresh" } },
      { "n", "<leader>gq", actions.close,              { desc = "Close diffview" } },
      { "n", "<tab>",      actions.select_next_entry,  { desc = "Next file" } },
      { "n", "<s-tab>",    actions.select_prev_entry,  { desc = "Prev file" } },
    },
    file_history_panel = {
      { "n", "<cr>",       actions.select_entry,       { desc = "Open diff for commit" } },
      { "n", "y",          actions.copy_hash,          { desc = "Copy commit hash" } },
      { "n", "<leader>gq", actions.close,              { desc = "Close diffview" } },
    },
  },
})

local map = vim.keymap.set
-- Source-control panel: all uncommitted changes vs index/HEAD
map("n", "<leader>gs", "<cmd>DiffviewOpen<cr>",                  { desc = "Git: source control (working tree diff)" })
-- Everything not yet on main
map("n", "<leader>gm", "<cmd>DiffviewOpen origin/main...HEAD<cr>", { desc = "Git: diff branch vs origin/main" })
-- History of the whole repo / just this file
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<cr>",            { desc = "Git: repo history" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<cr>",          { desc = "Git: current file history" })
map("n", "<leader>gq", "<cmd>DiffviewClose<cr>",                  { desc = "Git: close diffview" })
