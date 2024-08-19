scriptencoding utf-8
set encoding=utf-8
set nocompatible

" Plug {{{
" install if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall | source ~/.vimrc
endif


call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'kien/tabman.vim'
Plug 'lambdalisue/suda.vim'
Plug 'tpope/vim-surround'
Plug 'terryma/vim-expand-region'
Plug 'vim-scripts/IndexedSearch'
Plug 'junegunn/vim-easy-align'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Plug 'sheerun/vim-polyglot'
Plug 'ap/vim-css-color'
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
" Plug 'jparise/vim-graphql'
" Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'wakatime/vim-wakatime'
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-apathy'
Plug 'jreybert/vimagit'
" Plug 'rescript-lang/vim-rescript'

" Telescope
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'github/copilot.vim'


call plug#end()

" easy plugin updates
command! PU PlugUpdate | PlugUpgrade

" }}}

" indentation {{{
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

set autoindent
set nocopyindent
set nopreserveindent
set nosmartindent
set nocindent

" }}}

" misc-settings {{{
set splitright
set cmdheight=3
set hidden
set updatetime=200
set shortmess+=c
set signcolumn=yes
set noautochdir
set nostartofline
set autoread
set fileformats=unix,mac,dos
set fileformat=unix

" browse files in same dir as open file
set browsedir=current

" keep splits equal width (but not height)
set equalalways
set winfixheight

" status bar
set laststatus=2
set noshowmode

" disable modeline (i.e. 'vim:option=value' comments at the end of files
set nomodeline

" substitute with '/g' by default
set gdefault

" use older regex engine for better performance
set regexpengine=1

" no excessive whitespace wthen joining lines
set nojoinspaces

" search
set incsearch
set ignorecase
set smartcase
set infercase
set hlsearch

" mouse support
set mouse=a

" don't redraw screen durring macros
set lazyredraw

" cursor can move to spaces with no real character in vblock mode.
set virtualedit=block

" folding
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set nofoldenable
set foldlevel=999

" diff-mode
set diffopt=vertical
set fillchars+=diff:┈

" add blank lines to keep sides aligned
set diffopt+=filler

" ignore whitespace changes
set diffopt+=iwhite

" syntax highlight
" filetype indent plugin on
" set re=0
syntax off


" prevent wrapping lines
set textwidth=100
set nowrap

" when scrolling, keep cursor this many lines away from screen border
set scrolloff=9
set sidescrolloff=9

" don't syntax highlight long lines
set synmaxcol=220

" show line numbers
set number
"
" disable relative line number due to its poor performance (see https://github.com/neovim/neovim/issues/6960)
set norelativenumber

" ask confirmation instead of failing
set confirm

" neovim-ruby
let g:ruby_host_prog = 'rvm system do neovim-ruby-host'
" }}}

" language-specific-autocmd {{{
" remove trailing whitespace on save
autocmd BufRead * autocmd  BufWritePre <buffer> %s/\s\+$//e

" use foldmethod=marker
autocmd FileType zsh,bash,shell,vim,sql setlocal foldmethod=marker


" consider these files be json:
" .babelrc, .prettierrc, .eslintrc, etc.
autocmd BufRead {.babelrc,.prettierrc,.stylelintrc,.lintstagedrc,.huskyrc,.eslintrc} setfiletype json

" }}}

" colors {{{
set cursorcolumn
set cursorline

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set termguicolors

set background=dark

colorscheme nwsome

" highlight 100'th column
set colorcolumn=100

" }}}
"
" completion  {{{
set wildmenu
set wildmode=list:longest,full
set wildignorecase

" ignore these files for completion
set wildignore+=*.aux,*.out,*.toc
set wildignore+=*.o,*.obj,*.exe,*.dll,*.jar,*.pyc,*.rbc,*.class
set wildignore+=*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
set wildignore+=*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm
set wildignore+=*.eot,*.otf,*.ttf,*.woff
set wildignore+=*.docx
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz
set wildignore+=.sass-cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*.gem
set wildignore+=*.*~,*~
set wildignore+=*.swp,.lock,.DS_Store,._*,tags.lock
set isfname-==
set completeopt=menuone,noinsert,noselect

" }}}

" storage {{{
set directory=~/.vim/dirs/tmp

" turn off backups
set nobackup
set nowritebackup
set backupdir=~/.vim/dirs/backups

" turn on undo history
set undofile
set undodir=~/.vim/dirs/undos

set viminfo+=n~/.vim/dirs/viminfo

" create needed directories if they don't exist
if !isdirectory(&backupdir)
    call mkdir(&backupdir, "p")
endif
if !isdirectory(&directory)
    call mkdir(&directory, "p")
endif
if !isdirectory(&undodir)
    call mkdir(&undodir, "p")
endif

" }}}

" misc-mappings {{{
" save with sudo
ca w!! w suda://%


" save with C-s
nnoremap <c-s> :w<cr>

" indent without loosing focus
vnoremap < <gv
vnoremap > >gv

" command with colon
noremap ; :

"clear search results highlighting
nnoremap <c-l> :nohl<cr><c-l>

" set <leader> key
let mapleader = " "

" toggle concealing
map <leader>c :exec &conceallevel ? "set conceallevel=0" : "set conceallevel=1"<cr>

" sort lines
map <leader>o vv:sort<cr>

" move curent line's last character to the next line
map <leader>q $i<cr><esc>J

" escape key in terminal
:tnoremap <esc><esc> <c-\><c-n>

" run macro on selected lines
xnoremap @ :<c-u>call ExecuteMacroOverVisualRange()<cr>
function! ExecuteMacroOverVisualRange()
  echo "@".getcmdline()
  execute ":'<,'>normal @".nr2char(getchar())
endfunction


" stop using arrows in normal mode
noremap <up> <c-w>w
noremap <down> <c-w>W
noremap <left> :tabp<cr>
noremap <right> :tabn<cr>

" buffer navigation
map <c-up> :bnext<cr>
map <c-down> :bNext<cr>

" tab navigation
map tt :tabnew<cr>
map tn :tabn<cr>
map tp :tabp<cr>

" term-mode
map <F2> :below 10sp term://$SHELL<cr>i
" map <F4> :below 10sp term:///usr/bin/node<cr>i

" yank to system clipboard
nmap <F8> "+yy
vmap <F8> "+y
nmap <F7> "+P
vmap <F7> "+P
nmap <F9> "+p
vmap <F9> "+p

" }}}

" concealment {{{
set conceallevel=1
let g:javascript_conceal_arrow_function = '⇒'
" let g:javascript_conceal_function = 'ƒ'
" let g:javascript_conceal_return = '⇚'
" let g:javascript_conceal_this = '@'
" let g:javascript_conceal_null = 'ø'
" let g:javascript_conceal_undefined = '¿'
" let g:javascript_conceal_NaN = 'ℕ'
" let g:javascript_conceal_prototype = '¶'
" let g:javascript_conceal_static = '•'
" let g:javascript_conceal_super = 'Ω'

" }}}
"

" expand-region {{{
vmap v <plug>(expand_region_expand)
vmap <c-v> <plug>(expand_region_shrink)
" }}}

" gitgutter {{{
" git next/previous hunk
nmap <Leader>gn <Plug>GitGutterNextHunk
nmap <Leader>gp <Plug>GitGutterPrevHunk

" stage/revert hunk
nmap <Leader>ga <Plug>GitGutterStageHunk
nmap <Leader>gu <Plug>GitGutterUndoHunk
" }}}

" vimagit {{{
" only show filenames by default (hide diffs)
let g:magit_default_fold_level = 0

" open vimagit pane
nnoremap <leader>gs :Magit<CR>


" }}}

" polyglot {{{
"let g:polyglot_disabled = ['markdown', 'graphql']
" }}}

" tab-man {{{
" toggle display
let g:tabman_toggle = 'tl'

" focus on display
let g:tabman_focus  = 'tf'

" }}}

" airline {{{
let g:airline_powerline_fonts=1
let g:airline_theme='simple'

" tabline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_splits = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#fnametruncate = 6

" tab numbers
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tab_nr_type = 1

" coc diagnostics
let g:airline_section_error = '%{airline#util#wrap(airline#extensions#coc#get_error(),0)}'
let g:airline_section_warning = '%{airline#util#wrap(airline#extensions#coc#get_warning(),0)}'

" }}}

" easy-align {{{
let g:easy_align_interactive_modes = ['l', 'r']
let g:easy_align_bang_interactive_modes = ['c', 'r']
xmap ga <plug>(EasyAlign)
nmap ga <plug>(EasyAlign)

" }}}

" emmet {{{
let g:user_emmet_settings = {
      \ 'javascript.jsx': { 'extends': 'jsx', 'attribute_name': { 'for': 'htmlFor', 'class': 'className' }, 'quote_char': '"' },
      \ 'javascriptreact': { 'extends': 'jsx', 'attribute_name': { 'for': 'htmlFor', 'class': 'className' }, 'quote_char': '"' },
      \ 'typescriptreact': { 'extends': 'jsx', 'attribute_name': { 'for': 'htmlFor', 'class': 'className' }, 'quote_char': '"' },
      \ 'typescript.tsx': { 'extends': 'jsx', 'attribute_name': { 'for': 'htmlFor', 'class': 'className' }, 'quote_char': '"' },
      \ }

autocmd FileType javascript.jsx,typescript.tsx EmmetInstall

" }}}


" ale {{{
" let g:ale_set_baloons = 1
let g:ale_set_quickfix = 1
" let g:ale_set_loclist = 1
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 6
let g:ale_completion_enabled = 0
" let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 1
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_delay = 100
let g:ale_fix_on_save = 1

let g:ale_linters = {
  \ 'javascript': ['tsserver', 'css-languageserver', 'eslint'],
  \ 'typescript': ['tsserver', 'eslint'],
  \ 'typescriptreact': ['tsserver', 'eslint'],
  \ 'css': ['css-languageserver'],
  \ 'scss': ['css-languageserver'],
\}

let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint'],
  \ 'typescript': ['prettier', 'eslint'],
  \ 'typescriptreact': ['prettier', 'eslint'],
  \ 'json': ['prettier'],
  \ 'jsonc': ['prettier'],
  \ 'json5': ['prettier'],
  \ 'css': ['prettier', 'stylelint'],
  \ 'scss': ['prettier', 'stylelint'],
  \ 'graphql': ['prettier'],
  \ 'markdown': ['prettier'],
\}

let g:ale_javascript_eslint_suppress_missing_config = 1
let g:ale_javascript_eslint_suppress_eslintignore = 1
let g:ale_javascript_prettier_use_local_config = 1

nnoremap ,e :ALENextWrap<cr>
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>

let g:ale_change_sign_column_color = 0
let g:ale_sign_column_always = 1
let g:ale_set_signs = 1
let g:ale_open_list = 1
let g:ale_echo_cursor = 1
" let g:ale_cursor_detail = 1
let g:ale_echo_msg_format = '%s (%linter%) %[code]%'
let g:ale_echo_msg_error_str = '🔥'
let g:ale_echo_msg_warning_str = '💩'
let g:ale_echo_msg_info_str = '👉'
let g:ale_sign_error = '🔥'
let g:ale_sign_warning = '💩'
let g:ale_sign_style_error = '💩'
let g:ale_sign_style_warning = '💩'
let g:ale_sign_info = '👉'
let g:ale_virtualtext_cursor = 0
let g:ale_virtualtext_prefix = ''

nnoremap ,E :ALENextWrap<cr>
nnoremap ,d :ALEFindReferences<cr>
nnoremap ,i :ALEDetail<cr>
nnoremap <leader>an :ALENextWrap<cr>
nnoremap <leader>ap :ALEPreviousWrap<cr>

augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

" }}}

" fzf {{{
nnoremap <c-p> <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" }}}


" nerd-tree {{{
let NERDTreeShowHidden=1
nmap <F5> :NERDTreeToggle<cr>

" }}}

" coc {{{
" trigger completion and navigate with <tab>
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <tab> pumvisible() ? "\<c-n>" : <SID>check_back_space() ? "\<tab>" : coc#refresh()
inoremap <expr><s-tab> pumvisible() ? "\<c-p>" : "\<c-h>"

" trigger completion with <c-space>
inoremap <silent><expr> <c-space> coc#refresh()

" confirm completion with <cr>
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"

" navigate diagnostics
nmap <silent> ,e <plug>(coc-diagnostic-next)
nmap <silent> [c <plug>(coc-diagnostic-prev)
nmap <silent> ]c <plug>(coc-diagnostic-next)

" gotos
nmap <silent> gd <plug>(coc-definition)
nmap <silent> gy <plug>(coc-type-definition)
nmap <silent> gi <plug>(coc-implementation)
nmap <silent> gr <plug>(coc-references)

" show documentation in preview window
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<cr>

" highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" rename word
nmap <leader>rw <plug>(coc-rename)

" format selected region
vmap <leader>f  <plug>(coc-format-selected)
nmap <leader>f  <plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " setup formatexpr specified filetype(s).
  autocmd FileType typescript,javascript,javascript.jsx,json,jsonc setlocal formatexpr=CocAction('formatSelected')

  " update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" codeAction on selected region (e.g. `<leader>aap` for current paragraph)
vmap <leader>a  <plug>(coc-codeaction-selected)
nmap <leader>a  <plug>(coc-codeaction-selected)

" codeAction on the current line
nmap <leader>ac  <plug>(coc-codeaction)

" autofix problem
nmap <leader>F  <plug>(coc-fix-current)

" format buffer
command! -nargs=0 Format :call CocAction('format')

" fold buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)


" add diagnostic info for Lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }

" CocList {{{
" show all diagnostics
nnoremap <silent> <space>A  :<c-u>CocList diagnostics<cr>

" manage extensions
nnoremap <silent> <space>e  :<c-u>CocList extensions<cr>

" show commands
nnoremap <silent> <space>c  :<c-u>CocList commands<cr>

" find symbol of current document
nnoremap <silent> <space>o  :<c-u>CocList outline<cr>

" search workspace symbols
nnoremap <silent> <space>s  :<c-u>CocList -I symbols<cr>

" do default action for next item.
nnoremap <silent> <space>j  :<c-u>CocNext<cr>

" do default action for previous item.
nnoremap <silent> <space>k  :<c-u>CocPrev<cr>

" resume latest coc list
nnoremap <silent> <space>p  :<c-u>CocListResume<cr>

" }}}

" CocJest {{{
" run jest for current project
command! -nargs=0 Jest :call  CocAction('runCommand', 'jest.projectTest')

" run jest for current file
command! -nargs=0 JestCurrent :call  CocAction('runCommand', 'jest.fileTest', ['%'])

" run jest for current test
nnoremap <leader>te :call CocAction('runCommand', 'jest.singleTest')<cr>

" init jest in current cwd, (requires global jest command)
command! JestInit :call CocAction('runCommand', 'jest.init')

" }}}

" }}}

" treesitter {{{
lua << EOF
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = {},
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
EOF

" }}}

" vim:syntax=vim
