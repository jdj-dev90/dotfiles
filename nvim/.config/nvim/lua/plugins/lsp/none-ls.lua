return {
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"nvimtools/none-ls-extras.nvim",
		},
		opts = function()
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
			local null_ls = require("null-ls")

			return {
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.prettierd.with({
						filetypes = { "html", "javascript", "typescript", "css", "json", "yaml", "markdown", "tmpl" },
					}),
					null_ls.builtins.diagnostics.golangci_lint.with({
						filetypes = { "tmpl" },
					}),
					null_ls.builtins.formatting.gofumpt.with({
						filetypes = { "go", "gomod", "gotmpl", "tmpl" }, -- Use gotmpl as filetype
					}),
					require("none-ls.diagnostics.eslint_d"),
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({
							group = augroup,
							buffer = bufnr,
						})
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({ bufnr = bufnr })
							end,
						})
					end
				end,
			}
		end,
	},
}
