	"autocmd! bufwritepost .vimrc source %
set nocompatible
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_config_file = '.clang_complete'
let g:syntastic_cpp_compiler_options = '-fPIC'
let g:syntastic_check_on_open = 1
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1

let g:clang_complete_copen = 1
let g:clang_user_options='|| exit 0'
let g:clang_auto_select = 1
"let g:clang_use_library=1

au! BufEnter *.cc let b:fswitchdst = 'h' | let b:fswitchlocs = './'
au! BufEnter *.h let b:fswitchdst = 'cc,c' | let b:fswitchlocs = './'

call pathogen#infect()
"set autoindent
set smartindent
set cursorline
set mouse=a
set showmatch
"colorscheme marklar
set ruler
set wrap
set incsearch
set number
set laststatus=2
set t_Co=256
set encoding=utf-8 
"let g:Powerline_theme = 'solarized256'
"set foldmethod=indent
set nofoldenable
let g:DisableAutoPHPFolding = 1 


syntax on
let mojo_highlight_data = 1
set hls
set softtabstop=4
set shiftwidth=4
set expandtab

if has("persistent_undo")
    set undodir =~/.undodir//
    set undofile
endif

"set nowrap linebreak textwidth=80
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*


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
autocmd BufNewFile,BufRead *.exs set filetype=elixir
autocmd BufNewFile,BufRead *.sls set filetype=yaml

"autocmd Filetype cpp set tags+=~/.vim/tags/stdlib
autocmd Filetype cpp set tags+=~/.vim/tags/qtcore
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType cpp set omnifunc=complete#CompleteTags
"autocmd FileType cpp set omnifunc=omni#cpp#complete#Main
autocmd FileType css,scss,styl set omnifunc=htmlcomplete#CompleteCSS
autocmd Filetype ruby compiler ruby

inoremap ( ()<Left>
inoremap <expr> )  strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap [ []<Left>
inoremap <expr> ]  strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
inoremap { {}<Left>
inoremap <expr> }  strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"


"Omni complete related
map <F12> :!ctags -R --sort=yes --c++-kinds=+svpctn --fields=+iaS --extra=+q .<CR> 

"let OmniCpp_NamespaceSearch = 2
let OmniCpp_DisplayMode = 1
"let OmniCpp_ShowPrototypeInAbbr = 1
let OmniCpp_MayCompleteDot = 1
let OmniCpp_MayCompleteArrow = 1
let OmniCpp_MayCompleteScope = 1

set completeopt=menuone,menu,longest,preview

set complete-=i

let g:ctrlp_z_nerdtree = 1
let g:ctrlp_extensions = ['Z', 'F']
nnoremap sz :CtrlPZ<Cr>
nnoremap sf :CtrlPF<Cr>

autocmd CursorMovedI * if pumvisible()  == 0|pclose|endif
autocmd InsertLeave * if pumvisible()  == 0|pclose|endif

map <C-b> :!make<CR>
map <C-u> :!./run_tests --log_level=test_suite<CR>
map <C-c> :!make clean
map <C-t> :!make test<CR>
map fe :NERDTreeToggle<CR>

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

noremap ,t :call PyUnitRunTests()<CR>
noremap! ,t <Esc>:call PyUnitRunTests()<CR>

"let g:PyUnitTestsStructure = 'side-by-side'
"let g:PyUnitConfirmTestCreation = 1

let g:django_projects = '~/sophic/repos'
let g:django_activate_virtualenv = 1 

" use cppcheck
"comp cppcheck

" plug make ouput on quickfix window
command -nargs=* Make make <args> | cwindow 10

nnoremap <F9> i<CR><ESC>
let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_auto_select = 1
" Disable neocomplete for python
" Use jedi instead
autocmd FileType python NeoComplCacheLock
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h
map <c-q> <c-w>q

" default the statusline to green when entering
" Vim
hi statusline guibg=DarkGrey ctermfg=8 guifg=White ctermbg=15
"

set statusline =%#identifier#
set statusline+=[%t] "tail of the filename
set statusline+=%*

set statusline+=%#warningmsg#
set statusline+=%{&ff!='unix'?'['.&ff.']':''}
set statusline+=%*

set statusline+=%#warningmsg#
set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
set statusline+=%*

set statusline+=%h "help file flag
set statusline+=%y "filetype

set statusline+=%#identifier#
set statusline+=%r
set statusline+=%*

set statusline+=%#identifier#
set statusline+=%m
set statusline+=%*

set statusline+=%{fugitive#statusline()}

set statusline+=%#error#
set statusline+=%{StatuslineTabWarning()}
set statusline+=%*

set statusline+=%{StatuslineTrailingSpaceWarning()}

"set statusline+=%{StatuslineLongLineWarning()}

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

set statusline+=%#error#
set statusline+=%{&paste?'[paste]':''}
set statusline+=%*

set statusline+=%= "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\ \ "current highlight
set statusline+=%c, "cursor column
set statusline+=%l/%L "cursor line/total lines
set statusline+=\ %P "percent through file
hi Visual  ctermfg=White ctermbg=LightBlue cterm=none

function! StatuslineTrailingSpaceWarning()
    if !exists("b:statusline_trailing_space_warning")
        if !&modifiable
            let b:statusline_trailing_space_warning = ''
            return b:statusline_trailing_space_warning
        endif
        if search('\s\+$', 'nw') != 0
            let b:statusline_trailing_space_warning = '[\s]'
        else
            let b:statusline_trailing_space_warning = ''
        endif
    endif
    return b:statusline_trailing_space_warning
endfunction

function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction


function! StatuslineTabWarning()
    if !exists("b:statusline_tab_warning")
        let b:statusline_tab_warning = ''
        if !&modifiable
            return b:statusline_tab_warning
        endif

        let tabs = search('^\t', 'nw') != 0

        "find spaces that
        "arent used as
        "alignment in the
        "first indent column
        let spaces = search('^ \{' . &ts . ',}[^\t]', 'nw') != 0
        
        if tabs && spaces
            let b:statusline_tab_warning = '[mixed-indenting]'
        elseif (spaces && !&et) || (tabs && &et)
            let b:statusline_tab_warning = '[&et]'
        endif
    endif
    return b:statusline_tab_warning
endfunction

let g:tagbar_autoclose = 0
let g:tagbar_usearrows = 1
nnoremap <silent> <Leader>b :TagbarToggle<CR>


set colorcolumn=80

map ev :vsplit
map ee :split

" Some git aliases for figutive usage
map gci :Gcommit<CR>
map glola :Git lola<CR>
map glol :Git lol<CR>
map ga :Gwrite<CR>
map gst :Gstatus<CR>
map gl :Glog<CR>

map jk <ESC>

"FSwitch mappings
nmap <silent> <Leader>of :FSHere<cr>
nmap <silent> <Leader>oL :FSSplitRight<cr>
nmap <silent> <Leader>oJ :FSSplitBelow<cr>

