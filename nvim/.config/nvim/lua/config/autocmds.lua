-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
-- sync system clipboard while yanking
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local v = vim.v.event
    local regcontents = v.regcontents
    vim.defer_fn(function()
      vim.fn.setreg("+", regcontents)
    end, 100)
  end,
})
vim.api.nvim_create_autocmd("FileChangedRO", {
  callback = function()
    vim.cmd('echohl WarningMsg | echo "File changed RO." | echohl None')
  end,
})

vim.api.nvim_create_autocmd("FileChangedShell", {
  callback = function()
    vim.opt.autoread = true
    vim.cmd("checktime")
    vim.cmd('echohl WarningMsg | echo "File changed shell. Auto-reloading..." | echohl None')
  end,
})

-- More aggressive file change detection
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI" }, {
  callback = function()
    if vim.bo.modifiable and not vim.bo.readonly then
      vim.cmd("silent! checktime")
    end
  end,
})

-- Set global options for better file change handling
vim.opt.autoread = true
vim.opt.autowrite = true
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function(args)
    local bufnr = args.buf
    vim.keymap.set(
      "n",
      "<leader>a+",
      "<cmd>AiderTreeAddFile<cr>",
      { desc = "Add File from Tree to Aider", buffer = bufnr, noremap = true, silent = true }
    )
    vim.keymap.set(
      "n",
      "<leader>a-",
      "<cmd>AiderTreeDropFile<cr>",
      { desc = "Drop File from Tree from Aider", buffer = bufnr, noremap = true, silent = true }
    )
  end,
  desc = "Aider NvimTree Keymaps",
})

-- sync system clipboard to vim clipboard
vim.api.nvim_create_autocmd("FocusGained", {
  callback = function()
    local loaded_content = vim.fn.getreg("+")
    if loaded_content ~= "" then
      vim.fn.setreg('"', loaded_content)
    end
    -- Check for external file changes when focus is gained
    vim.cmd("checktime")
  end,
})

-- Define the custom system prompt content
local custom_system_prompt = [[
Follow these principles for effective interaction and autonomous tool use:

1.  **Analyze & Decompose:** Immediately break down user requests. Infer the necessary steps and identify the required tools (including standard tools, filesystem operations, Neovim commands, GitHub interactions, web searches, etc.).
2.  **Proactive Tool Execution:** Don't wait for explicit step-by-step instructions. If a task implies a sequence (e.g., find a file, then read it, then modify it), execute the necessary tool chain autonomously. Your goal is to fulfill the underlying intent efficiently and directly.
3.  **Minimize Confirmation:** Avoid asking for permission to use tools or take logical next steps. Assume implied consent based on the request. If you need clarification on the *goal* or *target* (e.g., which specific file if ambiguous), ask, but not on *whether* to use a tool.
4.  **Infer & Act:** Actively interpret the user's intent. If asked to "explore," "check," "find," or "refactor" something, proactively use tools like `glob`, `filesystem_list_directory`, `filesystem_read_file`, `read_definitions`, `web_search`, etc., to gather information and present relevant findings or proposed actions.
5.  **Direct Modification:** When asked to modify files (edit, create, delete, rename), use the appropriate tools (`filesystem_edit_file`, `filesystem_write_file`, `neovim_replace_in_file`, `filesystem_delete_item`, `filesystem_move_file`) directly. Present changes using the required format (like SEARCH/REPLACE blocks) for review or application.
6.  **Precision & Efficiency:** Always use the *most appropriate* tool for the job (e.g., `filesystem_edit_file` for complex edits, `neovim_replace_in_file` for SEARCH/REPLACE) and ensure parameters are accurate. Prioritize efficiency and minimize unnecessary user interaction. Use specialized MCP tools (like GitHub, Puppeteer) when the task demands them.
7.  **Context is Key:** Continuously use tools to maintain awareness of the project structure, file contents, definitions, and external information (via web search) as needed. Don't rely solely on memory or previous conversation turns.
]]

-- Create a variable to track the prompt state, start with it active
local prompt_active = true

-- Apply the custom prompt by default on load
-- require("avante.config").override({
--  system_prompt = custom_system_prompt,
-- })
-- vim.notify("Custom system prompt activated by default", vim.log.levels.INFO)

-- Autocmd to toggle the prompt on/off
vim.api.nvim_create_autocmd("User", {
  pattern = "ToggleMyPrompt",
  callback = function()
    prompt_active = not prompt_active
    local message
    if prompt_active then
      require("avante.config").override({
        system_prompt = custom_system_prompt,
      })
      message = "Custom system prompt activated"
    else
      require("avante.config").override({
        system_prompt = nil,
      })
      message = "Custom system prompt deactivated"
    end
    vim.notify(message, vim.log.levels.INFO)
  end,
})

vim.keymap.set("n", "<leader>am", function()
  vim.api.nvim_exec_autocmds("User", { pattern = "ToggleMyPrompt" })
end, { desc = "avante: toggle my prompt" })
