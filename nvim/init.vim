call plug#begin('~/.local/share/nvim/plugged')
set viminfo="NONE"
set shada="NONE"
set shada="NONE"
let g:ale_completion_enabled = 1
let g:ale_c_parse_makefile = 1
Plug 'mhinz/vim-startify'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'
Plug('scrooloose/nerdtree')
Plug('zah/nim.vim')
Plug('tpope/vim-surround')
Plug('flazz/vim-colorschemes')
Plug('luochen1990/rainbow')
Plug('ntpeters/vim-better-whitespace')
Plug 'parsonsmatt/intero-neovim'
Plug('raimondi/delimitmate')
Plug('bling/vim-airline')
Plug('vim-airline/vim-airline-themes')
Plug('rust-lang/rust.vim')
Plug('Yggdroot/indentLine')
Plug('ryanoasis/vim-devicons')
Plug('majutsushi/tagbar')
Plug('sbdchd/neoformat')
Plug('junegunn/vim-easy-align')
Plug('airblade/vim-gitgutter')
Plug('tpope/vim-fugitive')
Plug('udalov/kotlin-vim')
Plug('JuliaEditorSupport/julia-vim')
Plug('simnalamburt/vim-mundo')
Plug 'chriskempson/base16-vim'
"Plug 'ncm2/ncm2'
"Plug 'ncm2/ncm2-path'
"Plug 'roxma/nvim-yarp'
"Plug 'ncm2/ncm2-pyclang'
"Plug 'ncm2/ncm2-jedi'
"Plug 'artur-shaik/vim-javacomplete2'
"Plug 'ObserverOfTime/ncm2-jc2', {'for': ['java', 'jsp']}
Plug 'l04m33/vlime', {'rtp': 'vim/'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
let g:rainbow_active = 1
" set termguicolors
"Keybinds
map <C-n> :NERDTreeToggle<CR>
map <C-p> :bnext<CR>
map <C-o> :bprev<CR>
nnoremap <F5> :MundoToggle<cr>
nnoremap <F6> :call TermToggle(12)<CR>
nmap <F8> :TagbarToggle<CR>
"Map esc to exit terminal mode.
tnoremap <Esc> <C-\><C-n>
filetype plugin indent on
syntax enable
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        let g:term_win = win_getid()
    endif
endfunction


"Plugin configuration
" LanguageClient
" Required for operations modifying multiple buffers like rename.
set hidden

"    \ 'python' : ['/home/matt/.local/bin/pyls'],
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" Airline
let g:airline_powerline_fonts = 1
let g:gruvbox_contrast_dark='hard'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "hybrid"
silent! call airline#extensions#whitespace#disable().
"Startify
\ '  __     ___        ',
\ '  \ \   / (_)_ __ ___  ',
\ '   \ \ / /| | ''_ ` _ \ ',
\ '    \ V / | | | | | | |',
\ '     \_/  |_|_|_|_|_|_|',
\ '',
\ '',
\ ]
let g:startify_custom_header =
          \ 'map(g:ascii + startify#fortune#boxed(), "\"   \".v:val")'

function! s:filter_header(lines) abort
        let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
        let centered_lines = map(copy(a:lines),
            \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
        return centered_lines
    endfunction

let g:startify_custom_header = s:filter_header(startify#fortune#boxed())
set encoding=utf8
set number
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>

set undofile
au BufRead,BufNewFile *.asm set filetype=nasm
set undodir=~/.vim/undo

" pyclang
" path to directory where libclang.so can be found
" or path to the libclang.so file
let g:ncm2_pyclang#library_path = '/usr/lib64/libclang.so'
autocmd FileType c,cpp nnoremap <buffer> gd :<c-u>call ncm2_pyclang#goto_declaration()<cr>
" Java complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete

colorscheme Benokai
set tabstop=4
set shiftwidth=4
autocmd FileType json syntax match Comment +\/\/.\+$+
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

let g:vlime_cl_use_terminal = 1
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<C-l>'
let g:coc_snippet_prev = '<C-k>'
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() :
                                           \"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
