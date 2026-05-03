local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then vim.fn.system({ "git","clone","--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath }) end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({ { "folke/tokyonight.nvim" }, { "nvim-lualine/lualine.nvim" }, { "nvim-tree/nvim-tree.lua" }, { "nvim-treesitter/nvim-treesitter", build=":TSUpdate" }, { "neovim/nvim-lspconfig" }, { "williamboman/mason.nvim" }, { "williamboman/mason-lspconfig.nvim" }, { "hrsh7th/nvim-cmp" }, { "hrsh7th/cmp-nvim-lsp" } })

vim.cmd("colorscheme tokyonight")
