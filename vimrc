" Load pathogen
"runtime bundle/vim-pathogen/autoload/pathogen.vim
execute pathogen#infect()
"call pathogen#helptags()

" General
set nocompatible
set guicursor=
filetype on
filetype plugin on
filetype indent on
" faster refreshes for gitgutter and the like
set updatetime=100

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
"set statusline=%F%m%r%h%w\ %{fugitive#statusline()}\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
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

" Tab completion
"set wildmode=list:longest,list:full
"set complete=.,w,t

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
" Autorefresh NERDTree on buffer write
" (https://superuser.com/questions/1141994/autorefresh-nerdtree)
" autocmd BufWritePost * NERDTreeFocus | execute 'normal R' | wincmd p

" -------------------
" fzf
" -------------------
"" rtp not needed because installation is via pathogen
"" Path of the fzf git checkout (https://github.com/junegunn/fzf#as-vim-plugin)
"set rtp+=~/share/fzf

"" https://jesseleite.com/posts/2/its-dangerous-to-vim-alone-take-fzf
" Files tracked by git
nmap <Leader>f :GFiles<CR>
" All files
nmap <Leader>F :Files<CR>
" Buffers
nmap <Leader>b :Buffers<CR>
" Buffer history
nmap <Leader>h :History<CR>
" Tags in the current buffer
nmap <Leader>t :BTags<CR>
" Tags in the project
nmap <Leader>T :Tags<CR>

" -------------------
" fzf + ripgrep
" -------------------
"" https://sidneyliebrand.io/blog/how-fzf-and-ripgrep-improved-my-workflow
" File contents using ripgrep
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --ignore-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'right:50%:hidden', '?'),
  \   <bang>0)
nmap <Leader>c :Rg<CR>


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
      \ 'ctagsargs'  : ['-n', '-f', '-']
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

" " -------------------
" " ansible-vim
" " -------------------
let g:ansible_unindent_after_newline = 1

" " -------------------
" " vim-go
" " -------------------
" https://github.com/fatih/vim-go/wiki/Tutorial
let g:go_fmt_command = "goimports"
" Syntax highlighting
let g:go_highlight_types = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
" Switching between code and test files using ex commands
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')
" Automatically show function signature (:GoInfo)
let g:go_auto_type_info = 1
" Automatically highlight matching identifiers (:GoSameIds)
let g:go_auto_sameids = 1
" https://github.com/golang/tools/blob/master/gopls/doc/vim.md
"let g:go_def_mode = 'gopls'
"let g:go_info_mode = 'gopls'
" Enable go code completion with omnifunc (default enabled anyway)
"let g:go_code_completion_enabled = 1

" " -------------------
" " depolete
" " -------------------
"" Use deoplete.
let g:deoplete#enable_at_startup = 1
"" Real-time completion with gopls
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })
"" Use TAB for autocompletion https://github.com/Shougo/deoplete.nvim/issues/816#issuecomment-409119635
function! s:check_back_space() abort "{{{
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ deoplete#manual_complete()

" " -------------------
" " airline
" " -------------------
" Display buffer list when only one tab is open
let g:airline#extensions#tabline#enabled = 1
function! s:tagbar_integration()
  " statusline tells you what function you're in!
endfunction
