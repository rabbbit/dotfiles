set nocompatible

filetype off

" execute pathogen#infect()
" execute pathogen#helptags()

filetype plugin indent on
syntax on

set viminfo='500,f1,<500,:200,@200,/200,c,%

set background=dark
syntax enable

set backspace=2
let mapleader=","

imap <c-a> <esc>ggVG
nnoremap <c-a> ggVG

" show the status bar
set laststatus=2
set statusline=%<%f\%h%m%r\ %{fugitive#statusline()}%=%-10.(line=%l\ \ col=%c%V\ \ totlin=%L%)\ \%h%m%r%=%-40(bytval=0x%B,%n%Y%)\%P

" not interested in editing pyc files
set suffixes+=.pyc

" stoopid mouse
set mouse=a

" indenting
filetype on
filetype plugin indent on

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
set softtabstop=4

autocmd FileType python setlocal expandtab
autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4


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
highlight ColorColumn guibg=#2d2d2d ctermbg=246 ctermfg=238

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

highlight CursorLine term=reverse cterm=NONE ctermbg=7 guibg=LightRed
highlight CursorColumn term=reverse cterm=NONE ctermbg=7 guibg=DarkMagenta

" open files in the file path in a new tab (file under the cursor)
" vim-recipes
nnoremap gf <C-W>gf

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

" abbreviations
au BufNewFile,BufRead *.py iab imp import
au BufNewFile,BufRead *.py iab esql odb.execute_sql
au BufNewFile,BufRead *.py iab esto odb.execute
au BufNewFile,BufRead *.py iab epro odb.execute_proc
au BufNewFile,BufRead *.py iab efun odb.execute_func
au BufNewFile,BufRead *.py iab ipdb import pytest; pytest.set_trace();

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

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>

" Allow moving cursor past end of line in visual block mode:
set virtualedit+=block

" Keep search matches in the middle of the window:
nnoremap * *zzzv
nnoremap # #zzzv
nnoremap n nzzzv
nnoremap N Nzzzv

" nnoremap <leader><space> :noh<cr>

inoremap jj <ESC>

" don't hold onto old fugitive buffers http://vimcasts.org/episodes/fugitive-vim-browsing-the-git-object-database/
au BufReadPost fugitive://* set bufhidden=delete

" vim-plug
"
filetype off
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" original repos on github
Plug 'tpope/vim-pathogen'
Plug 'tpope/vim-fugitive'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-unimpaired'
Plug 'jnurmine/Zenburn'
" Plug 'phha/zenburn.nvim'
Plug 'eiginn/netrw'
" Plug 'davidhalter/jedi-vim'
Plug 'hynek/vim-python-pep8-indent'
Plug 'godlygeek/tabular'
" Plug 'avakhov/vim-yaml'
" Plug 'fatih/vim-go'
Plug 'scrooloose/nerdtree'
" Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'solarnz/thrift.vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'folke/trouble.nvim'
Plug 'folke/lsp-colors.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-buffer',
" Plug 'hrsh7th/cmp-cmdline',
Plug 'hrsh7th/cmp-nvim-lsp',
Plug 'hrsh7th/cmp-nvim-lsp-signature-help',
Plug 'hrsh7th/cmp-omni',
Plug 'hrsh7th/cmp-path',
Plug 'hrsh7th/nvim-cmp',
Plug 'rafamadriz/friendly-snippets',

Plug 'nvim-telescope/telescope.nvim',
Plug 'nvim-lua/plenary.nvim',
" Plug 'nvim-treesitter/nvim-treesitter',

" Plug 'williamboman/mason.nvim',
" Plug 'williamboman/mason-lspconfig.nvim',

Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-lualine/lualine.nvim'

call plug#end()

filetype plugin indent on     " required!

" limit autocompletion scanning
set complete=.,w,b,u,t

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=10      "deepest fold is 10 levels
set nofoldenable        "dont fold by default
set foldlevel=1         "this is just what i use

" nnoremap <space> za

" vnoremap <space> zf

set titleold=""
set titlestring=VIM:\%F

" match extra whitespace
" show extra whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+\%#\@<!$/

if &term =~ '256color'
 " disable Background Color Erase (BCE) so that color schemes
 " render properly when inside 256-color tmux and GNU screen.
 " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
	set t_ut=
endif

if &term =~ '^screen' && exists('$TMUX')
    set mouse+=a
	if !has('nvim')
	  " tmux knows the extended mouse mode
	  set ttymouse=xterm2
	endif
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
" let g:go_def_mode='gopls'
" let g:go_info_mode='gopls'

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
" if $GO_BIN_PATH != ""
" let g:go_bin_path=$GO_BIN_PATH
" endif


" COC.VIM

" Some servers have issues with backup files, see #649.
"set nobackup
"set nowritebackup
"
"" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
"" delays and poor user experience.
"set updatetime=300
"
"" Always show the signcolumn, otherwise it would shift the text each time
"" diagnostics appear/become resolved.
"set signcolumn=yes
"
"" Use tab for trigger completion with characters ahead and navigate.
"" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
"" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
"      \ coc#pum#visible() ? coc#pum#next(1):
"      \ CheckBackspace() ? "\<Tab>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
"
"" Make <CR> to accept selected completion item or notify coc.nvim to format
"" <C-g>u breaks current undo, please make your own choice.
"inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
"                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"
"function! CheckBackspace() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction
"
"" Use <c-space> to trigger completion.
"if has('nvim')
"  inoremap <silent><expr> <c-space> coc#refresh()
"else
"  inoremap <silent><expr> <c-@> coc#refresh()
"endif
"
"" Use `[g` and `]g` to navigate diagnostics
"" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
"nmap <silent> [g <Plug>(coc-diagnostic-prev)
"nmap <silent> ]g <Plug>(coc-diagnostic-next)
"
"" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
"
"" Use K to show documentation in preview window.
"nnoremap <silent> K :call ShowDocumentation()<CR>
"
"function! ShowDocumentation()
"  if CocAction('hasProvider', 'hover')
"    call CocActionAsync('doHover')
"  else
"    call feedkeys('K', 'in')
"  endif
"endfunction
"
"" Highlight the symbol and its references when holding the cursor.
"autocmd CursorHold * silent call CocActionAsync('highlight')
"
"" Symbol renaming.
"nmap <leader>rn <Plug>(coc-rename)
"
"" Formatting selected code.
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)
"
"augroup mygroup
"  autocmd!
"  " Setup formatexpr specified filetype(s).
"  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"  " Update signature help on jump placeholder.
"  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
"augroup end
"
"" Applying codeAction to the selected region.
"" Example: `<leader>aap` for current paragraph
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>a  <Plug>(coc-codeaction-selected)
"
"" Remap keys for applying codeAction to the current buffer.
"nmap <leader>ac  <Plug>(coc-codeaction)
"" Apply AutoFix to problem on the current line.
"nmap <leader>qf  <Plug>(coc-fix-current)
"
"" Run the Code Lens action on the current line.
"nmap <leader>cl  <Plug>(coc-codelens-action)
"
"" Map function and class text objects
"" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
"xmap if <Plug>(coc-funcobj-i)
"omap if <Plug>(coc-funcobj-i)
"xmap af <Plug>(coc-funcobj-a)
"omap af <Plug>(coc-funcobj-a)
"xmap ic <Plug>(coc-classobj-i)
"omap ic <Plug>(coc-classobj-i)
"xmap ac <Plug>(coc-classobj-a)
"omap ac <Plug>(coc-classobj-a)
"
"" Remap <C-f> and <C-b> for scroll float windows/popups.
"if has('nvim-0.4.0') || has('patch-8.2.0750')
"  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"endif
"
"" Use CTRL-S for selections ranges.
"" Requires 'textDocument/selectionRange' support of language server.
"nmap <silent> <C-s> <Plug>(coc-range-select)
"xmap <silent> <C-s> <Plug>(coc-range-select)
"
"" Add `:Format` command to format current buffer.
"command! -nargs=0 Format :call CocActionAsync('format')
"
"" Add `:Fold` command to fold current buffer.
"command! -nargs=? Fold :call     CocAction('fold', <f-args>)
"
"" Add `:OR` command for organize imports of the current buffer.
"command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')
"
"" Add (Neo)Vim's native statusline support.
"" NOTE: Please see `:h coc-status` for integrations with external plugins that
"" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"" Mappings for CoCList
"" Show all diagnostics.
"nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
"" Manage extensions.
"nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
"" Show commands.
"nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
"" Find symbol of current document.
"nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
"" Search workspace symbols.
"nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
"" Do default action for next item.
"nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
"" Do default action for previous item.
"nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
"" Resume latest coc list.
"nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" COC.VIM

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

" set t_Co=256
set cursorline cursorcolumn
let g:zenburn_unified_CursorColumn = 1
let g:zenburn_high_Contrast=0
let g:zenburn_alternate_Visual = 1
let g:zenburn_old_Visual = 0
let g:zenburn_enable_TagHighlight=1

colors zenburn

" let g:go_gopls_enabled= 0
" let g:go_fmt_command=""
"
let $USE_SYSTEM_GO = 1

