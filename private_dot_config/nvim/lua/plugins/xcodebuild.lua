return {
  "wojciech-kulik/xcodebuild.nvim",
  lazy = false,
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("xcodebuild").setup({
      logs = {
        auto_open_on_success_tests = true, -- open logs when tests succeeded
        auto_open_on_failed_tests = true, -- open logs when tests failed
        auto_open_on_success_build = false, -- open logs when build succeeded
        auto_open_on_failed_build = true, -- open logs when build failed
        auto_close_on_app_launch = false, -- close logs when app is launched
        auto_close_on_success_build = false, -- close logs when build succeeded (only if auto_open_on_success_build=false)
        auto_focus = false, -- focus logs buffer when opened
      },
      quickfix = {
        show_warnings_on_quickfixlist = false,
      },
      integrations = {
        xcode_build_server = {
          enabled = true, -- run "xcode-build-server config" when scheme changes
        },
      },
    })
  end,
}
