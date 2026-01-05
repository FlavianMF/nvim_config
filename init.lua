-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.opt.spell = true -- Enable spell checking globally
vim.opt.spelllang = "en_us,pt_br" -- Set primary (US) and secondary (UK) languages
-- vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add" -- Optional: Custom dictionary path
