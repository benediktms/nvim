local o = vim.o -- vim.api.nvim_set_option() — global options
local wo = vim.wo -- vim.api.nvim_buf_set_option() — buffer-local options
local bo = vim.bo -- vim.api.nvim_win_set_option() - window-local options

local utils = require('utils')

-- global options
o.hlsearch = true
o.incsearch = true
o.ignorecase = true
o.updatetime = 300
o.termguicolors = true
o.clipboard = [[unnamed,unnamedplus]]
o.mouse = 'a'
o.completeopt = "menuone,noselect"

-- vimscrip commands
vim.cmd('au FileType gitcommit setlocal tw=72')
-- vim.api.nvim_command('set auread=true')

-- buffer options
bo.tabstop = 2
bo.shiftwidth = 2
bo.softtabstop = 2
bo.expandtab = true
bo.smartindent = true

-- window options
wo.number = true
wo.relativenumber = true
wo.cursorline = true
wo.wrap = false

-- initialize plugins
require('lua/plugins')

-- configs to load after plugins
vim.cmd('colo dracula')

require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = "> ",
    selection_caret = "> ",
    entry_prefix = "  ",
    initial_mode = "insert",
    selection_strategy = "reset",
    sorting_strategy = "descending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        mirror = false,
      },
      vertical = {
        mirror = false,
      },
    },
    file_sorter =  require'telescope.sorters'.get_fuzzy_file,
    file_ignore_patterns = {},
    generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
    winblend = 0,
    border = {},
    borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
    color_devicons = true,
    use_less = true,
    path_display = {},
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
    grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
    qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

    -- Developer configurations: Not meant for general override
    buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
  }
}

require('lualine').setup{
  options = {theme = 'dracula-nvim'}
}

require('lua/mappings')

utils.create_augroup({
  {'FileType', '*', 'setlocal', 'shiftwidth=2'},
}, 'Shiftwidth')

require('nvim-autopairs').setup()

require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };
  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
  };
}
