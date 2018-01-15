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


" " --------------------
" " MiniBufExpl
" " --------------------
" let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines)
" let g:miniBufExplModSelTarget = 1 " If you use other explorers like TagList you can (As of 6.2.8) set it at 1:
" let g:miniBufExplUseSingleClick = 1 " If you would like to single click on tabs rather than double clicking on them to goto the selected buffer.
" let g:miniBufExplMaxSize = 1 " <max lines: defualt 0> setting this to 0 will mean the window gets as big as needed to fit all your buffers.
" "let g:miniBufExplForceSyntaxEnable = 1 " There is a Vim bug that can cause buffers to show up without their highlighting. The following setting will cause MBE to
" "let g:miniBufExplorerMoreThanOne = 1 " Setting this to 0 will cause the MBE window to be loaded even
" "let g:miniBufExplMapCTabSwitchBufs = 1
" "let g:miniBufExplMapWindowNavArrows = 1
" "for buffers that have NOT CHANGED and are NOT VISIBLE.
" highlight MBENormal guibg=LightGray guifg=DarkGray
" " for buffers that HAVE CHANGED and are NOT VISIBLE
" highlight MBEChanged guibg=Red guifg=DarkRed
" " buffers that have NOT CHANGED and are VISIBLE
" highlight MBEVisibleNormal term=bold cterm=bold gui=bold guibg=Gray guifg=Black
" " buffers that have CHANGED and are VISIBLE
" highlight MBEVisibleChanged term=bold cterm=bold gui=bold guibg=DarkRed guifg=Black

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

" gotags (https://github.com/jstemmer/gotags)
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
