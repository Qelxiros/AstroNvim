-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"

vim.cmd "colorscheme tokyonight-night"

local k = vim.api.nvim_set_keymap
local conf = { noremap = true, silent = true }

k("v", "<", "<gv", conf)
k("v", ">", ">gv", conf)
k("x", "<", "<gv", conf)
k("x", ">", ">gv", conf)

k("n", "<M-u>", ":UndotreeToggle<CR>", conf)

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_quickfix_open_on_warning = 0

vim.g.calendar_google_calendar = 1

vim.cmd "source ~/.config/nvim/lua/plugins/configs/credentials.vim"

require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.lsp.inlay_hint.enable(true)
