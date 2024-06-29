local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
    return
end

null_ls.setup({
    debug = false,
    sources = {
        null_ls.builtins.formatting.stylua,

        null_ls.builtins.formatting.prettierd.with({
            filetypes = { "html", "javascript", "typescript", "css", "json", "yaml", "markdown", "tmpl" }, -- Ensure .tmpl is included
        }),

        null_ls.builtins.diagnostics.golangci_lint.with({
            filetypes = { "tmpl" },
        }),
        null_ls.builtins.formatting.gofumpt.with({
            filetypes = { "go", "gomod", "gotmpl", "tmpl" }, -- Use gotmpl as filetype
        }),
        require("none-ls.diagnostics.eslint_d"),
        require("typescript.extensions.null-ls.code-actions"),
    },
    -- you can reuse a shared lspconfig on_attach callback here
    on_attach = function(client)
        --[[ if client.server_capabilities.document_formatting then ]]
        vim.cmd([[
            " augroup LspFormatting
            "     autocmd! * <buffer>
            "     autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
            " augroup END
            ]])
        --[[ end ]]
    end,
})
