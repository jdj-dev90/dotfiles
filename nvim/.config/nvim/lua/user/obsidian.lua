require("obsidian").setup({
    workspaces = {
        {
            name = "personal",
            path = "~/second-brain",
        },
    },
})

require("obsidian-bridge").setup({
    obsidian_server_address = "http://localhost:27123",
    scroll_sync = true,
})
