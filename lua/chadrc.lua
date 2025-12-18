-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
---@class ChadrcConfig
local M = {}

M.base46 = {
    theme =  "nightlamp",
    transparency=true
}
M.ui = {
    statusline = {
        style = "lualine",  -- Options: "default", "minimal", "lualine"
    },
    tabline = {
        enable = true,      -- Enable tabline
        style = "default",  -- Options: "default", "minimal"
    },
    winbar = {
        enable = true,      -- Enable winbar
    },
    borders = true,        -- Add borders to floating windows
    popupmenu = {
        enabled = true,     -- Enable popup menu
    },
}
M.lsp = {
    diagnostics = {
        underline = true,
        virtual_text = { spacing = 4, prefix = "●" },
    },
    formatting = {
        format_on_save = true,  -- Format on save
        timeout_ms = 1000,      -- Timeout for formatting requests
    },
}
return M
