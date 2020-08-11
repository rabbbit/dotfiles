set nocompatible

filetype off 

execute pathogen#infect()
execute pathogen#helptags()

filetype plugin indent on
syntax on

set viminfo='500,f1,<500,:200,@200,/200,c,%

set background=dark
syntax enable " 

" map notes
" in insert mode <c-o> (<C-O>) changes into command mode for a single command
" so imap abc <c-o>do_thing allows a single command to work in insert mode.
" to see where a mapping was made, can run :verbose map (for all commands) or
" :verbose map <cmd> - see :help map-listing
"
" set guifont=Monospace\ 9

set backspace=2
let mapleader=","

imap <c-a> <esc>ggVG
nnoremap <c-a> ggVG

" show the status bar
set laststatus=2
" set title
" set statusline=%<%f\%h%m%r%=%-20.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \ \%h%m%r%=%-39(bytval=0x%B,%n%Y%)\%P
set statusline=%<%f\%h%m%r\ %{fugitive#statusline()}%=%-10.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P

" not interested in editing pyc files
set suffixes+=.pyc

" stoopid mouse
set mouse=a

" indenting
" set smartindent
" set autoindent
filetype on
filetype plugin indent on

" to disable automatic commenting
"
" au FileType * setl fo-=cro

set ic " ignore case in search
set incsearch " incremental search
set hlsearch " highlight search results (switch off with screen redraw <C-L>)
set smartcase " ignore case when lowercase

" One of the most important options to activate. Allows you to switch from an
" " unsaved buffer without saving it first. Also allows you to keep an undo
" " history for multiple files. Vim will complain if you try to quit without
" " saving, and swap files will keep you safe if your computer crashes.
set hidden

" Show partial commands in the last line of the screen
set showcmd

" don't expand tabs
set tabstop=4
set shiftwidth=4
set expandtab
" expandtab inserts tabs instead of spaces
" set expandtab
" smarttab changes spaces inserted at the start of a line when tabbing
" set smarttab

" open new windows on the right
set splitright

" change directory automatically (the current directory will be that of the current buffer)
set autochdir
autocmd BufEnter * silent! lcd %:p:h

" filename auto completion
" set wildmode=longest:full
set wildmenu

" always have some lines of text when scrolling
set scrolloff=3

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

set textwidth=120
set colorcolumn=+1
highlight ColorColumn guibg=#2d2d2d ctermbg=246

" don't jump over text-wrapped lines
" Might want to take a quick look at the documentation for map to see if it should only apply in certain modes
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk


" Disable annoyances
"
" This one enters ex mode.
nmap Q ""

" Y should yank to the end of the line
noremap Y y$

"Replace current selection with buffer
vmap r "_dP

" Cycle through windows with F6 (and back with Shift-F6
" nnoremap <F6> <C-W>w
" nnoremap <S-F6> <C-W>W

" Cycle through open files with Ctrl-N and Ctrl-P
" nnoremap <C-N> :next<CR>
" nnoremap <C-P> :prev<CR>

" tab navigation with alt left / alt right
nnoremap  <a-right>  gt
inoremap  <a-right>  <c-o>gt
nnoremap  <a-left>   gT
inoremap  <a-left>   <c-o>gT

" can't remap tab - it also remaps <ctrl-I>
" window cycling with tab
nnoremap <s-tab> <c-w>w

" ctags tutorial
" http://www.vim.org/tips/tip.php?tip_id=94
" omnicpp auto completion
" http://www.vim.org/scripts/script.php?script_id=1520
" filetype plugin on

" create ctags
" map <C-f12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

highlight CursorLine term=reverse cterm=NONE ctermbg=7 guibg=LightRed
highlight CursorColumn term=reverse cterm=NONE ctermbg=7 guibg=DarkMagenta

" open files in the file path in a new tab (file under the cursor)
" vim-recipes
nnoremap gf <C-W>gf

" printing options
" vim-recipes - 35
" ':hardcopy' prints
" see also, discussion on cups-pdf and printing to pdf using :set pdev=pdf
set printoptions=paper:A4,syntax:y,wrap:y

" Insert tabs at the start of the line [in insert mode]
inoremap <Tab> <C-T>
" shift-tab to remove tabs (indentation) [in insert mode]
inoremap <S-Tab> <C-D>

" Function Key Mappings

" open this on F1
map <F1> :vnew ~/.vimrc<CR>

" Toggle list on \tl and F2
nnoremap <leader>tl :set invlist list?<CR>
nmap <F2> <leader>tl
imap <F2> <C-O><leader>tl

" Line numbers on with F3
noremap <F3> :set nonumber!<CR>:set foldcolumn=0<CR>

" Toggle paste mode on \tp and F4
nnoremap <leader>tp :set invpaste paste?<CR>
nmap <F4> <leader>tp
imap <F4> <C-O><leader>tp
set pastetoggle=<F4>

" buffers - show with F5
noremap <F5> :ls!<CR>

" cross hairs on f5
nnoremap <leader>tc :set cursorline!<cr>:set cursorcolumn!<cr>
"nmap <F5> <leader>tc

"syntastic
nnoremap <F6> :Errors<cr>
" let g:syntastic_python_checkers = ['pyflakes', 'pep8']
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_pep8_args = '--max-line-length=120'
let g:syntastic_python_flake8_args = '--max-line-length=120'

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

"------------------
" Filetype specific settings
"------------------

"------------------
" PYTHON

" change tabstop width for python files
autocmd BufRead,BufNewFile *.py set tabstop=4
autocmd BufRead,BufNewFile *.py set shiftwidth=4

" don't want comments at the beginning of the line in python
" (not convinced these do anything due to the python indent plugin)
au BufNewFile,BufRead *.py set nocindent
au BufNewFile,BufRead *.py set nosmartindent
au BufNewFile,BufRead *.py set autoindent

" au BufNewFile,BufRead *.py set path+=~/gen_python/lib/geneity/lib,~/gen_python/lib/geneity/db

" project-specific
" au BufNewFile,BufRead *.py set path+=~/PROJ-Coral/sportsbook/apps/admin/python,~/PROJ-Coral/sportsbook/apps/ticker/python
" au BufNewFile,BufRead *.py set path+=~/PROJ-Coral/sportsbook/apps/python/sportsbook/placebet,~/PROJ-Coral/sportsbook/apps/python/sportsbook/settlement,~/PROJ-Coral/sportsbook/apps/python/sportsbook/admin

" abbreviations
au BufNewFile,BufRead *.py iab imp import
au BufNewFile,BufRead *.py iab esql odb.execute_sql
au BufNewFile,BufRead *.py iab esto odb.execute
au BufNewFile,BufRead *.py iab epro odb.execute_proc
au BufNewFile,BufRead *.py iab efun odb.execute_func
au BufNewFile,BufRead *.py iab ipdb import pytest; pytest.set_trace();

"------------------
" JAVASCRIPT

au BufNewFile,BufRead *.js iab fun function

let g:ctags_statusline=1

"--------------------
"Python auto-complete
"let g:pydiction_location='/home/sknox/.vim/ftplugin/python/complete-dict'

" NOTES
" :scriptnames - list all of the plugin/script files that have been loaded
" :verbose map <F6> list which file set the mapping F6
"
"
"
"
"
"
"
"" To enable the saving and restoring of screen positions.
let g:screen_size_restore_pos = 1

" To save and restore screen for each Vim instance.
" This is useful if you routinely run more than one Vim instance.
" For all Vim to use the same settings, change this to 0.
let g:screen_size_by_vim_instance = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

"set sessionoptions+=resize,winpos

"autocmd VIMEnter * :source ~/.session.vim

"autocmd VIMLeave * :mksession! ~/.session.vim

" option name default optional ------------------------------------------------ 
" g:solarized_termcolors= 16 | 256 
" g:solarized_termtrans = 0 | 1 
" g:solarized_degrade = 0 | 1 
" g:solarized_bold = 1 | 0 
" g:solarized_underline = 1 | 0 
" g:solarized_italic = 1 | 0
" g:solarized_contrast = "normal"| "high" or "low" 
" g:solarized_visibility= "normal"| "high" or "low"
" ------------------------------------------------

set t_Co=256
set cursorline cursorcolumn
let g:zenburn_unified_CursorColumn = 1
let g:zenburn_high_Contrast=0
let g:zenburn_alternate_Visual = 1
let g:zenburn_old_Visual = 0
let g:zenburn_enable_TagHighlight=1

colors zenburn

"#g:solarized_contrast = "high" 
"#g:solarized_visibility= "high"
"#colors solarized

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

"nnoremap <C-h> <C-w>h
"nnoremap <C-j> <C-w>j
"nnoremap <C-k> <C-w>k
"nnoremap <C-l> <C-w>l

" Allow moving cursor past end of line in visual block mode:
set virtualedit+=block

" Keep search matches in the middle of the window:
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

nnoremap <leader><space> :noh<cr>

inoremap jj <ESC>

" don't hold onto old fugitive buffers http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
au BufReadPost fugitive://* set bufhidden=delete

" VUNDLE config: https://github.com/gmarik/vundle
"
filetype off 
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
" required! 
Plugin 'VundleVim/Vundle.vim'

" My Plugins here:
"
" original repos on github
Plugin 'tpope/vim-pathogen'
Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-unimpaired'
Plugin 'jnurmine/Zenburn'
Plugin 'eiginn/netrw'
Plugin 'davidhalter/jedi-vim'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'godlygeek/tabular'
Plugin 'avakhov/vim-yaml'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdtree'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'ryanoasis/vim-devicons'
Plugin 'solarnz/thrift.vim'
Plugin 'neoclide/coc.nvim'
        
" non github repos
" Plugin 'git://git.wincent.com/command-t.git'
" Plugin 'bling/vim-airline'

call vundle#end()  
filetype plugin indent on     " required!
 "
 " Brief help
 " :PluginList          - list configured bundles
 " :PluginInstall(!)    - install(update) bundles
 " :PluginSearch(!) foo - search(or refresh cache first) for foo
 " :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
 "
 " see :h vundle for more details or wiki for FAQ
 " NOTE: comments after Plugin command are not allowed..
 "

" limit autocompletion scanning
set complete=.,w,b,u,t

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

nnoremap <space> za

vnoremap <space> zf

set titleold=""
set titlestring=VIM:\%F

" match extra whitespace 
" show extra whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+\%#\@<!$/
" :match ExtraWhitespace /\s\+$/ 
" don't show when im typing? 

if &term =~ '256color'
 " disable Background Color Erase (BCE) so that color schemes
 " render properly when inside 256-color tmux and GNU screen.
 " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif

if &term =~ '^screen' && exists('$TMUX')
    set mouse+=a
    " tmux knows the extended mouse mode
    set ttymouse=xterm2
    " tmux will send xterm-style keys when xterm-keys is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
    execute "set <xHome>=\e[1;*H"
    execute "set <xEnd>=\e[1;*F"
    execute "set <Insert>=\e[2;*~"
    execute "set <Delete>=\e[3;*~"
    execute "set <PageUp>=\e[5;*~"
    execute "set <PageDown>=\e[6;*~"
    execute "set <xF1>=\e[1;*P"
    execute "set <xF2>=\e[1;*Q"
    execute "set <xF3>=\e[1;*R"
    execute "set <xF4>=\e[1;*S"
    execute "set <F5>=\e[15;*~"
    execute "set <F6>=\e[17;*~"
    execute "set <F7>=\e[18;*~"
    execute "set <F8>=\e[19;*~"
    execute "set <F9>=\e[20;*~"
    execute "set <F10>=\e[21;*~"
    execute "set <F11>=\e[23;*~"
    execute "set <F12>=\e[24;*~"
    map <Esc>OH <Home>
    map! <Esc>OH <Home>
    map <Esc>OF <End>
    map! <Esc>OF <End>
    imap <Esc>OF <End>
endif

" get rid of delay when exiting command mode
" set timeoutlen=1000

" gvim does it automatically ...
:au FileChangedShell * echo "Warning: File changed on disk"

" disable jedi automatic auto-completion
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0
let g:jedi#use_tabs_not_buffers = 1


" go
"
au FileType go nmap <Leader>dt <Plug>(go-def-tab)
" Automagically run goimports on save
let g:go_fmt_command="goimports"
" Run lint and vet on save
let g:go_metalinter_autosave = 0
" let g:go_metalinter_enabled = ['deadcode', 'errcheck', 'gosimple', 'govet', 'staticcheck', 'typecheck', 'unused', 'varcheck']
" let g:go_metalinter_command='golangci-lint run --print-issued-lines=false --disable-all --exclude-use-default=false'
" let g:go_metalinter_command='gometalinter'
" let g:go_list_type = 'locationlist'

set autowrite

" NERDTree
map <C-n> :NERDTreeToggle<CR>

" NERDTree open tree automatically if no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" vim-devicons, needed for nerdtree-syntax-highlight
" brew tap caskroom/fonts
" brew cask install font-droidsansmono-nerd-font-mono
" manually update terminal font, the below doesn't work
"
set encoding=UTF-8
set guifont=DroidSansMono_Nerd_Font_Mono:h11


" fixes for slow scrolling in golang
" https://github.com/fatih/vim-go/issues/706
set re=1
set ttyfast
set lazyredraw

set synmaxcol=160
syntax sync minlines=255

" ctrlp 
let g:ctrlp_working_path_mode = 'r'

let g:ctrlp_max_files=0

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" if executable('ag')
"  let g:ctrlp_user_command = 'ag %s -l --nocolor -ga ""'
" endif

let g:ctrlp_root_markers = ['.ctrlp']


" vimgopathmode for monorepo, I think
if $GO_BIN_PATH != ""
   let g:go_bin_path=$GO_BIN_PATH
endif


" COC.VIM

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_def_mapping_enabled = 0

let g:ctrlp_root_markers = ['.ctrlp']

let g:coc_global_extensions = ["coc-go", "coc-yaml", "coc-json"]

let g:coc_node_path = "/usr/local/bin/node"

let g:ctrlp_user_command = ['.git/', 'git ls-files --cached --others  --exclude-standard %s']

" sourcegraph
function! GetSourcegraphURL(config) abort
    if a:config['remote'] =~ "^gitolite@code.uber.internal"
        let repository = substitute(matchstr(a:config['remote'], 'code.uber.internal.*'), ':', '/', '')
        let commit = a:config['commit']
        let path = a:config['path']
        let url = printf("https://sourcegraph.uberinternal.com/%s@%s/-/blob/%s",
            \ repository,
            \ commit,
            \ path)
        let fromLine = a:config['line1']
        let toLine = a:config['line2']
        if fromLine > 0 && fromLine == toLine
            let url .= '#L' . fromLine
        elseif toLine > 0
            let url .= '#L' . fromLine . '-' . toLine
        endif
        return url
    endif
    return ''
endfunction
if !exists('g:fugitive_browse_handlers')
    let g:fugitive_browse_handlers = []
endif
if index(g:fugitive_browse_handlers, function('GetSourcegraphURL')) < 0
    call insert(g:fugitive_browse_handlers, function('GetSourcegraphURL'))
endif

autocmd BufNewFile,BufRead *.star,*.bzl,*.bazel set filetype=python syntax=python ts=4 shiftwidth=4
