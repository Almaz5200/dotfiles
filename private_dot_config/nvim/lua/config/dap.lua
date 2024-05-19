local dap = require("dap")
local xcodebuild = require("xcodebuild.dap")

dap.configurations.swift = {
  {
    name = "iOS App Debugger",
    type = "codelldb",
    request = "attach",
    program = xcodebuild.get_program_path,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    waitFor = true,
  },
}

dap.adapters.codelldb = {
  type = "server",
  port = "13000",
  executable = {
    -- TODO: make sure to set path to your codelldb
    command = os.getenv("HOME") .. "/nvimPlugins/codelldb/extension/adapter/codelldb",
    args = {
      "--port",
      "13000",
      "--liblldb",
      "/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB",
    },
  },
}

vim.g.rustaceanvim = function()
  -- Update this path
  local extension_path = vim.env.HOME .. "/nvimPlugins/codelldb/extension/"
  local codelldb_path = extension_path .. "adapter/codelldb"
  local liblldb_path = extension_path .. "lldb/lib/liblldb"
  local this_os = vim.uv.os_uname().sysname

  liblldb_path = liblldb_path .. (this_os == "Linux" and ".so" or ".dylib")

  local cfg = require("rustaceanvim.config")
  return {
    dap = {
      adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
    },
  }
end

-- nice breakpoint icons
local define = vim.fn.sign_define
define("DapBreakpoint", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
define("DapBreakpointRejected", { text = "", texthl = "DiagnosticError", linehl = "", numhl = "" })
define("DapStopped", { text = "", texthl = "DiagnosticOk", linehl = "", numhl = "" })
define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
define("DapLogPoint", { text = "", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
