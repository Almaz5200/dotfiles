-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

local M = {}
local run_command_async = function(cmd)
  local function on_exit(job_id, exit_code, event)
    if exit_code ~= 0 then
      -- Fetch error message from a buffer
      local error_msg = table.concat(vim.fn.getbufline(vim.fn.bufnr("%"), 1, -1), "\n")
      vim.notify(error_msg, vim.log.levels.ERROR)
    else
      vim.cmd("echo 'Tuist project generated'")
    end
  end

  local job_id = vim.fn.jobstart(cmd, {
    on_stderr = function(id, data, event)
      -- Collect error messages in a buffer for later use in on_exit
      vim.fn.appendbufline(vim.fn.bufnr("%"), -1, data)
    end,
    on_exit = on_exit,
  })

  if job_id == 0 then
    vim.notify("Failed to start job", vim.log.levels.ERROR)
  elseif job_id == -1 then
    vim.notify("Command execution failed", vim.log.levels.ERROR)
  end
end

local function toggle_home_away()
  -- Get the visual selection range
  local _, line1, col1 = unpack(vim.fn.getpos("'<"))
  local _, line2, col2 = unpack(vim.fn.getpos("'>"))
  -- Generate the range in the appropriate format
  local range = string.format("%d,%d", line1, line2)

  -- Check if the selection contains 'home' or 'Home'
  local contains_home = false
  local contains_away = false

  -- Temporarily set hlsearch to false to avoid highlighting
  local hlsearch = vim.opt.hlsearch
  vim.opt.hlsearch = false

  -- Check for 'home' or 'away' in selected range
  vim.cmd(string.format("%s%s", range, "/\\(home\\|Home\\)/"))
  if vim.v.errmsg == "" then
    contains_home = true
  end

  -- Check for 'away' or 'Away' in selected range
  vim.cmd(string.format("%s%s", range, "/\\(away\\|Away\\)/"))
  if vim.v.errmsg == "" then
    contains_away = true
  end

  -- Perform the appropriate substitutions
  if contains_home and not contains_away then
    vim.cmd(string.format("%s%s", range, [[s/home/{temp}/g]]))
    vim.cmd(string.format("%s%s", range, [[s/Home/{Temp}/g]]))
    vim.cmd(string.format("%s%s", range, [[s/away/home/g]]))
    vim.cmd(string.format("%s%s", range, [[s/Away/Home/g]]))
    vim.cmd(string.format("%s%s", range, [[s/{temp}/away/g]]))
    vim.cmd(string.format("%s%s", range, [[s/{Temp}/Away/g]]))
  elseif contains_away and not contains_home then
    vim.cmd(string.format("%s%s", range, [[s/away/{temp}/g]]))
    vim.cmd(string.format("%s%s", range, [[s/Away/{Temp}/g]]))
    vim.cmd(string.format("%s%s", range, [[s/home/away/g]]))
    vim.cmd(string.format("%s%s", range, [[s/Home/Away/g]]))
    vim.cmd(string.format("%s%s", range, [[s/{temp}/home/g]]))
    vim.cmd(string.format("%s%s", range, [[s/{Temp}/Home/g]]))
  elseif contains_home and contains_away then
    vim.cmd(string.format("%s%s", range, [[s/home/{temp}/g]]))
    vim.cmd(string.format("%s%s", range, [[s/Home/{Temp}/g]]))
    vim.cmd(string.format("%s%s", range, [[s/away/home/g]]))
    vim.cmd(string.format("%s%s", range, [[s/Away/Home/g]]))
    vim.cmd(string.format("%s%s", range, [[s/{temp}/away/g]]))
    vim.cmd(string.format("%s%s", range, [[s/{Temp}/Away/g]]))
  end

  -- Restore the previous state of hlsearch
  vim.opt.hlsearch = hlsearch
end

map(
  "n",
  "<leader>fw",
  "<cmd>lua require('telescope.builtin').live_grep({ additional_args = { '-u' } })<CR>",
  { desc = "Live Grep including hidden files" }
)
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to implementation" })
map("n", "<leader>cc", "<cmd>lua require('osc52').copy_operator()<CR>", { desc = "Copy to clipboard" })
map("v", "<leader>cc", "<cmd>lua require('osc52').copy_visual()<CR>", { desc = "Copy to clipboard" })
map("n", "<leader>mm", "<cmd>Telescope make <CR>", { desc = "Makefile" })

map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "Toggle breakpoint" })
map("n", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "Continue" })
map("n", "<leader>xx", "<cmd>lua require('nvchad.tabufline').close_buffer()<CR>", { desc = "Close buffer" })

map("n", "<leader>O", "<cmd> Oil <CR>", { desc = "Oil" })

map("n", "<leader>kx", "<cmd>TroubleToggle<CR>", { desc = "Toggle LSP Trouble" })
map("n", "<leader>kw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "LSP Workspace Diagnistics" })
map("n", "<leader>kd", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "LSP Document Diagnistics" })
map("n", "<leader>kl", "<cmd>TroubleToggle loglist<CR>", { desc = "LSP Trouble LogList" })
map("n", "<leader>kq", "<cmd>TroubleToggle quickfix<CR>", { desc = "LSP Quickfix List" })
map("n", "<leader>kR", "<cmd>TroubleToggle lsp_references<CR>", { desc = "LSP References" })

map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action" })
map("v", "<leader>ca", "<cmd>'<,'>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action" })

-- Xcodebuild mappings
map("n", "<leader>al", "<cmd> XcodebuildToggleLogs <CR>", { desc = "Show build logs" })
-- map("n", "<leader>aL", "<cmd> LspRestart | LspStart sourcekit <CR>", { desc = "Restart LSP" })
map("n", "<leader>aL", function()
  vim.cmd("LspRestart")
  vim.cmd("LspStart sourcekit")
end, { desc = "Restart LSP" })
map("n", "<leader>ab", "<cmd> XcodebuildBuild <CR>", { desc = "Build" })
map("n", "<leader>ar", "<cmd> XcodebuildBuildRun <CR>", { desc = "Build and run" })
map("n", "<leader>at", "<cmd> XcodebuildTest <CR>", { desc = "Test" })
map("n", "<leader>af", "<cmd> XcodebuildTestFailing <CR>", { desc = "Test Failed" })
map("n", "<leader>as", "<cmd> XcodebuildFailingSnapshots <CR>", { desc = "Show snapshots" })
map("n", "<leader>aS", "<cmd> XcodebuildSelectScheme <CR>", { desc = "Show snapshots" })
map("n", "<leader>aT", "<cmd> XcodebuildTestClass <CR>", { desc = "Test Class" })
map("n", "<leader>X", "<cmd> XcodebuildPicker <CR>", { desc = "Picker" })
map("n", "<leader>ad", "<cmd> XcodebuildSelectDevice <CR>", { desc = "Select device" })
map("n", "<leader>ap", "<cmd> XcodebuildSelectTestPlan <CR>", { desc = "Select Test plan" })
map("n", "<leader>aq", "<cmd> Telescope quickfix <CR>", { desc = "Telescope quickfix" })

map("n", "<leader>p", "<cmd> lua require('dropbar.api').pick()<CR>", { desc = "Pick from breadcrumbs" })
map("v", "<leader>cg", function()
  toggle_home_away()
end, { desc = "Change home to away" })

-- Custom function mappings
map(
  "n",
  "<leader>xg",
  "<cmd> lua run_command_async('tuist generate -n') <CR>",
  { desc = "Generate Tuist project silently" }
)
map(
  "n",
  "<leader>xG",
  "<cmd> lua run_command_async('tuist generate') <CR>",
  { desc = "Generate Tuist project silently" }
)
map("n", "<C-b>", "<cmd> lua require('dap').toggle_breakpoint() <CR>", { desc = "Toggle breakpoint" })
map(
  "n",
  "<leader>dp",
  "<cmd> lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) <CR>",
  { desc = "Set log point" }
)
map(
  "n",
  "<leader>dd",
  "<cmd> lua require('xcodebuild.dap').build_and_debug(true) <CR>",
  { desc = "Xcode Build & Debug" }
)
map(
  "n",
  "<leader>dr",
  "<cmd> lua require('xcodebuild.dap').debug_without_build(true) <CR>",
  { desc = "Xcode Debug without Build" }
)
map("n", "<leader>dR", "<cmd> lua require('dapui').open({reset=true}) <CR>", { desc = "Xcode Debug" })
map("n", "<leader>dc", "<cmd> DapContinue <CR>", { desc = "Continue" })
map("n", "<leader>ds", "<cmd> DapStepOver <CR>", { desc = "Step Over" })
map("n", "<leader>di", "<cmd> DapStepInto <CR>", { desc = "Step Into" })
map("n", "<leader>do", "<cmd> DapStepOut <CR>", { desc = "Step Out" })
map("n", "<leader>du", "<cmd> lua local dapui = require('dapui'); dapui.toggle() <CR>", { desc = "Toggle DAP UI" })
map(
  "n",
  "<leader>dx",
  "<cmd> lua local dap = require('dap'); dap.terminate(); require('xcodebuild.actions').cancel(); local success, dapui = pcall(require, 'dapui'); if success then dapui.close() end <CR>",
  { desc = "Terminate and Close DAP" }
)

map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to definition" })
