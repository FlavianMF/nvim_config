local tmux_pane_height = 10

return {
    {
        "Aietes/esp32.nvim",
        opts = {
            -- custom build dir
            build_dir = "build",
        },
        keys = {
            {
                "<leader>em",
                function()
                    vim.cmd("wa")
                    require("esp32").pick("monitor")
                end,
                desc = "ESP32: Pick & Monitor",
            },
            {
                "<C-e>b",
                function()
                    vim.cmd("wa")
                    local command = "idf.py build"
                    local in_tmux = vim.fn.exists("$TMUX") == 1
                    if in_tmux then
                        local pane_id = vim.g.idf_cmd_pane_id
                        local pane_exists = false
                        if pane_id then
                            -- check if pane exists
                            vim.fn.system(string.format("tmux list-panes -F '#D' | grep -q '^%s$'", pane_id))
                            if vim.v.shell_error == 0 then
                                pane_exists = true
                            end
                        end

                        if pane_exists then
                            vim.fn.system(string.format("tmux send-keys -t %s C-c", pane_id))
                            vim.fn.system(string.format("tmux send-keys -t %s 'clear' Enter", pane_id))
                            local final_cmd = string.format(
                                "tmux send-keys -t %s '%s; echo; echo \"Press Enter to close panel...\"; read' Enter",
                                pane_id,
                                command
                            )
                            vim.fn.system(final_cmd)
                            vim.fn.system(string.format("tmux select-pane -t %s", pane_id))
                        else
                            -- create new pane
                            local new_pane_cmd =
                                string.format("tmux split-window -d -P -F '#D' -l %s", tmux_pane_height) -- -d to not switch to it
                            local new_pane_id = vim.fn.trim(vim.fn.system(new_pane_cmd))
                            vim.g.idf_cmd_pane_id = new_pane_id
                            local final_cmd = string.format(
                                "tmux send-keys -t %s '%s; echo; echo \"Press Enter to close panel...\"; read' Enter",
                                new_pane_id,
                                command
                            )
                            vim.fn.system(final_cmd)
                            vim.fn.system(string.format("tmux select-pane -t %s", new_pane_id))
                        end
                    else
                        -- Fallback for non-tmux environments
                        require("esp32").command("build")
                    end
                end,
                desc = "IDF: Build Project",
            },
            {
                "<C-e>f",
                function()
                    local command = "idf.py flash"
                    local in_tmux = vim.fn.exists("$TMUX") == 1
                    if in_tmux then
                        local pane_id = vim.g.idf_cmd_pane_id
                        local pane_exists = false
                        if pane_id then
                            -- check if pane exists
                            vim.fn.system(string.format("tmux list-panes -F '#D' | grep -q '^%s$'", pane_id))
                            if vim.v.shell_error == 0 then
                                pane_exists = true
                            end
                        end

                        if pane_exists then
                            vim.fn.system(string.format("tmux send-keys -t %s C-c", pane_id))
                            vim.fn.system(string.format("tmux send-keys -t %s 'clear' Enter", pane_id))
                            local final_cmd = string.format(
                                "tmux send-keys -t %s '%s; echo; echo \"Press Enter to close panel...\"; read' Enter",
                                pane_id,
                                command
                            )
                            vim.fn.system(final_cmd)
                            vim.fn.system(string.format("tmux select-pane -t %s", pane_id))
                        else
                            -- create new pane
                            local new_pane_cmd =
                                string.format("tmux split-window -d -P -F '#D' -l %s", tmux_pane_height) -- -d to not switch to it
                            local new_pane_id = vim.fn.trim(vim.fn.system(new_pane_cmd))
                            vim.g.idf_cmd_pane_id = new_pane_id
                            local final_cmd = string.format(
                                "tmux send-keys -t %s '%s; echo; echo \"Press Enter to close panel...\"; read' Enter",
                                new_pane_id,
                                command
                            )
                            vim.fn.system(final_cmd)
                            vim.fn.system(string.format("tmux select-pane -t %s", new_pane_id))
                        end
                    else
                        -- Fallback for non-tmux environments
                        require("esp32").command("flash")
                    end
                end,
                desc = "IDF: Flash Project",
            },
            {
                "<C-e>m",
                function()
                    local command = "idf.py monitor"
                    local in_tmux = vim.fn.exists("$TMUX") == 1
                    if in_tmux then
                        local pane_id = vim.g.idf_cmd_pane_id
                        local pane_exists = false
                        if pane_id then
                            -- check if pane exists
                            vim.fn.system(string.format("tmux list-panes -F '#D' | grep -q '^%s$'", pane_id))
                            if vim.v.shell_error == 0 then
                                pane_exists = true
                            end
                        end

                        if pane_exists then
                            vim.fn.system(string.format("tmux send-keys -t %s C-c", pane_id))
                            vim.fn.system(string.format("tmux send-keys -t %s 'clear' Enter", pane_id))
                            local final_cmd = string.format("tmux send-keys -t %s '%s' Enter", pane_id, command)
                            vim.fn.system(final_cmd)
                            vim.fn.system(string.format("tmux select-pane -t %s", pane_id))
                        else
                            -- create new pane
                            local new_pane_cmd =
                                string.format("tmux split-window -d -P -F '#D' -l %s", tmux_pane_height) -- -d to not switch to it
                            local new_pane_id = vim.fn.trim(vim.fn.system(new_pane_cmd))
                            vim.g.idf_cmd_pane_id = new_pane_id
                            local final_cmd = string.format("tmux send-keys -t %s '%s' Enter", new_pane_id, command)
                            vim.fn.system(final_cmd)
                            vim.fn.system(string.format("tmux select-pane -t %s", new_pane_id))
                        end
                    else
                        -- Fallback for non-tmux environments
                        require("esp32").command("monitor")
                    end
                end,
                desc = "IDF: Monitor Device",
            },
            {
                "<C-e>a",
                function()
                    local command = "idf.py flash monitor"
                    local in_tmux = vim.fn.exists("$TMUX") == 1
                    if in_tmux then
                        local pane_id = vim.g.idf_cmd_pane_id
                        local pane_exists = false
                        if pane_id then
                            -- check if pane exists
                            vim.fn.system(string.format("tmux list-panes -F '#D' | grep -q '^%s$'", pane_id))
                            if vim.v.shell_error == 0 then
                                pane_exists = true
                            end
                        end

                        if pane_exists then
                            vim.fn.system(string.format("tmux send-keys -t %s C-c", pane_id))
                            vim.fn.system(string.format("tmux send-keys -t %s 'clear' Enter", pane_id))
                            local final_cmd = string.format("tmux send-keys -t %s '%s' Enter", pane_id, command)
                            vim.fn.system(final_cmd)
                            vim.fn.system(string.format("tmux select-pane -t %s", pane_id))
                        else
                            -- create new pane
                            local new_pane_cmd =
                                string.format("tmux split-window -d -P -F '#D' -l %s", tmux_pane_height) -- -d to not switch to it
                            local new_pane_id = vim.fn.trim(vim.fn.system(new_pane_cmd))
                            vim.g.idf_cmd_pane_id = new_pane_id
                            local final_cmd = string.format("tmux send-keys -t %s '%s' Enter", new_pane_id, command)
                            vim.fn.system(final_cmd)
                            vim.fn.system(string.format("tmux select-pane -t %s", new_pane_id))
                        end
                    else
                        -- Fallback for non-tmux environments
                        require("esp32").command("flash monitor")
                    end
                end,
                desc = "IDF: Flash & Monitor",
            },
            {
                "<C-e>d",
                function()
                    local command = "idf.py build && idf.py flash monitor"
                    local in_tmux = vim.fn.exists("$TMUX") == 1
                    if in_tmux then
                        local pane_id = vim.g.idf_cmd_pane_id
                        local pane_exists = false
                        if pane_id then
                            -- check if pane exists
                            vim.fn.system(string.format("tmux list-panes -F '#D' | grep -q '^%s$'", pane_id))
                            if vim.v.shell_error == 0 then
                                pane_exists = true
                            end
                        end

                        if pane_exists then
                            vim.fn.system(string.format("tmux send-keys -t %s C-c", pane_id))
                            vim.fn.system(string.format("tmux send-keys -t %s 'clear' Enter", pane_id))
                            local final_cmd = string.format("tmux send-keys -t %s '%s' Enter", pane_id, command)
                            vim.fn.system(final_cmd)
                            vim.fn.system(string.format("tmux select-pane -t %s", pane_id))
                        else
                            -- create new pane
                            local new_pane_cmd =
                                string.format("tmux split-window -d -P -F '#D' -l %s", tmux_pane_height) -- -d to not switch to it
                            local new_pane_id = vim.fn.trim(vim.fn.system(new_pane_cmd))
                            vim.g.idf_cmd_pane_id = new_pane_id
                            local final_cmd = string.format("tmux send-keys -t %s '%s' Enter", new_pane_id, command)
                            vim.fn.system(final_cmd)
                            vim.fn.system(string.format("tmux select-pane -t %s", new_pane_id))
                        end
                    else
                        -- Fallback for non-tmux environments
                        require("esp32").command("build flash monitor")
                    end
                end,
                desc = "IDF: Build, Flash & Monitor",
            },
            {
                "<C-e>c",
                function()
                    require("esp32").command("menuconfig")
                end,
                desc = "IDF: Menuconfig",
            },
            {
                "<C-e>x",
                function()
                    require("esp32").command("clean")
                end,
                desc = "IDF: Clean Project",
            },
        },
    },
    {
        "neovim/nvim-lspconfig",
        opts = function(_, opts)
            local esp32 = require("esp32")
            opts.servers = opts.servers or {}
            opts.servers.clangd = esp32.lsp_config()
            return opts
        end,
    },
}
