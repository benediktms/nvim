local utils = require('lua/utils')
local map = utils.map
local map_lua = utils.map_lua
local map_buf = utils.map_buf

-- map leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

options = { noremap = true }

map('n', '<leader><esc>', ':nohlsearch<cr>', options)
map('n', '<M>k', ':bnext<cr>', options)
map('n', '<M>j', ':bprev<cr>', options)
map('n', '<leader>x', ':bd<cr>', options)

map('n', '<leader>ff', ':Telescope find_files<cr>', options)
map('n', '<leader>fg', ':Telescope live_grep<cr>', options)
map('n', '<leader>fb', ':Telescope buffers<cr>', options)
map('n', '<leader>fh', ':Telescope help_tags<cr>', options)

map('i', '<expr><C-space>', 'compe#complete()')
map('i', '<expr><CR>', "compe#confirm(luaeval('require 'nvim-autopairs'.autopairs_cr()'))")
map('i', '<expr><C-e>', "compe#scroll({'delta': +4})")
map('i', '<expr><C-d>', "compe#scroll({'delta': -4})")

local t = function(str)
  return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn['vsnip#available'](1) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn['compe#complete']()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn['vsnip#jumpable'](-1) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    -- If <S-Tab> is not working in your terminal, change it to <C-h>
    return t "<S-Tab>"
  end
end

map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

map('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map_buf('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map_buf('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map_buf('n', 'gh', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map_buf('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map_buf('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map_buf('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  map_buf('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  map_buf('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  map_buf('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map_buf('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map_buf('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map_buf('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  map_buf('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  map_buf('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  map_buf('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  map_buf('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  map_buf("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
