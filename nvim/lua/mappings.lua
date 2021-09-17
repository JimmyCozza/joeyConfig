local remap = { noremap = false }
local silentRemap = {noremap = false, silent = true}

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>f', '<cmd>Telescope find_files hidden=true<CR>')
map('n', '<leader>tn', '<cmd>Telescope file_browser<CR>')
map('n', '<leader>tg', ":lua require('telescope.builtin').live_grep({previewer = false})<cr>")

-- add comma to end of line and put cursor back where it was
map('n', ',,', 'm`A,<Esc>``m`')
-- remove last character from line and put cursor back where it was
map('n', '::', 'm`$x<Esc>``m`')

-- mode selection (or line) up or down
map('n', '<c-j>', ':m .+1<CR>==')
map('n', '<c-k>', ':m .-2<CR>==')
map('i', '<c-j>', '<Esc>:m .+1<CR>==gi')
map('i', '<c-k>', '<Esc>:m .-2<CR>==gi')
map('v', '<c-j>', ":m '>+1<CR>gv=gv")
map('v', '<c-k>', ":m '<-2<CR>gv=gv")

map('n', '<Leader>d', ':bdelete<CR>')
map('n', '<Leader><Leader>d', ':bdelete!<CR>')
map('t', '<Leader><Leader>d', '<c-\\><c-n>:bdelete!<CR>')

map('i', 'jk', '<Esc>:w<CR>')

-- leader tab and leader \ for moving between buffers (nice for my ergodox keyboard)
map('n', '<Leader><Tab>', ':bprevious<CR>')
map('n', '<Leader>\\', ':bnext<CR>')

-- this will replace the current word with the last thing yanked. Can be
-- repeated without fear of overriding the last yanked thing
-- delete into blackhole register, then paste 0 register (last yanked item)
map('n', '<Leader>v', '"_diw"0P')

-- Fugitive remappings for ease of use
map('n', '<Leader>gs', ':Gstatus<CR>')
map('n', '<Leader>gb', ':Git blame<CR>')

-- move to next or previous gittable chunk change in file
map('n', '<Leader>hn', '<Plug>(GitGutterNextHunk)', remap)
map('n', '<Leader>hp', '<Plug>(GitGutterPrevHunk)', remap)

-- who needs EX mode? last macro with Q
map('n', 'Q', '@@')

-- CoC doesn't load up locationlist by default, have to run CocDiagnostics first
map('n', '<Leader><Up>', ':CocDiagnostics<CR>')
-- LocationList navigation
map('n', '<Up>', ':lopen<CR>')
map('n', '<Down>', ':lclose<CR>')
map('n', '<Left>', ':lprev<CR>')
map('n', '<Right>', ':lnext<CR>')


map('n', '<Leader>nt', ':NERDTreeFind<CR>', remap)

-- Remap keys for gotos
map('n', 'gd', '<Plug>(coc-definition)', silentRemap)
map('n', 'gy', '<Plug>(coc-type-definition)', silentRemap)
map('n', 'gi', '<Plug>(coc-implementation)', silentRemap)
map('n', 'gr', '<Plug>(coc-references)', silentRemap)

map('n', '<Leader>r', '<Plug>(coc-rename)', remap)
map('n', '<Leader>p', ':CocCommand prettier.formatFile<CR>')
map('n', '<Leader>af', ':CocCommand eslint.executeAutoFix<CR>')
map('n', '<Leader><Leader>p', ":silent %!prettier --stdin --stdin-filepath % --trailing-comma es5 --no-semi --single-quote --print-width 120<CR>")
