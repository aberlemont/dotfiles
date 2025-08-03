return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = { "nvim-lua/plenary.nvim" },
  module = "telescope",
  config = function()

    local actions = require "telescope.actions"

    local select_one_or_multi = function(prompt_bufnr)
      local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()
      if not vim.tbl_isempty(multi) then
        actions.close(prompt_bufnr)
        for _, j in pairs(multi) do
          if j.path ~= nil then
            vim.cmd(string.format('%s %s', 'edit', j.path))
          end
        end
      else
        actions.select_default(prompt_bufnr)
      end
    end

    local smart_send_to_qflist = function(prompt_bufnr)
      local picker = require("telescope.actions.state").get_current_picker(prompt_bufnr)
      local multi = picker:get_multi_selection()
      if not vim.tbl_isempty(multi) then
          actions.send_selected_to_qflist(prompt_bufnr)
      else
          actions.send_to_qflist(prompt_bufnr)
      end
      actions.open_qflist(prompt_bufnr)
    end

    require('telescope').setup({
      defaults = {
        mappings = {
          i = {
              ["<CR>"] = select_one_or_multi,
              ["<C-q>"] = smart_send_to_qflist,
          },
        },
        layout_strategy = 'vertical',
        layout_config = {
          width = 0.95,
          height = 0.95
        },
      },
      pickers = {
        buffers = {
            ignore_current_buffer = true,
            sort_lastused = true,
        },
      },
    })

    local builtin = require('telescope.builtin')

    -- imported mappings
    vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
    vim.keymap.set("n", "<leader>fr", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>fh", ":Telescope find_files hidden=true <CR>")
    vim.keymap.set('n', '<leader>pWs', function()
      local word = vim.fn.expand("<cWORD>")
      builtin.grep_string({ search = word })
    end)

    -- own mappings
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", ";", builtin.buffers, {})
    vim.keymap.set("n", "<leader>o", ":Telescope find_files cwd=.")
    vim.keymap.set('n', '<leader>*', function()
      local word = vim.fn.expand("<cword>")
      builtin.grep_string({ search = word })
    end)
  end
}
