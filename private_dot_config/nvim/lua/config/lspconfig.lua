--local config = require("plugins.configs.lspconfig")

local on_attach = function(cl, bf)
  -- make sure to attach only once per client per buffer
  --require("vim.lsp").buf.attach_client(bf, cl)
end
local capabilities = vim.lsp.protocol.make_client_capabilities()
local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "python" },
})

lspconfig.sourcekit.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "swift" },
})

lspconfig.graphql.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "graphql" },
})

lspconfig.clangd.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "c" },
})
lspconfig.gopls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "go" },
})
lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "lua" },
})
-- lspconfig.haskell_language_server.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   filetypes = {"haskell", "hs"}
-- }
