require("mason").setup() require("mason-lspconfig").setup({ ensure_installed = { "clangd","pyright","tsserver" } })

local lsp = require("lspconfig")

lsp.clangd.setup({}) lsp.pyright.setup({}) lsp.tsserver.setup({})
