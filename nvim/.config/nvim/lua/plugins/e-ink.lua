return {
  "e-ink-colorscheme/e-ink.nvim",
  priority = 1000,
  config = function()
    require("e-ink").setup()
    vim.cmd.colorscheme("e-ink")

    -- Remove Everforest colors and use only grayscale
    local mono = require("e-ink.palette").mono()
    local set_hl = vim.api.nvim_set_hl

    -- Override all highlight groups to use only mono palette
    -- This removes the "hint of Everforest" and makes it fully grayscale
    local groups = {
      "Keyword",
      "Type",
      "Function",
      "String",
      "Comment",
      "Constant",
      "Identifier",
      "PreProc",
      "Special",
      "Statement",
      "Error",
      "Warning",
      "Operator",
      "Number",
      "Float",
      "Boolean",
      "Character",
      "SpecialChar",
      "SpecialComment",
      "Tag",
      "Todo",
      "Delimiter",
      "Repeat",
      "Conditional",
      "Label",
      "Exception",
      "Include",
      "Define",
      "Macro",
      "Typedef",
      "Structure",
      "StorageClass",
      "MoreMsg",
      "Question",
      "Search",
      "IncSearch",
      "DiffAdd",
      "DiffChange",
      "DiffDelete",
      "DiffText",
    }

    for _, group in ipairs(groups) do
      -- Use different gray levels for different syntax categories
      local fg = mono[10] -- default to light gray
      if group:match("Comment") then
        fg = mono[7] -- comments darker
      elseif group:match("String") or group:match("Character") then
        fg = mono[9] -- strings slightly brighter
      elseif group:match("Constant") or group:match("Number") then
        fg = mono[8]
      end
      set_hl(0, group, { fg = fg })
    end

    -- Override UI element colors (Noice, Notify, Command Palette, etc.)
    local ui_groups = {
      -- Noice
      "NoicePopupmenu",
      "NoicePopupmenuBorder",
      "NoicePopupmenuMatch",
      "NoicePopupmenuSelected",
      "NoiseCmdline",
      "NoiseCmdlinePopupmenu",
      "NoiceFormatTitle",
      "NoiceFormatProgressDone",
      "NoiceFormatProgressTodo",
      -- Notify
      "NotifyBackground",
      "NotifyERRORBorder",
      "NotifyWARNBorder",
      "NotifyINFOBorder",
      "NotifyDEBUGBorder",
      "NotifyTRACEBorder",
      -- Command/Search
      "CmdlinePopupmenu",
      "Pmenu",
      "PmenuSbar",
      "PmenuThumb",
      "PmenuMatch",
      "PmenuMatchSel",
      -- Floats/Borders
      "FloatBorder",
      "FloatTitle",
      "NormalFloat",
      -- Telescope/Picker
      "TelescopeNormal",
      "TelescopeSelection",
      "TelescopeMatching",
      -- Misc
      "VertSplit",
      "WinSeparator",
      "StatusLine",
      "StatusLineNC",
    }

    for _, group in ipairs(ui_groups) do
      set_hl(0, group, { fg = mono[10], bg = mono[1] })
    end

    -- Specifically set selection/highlight colors to be subtle grays
    set_hl(0, "Visual", { bg = mono[3], fg = mono[10] })
    set_hl(0, "VisualNOS", { bg = mono[3], fg = mono[10] })
    set_hl(0, "Search", { bg = mono[4], fg = mono[10] })
    set_hl(0, "IncSearch", { bg = mono[5], fg = mono[10] })

    -- Override terminal colors to be grayscale
    vim.g.terminal_color_0 = mono[1] -- black
    vim.g.terminal_color_1 = mono[3] -- red -> gray
    vim.g.terminal_color_2 = mono[4] -- green -> gray
    vim.g.terminal_color_3 = mono[5] -- yellow -> gray
    vim.g.terminal_color_4 = mono[6] -- blue -> gray
    vim.g.terminal_color_5 = mono[7] -- purple -> gray
    vim.g.terminal_color_6 = mono[8] -- aqua -> gray
    vim.g.terminal_color_7 = mono[10] -- white
    vim.g.terminal_color_8 = mono[2] -- bright black
    vim.g.terminal_color_9 = mono[3] -- bright red -> gray
    vim.g.terminal_color_10 = mono[4] -- bright green -> gray
    vim.g.terminal_color_11 = mono[5] -- bright yellow -> gray
    vim.g.terminal_color_12 = mono[6] -- bright blue -> gray
    vim.g.terminal_color_13 = mono[7] -- bright purple -> gray
    vim.g.terminal_color_14 = mono[8] -- bright aqua -> gray
    vim.g.terminal_color_15 = mono[10] -- bright white
  end,
}
