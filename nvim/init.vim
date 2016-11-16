set runtimepath+=/home/matt/.config/nvim/.//repos/github.com/Shougo/dein.vim

call dein#begin('/home/matt/.config/nvim/./')

call dein#add('Shougo/dein.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('flazz/vim-colorschemes')
call dein#add ('raimondi/delimitmate')
call dein#add('bling/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('Shougo/deoplete.nvim')
call dein#add('zchee/deoplete-clang')
call dein#add('ervandew/supertab')
call dein#add('zchee/deoplete-jedi')
call dein#add('sjl/gundo.vim')

call dein#end()
filetype plugin indent on
syntax enable

"Functions
function SplitTerm()
	split
	wincmd j
	terminal
	resize 10
	wincmd k
endfunction


"Keybinds
map <C-n> :NERDTreeToggle<CR>
nnoremap <C-t>    :tabnew<CR>
nnoremap <C-p>    :tabnext<CR>
nnoremap <C-o>    :tabprevious<CR>
nnoremap <F5> :GundoToggle<CR>
nnoremap <F6> :call SplitTerm()<CR>
"Map esc to exit terminal mode.
tnoremap <Esc> <C-\><C-n>

"Plugin configuration
"Airline
let g:airline_powerline_fonts = 1
let g:gruvbox_contrast_dark='hard'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='zenburn'
"Deoplete
let g:deoplete#sources#clang#libclang_path = '/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header = '/usr/include/clang/'
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#disable_auto_complete = 0

colorscheme Monokai
