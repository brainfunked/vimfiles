" Load pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim

" General
set nocompatible
filetype on
filetype plugin on
filetype indent on

" Load plugins
call pathogen#infect()
call pathogen#helptags()

" Theme/Colours
syntax on
set t_Co=256
set background=dark
colorscheme solarized

" Vim UI
set number
"set mouse=a "Use mouse everywhere
runtime macros/matchit.vim "Extended matching with %

" Visual Cues
set showmatch "Show matching brackets
set mat=5
set incsearch
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2 
set hlsearch
set cursorline
set colorcolumn=80
set wildmenu
" Display extra whitespace
set list listchars=tab:»·,trail:·

" Text Formatting/Layout
set ai "autoindent
set si "smartindent
"set cindent "Do C-style indenting
set tabstop=2 "Tab spacing (Settings below are just to unify it)
set softtabstop=2 "Unify
set shiftwidth=2 "Unify
set expandtab "spaces for tabs

" manpage viewing in Vim
runtime ftplugin/man.vim

" latexSuite plugin
set grepprg=grep\ -nH\ $*

" Tab completion
set wildmode=list:longest,list:full
set complete=.,w,t

" Spell check plugin for vim 7
"setlocal spell spelllang=en_gb
"setlocal spell encoding=utf-8
au FileType markdown setlocal spell spelllang=en_gb
au FileType asciidoc setlocal spell spelllang=en_gb
au BufRead, BufNewFile *.md setlocal spell spelllang=en_gb
au BufRead, BufNewFile *.adoc setlocal spell spelllang=en_gb

" Force vertical diff mode
set diffopt+=vertical

" Python
au FileType python setlocal tabstop=4 expandtab shiftwidth=4 softtabstop=4

" Configuration for various plugins
" http://vim.wikia.com/wiki/Using_vim_as_an_IDE_all_in_one
" --------------------
" ShowMarks
" --------------------
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
let g:showmarks_enable = 1
" For marks a-z
highlight ShowMarksHLl gui=bold guibg=LightBlue guifg=Blue
" For marks A-Z
highlight ShowMarksHLu gui=bold guibg=LightRed guifg=DarkRed
" For all other marks
highlight ShowMarksHLo gui=bold guibg=LightYellow guifg=DarkYellow
" For multiple marks on the same line.
highlight ShowMarksHLm gui=bold guibg=LightGreen guifg=DarkGreen

" " -------------------
" " BufExplorer
" " -------------------
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
map <leader>o :BufExplorer<cr>

" " -------------------
" " NERDTree
" " -------------------
let NERDTreeIgnore=['\.vim$', '\~$[[file]]', '^\.git$[[dir]]', '^vendor$[[dir]]', '\.pyc$[[file]]', '\.swp$']
let NERDTreeShowHidden=1
" Open NERDTree when no files are specified on startup
" (https://github.com/scrooloose/nerdtree/blob/master/README.markdown)
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" " -------------------
" " fzf
" " -------------------
" Path of the fzf git checkout (https://github.com/junegunn/fzf#as-vim-plugin)
set rtp+=~/share/fzf

" fzf + ripgrep (http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/)
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf}"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

" " -------------------
" " Tagbar
" " -------------------
nmap <F4> :TagbarToggle<CR>

" Go support with gotags (https://github.com/jstemmer/gotags)
let g:tagbar_type_go = {
  \ 'ctagstype' : 'go',
  \ 'kinds'     : [
    \ 'p:package',
    \ 'i:imports:1',
    \ 'c:constants',
    \ 'v:variables',
    \ 't:types',
    \ 'n:interfaces',
    \ 'w:fields',
    \ 'e:embedded',
    \ 'm:methods',
    \ 'r:constructor',
    \ 'f:functions'
  \ ],
  \ 'sro' : '.',
  \ 'kind2scope' : {
    \ 't' : 'ctype',
    \ 'n' : 'ntype'
  \ },
  \ 'scope2kind' : {
    \ 'ctype' : 't',
    \ 'ntype' : 'n'
  \ },
  \ 'ctagsbin'  : 'gotags',
  \ 'ctagsargs' : '-sort -silent'
\ }

" Ruby support with or without ripper-tags (https://github.com/tmm1/ripper-tags)
if executable('ripper-tags')
  let g:tagbar_type_ruby = {
      \ 'kinds'      : ['m:modules',
                      \ 'c:classes',
                      \ 'C:constants',
                      \ 'F:singleton methods',
                      \ 'f:methods',
                      \ 'a:aliases'],
      \ 'kind2scope' : { 'c' : 'class',
                       \ 'm' : 'class' },
      \ 'scope2kind' : { 'class' : 'c' },
      \ 'ctagsbin'   : 'ripper-tags',
      \ 'ctagsargs'  : ['-f', '-']
      \ }
else
  let g:tagbar_type_ruby = {
      \ 'kinds' : [
          \ 'm:modules',
          \ 'c:classes',
          \ 'd:describes',
          \ 'C:contexts',
          \ 'f:methods',
          \ 'F:singleton methods'
      \ ]
  \ }
endif

" asciidoc (Requires a corresponding ctags configuration. Check at
" https://github.com/majutsushi/tagbar/wiki#asciidoc)
let g:tagbar_type_asciidoc = {
    \ 'ctagstype' : 'asciidoc',
    \ 'kinds' : [
        \ 'h:table of contents',
        \ 'a:anchors:1',
        \ 't:titles:1',
        \ 'n:includes:1',
        \ 'i:images:1',
        \ 'I:inline images:1'
    \ ],
    \ 'sort' : 0
\ }
