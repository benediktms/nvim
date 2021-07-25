local cmd = vim.cmd
local u = require('utils')

u.create_augroup({
    {'BufEnter,FocusGained,InsertLeave', '*', 'set relativenumber'},
    {'BufLeave,FocusLeave,InsertEnter', '*', 'set relativenumber'},
}, 'toggle_relative_number')

