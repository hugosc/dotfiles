return {
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
    },
    -- cmd = "MCPHub", -- lazily start the hub when `MCPHub` is called
    cmd = "MCPHub", -- lazy load by default
    build = "bundled_build.lua",
    config = function()
      require("mcphub").setup({
        auto_approve = true, -- Automatically approve all requests
        extensions = {
          avante = {},
        },
        -- Required options
        --
        port = 3000, -- Port for MCP Hub server
        use_bundled_binary = true,
        config = vim.fn.expand("~/mcpservers.json"), -- Absolute path to config file

        -- Optional options
        on_ready = function(hub)
          -- Called when hub is ready
        end,
        on_error = function(err)
          -- Called on errors
        end,
        shutdown_delay = 0, -- Wait 0ms before shutting down server after last client exits
        log = {
          level = vim.log.levels.WARN,
          to_file = false,
          file_path = nil,
          prefix = "MCPHub",
        },
      })
    end,
  },
}
