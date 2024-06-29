local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end

vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "GitSignsAdd" })
vim.api.nvim_set_hl(0, "GitSignsChange", { link = "GitSignsChange" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "GitSignsDelete" })
vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "GitSignsAdd" })
vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "GitSignsAdd" })

gitsigns.setup({

  -- Define highlights
  on_attach = function()
    -- Add highlights
    vim.api.nvim_set_hl(0, "GitSignsAdd", { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "GitSignsAddLn", { link = "DiffAdd" })
    vim.api.nvim_set_hl(0, "GitSignsAddNr", { link = "DiffAdd" })

    -- Change highlights
    vim.api.nvim_set_hl(0, "GitSignsChange", { link = "DiffChange" })
    vim.api.nvim_set_hl(0, "GitSignsChangeLn", { link = "DiffChange" })
    vim.api.nvim_set_hl(0, "GitSignsChangeNr", { link = "DiffChange" })

    -- Change delete highlights
    vim.api.nvim_set_hl(0, "GitSignsChangedelete", { link = "DiffChange" })
    vim.api.nvim_set_hl(0, "GitSignsChangedeleteLn", { link = "DiffChange" })
    vim.api.nvim_set_hl(0, "GitSignsChangedeleteNr", { link = "DiffChange" })

    -- Delete highlights
    vim.api.nvim_set_hl(0, "GitSignsDelete", { link = "DiffDelete" })
    vim.api.nvim_set_hl(0, "GitSignsDeleteLn", { link = "DiffDelete" })
    vim.api.nvim_set_hl(0, "GitSignsDeleteNr", { link = "DiffDelete" })

    -- Top delete highlights
    vim.api.nvim_set_hl(0, "GitSignsTopdelete", { link = "DiffDelete" })
    vim.api.nvim_set_hl(0, "GitSignsTopdeleteLn", { link = "DiffDelete" })
    vim.api.nvim_set_hl(0, "GitSignsTopdeleteNr", { link = "DiffDelete" })
  end,

  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "契" },
    topdelete = { text = "契" },
    changedelete = { text = "▎" },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false,    -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false,   -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  yadm = {
    enable = false,
  },
})
