 " .vimrc

" Set values {{{
set t_Co=256
set background=dark
"colorscheme jellybeans

set nocompatible
set tabstop=4  
set shiftwidth=4
set expandtab       
set smarttab        
set showcmd         
set number          
set relativenumber
set showmatch       
set hlsearch        
set incsearch       
set ignorecase      
set smartcase       
set backspace=2     
set autoindent      
set smartindent
set formatoptions=c,q,r,t
set ruler      
set laststatus=2
set textwidth=999
set splitright
set splitbelow
set exrc
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif
filetype indent on
"set mouse=a
set spell spelllang=en_us

syntax on
set noshowmatch
autocmd BufNewFile,BufRead *.lys set syntax=lisp

set pastetoggle=<F2>
" Ignore these for any vim file auto complete.
set wildignore+=*/tmp/*,*/temp/*,*.so,*.swp,*.zip,*.meta,*.swo,*.exe,*.bak,*.png,*.jpg,*.d,*.o
set wildmode=list:longest
" }}}

" Neobundle config {{{
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
"NeoBundle 'itchyny/lightline.vim'
NeoBundle 'bling/vim-airline'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'paradigm/TextObjectify'
NeoBundle 'mattn/emmet-vim'
"NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'Raimondi/delimitMate'
"NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'jiangmiao/simple-javascript-indenter'
" Seems to interfer when creating a shell from vim, also don't use it.
"NeoBundle 'jaxbot/brolink.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
"NeoBundle 'garbas/vim-snipmate'
"NeoBundle 'honza/vim-snippets'
" Why jedi so slow :(
"NeoBundle 'davidhalter/jedi-vim'
"NeoBundle 'mhinz/vim-blockify'
"NeoBundle 'Valloric/MatchTagAlways'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'junegunn/vim-easy-align'
"NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'AndrewRadev/switch.vim'
"NeoBundle 'mbbill/undotree'
NeoBundle 'morhetz/gruvbox'
NeoBundle 'PeterRincker/vim-argumentative'
"NeoBundle 'SirVer/ultisnips'
"NeoBundle 'honza/vim-snippets'
"NeoBundle 'astrellon/my_ultisnippets'
NeoBundle 'vim-scripts/ShaderHighLight'
NeoBundle 'leafgarland/typescript-vim'
NeoBundle 'prabirshrestha/asyncomplete.vim'
NeoBundle 'OmniSharp/omnisharp-vim'
NeoBundle 'puremourning/vimspector'
"NeoBundle 'neoclide/coc.nvim'

call neobundle#end()

let delimitMate_expand_cr=1
let delimitMate_expand_space=1

filetype plugin indent on

NeoBundleCheck

colorscheme gruvbox
" }}}

autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Save and reload buffer positions {{{
" VimTip 80: Restore cursor to file position in previous editing session
" for unix/linux/solaris
  set viminfo='10,\"100,:20,%,n~/.viminfo

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END
 
autocmd BufWinLeave .* mkview
autocmd BufWinEnter .* silent loadview
" }}}

" Diff with saved function {{{
function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()
com! Q q
" }}}

" Nice text folding {{{
function! NeatFoldText() 
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction
set foldtext=NeatFoldText()

function! NeatFoldExpr()
    let line = getline(v:lnum)

    " Undefined for empty lines
    if line =~? '\v^\s*$'
        return '-1'
    endif
    " Add one for the start of a multiline comment
    if line =~? '\v^\s*/\*'
        return 'a1'
    endif
    " Subtract one for the end of a multiline comment
    if line =~? '\v^\s*\**\*/'
        return 's1'
    endif
    " Add one for a marker
    if line =~ '{{{'

        return 'a1'
    endif
    " Subtract one for a marker
    if line =~ '}}}'
        return 's1'
    endif

    " Else this line is the save as above
    return '='
endfunction
set foldmethod=marker
set foldexpr=NeatFoldExpr()
" }}}

" Remapping {{{
let mapleader=","
map <C-a> <C-u>
silent! nmap <F3> :NERDTreeToggle<CR>
silent! map <F4> :NERDTreeFind<CR>
imap jk <Esc>
map <Space> :w<CR>

map <silent> <C-a> <C-u>

" navigation for ctrlp
imap <silent> <C-h> <left>
imap <silent> <C-j> <down>
imap <silent> <C-k> <up>
imap <silent> <C-l> <right>

nnoremap <C-J> <C-W><C-J> "Ctrl-j to move down a split  
nnoremap <C-K> <C-W><C-K> "Ctrl-k to move up a split  
nnoremap <C-L> <C-W><C-L> "Ctrl-l to move right a split  
nnoremap <C-H> <C-W><C-H> "Ctrl-h to move left a split  

nnoremap j gj
nnoremap k gk

nnoremap ; :

map <silent> <leader>x <C-y>,

" Don't move on *
nnoremap * *<c-o>

" Move to start and end of lines
noremap H ^
noremap L $

" Move to start and end of line in insert mode
inoremap <c-a> <esc>I
inoremap <c-e> <esc>A

" Split line, reverse of J
nnoremap S i<cr><esc><right>
noremap <leader>s i<cr><esc><right>O
inoremap <c-]> {<cr>}<esc>O
" Mappings for adding brackets after pressing enter.
inoremap {<cr> {<cr>}<esc>O
inoremap [<cr> [<cr>]<esc>O
inoremap (<cr> (<cr>)<esc>O
inoremap {% { %><cr><% } %><esc>O<tab>
" Wrap line below inside { }'s 
inoremap {j {<esc>j>>o}

" Shortcuts for dealing with system clipboard.
nnoremap cp "+p
nnoremap cP "+P
nnoremap cy "+y

" Match whole line
inoremap <c-l> <c-x><c-l>
" Match filename
inoremap <c-f> <c-x><c-f>

nnoremap <leader>p :pclose<CR>
inoremap <leader>p :pclose<CR>

function! CopenMake()
    :copen | make
endfunction

nnoremap <leader>m :call CopenMake()<CR>
" }}}

" Next and Last {{{
"
" Motion for "next/last object".  "Last" here means "previous", not "final".
" Unfortunately the "p" motion was already taken for paragraphs.
"
" Next acts on the next object of the given type, last acts on the previous
" object of the given type.  These don't necessarily have to be in the current
" line.
"
" Currently works for (, [, {, and their shortcuts b, r, B. 
"
" Next kind of works for ' and " as long as there are no escaped versions of
" them in the string (TODO: fix that).  Last is currently broken for quotes
" (TODO: fix that).
"
" Some examples (C marks cursor positions, V means visually selected):
"
" din'  -> delete in next single quotes                foo = bar('spam')
"                                                      C
"                                                      foo = bar('')
"                                                                C
"
" canb  -> change around next parens                   foo = bar('spam')
"                                                      C
"                                                      foo = bar
"                                                               C
"
" vin"  -> select inside next double quotes            print "hello ", name
"                                                       C
"                                                      print "hello ", name
"                                                             VVVVVV

onoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
xnoremap an :<c-u>call <SID>NextTextObject('a', '/')<cr>
onoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>
xnoremap in :<c-u>call <SID>NextTextObject('i', '/')<cr>

onoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
xnoremap al :<c-u>call <SID>NextTextObject('a', '?')<cr>
onoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>
xnoremap il :<c-u>call <SID>NextTextObject('i', '?')<cr>


function! s:NextTextObject(motion, dir)
    let c = nr2char(getchar())
    let d = ''

    if c ==# "b" || c ==# "(" || c ==# ")"
        let c = "("
    elseif c ==# "B" || c ==# "{" || c ==# "}"
        let c = "{"
    elseif c ==# "r" || c ==# "[" || c ==# "]"
        let c = "["
    elseif c ==# "'"
        let c = "'"
    elseif c ==# '"'
        let c = '"'
    else
        return
    endif

    " Find the next opening-whatever.
    execute "normal! " . a:dir . c . "\<cr>"

    if a:motion ==# 'a'
        " If we're doing an 'around' method, we just need to select around it
        " and we can bail out to Vim.
        execute "normal! va" . c
    else
        " Otherwise we're looking at an 'inside' motion.  Unfortunately these
        " get tricky when you're dealing with an empty set of delimiters because
        " Vim does the wrong thing when you say vi(.

        let open = ''
        let close = ''

        if c ==# "(" 
            let open = "("
            let close = ")"
        elseif c ==# "{"
            let open = "{"
            let close = "}"
        elseif c ==# "["
            let open = "\\["
            let close = "\\]"
        elseif c ==# "'"
            let open = "'"
            let close = "'"
        elseif c ==# '"'
            let open = '"'
            let close = '"'
        endif

        " We'll start at the current delimiter.
        let start_pos = getpos('.')
        let start_l = start_pos[1]
        let start_c = start_pos[2]

        " Then we'll find it's matching end delimiter.
        if c ==# "'" || c ==# '"'
            " searchpairpos() doesn't work for quotes, because fuck me.
            let end_pos = searchpos(open)
        else
            let end_pos = searchpairpos(open, '', close)
        endif

        let end_l = end_pos[0]
        let end_c = end_pos[1]

        call setpos('.', start_pos)

        if start_l == end_l && start_c == (end_c - 1)
            " We're in an empty set of delimiters.  We'll append an "x"
            " character and select that so most Vim commands will do something
            " sane.  v is gonna be weird, and so is y.  Oh well.
            execute "normal! ax\<esc>\<left>"
            execute "normal! vi" . c
        elseif start_l == end_l && start_c == (end_c - 2)
            " We're on a set of delimiters that contain a single, non-newline
            " character.  We can just select that and we're done.
            execute "normal! vi" . c
        else
            " Otherwise these delimiters contain something.  But we're still not
            " sure Vim's gonna work, because if they contain nothing but
            " newlines Vim still does the wrong thing.  So we'll manually select
            " the guts ourselves.
            let whichwrap = &whichwrap
            set whichwrap+=h,l

            execute "normal! va" . c . "hol"

            let &whichwrap = whichwrap
        endif
    endif
endfunction

" }}}

" Numbers {{{

" Motion for numbers.  Great for CSS.  Lets you do things like this:
"
" margin-top: 200px; -> daN -> margin-top: px;
"              ^                          ^
" TODO: Handle floats.

onoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
xnoremap N :<c-u>call <SID>NumberTextObject(0)<cr>
onoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap aN :<c-u>call <SID>NumberTextObject(1)<cr>
onoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>
xnoremap iN :<c-u>call <SID>NumberTextObject(1)<cr>

function! s:NumberTextObject(whole)
    let num = '\v[0-9]'

    " If the current char isn't a number, walk forward.
    while getline('.')[col('.') - 1] !~# num
        normal! l
    endwhile

    " Now that we're on a number, start selecting it.
    normal! v

    " If the char after the cursor is a number, select it.
    while getline('.')[col('.')] =~# num
        normal! l
    endwhile

    " If we want an entire word, flip the select point and walk.
    if a:whole
        normal! o

        while col('.') > 1 && getline('.')[col('.') - 2] =~# num
            normal! h
        endwhile
    endif
endfunction

" }}}

" Super tab settings {{{
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1
"let g:SuperTabDefaultCompletionType = "context"
" }}}

" NERDTree settings {{{
let NERDTreeIgnore = ['\.pyc$','\.d$','\.o$']
" }}}

" CtrlP settings {{{
let g:ctrlp_root_markers=['.ctrlp']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn))|(temp|node_modules)$',
  \ 'file': '\v\.(exe|so|dll|meta|swp|swo|bak|png|jpg|d|o)$',
  \ }
" }}}

" Search for selected text. {{{
" http://vim.wikia.com/wiki/VimTip171
let s:save_cpo = &cpo | set cpo&vim
if !exists('g:VeryLiteral')
  let g:VeryLiteral = 0
endif
function! s:VSetSearch(cmd)
  let old_reg = getreg('"')
  let old_regtype = getregtype('"')
  normal! gvy
  if @@ =~? '^[0-9a-z,_]*$' || @@ =~? '^[0-9a-z ,_]*$' && g:VeryLiteral
    let @/ = @@
  else
    let pat = escape(@@, a:cmd.'\')
    if g:VeryLiteral
      let pat = substitute(pat, '\n', '\\n', 'g')
    else
      let pat = substitute(pat, '^\_s\+', '\\s\\+', '')
      let pat = substitute(pat, '\_s\+$', '\\s\\*', '')
      let pat = substitute(pat, '\_s\+', '\\_s\\+', 'g')
    endif
    let @/ = '\V'.pat
  endif
  normal! gV
  call setreg('"', old_reg, old_regtype)
endfunction
vnoremap <silent> * :<C-U>call <SID>VSetSearch('/')<CR>/<C-R>/<CR>
vnoremap <silent> # :<C-U>call <SID>VSetSearch('?')<CR>?<C-R>/<CR>
vmap <kMultiply> *
nmap <silent> <Plug>VLToggle :let g:VeryLiteral = !g:VeryLiteral
  \\| echo "VeryLiteral " . (g:VeryLiteral ? "On" : "Off")<CR>
if !hasmapto("<Plug>VLToggle")
  nmap <unique> <Leader>vl <Plug>VLToggle
endif
let &cpo = s:save_cpo | unlet s:save_cpo
" }}}

" Emmet settings {{{
let g:user_emmet_leader_key='<leader>.'
autocmd FileType html,css,js EmmetInstall
" }}}

" File Type settings {{{
autocmd Filetype html setlocal ts=2 sts=2 sw=2
autocmd Filetype ruby setlocal ts=2 sts=2 sw=2
autocmd Filetype javascript setlocal ts=4 sts=4 sw=4
" }}}

" Push to Sketchup {{{
" Add this to your .vimrc or autoload it.
function! s:PushToSketchup()
    :w !curl --data-binary "@-" http://localhost:2345
endfunction
com! PushSKP call s:PushToSketchup()
" }}}

" Simply Javascript Indenter config {{{
let g:SimpleJsIndenter_BriefMode = 1
" }}}

" Filetype specific settings {{{

au BufNewFile,BufRead,BufEnter *.cpp,*.hpp set omnifunc=omni#cpp#complete#Main
au BufNewFile,BufRead,BufEnter *.ejs set filetype=html sw=2
au BufNewFile,BufRead,BufEnter *.css set syntax=css sw=4
au BufNewFile,BufRead,BufEnter *.dot set filetype=html sw=2
au BufNewFile,BufRead,BufEnter *.py let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"

" }}}

" Easy Align {{{
vmap <Enter> <Plug>(EasyAlign)

nmap <Leader>a <Plug>(EasyAlign)
" }}}

" YouCompleteMe config {{{
nnoremap <leader>jd :YcmCompleter GoTo<CR>
let g:ycm_confirm_extra_conf = 0
" }}}

let g:OmniSharp_server_use_net6 = 1
let g:vimspector_base_dir='~/.vim/bundle/vimspector'

" switch.vim config {{{
let g:switch_mapping = "-"
" }}}

" Undotree config {{{
"if has("persistent_undo")
"    set undodir='~/.undodir/'
"    set undofile
"endif
"
"au BufReadPost * call ReadUndo()
"au BufWritePost * call WriteUndo()
"func ReadUndo()
"    if filereadable(expand('%:h'). '/.undodir/' . expand('%:t'))
"        rundo %:h/.undodir/%:t
"    endif
"endfunc
"func WriteUndo()
"    let dirname = expand('%:h') . '/.undodir'
"    if !isdirectory(dirname)
"        call mkdir(dirname)
"    endif
"    wundo %:h/.undodir/%:t
"endfunc
"
nnoremap <F5> :UndotreeToggle<cr>
" }}}

" Airline config {{{
let g:airline_powerline_fonts = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline_section_b = '%{getcwd()}'

function! AirlineInit()
    let g:parent_folder = pathshorten(expand('%:p:h'))
    let g:airline_section_b = airline#section#create_left(['%{parent_folder}'])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
" }}}

" UltiSnips config {{{
let g:UltiSnipsExpandTrigger="<c-h>"
let g:UltiSnipsListSnippets="<c-l>"
" }}}
