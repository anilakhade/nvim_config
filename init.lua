-- =============================================================================
-- This is my neovim setup

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = ""
vim.opt.clipboard = "unnamedplus"
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.foldenable = true

-- ==============================================================================

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- ==============================================================================

require("lazy").setup({
	{"EdenEast/nightfox.nvim"},
	{"nvim-tree/nvim-tree.lua"},
    {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},
    {"williamboman/mason.nvim"},
    {"williamboman/mason-lspconfig.nvim"},
    {"neovim/nvim-lspconfig"},
    {"hrsh7th/nvim-cmp"},
    {"L3MON4D3/LuaSnip"},
    {"hrsh7th/cmp-nvim-lsp"},
    {"windwp/nvim-autopairs"},
    {"nvim-lua/plenary.nvim"},
    {"nvim-telescope/telescope.nvim"},
    {"nvim-lualine/lualine.nvim"},
    {"numToStr/Comment.nvim"},
    {"lukas-reineke/indent-blankline.nvim", main = "ibl"},
    {"lewis6991/gitsigns.nvim"},
    {"akinsho/bufferline.nvim", version = "*"},
    {"akinsho/toggleterm.nvim", version = "*"},
    {"folke/which-key.nvim"},
    {"j-hui/fidget.nvim", tag = "legacy"},
    {"ThePrimeagen/harpoon", branch = "harpoon2"},
    {"folke/trouble.nvim"},
    {"simrat39/symbols-outline.nvim"},
    {"hrsh7th/cmp-cmdline"},
})


-- Theme =======================================================================

vim.cmd.colorscheme("carbonfox") 
-- all themes options 
-- nightfox, dayfox, dawnfox, duskfox, nordfox, terafox, carbonfox


-- SetUp =======================================================================
require("nvim-tree").setup()

require("nvim-treesitter.configs").setup({
    highlight = { enable = true },
    indent = { enable = true },
})

require("mason").setup()
require("mason-lspconfig").setup()
require("telescope").setup()
require("lualine").setup()
require("nvim-autopairs").setup()
require("Comment").setup()
require("ibl").setup()
require("gitsigns").setup()
require("bufferline").setup()
require("toggleterm").setup()
require("which-key").setup()
require("fidget").setup()
require("trouble").setup()

vim.deprecate = function() end
require("symbols-outline").setup()

-- ============================================================================

local harpoon = require("harpoon")
harpoon:setup()


vim.lsp.config("clangd", {})
vim.lsp.enable("clangd")

vim.lsp.config("pyright", {})
vim.lsp.enable("pyright")

vim.lsp.inlay_hint.enable(true)

local cmp = require("cmp")

-- =============================================================================

cmp.setup({
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },

    sources = {
        { name = "nvim_lsp" },
    },

    mapping = cmp.mapping.preset.insert({
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
    }),
})

-- =============================================================================

-- cmdline completion
local cmp = require("cmp")

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "cmdline" }
    }
})


-- =============================================================================

vim.keymap.set("n", "gd", vim.lsp.buf.definition)
vim.keymap.set("n", "gD", vim.lsp.buf.declaration)
vim.keymap.set("n", "gr", vim.lsp.buf.references)
vim.keymap.set("n", "K", vim.lsp.buf.hover)
vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)

vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files)
vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep)
vim.keymap.set("n", "<leader>fb", require("telescope.builtin").buffers)
vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags)

vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")

vim.keymap.set("n", "<leader>t", "<cmd>ToggleTerm<CR>")

vim.keymap.set("n", "<leader>a", function() require("harpoon"):list():add() end)

vim.keymap.set("n", "<leader>h", function() require("harpoon").ui:toggle_quick_menu(require("harpoon"):list()) end)

vim.keymap.set("n", "<leader>1", function() require("harpoon"):list():select(1) end)
vim.keymap.set("n", "<leader>2", function() require("harpoon"):list():select(2) end)
vim.keymap.set("n", "<leader>3", function() require("harpoon"):list():select(3) end)
vim.keymap.set("n", "<leader>4", function() require("harpoon"):list():select(4) end)

vim.keymap.set("n", "<leader>x", "<cmd>Trouble diagnostics toggle<CR>")
vim.keymap.set("n", "<leader>xs", "<cmd>Trouble symbols toggle<CR>")
vim.keymap.set("n", "<leader>xr", "<cmd>Trouble lsp_references toggle<CR>")

vim.keymap.set("n", "<leader>ih", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

vim.keymap.set("n", "<leader>o", "<cmd>SymbolsOutline<CR>")
