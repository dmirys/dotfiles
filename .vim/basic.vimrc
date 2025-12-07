" General VIM settings
" Description: Basic setup to simplify VIM usage.
" Author: Dmitry Yastrebkov


" Disable vi compatibility (require VIM)
set nocompatible

" Set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" Enable mouse in all modes, e.g. to easily switch tabs
" To copy/paste with mouse you have to hold Shift
set mouse=a

" Turn on syntax highlighting
syntax on

" Use indentation of previous line
set autoindent

" Use intelligent indentation
set smartindent

" Wrap line at N chars
set textwidth=120

" Show line numbers
set number

" Highlight matching braces
set showmatch

" Tab settings:
"   Use spaces for indentation or tabs instead of spaces (4 character cells wide).
"   Define key combination for switching tab settings.
"   By default tabs will be used.
function! UseTabs()
    set tabstop=4     " Size of a hard tabstop (ts).
    set shiftwidth=4  " Size of an indentation (sw).
    set noexpandtab   " Always uses tabs instead of space characters (noet).
    set autoindent    " Copy indent from current line when starting a new line (ai).
endfunction
function! UseSpaces()
    set tabstop=4     " Size of a hard tabstop (ts).
    set shiftwidth=4  " Size of an indentation (sw).
    set expandtab     " Always uses spaces instead of tab characters (et).
    set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, feature is off (sts).
    set autoindent    " Copy indent from current line when starting a new line.
    set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
endfunction
function! ToggleTabs()
    if &expandtab
        call UseTabs()
        retab!
        echom "Will use tabs"
    else
        call UseSpaces()
        retab!
        echom "Will use spaces"
    endif
endfunction
map <silent><Leader>t :call ToggleTabs()<CR>
:call UseTabs()

" Close current buffer. When used on last buffer it will open new blank buffer
map <Leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" Toggle invisible characters displaying
map <silent><Leader>s :set list<CR>:call ToggleInvisibleChars()<CR>
function! ToggleInvisibleChars()
    if empty(&listchars)
        set listchars=tab:→\ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»
        set list
    else
        set listchars=
        set nolist
    endif
endfunction

" Toggle line numbers
map <silent><Leader>n :set number!<CR>


" Functional buttons presets
" ==========================

" F2 - Save file from normal mode
nmap <F2> :w<CR>
" F2 - Save file from insert mode (exit insert mode, save file, return back to insert mode)
imap <F2> <ESC>:w<CR>i

