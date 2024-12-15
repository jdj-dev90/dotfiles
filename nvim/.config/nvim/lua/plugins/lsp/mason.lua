return {
  {
    "williamboman/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate" },
    config = function(_, opts)
      require("mason").setup(opts)
    end,
  },
  { "williamboman/mason-lspconfig.nvim" },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = { ensure_installed = 'ts_ls', 'lua_ls' },
    dependencies = { "williamboman/mason.nvim" },
    cmd = {
      "MasonToolsInstall",
      "MasonToolsInstallSync",
      "MasonToolsUpdate",
      "MasonToolsUpdateSync",
      "MasonToolsClean",
    },
  },
}
