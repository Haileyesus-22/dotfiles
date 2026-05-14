-- ── Options ───────────────────────────────────────────────
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.clipboard = "unnamedplus"

-- ── Leader key ────────────────────────────────────────────
vim.g.mapleader = " "

-- ── Theme ─────────────────────────────────────────────────
require("catppuccin").setup({ flavour = "mocha" })
vim.cmd.colorscheme("catppuccin")

-- ── Keymaps ───────────────────────────────────────────────
local map = vim.keymap.set

-- navigation
map("n", "<C-h>", "<C-w>h")
map("n", "<C-l>", "<C-w>l")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")

-- file tree
map("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
local ts = require("telescope.builtin")
map("n", "<leader>ff", ts.find_files)
map("n", "<leader>fg", ts.live_grep)
map("n", "<leader>fb", ts.buffers)

-- lazygit
map("n", "<leader>g", ":term lazygit<CR>")

-- ── Plugins ───────────────────────────────────────────────
require("nvim-tree").setup()
require("lualine").setup({ options = { theme = "catppuccin" } })
require("gitsigns").setup()
require("nvim-autopairs").setup()
require("Comment").setup()

-- ── LSP ───────────────────────────────────────────────────
local lsp = require("lspconfig")
local caps = require("cmp_nvim_lsp").default_capabilities()

lsp.ts_ls.setup({ capabilities = caps })
lsp.rust_analyzer.setup({ capabilities = caps })

map("n", "gd", vim.lsp.buf.definition)
map("n", "K", vim.lsp.buf.hover)
map("n", "<leader>rn", vim.lsp.buf.rename)
map("n", "<leader>ca", vim.lsp.buf.code_action)

-- ── Completion ────────────────────────────────────────────
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then cmp.select_next_item()
      else fallback() end
    end, { "i", "s" }),
  }),
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
  },
  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },
})
