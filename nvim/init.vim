call plug#begin('~/.local/share/nvim/plugged')

Plug 'mhinz/vim-startify'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug('scrooloose/nerdtree')
Plug('tpope/vim-surround')
Plug('gcmt/wildfire.vim')
Plug('kovisoft/slimv')
Plug('kien/rainbow_parentheses.vim')
Plug('ntpeters/vim-better-whitespace')
Plug('SpaceVim/cscope.vim')
Plug 'parsonsmatt/intero-neovim'
Plug('flazz/vim-colorschemes')
Plug('idanarye/vim-vebugger')
Plug('raimondi/delimitmate')
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug('bling/vim-airline')
Plug('vim-airline/vim-airline-themes')
Plug('Shougo/deoplete.nvim')
Plug('zchee/deoplete-jedi')
Plug('Rip-Rip/clang_complete')
Plug('simnalamburt/vim-mundo')
Plug('rust-lang/rust.vim')
Plug('Yggdroot/indentLine')
Plug('ryanoasis/vim-devicons')
Plug('neomake/neomake')
Plug('majutsushi/tagbar')
Plug('ctrlpvim/ctrlp.vim')
Plug('sbdchd/neoformat')
Plug('junegunn/vim-easy-align')
Plug('easymotion/vim-easymotion')
Plug('airblade/vim-gitgutter')
Plug('tpope/vim-fugitive')

call plug#end()

"Keybinds
map <Leader> <Plug>(easymotion-prefix)
map <C-n> :NERDTreeToggle<CR>
nnoremap <C-t>    :tabnew<CR>
nnoremap <C-p>    :tabnext<CR>
nnoremap <C-o>    :tabprevious<CR>
map <C-L> :bnext<CR>
map <C-K> :bprev<CR>
nnoremap <F5> :MundoToggle<cr>
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
" LanguageClient
" Required for operations modifying multiple buffers like rename.
set hidden

let g:LanguageClient_serverCommands = {
    \ 'rust': ['rls'],
    \ }

" Automatically start language servers.
let g:LanguageClient_autoStart = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
" Rainbow
let g:rbpt_loadcmd_toggle = 0
let g:rbpt_loadcmd_toggle = 0
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
" Airline
let g:airline_powerline_fonts = 1
let g:gruvbox_contrast_dark='hard'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme = "badwolf"
silent! call airline#extensions#whitespace#disable().
" Deoplete
let g:clang_library_path='/usr/lib/libclang.so'
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
" au FileType rust call SuperTabSetDefaultCompletionType("<c-x><c-o>")
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
" Neomake
" When writing a buffer.
call neomake#configure#automake('w')
" When writing a buffer, and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing.
call neomake#configure#automake('rw', 1000)
" Cscope.vim
nnoremap <leader>fa :call CscopeFindInteractive(expand('<cword>'))<CR>
nnoremap <leader>l :call ToggleLocationList()<CR>
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>
" Vim-slime
let g:slime_target = "neovim"

set encoding=utf8
set number

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
set undofile
au BufRead,BufNewFile *.asm set filetype=nasm
set undodir=~/.vim/undo
