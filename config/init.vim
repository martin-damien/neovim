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

Plug 'NLKNguyen/papercolor-theme'

Plug 'SirVer/ultisnips' | Plug 'phux/vim-snippets'

Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'

Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'}
Plug 'phpactor/ncm2-phpactor', {'for': 'php'}
Plug 'ncm2/ncm2-ultisnips'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'StanAngeloff/php.vim', {'for': 'php'}

Plug 'w0rp/ale'

Plug 'scrooloose/nerdtree'

call plug#end()

" =============================================================================
" UI
" =============================================================================

set t_Co=256
set background=light
colorscheme PaperColor
syntax on
set nu

let g:airline_theme='papercolor'

" =============================================================================
" Keys mapping
" =============================================================================

inoremap <silent> <expr> <CR> (pumvisible() ? ncm2_ultisnips#expand_or("\<CR>", 'n') : "\<CR>")
inoremap <expr> <TAB> pumvisible() ? "\<c-n>" : "\<TAB>"
inoremap <expr> <s-tab> pumvisible() ? "\<c-p>" : "\<TAB>"

tnoremap <Esc> <C-\><C-n>

nnoremap <C-p> :<C-u>FZF<CR>

nnoremap <C-n> :NERDTreeToggle<CR>

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

" PHPactor settings -----------------------------------------------------------

autocmd FileType php setlocal omnifunc=phpactor#Complete
let g:phpactorOmniError = v:true

" UtilSnips settings ----------------------------------------------------------

let g:UltiSnipsExpandTrigger="<c-space>"
let g:UltiSnipsJumpForwardTrigger="<c-space>"

let g:ultisnips_php_scalar_types = 1

" ALE settings ----------------------------------------------------------------

let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_open_list = 1
let g:ale_keep_list_window_open=0
let g:ale_set_quickfix=0
let g:ale_list_window_size = 5
let g:ale_php_phpcbf_standard='PSR2'
let g:ale_php_phpcs_standard='phpcs.xml.dist'
let g:ale_php_phpmd_ruleset='phpmd.xml'
let g:ale_fixers = {
  \ '*': ['remove_trailing_lines', 'trim_whitespace'],
  \ 'php': ['phpcbf', 'php_cs_fixer', 'remove_trailing_lines', 'trim_whitespace'],
  \}
let g:ale_fix_on_save = 1
