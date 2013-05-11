	"autocmd! bufwritepost .vimrc source %
set nocompatible
call pathogen#infect()
"set autoindent
set smartindent
set mouse=a
set showmatch
"colorscheme marklar
set ruler
set wrap
set incsearch
set number

syntax on
let mojo_highlight_data = 1
set hls

set softtabstop=4
set shiftwidth=4
set expandtab

set wrap linebreak textwidth=0

filetype plugin on
set grepprg=grep\ -nH\ $*
let g:tex_flavor='latex'

set backspace=indent,eol,start

autocmd BufNewFile *.erl exe "normal! i-module(". expand('%:t:r') . ").\n-compile(export_all).\n\n"
autocmd BufNewFile *.java exe "normal! ipublic class ". expand('%:t:r'). " {\n\n\tpublic ".expand('%:t:r') ."() {\n\n}\n}\n"
autocmd BufNewFile *.cu exe "normal! i__global__ void ". expand('%:t:r'). "() {\n\n}\n"
autocmd BufNewFile,BufRead *.pro set filetype=make

autocmd BufNewFile,BufRead SCons* set filetype=scons
autocmd BufNewFile,BufRead *.ninja set filetype=ninja

"autocmd Filetype cpp set tags+=~/.vim/tags/stdlib
"autocmd Filetype cpp set tags+=~/.vim/tags/qt4
autocmd Filetype ruby compiler ruby

inoremap ( ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap [ []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap { {}<Left>
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"


"Omni complete related
"map <F12> :!ctags -R --sort=yes --c++-kinds=+svpctn --fields=+iaS --extra=+q .<CR> 

"let OmniCpp_NamespaceSearch = 2
"let OmniCpp_DisplayMode = 1
"let OmniCpp_ShowPrototypeInAbbr = 1
"let OmniCpp_MayCompleteDot = 1
"let OmniCpp_MayCompleteArrow = 1
"let OmniCpp_MayCompleteScope = 1

"set completeopt=menuone,menu,longest,preview

"autocmd CursorMovedI * if pumvisible()  == 0|pclose|endif
"autocmd InsertLeave * if pumvisible()  == 0|pclose|endif

map <C-b> :!make<CR>
map <C-u> :!./run_tests --log_level=test_suite<CR>
map <C-c> :!make clean
map <C-t> :!make test<CR>

",v brings up my .vimrc
"",V reloads it -- making all changes active (have to save first) 

map ,v :sp /home/jurnell/.vimrc<CR><C-W>_
map <silent> ,V :source /home/jurnell/.vimrc<CR>:filetype detect<CR>:exe ":echo 'vimrc reloaded'"<CR>

let vimclojure#HighlightBuiltins=1
let vimclojure#ParenRainbow=1


let g:clojure_simplefold_nestable_start_expr = '\v\(defn'
let g:clojure_simplefold_nestable_end_expr = '\v^\s*$'

let g:C_Styles = { '*.c' : 'default', '*.h,*.cc,*.cpp,*.hh,*.hpp' : 'CPP' }

map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

noremap ; :

map <C-h> :tabprevious<CR> 
map <C-l> :tabnext<CR> 
map <C-left> :tabprevious<CR>
map <C-right> :tabnext<CR>
noremap [ {
noremap ] }

nmap <F4> :%s//gc<left><left><left>
map <F1> :%s/<C-r><C-w>//gc<left><left><left>

let g:tex_flavor='latex'

set directory=~/.backup//

imap ii <Esc>
imap ,, <Esc>
nnoremap aa :let @/=""<CR>

" latex suite settings
let g:Tex_Env_frame = "\\begin{frame}{<++>}\<CR><++>\<CR>\\end{frame}\<CR>\<CR><++>"
let g:Tex_Env_fframe = "\\begin{fframe}[<++>]{<++>}\<CR><++>\<CR>\\end{fframe}\<CR>\<CR><++>"
let g:Tex_Env_sverb = "\\begin{sverb}\<CR>\uncover\<<++>\>{<++>}\<CR>\\end{sverb}"
let g:Tex_AutoFolding = 0

" use cppcheck
comp cppcheck

" plug make ouput on quickfix window
command -nargs=* Make make <args> | cwindow 10

" toggles the quickfix window.
"command -bang -nargs=? QFix call
"#QFixToggle(<bang>0)
"function! QFixToggle(forced)
"	if exists("g:qfix_win") && a:forced == 0
"		cclose
"	else
"		execute "copen 10"
"	endif
"endfunction

" used to track the quickfix window
"augroup QFixToggle
"	autocmd!
"	autocmd BufWinEnter quickfix let g:qfix_win = bufnr("$")
"	autocmd BufWinLeave * if exists("g:qfix_win") && expand("<abuf>") == g:qfix_win | unlet! g:qfix_win | endif
"augroup END

" show/hide quickfix window
"noremap <silent> <F7> <ESC>:QFix<CR>

nnoremap <F9> i<CR><ESC>
