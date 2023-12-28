return {
  "nvim-telescope/telescope.nvim",
  keys = {
    {
      "<Leader>f/",
      function()
        require("telescope.builtin").live_grep({
          path_display = { tail = true },
          prompt_title = "Search Buffer Content",
          search_dirs = { vim.fn.expand("%:p") },
        })
      end,
    },
  },
}
