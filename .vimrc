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
set formatoptions=c,q,r,t
set ruler      
set laststatus=2
set textwidth=999

syntax on
set noshowmatch

set pastetoggle=<F2>
" Ignore these for any vim file auto complete.
set wildignore+=*/tmp/*,*/temp/*,*.so,*.swp,*.zip,*.meta,*.swo,*.exe,*.bak,*.png,*.jpg
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
NeoBundle 'pangloss/vim-javascript'
"NeoBundle 'Valloric/YouCompleteMe'

NeoBundle 'Shougo/vimshell'

call neobundle#end()

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
map <C-a> <C-u>
silent! nmap <F3> :NERDTreeToggle<CR>
silent! map <F4> :NERDTreeFind<CR>
silent! imap jk <Esc>
nmap <Space> :w<CR>

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
" }}}

" Super tab settings {{{
let g:SuperTabContextDefaultCompletionType = "<c-x><c-o>"
let g:SuperTabDefaultCompletionTypeDiscovery = ["&omnifunc:<c-x><c-o>","&completefunc:<c-x><c-n>"]
let g:SuperTabClosePreviewOnPopupClose = 1
" }}}

" NERDTree settings {{{
let NERDTreeIgnore = ['\.pyc$','\.d$','\.o$']
" }}}

" CtrlP settings {{{
let g:ctrlp_root_markers=['.ctrlp']
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn))|(temp)$',
  \ 'file': '\v\.(exe|so|dll|meta|swp|swo|bak|png|jpg)$',
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

