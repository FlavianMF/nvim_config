-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- vim.opt.spell = true -- Enable spell checking globally
vim.opt.spelllang = "en_us,pt_br" -- Set primary (US) and secondary (UK) language
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add" -- Optional: Custom dictionary path

vim.opt.colorcolumn = "80"

local cmp = require("cmp")

cmp.setup({
  mapping = vim.tbl_extend("force", cmp.mapping.defaults(), {
    -- Use Tab to confirm the selection or select the first item if none is selected
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          -- Select the first item automatically if nothing is selected
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        else
          -- Confirm the currently selected item
          cmp.confirm({ select = true })
        end
      else
        -- If no completion menu is visible, perform a normal Tab (indentation)
        fallback()
      end
    end, { "i", "s", "c" }), -- Modes: Insert, Select, Command

    -- Use Enter (CR) to insert a newline without confirming the completion
    ["<CR>"] = cmp.mapping(function(fallback)
      -- If the completion menu is visible, abort the completion popup
      if cmp.visible() then
        cmp.abort()
      end
      -- Fallback to the default Enter behavior (insert a newline)
      fallback()
    end, { "i", "s" }),

    -- Optional: Remap the default Tab/S-Tab keys for cycling through items if needed
    -- ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), -- Next item
    -- ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), -- Previous item
  }),
  -- ... other cmp options ...
  completion = {
    completeopt = "menu,menuone,noselect", -- Prevents auto-selecting the first item so Enter works as intended
  },
})
