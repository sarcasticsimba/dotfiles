set wildmenu
set hidden

filetype off 
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'jaxbot/semantic-highlight.vim'
    Plugin 'gmarik/Vundle.vim'
    Plugin 'keith/swift.vim'
call vundle#end()

set formatoptions+=1r
syntax on
set lbr
set number

set nowrap
set linebreak
set sidescroll=5
set listchars+=precedes:<
set listchars+=extends:>

set autoindent
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4
set backspace=2

set incsearch
set ignorecase
set smartcase
set hlsearch

" Split to the right and down
set splitright
set splitbelow

" Sane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

hi TabLineFill ctermfg=7 ctermbg=7
hi TabLine cterm=bold ctermfg=7
hi TabLineSel cterm=bold
set showtabline=2

" Vertically center line when teleporting with gg
nnoremap gg ggz.

" Use a line when in insert mode, and a block when not
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Use tabs only in Makefiles
autocmd FileType make setlocal noexpandtab
