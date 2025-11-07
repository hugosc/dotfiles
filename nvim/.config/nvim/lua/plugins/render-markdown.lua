-- This file acts as the plugin specification for render-markdown.nvim
-- It will be loaded by LazyVim if you require it correctly in your main config (e.g., in lua/config/lazy.lua or a file in lua/plugins/)

-- Define custom highlight groups for your heading colors
-- You can place this here or in a more central colors/theme file

return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- Add dependencies if needed (e.g., for icons)
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.icons" }, -- Or 'nvim-tree/nvim-web-devicons'
  -- Configure the plugin within the 'opts' table
  opts = {
    -- You can configure many aspects here, refer to the plugin's README/Wiki
    -- For heading colors, we override the default highlight groups:
    heading = {
      -- Ensure headings are enabled
      enabled = true,
      -- Link the plugin's internal highlight groups to your custom ones
      -- These control the icon and text color
      foregrounds = {
        "MyHeading1Fg", -- H1 foreground
        "MyHeading2Fg", -- H2 foreground
        "MyHeading3Fg", -- H3 foreground
        "MyHeading4Fg", -- H4 foreground (Define this highlight group if used)
        "MyHeading5Fg", -- H5 foreground (Define this highlight group if used)
        "MyHeading6Fg", -- H6 foreground (Define this highlight group if used)
      },
      -- These control the full-line background color when width = 'full'
      backgrounds = {
        "MyHeading1Bg", -- H1 background
        "MyHeading2Bg", -- H2 background
        "MyHeading3Bg", -- H3 background
        "MyHeading4Bg", -- H4 background (Define this highlight group if used)
        "MyHeading5Bg", -- H5 background (Define this highlight group if used)
        "MyHeading6Bg", -- H6 background (Define this highlight group if used)
      },
      -- Other heading options you might want to configure:
      -- width = 'full', -- 'full' or 'block'
      -- border = false, -- Add borders above/below headings
      -- icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' }, -- Customize icons (requires Nerd Font)
      -- signs = { '󰫎 ' }, -- Customize sign column icons
    },
    -- Ensure the plugin uses the correct highlight groups by defining them
    -- (This is done above with vim.api.nvim_set_hl)
  },
  -- You might want to delay loading until a Markdown file is opened
  ft = { "markdown", "vimwiki" }, -- Add 'vimwiki' if you use it
  -- Or use 'event = "VeryLazy"'
  config = function(_, opts)
    -- If you need treesitter integration for vimwiki
    -- vim.treesitter.language.register('markdown', 'vimwiki')

    -- Call the setup function
    require("render-markdown").setup(opts)

    -- Define the highlight groups here instead of globally if preferred
    -- vim.api.nvim_set_hl(0, 'MyHeading1Fg', { fg = '#FF8700', bold = true })
    -- ... etc ...
  end,
}
