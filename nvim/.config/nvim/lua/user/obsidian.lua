require("obsidian").setup({
    workspaces = {
        {
            name = "personal",
            path = "~/vaults/second-brain",
        },
    },
    notes_subdir = "inbox",
    new_notes_location = "notes_subdir",

    disable_frontmatter = true,
    templates = {
        subdir = "templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M:%S",
    },

    -- name new notes starting the ISO datetime and ending with note name
    -- put them in the inbox subdir
    -- note_id_func = function(title)
    --   local suffix = ""
    --   -- get current ISO datetime with -5 hour offset from UTC for EST
    --   local current_datetime = os.date("!%Y-%m-%d-%H%M%S", os.time() - 5*3600)
    --   if title ~= nil then
    --     suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    --   else
    --     for _ = 1, 4 do
    --       suffix = suffix .. string.char(math.random(65, 90))
    --     end
    --   end
    --   return current_datetime .. "_" .. suffix
    -- end,

    note_id_func = function(title)
        local suffix = ""
        if title ~= nil then
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
        else
            for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
                suffix = tostring(os.time()) .. "-" .. suffix
            end
        end
        return suffix
    end,

    -- key mappings, below are the defaults
    mappings = {
        -- overrides the 'gf' mapping to work on markdown/wiki links within your vault
        ["gf"] = {
            action = function()
                return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
        -- toggle check-boxes
        -- ["<leader>ch"] = {
        --   action = function()
        --     return require("obsidian").util.toggle_checkbox()
        --   end,
        --   opts = { buffer = true },
        -- },
    },
    completion = {
        nvim_cmp = true,
        min_chars = 2,
    },
    ui = {
        -- Disable some things below here because I set these manually for all Markdown files using treesitter
        checkboxes = {},
        bullets = {},
    },
})

--[[ require("obsidian-bridge").setup({ ]]
--[[     obsidian_server_address = "http://localhost:27123", ]]
--[[     scroll_sync = true, ]]
--[[ }) ]]

local function is_obsidian_running()
    local handle = io.popen("pgrep -f obsidian")
    if not handle then
        return false
    end

    local result = handle:read("*a")
    handle:close()

    -- Check if the result is not nil and not empty
    return result ~= nil and result ~= ""
end

local function in_second_brain_dir()
    local second_brain_path = vim.fn.getenv("SECOND_BRAIN")
    if not second_brain_path or second_brain_path == "" then
        return false
    end

    local current_dir = vim.fn.getcwd()
    return current_dir == second_brain_path
end

local function setup_obsidian_bridge()
    if is_obsidian_running() and in_second_brain_dir() then
        require("obsidian-bridge").setup({
            obsidian_server_address = "http://localhost:27123",
            scroll_sync = true,
        })
        print("Obsidian bridge setup complete.")
    elseif not in_second_brain_dir() then
        print("Obsidian bridge exiting.")
    else
        print("Obsidian is not running or not in second-brain directory. Retrying...")
        vim.defer_fn(setup_obsidian_bridge, 5000) -- Retry after 5 seconds
    end
end

-- Initial check and setup
setup_obsidian_bridge()
