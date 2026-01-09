return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        cspell_ls = {
          settings = {
            cspell = {
              -- Add words directly here
              words = { "mycustomword" },
              -- Or link to a dictionary file
              dictionaries = { "project-words" },
              dictionaryDefinitions = {
                { name = "project-words", path = vim.fn.expand("./spell/en.utf-8.add"), addWords = true },
              },
            },
          },
        },
      },
    },
  },
}
