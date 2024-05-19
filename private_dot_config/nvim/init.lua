-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- set shell to zsh
vim.o.shell = "/bin/bash"
if vim.fn.has('nvim-0.10') == 1 then
  vim.opt.clipboard = 'unnamedplus'
  vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
      ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
      ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
      ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
      ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
    },
  }
end
