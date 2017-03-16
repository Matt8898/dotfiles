call plug#begin('~/.local/share/nvim/plugged')

Plug 'mhinz/vim-startify'
Plug('scrooloose/nerdtree')
Plug('flazz/vim-colorschemes')
Plug('raimondi/delimitmate')
Plug('bling/vim-airline')
Plug('vim-airline/vim-airline-themes')
Plug('Shougo/deoplete.nvim')
Plug('zchee/deoplete-clang')
Plug('zchee/deoplete-jedi')
Plug('mbbill/undotree')
Plug('rust-lang/rust.vim')
Plug('sebastianmarkow/deoplete-rust')
Plug('Yggdroot/indentLine')
Plug('ryanoasis/vim-devicons')
Plug('https://github.com/vim-syntastic/syntastic.git')
Plug('majutsushi/tagbar')
Plug('ctrlpvim/ctrlp.vim')
Plug('sbdchd/neoformat')
Plug('junegunn/vim-easy-align')
Plug('easymotion/vim-easymotion')
Plug('airblade/vim-gitgutter')
Plug('tpope/vim-fugitive')

call plug#end()

"Keybinds
map <C-n> :NERDTreeToggle<CR>
nnoremap <C-t>    :tabnew<CR>
nnoremap <C-p>    :tabnext<CR>
nnoremap <C-o>    :tabprevious<CR>
map <C-L> :bnext<CR>
map <C-K> :bprev<CR>
nnoremap <F5> :UndotreeToggle<cr>
nnoremap <F6> :call SplitTerm()<CR>
nmap <F8> :TagbarToggle<CR>
let g:ctrlp_map = '<c-i>'
"Map esc to exit terminal mode.
tnoremap <Esc> <C-\><C-n>
filetype plugin indent on
syntax enable
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"Functions
function SplitTerm()
	split
	wincmd j
	terminal
	resize 10
	wincmd k
endfunction

"Plugin configuration
"Airline
let g:airline_powerline_fonts = 1
let g:gruvbox_contrast_dark='hard'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "badwolf"
silent! call airline#extensions#whitespace#disable().
"Deoplete
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/include/clang/'
let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#d#dcd_server_autostart = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
set hidden
let g:deoplete#sources#rust#racer_binary= "/usr/bin/racer"
let g:deoplete#sources#rust#rust_source_path='/usr/src/rust/src/'
" au FileType rust call SuperTabSetDefaultCompletionType("<c-x><c-o>")
let g:deoplete#disable_auto_complete = 0
		inoremap <silent><expr> <TAB>
		\ pumvisible() ? "\<C-n>" :
		\ <SID>check_back_space() ? "\<TAB>" :
		\ deoplete#mappings#manual_complete()
		function! s:check_back_space() abort "{{{
		let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~ '\s'
	endfunction"}}}
set nu
set completeopt-=preview
"Startify
let g:startify_custom_header = [
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

colorscheme badwolf
function! s:filter_header(lines) abort
        let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
        let centered_lines = map(copy(a:lines),
            \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
        return centered_lines
    endfunction

let g:startify_custom_header = s:filter_header(startify#fortune#boxed())
set encoding=utf8
set guifont=DroidSansMonoForPowerline\ Nerd\ Font:style=Book\ 11

" Idea: Vim "setup" plugin
