return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "takeshid/avante-status.nvim",
    },
    config = function()
      local lualine = require("lualine")
      local config = {
        sections = {
          lualine_x = {
            "encoding",
            "fileformat",
            "filetype",
          },
        },
        -- Hide lualine for snacks dashboard
        options = {
          disabled_filetypes = {
            "snacks_dashboard",
          },
        },
      }
      lualine.setup(config)
    end,
  },
}
