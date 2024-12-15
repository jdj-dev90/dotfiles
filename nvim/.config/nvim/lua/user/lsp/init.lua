local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local lsp_cmds = vim.api.nvim_create_augroup("lsp_cmds", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_cmds,
  desc = "LSP actions",
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = true })
    end
    bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>")
    bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>")
    bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>")
    bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>")
    bufmap("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>")
    bufmap("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>")
    bufmap("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>")
    bufmap("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>")
    bufmap({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>")
    bufmap("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>")
    bufmap("x", "<F4>", "<cmd>lua vim.lsp.buf.range_code_action()<cr>")
    bufmap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<cr>")
    bufmap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>")
    bufmap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>")
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.tmpl",
  callback = function()
    vim.bo.filetype = "gotmpl"
  end,
})

local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config

lsp_defaults.capabilities =
    vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

require("user.lsp.null-ls")
require("user.lsp.schema-store")
require("user.lsp.rust-tools")

require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
    },
  },
})

require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls" },
})

local util = require("lspconfig.util")
require("mason-lspconfig").setup_handlers({
  function(server)
    lspconfig[server].setup({})
  end,
  ["ts_ls"] = function()
    lspconfig.ts_ls.setup({
      root_dir = util.root_pattern(".git"),
      settings = {
        completions = {
          completeFunctionCalls = true,
        },
      },
    })
  end,
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = {
              "vim",
              "luaList", -- KrakenD
              "luaTable", -- KrakenD
              "http_response", -- KrakenD
              "custom_error", -- KrakenD
            },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })
  end,
  ["gopls"] = function()
    lspconfig.gopls.setup({
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
          },
          staticcheck = true,
        },
      },
      filetypes = { "go", "gomod", "gotmpl" }, -- Include gotmpl filetype
    })
  end,
  ["yamlls"] = function()
    lspconfig.yamlls.setup({
      settings = {
        yaml = {
          validate = true,
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = {
            -- GitHub Workflows schema for files in .github/workflows/
            ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/github-workflow.json"] =
            ".github/workflows/*.{yml,yaml}",

            -- GCP Workflows schema for workflows outside .github/
            ["https://raw.githubusercontent.com/SchemaStore/schemastore/master/src/schemas/json/workflows.json"] =
            "workflows/*.{yml,yaml}",

            -- Kustomization schema
            ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",

            -- Docker Compose schema
            ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] =
            "docker-compose*.{yml,yaml}",
          },
        },
      },
    })
  end,
})
