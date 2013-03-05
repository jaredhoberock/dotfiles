" Configuration file for gvim
" Written for Debian GNU/Linux by W.Akkerman <wakkerma@debian.org>
" Some modifications by J.H.M. Dassen <jdassen@wi.LeidenUniv.nl>
" Lots of modification by Me, John Carrino.  

" Normally we use vim-extensions. If you want true vi-compatibility
" remove change the following statements
set nocompatible        " Use Vim defaults (much better!)
set showcmd             " Show (partial) command in status line.
"set showmatch           " Show matching brackets.
                        " don't do this -- it doesn't scale - jph
set notimeout           "i like to be pokey
set ruler      
set nottimeout
"set ignorecase         " Do case insensitive matching
set incsearch           " Incremental search
"set autowrite          " Automatically save before commands like next and make
set expandtab           " Get rid of tabs altogether and replace with spaces
set autoindent          " always set autoindenting on
set nofen               " disable folds
set linebreak           " This displays long lines as wrapped at word boundries
set wildmenu            " This is used with wildmode(full) to cycle options 
set nobackup            " Don't keep a backup file
set hidden
set noswapfile          " this guy is really annoyoing sometimes
set textwidth=0         " Don't wrap words by default
set nowrap
set history=50          " keep 50 lines of command line history
set whichwrap+=<,>,[,],h,l,~  "arrow keys can wrap in normal and insert modes
set helpfile=$VIMRUNTIME/doc/help.txt
set backspace=2         " allow backspacing over everything in insert mode
set timeoutlen=10000
set viminfo='20,\"50    " read/write a .viminfo file, don't store more than
                        " 50 lines of registers
set ttimeoutlen=10000
set matchtime=10
set softtabstop=2       " Why are tabs so big?  This fixes it
set shiftwidth=2                " dont indent like mad when editing code
set cindent shiftwidth=2        " dont indent like mad when editing code
                                " 2 is clearly the superior indent width - jph
"set guifont=Courier\ 10\ Pitch\ 12
set guioptions-=T
"set guioptions-=m
set foldmethod=indent   " use indent unless overridden
set foldlevel=0         " show contents of all folds
set foldcolumn=2        " set a column incase we need it
set scrolloff=1         " dont let the curser get too close to the edge
"set wrapmargin=80      " When pasteing, use this, because textwidth becomes 0
                        " wrapmargin inserts breaks if you exceed its value
set wildmode=list:longest,full  "list all options, match to the longest
                                "Then more tabs cycle through full completions
"set cscopeprg=~/bin/cscope      "set cscope bin path
"set tags+=./.tags,.tags,../.tags,../../.tags         "set ctags 
"set path=.,/vobs/jem/hardhat/linux-2.4.x/include,/usr/include,/afs/acm/user/kcrane/src/magrathea2/include
colorscheme darkblue    "better font and colors
let spell_auto_type=""    "don't automatically spell check!

" Suffixes that get lower priority when doing tab completion for filenames.
" These are files I am not likely to want to edit or read.
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc,.class

"fu! CscopeAdd() " Add Cscope database named .cscope.out
"    let dir = getcwd()
"    let savedir = getcwd()
"    wh (dir != '/')
"        let scopefile = dir . '/' . ".cscope.out"
"        if filereadable(scopefile)
"            exe "cs add " scopefile
"            exe "cd " savedir
"            return dir
"        en
"        cd ..
"        let dir = getcwd()
"    endw
"    exe "cd " savedir
"endf

"autocmd BufReadPost /tmp/woody-* set ft=tex
autocmd BufReadPost .tags set filetype=tags     " .tag files need love too
autocmd BufReadPost .z* set ft=zsh  "obscure zsh files need love too
autocmd BufReadPost *.java ia bool boolean | ia virtual abstract | ia const final
"autocmd BufReadPost *.java set makeprg=/home/jcarrino/bin/j2sdk1.4.2/bin/javac
"autocmd FileType python set complete+=k~/.vim/pydiction-0.4/pydiction iskeyword+=.,(

imap  ^
imap  $
imap <F1> 
imap <C-j> <ESC>ja
imap <C-k> <ESC>ka
imap <C-l> <ESC>la
imap <C-h> <ESC>i

"call CscopeAdd()    "cscope is where the loaded database is located
filetype plugin on   "make sure latex files work right
filetype indent on   "latex is cool

syntax on

iabbr _WTH <C-R>=TexHeaderBegin()<CR><ESC>kki

function! TexHeaderBegin()
    let C = "\\documentclass{article}\n\\usepackage{amsmath,amssymb,amscd}\n\\nofiles\n\\begin{document}\n\n\\end{document}\n"
    return C
endfunction

function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<TAB>"
    elseif a:direction == "backward"
        return "\<c-n>"
    else
        return "\<c-p>"
    endif
endfunction

inoremap <TAB> <c-r>=InsertTabWrapper("forward")<cr>
inoremap <S-TAB> <c-r>=InsertTabWrapper("backward")<cr>

let g:LargeFile=10

let loaded_matchparen = 1

"change to the directory of the file being edited
if exists('+autochdir')
  set autochdir
else
  autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif

