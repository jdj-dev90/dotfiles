require("mason-nvim-dap").setup({
  ensure_installed = { "typescript", "node" },
  automatic_setup = true
})



require("mason-nvim-dap").setup_handlers()
require('telescope').load_extension('dap')

-- DAP-UI --
require("dapui").setup()


-- nvim-dap-virtual-text. Show virtual text for current frame
vim.g.dap_virtual_text = true

