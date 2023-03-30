local typescript_ok, typescript = pcall(require, 'typescript')

-- It enables tsserver automatically so no need to call lspconfig.tsserver.setup
if typescript_ok then
  typescript.setup({})
end

