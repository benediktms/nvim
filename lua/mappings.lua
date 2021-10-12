local utils = require('utils')
local map = utils.map
local vim = vim

-- map leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local options = {noremap = true}

map('n', '<leader><esc>', ':nohlsearch<cr>', options)
map('n', '<M>k', ':bnext<cr>', options)
map('n', '<M>j', ':bprev<cr>', options)
map('n', '<leader>x', ':bd<cr>', options)

map('n', '<leader>f', ':Neoformat<cr>', options)

map('n', '<C-p>', ':Telescope git_files<cr>', options)
map('n', '<leader>ff', ':Telescope find_files<cr>', options)
map('n', '<leader>fg', ':Telescope live_grep<cr>', options)
map('n', '<leader>fb', ':Telescope buffers<cr>', options)
map('n', '<leader>fh', ':Telescope help_tags<cr>', options)

map('i', '<expr><C-space>', 'compe#complete()')
map('i', '<expr><CR>',
    "compe#confirm(luaeval('require 'nvim-autopairs'.autopairs_cr()'))")
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
        -- elseif vim.fn['vsnip#available'](1) == 1 then
        --   return t "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
        -- elseif vim.fn['vsnip#jumpable'](-1) == 1 then
        --   return t "<Plug>(vsnip-jump-prev)"
    else
        -- If <S-Tab> is not working in your terminal, change it to <C-h>
        return t "<S-Tab>"
    end
end

map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

map('i', '<cr>', 'compe#confirm("<cr>")', {expr = true})

-- local options = {noremap = true, silent = true}

-- some additional code navigation keymaps are defined in the lsp
-- map('n', 'gh', ':Lspsaga lsp_finder<cr>', options)
-- map('n', '<leader>ga', ':Lspsaga code_action<cr>', options)
-- map('v', '<leader>ga', ':<C-U>Lspsaga range_code_action<cr>', {silent = true})
-- map('n', 'K', ':Lspsaga hover_doc<cr>', options)
-- map('n', '<C-f>',
--     "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", options)
-- map('n', '<C-b>',
--     "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", options)
-- map('n', 'gs', ':Lspsaga signature_help<cr>', options)
-- map('n', 'gr', ':Lspsaga rename<cr>', options)
-- map('n', '[d', ':Lspsaga diagnostic_jump_next<cr>', options)
-- map('n', ']d', ':Lspsaga diagnostic_jump_prev<cr>', options)

local options = {noremap = true, silent = true}

map('n', "<C-h>", "<CMD>lua require('Navigator').left()<CR>", options)
map('n', "<C-k>", "<CMD>lua require('Navigator').up()<CR>", options)
map('n', "<C-l>", "<CMD>lua require('Navigator').right()<CR>", options)
map('n', "<C-j>", "<CMD>lua require('Navigator').down()<CR>", options)
-- map('n', "<C-p>", "<CMD>lua require('Navigator').previous()<CR>", options)

map('n', "<leader>-", "<C-w>s")
map('n', "<leader>+", "<C-w>v")
map('n', "<leader>x", "<C-w>c")
map('n', "<leader>X", ":bd<CR>")
