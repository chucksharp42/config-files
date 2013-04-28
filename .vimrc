"""""""""""""""""""""""
"""""""""""""""""""""""        Environment Options
"""""""""""""""""""""""
"
set nocompatible               " Use Vim defaults
"
set autoindent
set backspace=2                " allow backspacing over everything in insert mode
set diffopt+=iwhite            " ignore whitespace in diff mode
set expandtab                  " convert tabs and indents to spaces
set history=200                " keep 500 lines of history
set ignorecase
set incsearch                  " search as you type
set ruler                      " always show ruler
"set scrolljump=10
set scrolloff=2                " always keep N lines below or above cursor
set shiftround                 " round indents to shiftwidth
set shiftwidth=2
set showcmd
set showmatch matchtime=3
set smartcase                  " override ignorecase if casing is used in searching
set smartindent                " auto indents smartly with braces
set tabstop=2                 " how tabs are interpreted - leave at 8 to make more obvious
set tags=tags\ ~/.tags
set ttyscroll=1
set wildmode=list:longest,full
set wrapmargin=10
"
set laststatus=2
set statusline=%F%m%r%h%w\ [%{&ff}]\ CHR=\%03.3b,\%02.2B\ %vx%l/%L\ %p%%
"
set mouse=a 
set pastetoggle=<f2>
"
"
"" Filetype stuff & autocomplete:
"
syntax on
filetype plugin on
au BufNewFile,BufRead *.less set filetype=css
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete
"
"
" Pathogen is auto-plugin-installer/loader
execute pathogen#infect()
let NERDTreeDirArrows=0
map <ESC>n :NERDTree<CR>
"
"
"""""""""""""""""""""""
"""""""""""""""""""""""			Abbreviations
"""""""""""""""""""""""
"
"" Abbreviations to "cut and paste" between vi sessions using temporary files.
"
"" Write to and insert contents of temporary file
ab aW w! /tmp/csharp.temp.a
ab aR r /tmp/csharp.temp.a
ab bW w! /tmp/csharp.temp.b
ab bR r /tmp/csharp.temp.b
"
"""""""""""""""""""""""
"""""""""""""""""""""""			Mappings
"""""""""""""""""""""""
"
"" Maps for pasting
"
"" Set 'exact' input mode for pasting exactly what is entered:
map! \x :se noai wm=0a
"" Set 'normal' input mode with usual autoindent and wrapmargn:
"map! \n :se ai wm=8a
"" Read pasted text, clean up lines with fmt.  Type CTRL-D when done:
map! \r :r!fmt
"
"
""	INPUT MACROS that to have active
"
map!  :stop!
""	so i can stop in input mode.
"
""	EXCHANGE MACROS -- for exchanging things
"
map #12 xp
""	exchange current char with next one in edit mode
"
""	OTHER MACROS
"
map!  :wa
""	write out the file
"
map \* i
""	split line
"
map Y y$
""	so Y is analagous to C and D
"
"
""	META MACROS, all begin with meta-key '\' ; more later in file
"
map \C $mm81a 81|D`mld0:s/  / /g$p
""	center text.
"
""	INVERT CASE ON WORDS -- V is like W, v is like w.  3V is fine, but only to EOL.
"
""	uses both register n and mark n.
map \v ywmnoP:s/./\~/g0"nDdd`n@n
""	abc -> ABC    ABC->abc
map \V yWmnoP:s/./\~/g0"nDdd`n@n
""	abc.xyz -> ABC.XYZ    ABC.XYZ->abc.xyz
"
"
""	EXECUTION MACROS --	these two are for executing existing lines.  
"
map \@ "mdd@m
map! \@ "mdd@m
""	xqt line as a straight vi command (buffer m, use @@ to repeat)
map \! 0i:-1 r!"ndd@n
map! \! 0i:r!"nddk@n
""	xqt line as :r! command (buffer n, use @@ to repeat)
map \t :r!cat /dev/tty
""	read in stuff from X put buffer [in X window system --JP]
"
""	SPELL MACROS
"
map \s :w:!ispell %:r %
""	ispell the file
"
"
""	FORMATING MACROS
"
map \P :.,$!fmt -70
""	format thru end of document
map \p {!}fmt -70
""	format paragraph
map \e :%!expand -4
""	expand tabs to 4 stops
"
"" troff left quote
"map! ``  \*(lq 
"" troff right quote
"map! ''  \*(rq
"
"" FUNCTION KEYS
"
"map #0 :so ~/.exrc-html-on

"" so ~/.exrc-html-on
set tags=~/.vim/mytags/mailapi
"
noremap <space> <PageDown>  " space bar scrolls one page at a time
noremap <BS> <PageUp>
noremap - <PageUp>

" Window movement
nnoremap <F3> <C-W>w
"nnoremap <S-F3> <C-W>W

" Vimdiff
nnoremap <F12> ]cz.
nnoremap <F11> [cz.

" Previous/next file
nnoremap <F5> :prev<CR>
nnoremap <F6> :next<CR>
nnoremap <S-F5> :wN<CR>
nnoremap <S-F6> :wn<CR>

" have the usual indentation keystrokes still work in visual mode:
vnoremap <C-T> >
vnoremap <C-D> <LT>
vnoremap > >gv
vnoremap < <gv
vmap <Tab> <C-T>
vmap <S-Tab> <C-D>

" Make search & comments readable
highlight Search term=reverse  ctermbg=4 ctermfg=3
highlight Comment term=reverse ctermfg=DarkGray

syntax sync minlines=1000

let php_folding=1
let php_sql_query=1
let php_htmlInStrings=1

abbrev fucntion function

" Map numkeypad +/- to standard
map! Ol +
map! OS -
map Ol +
map OS -


" php mappings
map! ;;t $this->

map <F13> :set number!<Cr>
map <F15> :set TlistToggle<Cr>
map <F14> za
map <C-F14> zA
map <S-F14> zM
