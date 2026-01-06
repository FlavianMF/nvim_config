local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    spec = {
        -- add LazyVim and import its plugins
        { "LazyVim/LazyVim", import = "lazyvim.plugins" },
        -- import/override with your plugins
        { import = "plugins" },
    },
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    checker = {
        enabled = true, -- check for plugin updates periodically
        notify = false, -- notify on update
    }, -- automatically check for plugin updates
    performance = {
        rtp = {
            -- disable some rtp plugins
            disabled_plugins = {
                "gzip",
                -- "matchit",
                -- "matchparen",
                -- "netrwPlugin",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})

vim.cmd.colorscheme("vesper")

-- require("devcontainer").setup({
--     config_search_start = function()
--         -- By default this function uses vim.loop.cwd()
--         -- This is used to find a starting point for .devcontainer.json file search
--         -- Since by default, it is searched for recursively
--         -- That behavior can also be disabled
--     end,
--     workspace_folder_provider = function()
--         -- By default this function uses first workspace folder for integrated lsp if available and vim.loop.cwd() as a fallback
--         -- This is used to replace `${localWorkspaceFolder}` in devcontainer.json
--         -- Also used for creating default .devcontainer.json file
--     end,
--     terminal_handler = function(command)
--         -- By default this function creates a terminal in a new tab using :terminal command
--         -- It also removes statusline when that tab is active, to prevent double statusline
--         -- It can be overridden to provide custom terminal handling
--     end,
--     nvim_installation_commands_provider = function(path_binaries, version_string)
--         -- Returns table - list of commands to run when adding neovim to container
--         -- Each command can either be a string or a table (list of command parts)
--         -- Takes binaries available in path on current container and version_string passed to the command or current version of neovim
--     end,
--     devcontainer_json_template = function()
--         -- Returns table - list of lines to set when creating new devcontainer.json files
--         -- As a template
--         -- Used only when using functions from commands module or created commands
--     end,
--     -- Can be set to false to prevent generating default commands
--     -- Default commands are listed below
--     generate_commands = true,
--     -- By default no autocommands are generated
--     -- This option can be used to configure automatic starting and cleaning of containers
--     autocommands = {
--         -- can be set to true to automatically start containers when devcontainer.json is available
--         init = false,
--         -- can be set to true to automatically remove any started containers and any built images when exiting vim
--         clean = false,
--         -- can be set to true to automatically restart containers when devcontainer.json file is updated
--         update = false,
--     },
--     -- can be changed to increase or decrease logging from library
--     log_level = "info",
--     -- can be set to true to disable recursive search
--     -- in that case only .devcontainer.json and .devcontainer/devcontainer.json files will be checked relative
--     -- to the directory provided by config_search_start
--     disable_recursive_config_search = false,
--     -- can be set to false to disable image caching when adding neovim
--     -- by default it is set to true to make attaching to containers faster after first time
--     cache_images = true,
--     -- By default all mounts are added (config, data and state)
--     -- This can be changed to disable mounts or change their options
--     -- This can be useful to mount local configuration
--     -- And any other mounts when attaching to containers with this plugin
--     attach_mounts = {
--         neovim_config = {
--             -- enables mounting local config to /root/.config/nvim in container
--             enabled = false,
--             -- makes mount readonly in container
--             options = { "readonly" },
--         },
--         neovim_data = {
--             -- enables mounting local data to /root/.local/share/nvim in container
--             enabled = false,
--             -- no options by default
--             options = {},
--         },
--         -- Only useful if using neovim 0.8.0+
--         neovim_state = {
--             -- enables mounting local state to /root/.local/state/nvim in container
--             enabled = false,
--             -- no options by default
--             options = {},
--         },
--     },
--     -- This takes a list of mounts (strings) that should always be added to every run container
--     -- This is passed directly as --mount option to docker command
--     -- Or multiple --mount options if there are multiple values
--     always_mount = {},
--     -- This takes a string (usually either "podman" or "docker") representing container runtime - "devcontainer-cli" is also partially supported
--     -- That is the command that will be invoked for container operations
--     -- If it is nil, plugin will use whatever is available (trying "podman" first)
--     container_runtime = nil,
--     -- Similar to container runtime, but will be used if main runtime does not support an action - useful for "devcontainer-cli"
--     backup_runtime = nil,
--     -- This takes a string (usually either "podman-compose" or "docker-compose") representing compose command - "devcontainer-cli" is also partially supported
--     -- That is the command that will be invoked for compose operations
--     -- If it is nil, plugin will use whatever is available (trying "podman-compose" first)
--     compose_command = nil,
--     -- Similar to compose command, but will be used if main command does not support an action - useful for "devcontainer-cli"
--     backup_compose_command = nil,
-- })
