" General
set nocompatible
filetype on
filetype plugin on
filetype indent on

" Load plugins
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" Theme/Colours
syntax on
set background=dark
colorscheme vividchalk

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

" Spell check plugin for vim 7
"setlocal spell spelllang=en_gb
"setlocal spell encoding=utf-8

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

" --------------------
" TagList
" --------------------
" F4: Switch on/off TagList
nnoremap <silent> <F4> :TlistToggle<CR>
" TagListTagName - Used for tag names
highlight MyTagListTagName gui=bold guifg=Black guibg=Orange
" TagListTagScope - Used for tag scope
highlight MyTagListTagScope gui=NONE guifg=Blue
" TagListTitle - Used for tag titles
highlight MyTagListTitle gui=bold guifg=DarkRed guibg=LightGray
" TagListComment - Used for comments
highlight MyTagListComment guifg=DarkGreen
" TagListFileName - Used for filenames
highlight MyTagListFileName gui=bold guifg=Black guibg=LightBlue
"let Tlist_Ctags_Cmd = $VIM.'/vimfiles/ctags.exe' " location of ctags tool
let Tlist_Show_One_File = 1 " Displaying tags for only one file~
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_Sort_Type = "name" " sort by order or name
let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
let Tlist_Compart_Format = 1 " Remove extra information and blank lines from the taglist window.
let Tlist_GainFocus_On_ToggleOpen = 1 " Jump to taglist window on open.
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_Close_On_Select = 0 " Close the taglist window when a file or tag is selected.
let Tlist_Enable_Fold_Column = 1 " Don't Show the fold indicator column in the taglist window.
let Tlist_WinWidth = 40
" let Tlist_Ctags_Cmd = 'ctags --c++-kinds=+p --fields=+iaS --extra=+q --languages=c++'
" very slow, so I disable this
" let Tlist_Process_File_Always = 1 " To use the :TlistShowTag and the :TlistShowPrototype commands without the taglist window and the taglist menu, you should set this variable to 1.
":TlistShowPrototype [filename] [linenumber]

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
" " FuzzyFinder
" " -------------------
nmap ,f :FufTag<CR>
nmap ,b :FufBuffer<CR>
nmap ,t :FufTaggedFile<CR>
map <F8> :!/usr/bin/ctags -R --ruby-kinds=+cfmF --perl-kinds=+cflpsd --fields=+iaS --extra=+f --exclude=@$HOME/.ctags_ignore .<CR>

" " -------------------
" " BufExplorer
" " -------------------
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1
map <leader>o :BufExplorer<cr>

