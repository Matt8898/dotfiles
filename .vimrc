set nocompatible
filetype off               

call vundle#rc()

set term=builtin_ansi
syntax on
set laststatus=2
let g:airline#extensions#tabline#enabled = 1
syntax enable
let g:syntastic_python_python_exec = '/usr/bin/python3'
map <C-n> :NERDTreeToggle<CR>
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
nnoremap <C-t>     :tabnew<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
inoremap <C-t>     <Esc>:tabnew<CR>
let g:airline_theme='solarized'
if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif
set background=dark
let g:solarized_visibility = "high"
let g:solarized_contrast = "high"
colorscheme solarized
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
let g:airline_powerline_fonts = 1
:set guioptions-=T  "remove toolbar
:set guioptions-=r  "remove right-hand scroll bar
:set guioptions-=L  "remove left-hand scroll bar
let g:solarized_termcolors=256

if exists("g:loaded_linuxsty")
finish
endif
let g:loaded_linuxsty = 1
set wildignore+=*.ko,*.mod.c,*.order,modules.builtin
augroup linuxsty
autocmd!
autocmd FileType c,cpp call s:LinuxFormatting()
autocmd FileType c,cpp call s:LinuxKeywords()
autocmd FileType c,cpp call s:LinuxHighlighting()
autocmd FileType diff,kconfig setlocal tabstop=8
augroup END
function s:LinuxFormatting()
setlocal tabstop=8
setlocal shiftwidth=8
setlocal softtabstop=8
setlocal textwidth=80
setlocal noexpandtab
setlocal cindent
setlocal formatoptions=tcqlron
setlocal cinoptions=:0,l1,t0,g0,(0
endfunction
function s:LinuxKeywords()
syn keyword cOperator likely unlikely
syn keyword cType u8 u16 u32 u64 s8 s16 s32 s64
endfunction
function s:LinuxHighlighting()
highlight default link LinuxError ErrorMsg
syn match LinuxError / \+\ze\t/ " spaces before tab
syn match LinuxError /\s\+$/ " trailing whitespaces
syn match LinuxError /\%81v.\+/ " virtual column 81 and more
endfunction
" vim: ts=4 et sw=4
