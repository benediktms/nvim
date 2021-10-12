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
o.exrc = true
o.secure = true
o.signcolumn = "yes"

-- vimscrip commands
vim.cmd('au FileType gitcommit setlocal tw=72')
vim.cmd('au TextYankPost * silent! lua vim.highlight.on_yank{}')

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
require('plugins')

-- configs to load after plugins
require('lsp-config')

require'nvim-treesitter.configs'.setup {
  context_commentstring = {
    enable = true
  }
}

vim.cmd('colo tokyonight')

require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg', '--color=never', '--no-heading', '--with-filename',
            '--line-number', '--column', '--smart-case'
        },
        prompt_prefix = "> ",
        selection_caret = "> ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_config = {
            horizontal = {mirror = false},
            vertical = {mirror = false}
        },
        file_sorter = require'telescope.sorters'.get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require'telescope.sorters'.get_generic_fuzzy_sorter,
        winblend = 0,
        border = {},
        borderchars = {'─', '│', '─', '│', '╭', '╮', '╯', '╰'},
        color_devicons = true,
        use_less = true,
        path_display = {},
        set_env = {['COLORTERM'] = 'truecolor'}, -- default = nil,
        file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
        grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
        qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    }
}

require('lualine').setup {options = {theme = 'tokyonight'}}

require'nvim-tree'.setup()

utils.create_augroup({{'FileType', '*', 'setlocal', 'shiftwidth=2'}},
                     'Shiftwidth')

require('nvim-autopairs').setup()

require'compe'.setup {
    enabled = true,
    autocomplete = true,
    debug = false,
    min_length = 1,
    preselect = 'enable',
    throttle_time = 80,
    source_timeout = 200,
    resolve_timeout = 800,
    incomplete_delay = 400,
    max_abbr_width = 100,
    max_kind_width = 100,
    max_menu_width = 100,
    documentation = {
        border = {'', '', '', ' ', '', '', '', ' '}, -- the border option is the same as `|help nvim_open_win|`
        winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
        max_width = 120,
        min_width = 60,
        max_height = math.floor(vim.o.lines * 0.3),
        min_height = 1
    },
    source = {
        path = true,
        buffer = true,
        calc = true,
        nvim_lsp = true,
        nvim_lua = true,
        spelling = true
    }
}

-- require('lspsaga').init_lsp_saga()

require('lspkind').init({
    -- enables text annotations
    --
    -- default: true
    with_text = true,

    -- default symbol map
    -- can be either 'default' or
    -- 'codicons' for codicon preset (requires vscode-codicons font installed)
    --
    -- default: 'default'
    preset = 'codicons',

    -- override preset symbols
    --
    -- default: {}
    symbol_map = {
        Text = '',
        Method = 'ƒ',
        Function = '',
        Constructor = '',
        Variable = '',
        Class = '',
        Interface = 'ﰮ',
        Module = '',
        Property = '',
        Unit = '',
        Value = '',
        Enum = '了',
        Keyword = '',
        Snippet = '﬌',
        Color = '',
        File = '',
        Folder = '',
        EnumMember = '',
        Constant = '',
        Struct = ''
    }
})

require'lspinstall'.setup() -- important

local servers = require'lspinstall'.installed_servers()
for _, server in pairs(servers) do require'lspconfig'[server].setup {} end

local function setup_servers()
    require'lspinstall'.setup()
    servers = require'lspinstall'.installed_servers()
    for _, server in pairs(servers) do require'lspconfig'[server].setup {} end
end
setup_servers()

-- Automatically reload after `:LspInstall <server>` so we don't have to restart neovim
require'lspinstall'.post_install_hook = function()
    setup_servers() -- reload installed servers
    vim.cmd("bufdo e") -- this triggers the FileType autocmd that starts the server
end

require('gitsigns').setup()

require('mappings')
