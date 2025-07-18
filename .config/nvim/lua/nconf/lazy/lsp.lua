return {
  "neovim/nvim-lspconfig",
  version = "*", -- remove after they fix ESLint
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
  },

  config = function()
    local lspconfig_defaults = require('lspconfig').util.default_config
    lspconfig_defaults.capabilities = vim.tbl_deep_extend(
      'force',
      lspconfig_defaults.capabilities,
      require('cmp_nvim_lsp').default_capabilities()
      )

    vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = {buffer = event.buf}
          opts.desc = "Show documentation for what is under cursor"
          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          opts.desc = "Show LSP definition"
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          opts.desc = "Show LSP declaration"
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          opts.desc = "Show LSP implementation"
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          opts.desc = "Show LSP type definition"
          vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          opts.desc = "Show LSP references"
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          opts.desc = "Show LSP signature help"
          vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
          opts.desc = "Show LSP smart rename"
          vim.keymap.set('n', 'rn', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
          opts.desc = "Show LSP format buffer"
          vim.keymap.set({'n', 'x'}, '<leader>fs', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          opts.desc = "Show LSP code action"
          vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
          opts.desc = "Show buffer diagnostics"
          vim.keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)
          opts.desc = "Show line diagnostics"
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line
          opts.desc = "Go to previous diagnostic"
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer
          opts.desc = "Go to next diagnostic"
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer
        end,
      })

    -----------
    -- SERVERS
    require'lspconfig'.clangd.setup{}
    -----------

    local cmp = require('cmp')

    cmp.setup({
      sources = {
        {name = "nvim_lsp"},
        {name = "luasnip"},
      },
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body)
          -- vim.snippet.expand(args.body)
        end,
      },
      preselect = 'item',
      completion = {
        completeopt = 'menu,menuone,noinsert'
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({select = false}),
        -- Jump to the next snippet placeholder
        ['<C-f>'] = cmp.mapping(function(fallback)
          local luasnip = require('luasnip')
          if luasnip.locally_jumpable(1) then
            luasnip.jump(1)
          else
            fallback()
          end
        end, {'i', 's'}),
        -- Jump to the previous snippet placeholder
        ['<C-b>'] = cmp.mapping(function(fallback)
          local luasnip = require('luasnip')
          if luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {'i', 's'}),
      }),
    })
  end
}
