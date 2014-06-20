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
"set textwidth=79    
set formatoptions=c,q,r,t
set ruler      
" set mouse=a         
set laststatus=2

syntax on
set noshowmatch

set pastetoggle=<F2>
" Ignore these for any vim file auto complete.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.meta,*.swo,*.exe,*.bak
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
set foldmethod=marker
" }}}

" Remapping {{{
map <C-a> <C-u>
silent! nmap <F3> :NERDTreeToggle<CR>
silent! map <F4> :NERDTreeFind<CR>
silent! imap ii <Esc>
nmap <Space> :w<CR>

map <silent> <C-a> <C-u>

" navigation for ctrlp
imap <silent> <C-h> <left>
imap <silent> <C-j> <down>
imap <silent> <C-k> <up>
imap <silent> <C-l> <right>
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
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|meta|swp|swo|bak)$',
  \ }
" }}}

