<<<<<<< HEAD
" .vimrc
" See: http://vimdoc.sourceforge.net/htmldoc/options.html for details

" For multi-byte character support (CJK support, for example):
"set fileencodings=ucs-bom,utf-8,cp936,big5,euc-jp,euc-kr,gb18030,latin1

set nocompatible
"filetype off

"set rtp+=~/.vim/bundle/vundle
"call vundle#rc()

"Bundle 'Valloric/YouCompleteMe'

"filetype plugin indent on
execute pathogen#infect()


set t_Co=256
colorscheme jellybeans
       
set tabstop=4       " Number of spaces that a <Tab> in the file counts for.
 
set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.
 
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.
 
set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.
 
set showcmd         " Show (partial) command in status line.

set number          " Show line numbers.

 set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.
 
 set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
 
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
 
set ignorecase      " Ignore case in search patterns.
 
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
 
set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.
 
set autoindent      " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).
 
set textwidth=79    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.
 
set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode. 
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)
 
set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.
 
set background=dark " When set to "dark", Vim will try to use colors that look
                    " good on a dark background. When set to "light", Vim will
                    " try to use colors that look good on a light background.
                    " Any other value is illegal.
 
set mouse=a         " Enable the use of the mouse.

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

function! s:DiffWithSaved()
    let filetype=&ft
    diffthis
    vnew | r # | normal! 1Gdd
    diffthis
    exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
com! DiffSaved call s:DiffWithSaved()

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
set foldmethod=marker

map <C-a> <C-u>

filetype plugin indent on
syntax on
set noshowmatch
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

"Super tab settings
autocmd FileType cs setlocal let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1
" Allows for yanking and pasting to a common file
vmap <silent> ,y y:new<CR>:call setline(1,getregtype())<CR>o<Esc>P:wq! ~/.vimpaste<CR>
nmap <silent> ,y :new<CR>:call setline(1,getregtype())<CR>o<Esc>P:wq! ~/.vimpaste<CR>
map <silent> ,p :sview ~/.vimpaste<CR>"zdddG:q!<CR>:call setreg('"', @", @z)<CR>p
map <silent> ,P :sview ~/.vimpaste<CR>"zdddG:q!<CR>:call setreg('"', @", @z)<CR>P

" autocmd VimEnter * NERDTree
let NERDTreeIgnore = ['\.pyc$','\.d$','\.o$']

"silent! nmap <C-a> :NERDTreeToggle<CR>
silent! map <F3> :NERDTreeFind<CR>
silent! imap ii <Esc>

" navigation for ctrlp
imap <silent> <C-h> <left>
imap <silent> <C-j> <down>
imap <silent> <C-k> <up>
imap <silent> <C-l> <right>

set pastetoggle=<F2>

 " let g:NERDTreeMapActivateNode="<F3>"
 " let g:NERDTreeMapPreview="<F4>"
=======
" .vimrc

" Set values {{{
set t_Co=256
colorscheme jellybeans

set nocompatible
set tabstop=4  
set shiftwidth=4
set expandtab       
set smarttab        
set showcmd         
set number          
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
filetype indent on
"set mouse=a

syntax on
set noshowmatch

set pastetoggle=<F2>
" Ignore these for any vim file auto complete.
set wildignore+=*/tmp/*,*/temp/*,*.so,*.swp,*.zip,*.meta,*.swo,*.exe,*.bak,*.png,*.jpg,*.d,*.o
" }}}

" Neobundle config {{{
set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-surround'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'paradigm/TextObjectify'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'digitaltoad/vim-jade'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'mustache/vim-mustache-handlebars'
NeoBundle 'vim-scripts/a.vim'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'jaxbot/brolink.vim'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'tomtom/tlib_vim'
NeoBundle 'MarcWeber/vim-addon-mw-utils'
NeoBundle 'garbas/vim-snipmate'
NeoBundle 'honza/vim-snippets'
" Why jedi so slow :(
"NeoBundle 'davidhalter/jedi-vim'
"NeoBundle 'mhinz/vim-blockify'
NeoBundle 'Valloric/MatchTagAlways'
NeoBundle 'tpope/vim-repeat'
NeoBundle 'junegunn/vim-easy-align'
NeoBundle 'Valloric/YouCompleteMe'

call neobundle#end()

let delimitMate_expand_cr=1
let delimitMate_expand_space=1

filetype plugin indent on

NeoBundleCheck
" }}}

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
silent! imap jk <Esc>
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
noremap L g_

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
"let g:user_emmet_leader_key='<C-x>'
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
" }}}
>>>>>>> 8fd4d8eb7ce7bb1f2b70f30f43c26dd9d9290c41
