" Jason Heppler vimrc

" Compatibility
set nocompatible                " choose no compatibility with legacy vi

" Plugins
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

" Filetypes
if has("autocmd")
    filetype indent plugin on

    " Shortcuts
    nnoremap _ap :setlocal filetype=apache<CR>
    nnoremap _bi :setlocal filetype=bindzone<CR>
    nnoremap _cs :setlocal filetype=css<CR>
    nnoremap _ht :setlocal filetype=html<CR>
    nnoremap _js :setlocal filetype=javascript<CR>
    nnoremap _md :setlocal filetype=markdown<CR>
    nnoremap _pl :setlocal filetype=perl<CR>
    nnoremap _ph :setlocal filetype=php<CR>
    nnoremap _py :setlocal filetype=python<CR>
    nnoremap _rb :setlocal filetype=ruby<CR>
    nnoremap _sh :setlocal filetype=sh<CR>
    nnoremap _vi :setlocal filetype=vim<CR>
    nnoremap _xm :setlocal filetype=xml<CR>

    " Apache
    augroup apache
        autocmd!
        autocmd BufNewFile,BufRead *{etc,local,lib}/apache*/*.conf setlocal filetype=apache
        autocmd BufNewFile,BufRead *etc/apache*/sites-*/* setlocal filetype=apache
    augroup END

    " Markdown
    augroup markdown
        autocmd!
        autocmd Filetype markdown setlocal formatoptions+=t
        autocmd Filetype markdown setlocal textwidth=79
        if exists("&colorcolumn")
            autocmd Filetype markdown setlocal colorcolumn=+1
        endif
    augroup END
endif

" Commands
if has("cmdline_info")
    set ruler
    set showcmd
    set showmode
endif

" Encoding
set fileformats=unix,dos,mac
if has("multi_byte")
    set encoding=utf-8
endif

" Formatting
set expandtab
set formatoptions=croqn1
silent! set formatoptions+=j
set smarttab
set nojoinspaces
set shiftround
set shiftwidth=4
set softtabstop=4
set tabstop=4
set backspace=indent,eol,start  " backspace through everything in insert mode
set list
set list listchars=tab:\ \ ,trail:·

" toggle automatic hardwrapping
nmap <silent> <leader>wa :set fo-=a<CR>
nmap <silent> <leader>aw :set fo+=a<CR>

" remove line breaks within paragraphs (softwrap)
" http://superuser.com/questions/200423/join-lines-inside-paragraphs-in-vim
nmap <silent> <leader>sw Go<Esc>:3,$g/^./ .,/^$/-1 join<CR>
" straighten quotes
nmap <leader>q :exe '%s/[“”]/"/eg'<cr>:exe "%s/[‘’]/'/eg"<cr>:nohlsearch<cr>

" auto commands
:autocmd BufWrite *.py %retab   " retab python files

" abbreviations
:iabbrev ppython #!/usr/bin/env python <cr>#-*- coding: utf-8 -*-
:iabbrev rruby #!/usr/bin/env ruby<cr>

" searching
set hlsearch                    " highlight matches
set incsearch                   " incremental search
set ignorecase                  " case insensitive
set smartcase
nnoremap <CR> :noh<CR>          " remove search highlight

" mappings
let mapleader = ","
noremap! jj <Esc>
nmap <leader>g :GundoToggle<CR>

" NERDTree
augroup ps_nerdtree
    au!

    au Filetype nerdtree setlocal nolist
    au Filetype nerdtree nnoremap <buffer> K :q<cr>
augroup END

let NERDTreeHighlightCursorline = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

map <leader>d :NERDTreeToggle<CR>

" buffer navigation
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l

" Colors
if has("syntax")
    syntax enable
    set background=dark
    silent! colorscheme sahara
    if has("folding")
        set fillchars=diff:\ ,fold:\ ,vert:\ 
    endif
    if exists("&synmaxcol")
        set synmaxcol=3000
    endif
endif


" colorscheme
"syntax enable
"let g:solarized_termtrans=1
"colorscheme solarized
"set background=dark

set laststatus=2

" Marked.app
:nnoremap <leader>ma :silent !open -a Marked.app '%:p' :redraw!<cr>

" enable fancy mode
let g:Powerline_symbols = 'fancy'

" Visuals
set number
set colorcolumn=81
set cursorline
nmap <leader>ev :vsplit $MYVIMRC<cr> " mapping to edit vimrc quickly
nmap <leader>sv :source $MYVIMRC<cr> " mapping to source vimrc quickly

" writing mode
func! WordProcessorMode()
    setlocal formatoptions=t1
    setlocal textwidth=100
    map j gj
    map k gk
    setlocal spell spelllang=en_us
    setlocal noexpandtab
    set tw=72
    set fo=cqt
    set wm=0
endfu
com! WP call WordProcessorMode()

" bibkeys
" via https://github.com/lmullen/bibkeys
" launch with CTRL-X CTRL-K
set dictionary=$HOME/bib/citekeys.txt
set complete+=k

" Find text markers
nnoremap <leader>{ :vimgrep /{\w\+}/ %<CR>:copen<CR>

" Some file types should wrap their text
function! s:setupWrapping()
    set wrap
    set linebreak
    set textwidth=72
    set nolist
endfunction

if has("autocmd")
    " Make sure all mardown files have the correct filetype set and setup wrapping
    au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrapping()
endif

" Strip trailing white space (,ss)
function! StripWhitespace()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    :%s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfunction
noremap <leader>ss :call StripWhitespace()<CR>

" Source configuration files
nmap <leader>sv :source %<cr>
source $HOME/.vim/bibtex.vimrc
source $HOME/.vim/gitit.vimrc
source $HOME/.vim/markdown.vimrc
source $HOME/.vim/pandoc.vimrc
