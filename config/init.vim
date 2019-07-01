" =============================================================================
" MARTIN Damien's Neovim settings
"
" Largely inspired by https://kushellig.de/neovim-php-ide/
" =============================================================================

" =============================================================================
" Automaticaly download plugins manager
" =============================================================================

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd!
    autocmd VimEnter * PlugInstall
endif

" =============================================================================
" Install plugins
" =============================================================================

call plug#begin('~/.local/share/nvim/plugged')

Plug 'jreybert/vimagit'

Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim'
Plug 'NLKNguyen/papercolor-theme'

Plug 'SirVer/ultisnips' | Plug 'phux/vim-snippets'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
Plug 'ncm2/ncm2-ultisnips'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'pbogut/fzf-mru.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'StanAngeloff/php.vim', {'for': 'php'}
Plug 'nelsyeung/twig.vim'

Plug 'adoy/vim-php-refactoring-toolbox', {'for': 'php'}
Plug 'arnaud-lb/vim-php-namespace', {'for': 'php'}

Plug 'alvan/vim-php-manual', {'for': 'php'}

Plug 'w0rp/ale'

Plug 'scrooloose/nerdtree'

Plug 'editorconfig/editorconfig-vim'

"Plug 'nightsense/night-and-day'
Plug 'ludovicchabant/vim-gutentags'

Plug 'ncm2/ncm2-tern',  {'do': 'npm install'}

Plug 'airblade/vim-rooter'
Plug 'justinmk/vim-sneak'
Plug 'mhinz/vim-startify'
Plug 'tpope/vim-speeddating'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'wakatime/vim-wakatime'

call plug#end()

" =============================================================================
" UI
" =============================================================================

set t_Co=256
syntax on
set nu

colorscheme nord
let g:airline_theme='nord'

" =============================================================================
" Editing
" =============================================================================

set tabstop=8
set softtabstop=0
set expandtab
set shiftwidth=4
set smarttab

" =============================================================================
" Keys mapping
" =============================================================================

let mapleader = " "

" NCM2

inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("", 'n') : "\<CR>")
inoremap <expr> <c-space> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <c-bs> pumvisible() ? "\<c-p>" : "\<TAB>"

" Neovim terminal

tnoremap <Esc> <C-\><C-n>

" NERDTree

nnoremap <C-n> :NERDTreeToggle<CR>

" PHPactor

nnoremap <C-c> :call phpactor#ContextMenu()<CR>

" ???

nnoremap <leader>rlv :call PhpRenameLocalVariable()<CR>
nnoremap <leader>rcv :call PhpRenameClassVariable()<CR>
nnoremap <leader>rrm :call PhpRenameMethod()<CR>
nnoremap <leader>reu :call PhpExtractUse()<CR>
nnoremap <leader>rep :call PhpExtractClassProperty()<CR>
nnoremap <leader>rnp :call PhpCreateProperty()<CR>
nnoremap <leader>rdu :call PhpDetectUnusedUseStatements()<CR>
nnoremap <leader>rsg :call PhpCreateSettersAndGetters()<CR>:
nnoremap <leader>rcc :call PhpConstructorArgumentMagic()<CR>

" Custom functions

nnoremap <leader>ric :call PHPModify("implement_contracts")<CR>
nnoremap <leader>raa :call PHPModify("add_missing_properties")<CR>
nnoremap <leader>rmc :call PHPMoveClass()<CR>
nnoremap <leader>rmd :call PHPMoveDir()<CR>
nnoremap <leader>h :call UpdatePhpDocIfExists()<CR>

" Vim PHP namespace

nnoremap <Leader>u :PHPImportClass<CR>
nnoremap <Leader>e :PHPExpandFQCNAbsolute<CR>
nnoremap <Leader>E :PHPExpandFQCN<CR>

" FZF

nnoremap <C-p> :<C-u>FZF<CR>
nnoremap <leader><Enter> :FZFMru<cr>
nnoremap <leader>s :Rg<space>
nnoremap <leader>R :exec "Rg ".expand("<cword>")<cr>
nnoremap <leader>, :Files<cr>
nnoremap <leader>. :call fzf#run({'sink': 'e', 'right': '40%'})<cr>
nnoremap <leader>d :BTags<cr>
nnoremap <leader>D :BTags <C-R><C-W><cr>
nnoremap <leader>S :Tags<cr>
nnoremap <leader><tab> :Buffers<cr>

" ???

vnoremap // "hy:exec "Rg ".escape('<C-R>h', "/\.*$^~[()")<cr>
vnoremap <leader>rec :call PhpExtractConst()<CR>

command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'
map <c-s> <esc>:w<cr>:Silent php-cs-fixer fix %:p --level=symfony<cr>

" =============================================================================
" Autocompletion
" =============================================================================

augroup ncm2
    au!
    autocmd BufEnter * call ncm2#enable_for_buffer()
    au User Ncm2PopupOpen set completeopt=noinsert,menuone,noselect
    au User Ncm2PopupClose set completeopt=menuone
augroup END

" =============================================================================
" Plugins
" =============================================================================

" Night and day settings ------------------------------------------------------

" NB: Those settings are for Reims, France

"let g:nd_themes = [
"            \ ['sunrise+0',   'gruvbox',    'light', 'gruvbox' ],
"            \ ['sunrise+1/4', 'PaperColor', 'light', 'papercolor' ],
"            \ ['sunset+1/5',  'nord',       'dark',  'nord' ],
"            \ ['sunset+1/3',  'gruvbox',    'dark',  'gruvbox'  ],
"            \ ]

"let g:nd_latitude = '50'
"let g:nd_timeshift = '14'
"let g:nd_airline = 1

" PHPactor settings -----------------------------------------------------------

autocmd FileType php setlocal omnifunc=phpactor#Complete
let g:phpactorOmniError = v:true

" UtilSnips settings ----------------------------------------------------------

let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-space>"

let g:ultisnips_php_scalar_types = 1

" ALE settings ----------------------------------------------------------------

let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 0
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \ 'php': ['psalm', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
            \}
let g:airline#extensions#ale#enabled = 1

" PHP refactoring toolbox settings --------------------------------------------

let g:vim_php_refactoring_default_property_visibility = 'private'
let g:vim_php_refactoring_default_method_visibility = 'private'
let g:vim_php_refactoring_auto_validate_visibility = 1
let g:vim_php_refactoring_phpdoc = "pdv#DocumentCurrentLine"
let g:vim_php_refactoring_use_default_mapping = 0

" Vim PHP manual --------------------------------------------------------------

let g:php_manual_online_search_shortcut = '<leader>k'

" FZF -------------------------------------------------------------------------

let g:fzf_mru_relative = 1
let g:LanguageClient_selectionUI = 'fzf'

" Rooter  --------------------------------------------------------------------- 

let g:rooter_patterns = ['composer.json', '.git/']

" Git NerdTree ----------------------------------------------------------------

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

let g:NERDTreeShowIgnoredStatus = 1

" Git Gutter ------------------------------------------------------------------

let g:gitgutter_sign_added = '█'
let g:gitgutter_sign_modified = '█'
let g:gitgutter_sign_removed = '█'
let g:gitgutter_sign_removed_first_line = '░'
let g:gitgutter_sign_modified_removed = '░'

" =============================================================================
" Custom functions
" =============================================================================

function! PHPModify(transformer)
    :update
    let l:cmd = "silent !".g:phpactor_executable." class:transform ".expand('%').' --transform='.a:transformer
    execute l:cmd
endfunction

function! PhpConstructorArgumentMagic()
    if exists("*UpdatePhpDocIfExists")
        normal! gg
        /__construct
        normal! n
        :call UpdatePhpDocIfExists()
        :w
    endif
    :call PHPModify("complete_constructor")
endfunction

function! PHPMoveClass()
    :w
    let l:oldPath = expand('%')
    let l:newPath = input("New path: ", l:oldPath)
    execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
    execute "bd ".l:oldPath
    execute "e ". l:newPath
endfunction

function! PHPMoveDir()
    :w
    let l:oldPath = input("old path: ", expand('%:p:h'))
    let l:newPath = input("New path: ", l:oldPath)
    execute "!".g:phpactor_executable." class:move ".l:oldPath.' '.l:newPath
endfunction

function! UpdatePhpDocIfExists()
    normal! k
    if getline('.') =~ '/'
        normal! V%d
    else
        normal! j
    endif
    call PhpDocSingle()
    normal! k^%k$
    if getline('.') =~ ';'
        exe "normal! $svoid"
    endif
endfunction
