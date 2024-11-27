-- Set tab and indentation settings
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.shiftwidth = 4        -- Number of spaces to use for each indentation level
vim.opt.tabstop = 4           -- Number of spaces a <Tab> character counts for
vim.opt.softtabstop = 4       -- Number of spaces a <Tab> counts for while editing
vim.opt.number = true

-- Ensure packer is loaded
vim.cmd [[packadd packer.nvim]]
vim.cmd [[colorscheme onedark]]


-- Initialize Packer
require('packer').startup(function(use)
  -- Packer itself
  use 'wbthomason/packer.nvim'

  use 'joshdick/onedark.vim'
  -- Mason for managing language servers
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'  -- Bridges Mason with nvim-lspconfig
  
  -- Neovim's built-in LSP configuration plugin
  use 'neovim/nvim-lspconfig'

  -- Optionally, add completion plugin for better coding experience
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/vim-vsnip'
  use 'hrsh7th/cmp-vsnip'


    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

end)



-- Load and configure Mason
require("mason").setup()

-- Ensure Mason-LSPconfig bridges Mason and nvim-lspconfig
require("mason-lspconfig").setup()

-- Configure Neovim's built-in LSP with lspconfig
local lspconfig = require('lspconfig')

-- Example of configuring C++ server clangd
lspconfig.clangd.setup{}

-- Example of configuring Python server pyright
lspconfig.pyright.setup{}



require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "cpp", "typescript", "javascript" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- nvim-cmp setup
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- Set up vsnip as the snippet engine
    end,
  },
  mapping = {
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item() -- Select the next item in the suggestion list
      elseif vim.fn  == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-j>", true, true, true), "")
      else
        fallback() -- Fallback to normal tab behavior
      end
    end, { "i", "s" }),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item() -- Select the previous item in the suggestion list
      elseif vim.fn["vsnip#jumpable"](-1) == 1 then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-k>", true, true, true), "")
      else
        fallback()
      end
    end, { "i", "s" }),

    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Confirm the selection
    ['<C-Space>'] = cmp.mapping.complete(), -- Trigger completion manually
    ['<C-e>'] = cmp.mapping.close(), -- Close the completion menu
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- Snippet completion
    { name = 'buffer' }, -- Buffer completion
    { name = 'path' }, -- Path completion
  },
})

-- Helper function to check if words exist before the cursor

