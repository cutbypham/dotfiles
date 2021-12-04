call plug#begin()
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
set hidden
set shortmess+=c
set signcolumn=yes
set updatetime=10
let g:coc_global_extensions = [
            \ "coc-snippets",
            \ "coc-prettier",
            \ "coc-json",
            \ "coc-html",
            \ "coc-htmlhint",
            \ "coc-html-css-support",
            \ "coc-eslint",
            \ "coc-emmet",
            \ "coc-dot-complete",
            \ "coc-diagnostic",
            \ "coc-dash-complete",
            \ "coc-tsserver",
            \ "coc-sql",
            \ "coc-sh",
            \ "coc-omnisharp",
            \ "coc-go",
            \ "coc-vetur",
            \ "coc-lua",
            \ "coc-deno",
            \ "coc-css",
            \ "coc-clangd"]

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

nmap <silent> [d :call CocAction('diagnosticNext')<enter>
nmap <silent> ]d :call CocAction('diagnosticPrevious')<enter>

nmap <silent> <leader>c :CocAction<enter>

noremap <silent> <Leader>; :CocCommand<enter>

imap <C-l> <Plug>(coc-snippets-expand)

vmap <C-j> <Plug>(coc-snippets-select)

let g:coc_snippet_prev = '<c-k>'

xmap <leader>x  <Plug>(coc-convert-snippet)

inoremap <C-j> <Plug>(coc-snippets-expand-jump)

imap <C-j> <Plug>(coc-snippets-expand-jump)

command! -nargs=0 EditSnippets :call CocAction('runCommand', 'snippets.editSnippets')
command! -nargs=0 FormatFile :call CocAction('runCommand', 'prettier.formatFile')
command! -nargs=0 RenameCurrentWord :call CocAction('runCommand', 'document.renameCurrentWord')

Plug 'https://github.com/voldikss/vim-floaterm'

let g:floaterm_width=0.9
let g:floaterm_height=0.9
let g:floaterm_title=""
let g:floaterm_borderchar="─│─│╭╮╰╯"
hi FloatermBorder guibg=Normal guifg=#88507D

autocmd VimEnter * FloatermNew --silent

let g:floaterm_keymap_toggle = '<c-s>'

noremap <silent> gp :FloatermSend! cd %:p:h ; git push ; cd -<enter>
noremap <silent> gP :FloatermSend! cd %:p:h ; git push -f ; cd -<enter>

command! GitHubIssueList execute "FloatermNew --autoclose=1 source ~/dotfiles/zsh/functions/fzfConfig.zsh ; cd %:h:p ; gitHubIssueList"
noremap <silent> gil :GitHubIssueList<enter>
command! GitHubIssueClose execute "FloatermNew --autoclose=1 source ~/dotfiles/zsh/functions/fzfConfig.zsh ; cd %:h:p ; gitHubIssueClose"
noremap <silent> gic :GitHubIssueClose<enter>
command! GitHubIssueViewWeb execute "FloatermNew --autoclose=1 source ~/dotfiles/zsh/functions/fzfConfig.zsh ; cd %:h:p ; gitHubIssueViewWeb"
noremap <silent> giv :GitHubIssueViewWeb<enter>
command! GithubRepoViewWeb execute "FloatermSend cd %:h:p ; gh browse ; cd -"
command! LazyGit execute "FloatermNew --autoclose=1 cd %:h:p ; lazygit ; cd -"
noremap <silent> gl :LazyGit<enter>

Plug 'https://github.com/wellle/targets.vim'

Plug 'liuchengxu/vista.vim'
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
noremap <leader>l :Vista finder fzf<enter>
noremap <leader>v :Vista!!<enter>

Plug 'https://github.com/rhysd/vim-clang-format', {'for': ['h', 'cs', 'c', 'cpp']}
let g:clang_format#auto_format=1
autocmd BufWritePre *.cs ClangFormat
Plug 'https://github.com/kana/vim-operator-user'

Plug 'https://github.com/nvim-lua/popup.nvim'
Plug 'https://github.com/ThePrimeagen/harpoon'
nmap <silent> mi :lua require("harpoon.mark").add_file()<enter>
nmap <silent> mo :lua require("harpoon.ui").toggle_quick_menu()<enter>
" moving less, thinking like hjkl, now with number qwert|asdfg
" 6|7|8|9|10
" q|w|e|r|t
" ----------
" 1|2|3|4|5
" a|s|d|f|g
nmap <silent> ma :lua require("harpoon.ui").nav_file(1)<enter>
nmap <silent> ms :lua require("harpoon.ui").nav_file(2)<enter>
nmap <silent> md :lua require("harpoon.ui").nav_file(3)<enter>
nmap <silent> mf :lua require("harpoon.ui").nav_file(4)<enter>
nmap <silent> mg :lua require("harpoon.ui").nav_file(5)<enter>
nmap <silent> mq :lua require("harpoon.ui").nav_file(6)<enter>
nmap <silent> mw :lua require("harpoon.ui").nav_file(7)<enter>
nmap <silent> me :lua require("harpoon.ui").nav_file(8)<enter>
nmap <silent> mr :lua require("harpoon.ui").nav_file(9)<enter>
nmap <silent> mt :lua require("harpoon.ui").nav_file(10)<enter>

Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }

Plug 'https://github.com/junegunn/fzf.vim'

inoremap <expr> fw fzf#vim#complete#word()
imap fp <plug>(fzf-complete-path)
noremap <leader>f :Files<enter>
noremap <leader>F :Files ~<enter>
noremap <leader>k :Buffers<enter>
noremap <leader>j :Rg<enter>
noremap <leader>h :History<enter>
noremap ; :Commands<enter>
noremap // :BLines<enter>

let g:fzf_layout = { 'window': {
            \ 'width': 0.9,
            \ 'height': 0.9,
            \ 'highlight': 'Comment',
            \ 'rounded': v:true } }
let $FZF_DEFAULT_OPTS='--reverse'
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'Normal', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

Plug 'https://github.com/tpope/vim-fugitive'

noremap <silent> gs :G<enter>gg5j2ly$k0
noremap <silent> gc :silent lcd %:h<enter>:BCommits<enter>
noremap <silent> gb :G blame<enter>
noremap <silent> gd :vsplit<Return><C-w>w:Gdiff<enter>

Plug 'https://github.com/tpope/vim-eunuch'

" Plug 'https://github.com/kevinhwang91/vim-ibus-sw'

Plug 'https://github.com/dkarter/bullets.vim'
let g:bullets_enabled_file_types = [
            \ 'markdown',
            \ 'text',
            \ 'gitcommit',
            \ 'scratch'
            \]

Plug 'https://github.com/iamcco/markdown-preview.nvim', {'do': 'cd app & yarn install'}

Plug 'https://github.com/ferrine/md-img-paste.vim'

autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
let g:mdip_imgdir = 'img'
let g:mdip_imgname = 'image'

Plug 'https://github.com/phaazon/hop.nvim'
map f :HopChar1<enter>
noremap f :HopChar1<enter>

Plug 'https://github.com/wellle/tmux-complete.vim'

Plug 'https://github.com/christoomey/vim-tmux-navigator'

Plug 'https://github.com/max397574/better-escape.nvim'

Plug 'https://github.com/mattn/emmet-vim'
let g:user_emmet_leader_key=','
let g:user_emmet_install_global = 0
autocmd FileType xhtml,html,css,markdown EmmetInstall

Plug 'https://github.com/AndrewRadev/tagalong.vim'
let g:tagalong_filetypes = ['eco', 'eelixir', 'ejs', 'eruby', 'html', 'xhtml', 'htmldjango', 'javascriptreact', 'jsx', 'php', 'typescriptreact', 'xml']

Plug 'https://github.com/leafOfTree/vim-matchtag'

Plug 'https://github.com/tpope/vim-surround'

set virtualedit=block

Plug 'https://github.com/windwp/nvim-autopairs'

Plug 'https://github.com/windwp/nvim-ts-autotag'

Plug 'https://github.com/preservim/nerdcommenter'
let g:NERDSpaceDelims = 1
map mm <Plug>NERDCommenterToggle

Plug 'https://github.com/mbbill/undotree'
set undodir=~/sync/ok/undodir
set undofile
nnoremap <leader>u :UndotreeToggle<enter>
let g:undotree_WindowLayout = 3

Plug 'https://github.com/romainl/vim-cool'

set hlsearch
set ignorecase
set incsearch
set smartcase
set magic
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap * *zz
nnoremap # #zz

Plug 'https://github.com/norcalli/nvim-colorizer.lua'
autocmd BufRead,BufNewFile * :ColorizerAttachToBuffer

Plug 'https://github.com/lukas-reineke/indent-blankline.nvim'
if &diff
    let g:indent_blankline_enabled = v:false
endif
let g:indent_blankline_char = '▏'
let g:indent_blankline_filetype_exclude = [
            \ 'help', 'yaml'
            \]

Plug 'https://github.com/nvim-lua/plenary.nvim'

Plug 'https://github.com/lewis6991/gitsigns.nvim'

Plug 'https://github.com/rktjmp/lush.nvim'

Plug 'https://github.com/mcchrish/zenbones.nvim'
call plug#end()

syntax enable
set termguicolors

runtime ./themeControl.vim

set cursorline

autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

set number relativenumber
command! NumberLine execute "set number relativenumber"
command! NumberLineOff execute "set number! relativenumber!"

set statusline=[\ %F\ %m]\ %r%h%w%=\ %{fugitive#statusline()}

set list
let &listchars = 'tab:▸ ,trail:·,nbsp:±,extends:❯,precedes:❮'

set wrap linebreak
let &showbreak = '⤷'
set cpo+=n

set tabstop=4 softtabstop=4 noet
set shiftwidth=4
autocmd BufRead,BufNewFile *.cs,*.h,*.cpp,*.scss,*.css,*.html,*.md setlocal tabstop=2 shiftwidth=2 softtabstop=2
set expandtab

set nocompatible
filetype plugin indent on
set encoding=UTF-8
set mouse=a
set clipboard=unnamedplus

set autoindent
set smartindent
set autoread
set autowrite
set nobackup
set noswapfile
set lazyredraw
set ttyfast
set nowritebackup

set inccommand=split
set scrolloff=5

nnoremap + <C-a>
nnoremap - <C-x>

xnoremap < <gv
xnoremap > >gv

map <space> <leader>

noremap <silent> <C-t> :tabnew<Return>
noremap <silent> <S-e> gT
noremap <silent> <S-r> gt

noremap <silent> <leader>1 1gt
noremap <silent> <leader>2 2gt
noremap <silent> <leader>3 3gt
noremap <silent> <leader>4 4gt
noremap <silent> <leader>5 5gt
noremap <silent> <leader>6 6gt
noremap <silent> <leader>7 7gt
noremap <silent> <leader>8 8gt
noremap <silent> <leader>9 9gt

noremap <silent> <space>s :setlocal spell! spell?<enter>

set spelllang=en_us,vi

noremap ss :split<Return><C-w>w
noremap sv :vsplit<Return><C-w>w

map <silent> <Right> <C-w><
map <silent> <Down> <C-W>-
map <silent> <Up> <C-W>+
map <silent> <Left> <C-w>>

noremap <silent> cd. :cd %:h<enter>
noremap <silent> cd :cd<enter>

inoremap , ,<c-g>u
inoremap . .<c-g>u
inoremap ! !<c-g>u
inoremap ? ?<c-g>u
inoremap [ [<c-g>u

vnoremap <silent> <C-j> :m '>+1<enter>gv=gv
vnoremap <silent> <C-k> :m '<-2<enter>gv=gv

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
nnoremap gj j
nnoremap gk k

noremap <silent> gx :silent execute "!xdg-open " . "<cfile>"<enter>

nnoremap <leader>w :w<enter>
nnoremap <leader>q :q<enter>
nnoremap <leader>o :wq<enter>
noremap <leader>z <C-w>o
nnoremap Q :qa!<enter>

noremap H :cp<enter>
noremap L :cn<enter>
noremap J :bn<enter>
noremap K :bp<enter>

noremap Y y$

nnoremap <leader>i :%s/\<<C-r><C-w>\>/

nmap <silent> <leader>x :!xdg-open '%'<enter><enter>

nmap gf :edit <cfile><enter>

imap ;; <esc>A;<enter>
imap ;, <esc>A,<enter>

" @todo vim S/C-enter not working in fedora gnome 41.1
" @body @thuanpham2311
imap <S-enter> <esc>o
imap <C-enter> <esc>O
nnoremap <silent> <S-enter> o<esc>
nnoremap <silent> <C-enter> O<esc>

xnoremap <silent> p p:let @+=@0<enter>:let @"=@0<enter>
nnoremap M <c-^>

command! OpenFileInBraveBrowser execute "silent !brave-browser '%'"
command! CopyFileName execute "silent !echo % | wl-copy"
command! Reload execute "silent source ~/.config/nvim/init.vim | silent !tmux source-file ~/.tmux.conf"

command! Light execute "silent !light" | execute "silent source ~/.config/nvim/init.vim | silent !tmux source-file ~/.tmux.conf"
command! Dark execute "silent !dark" | execute "silent source ~/.config/nvim/init.vim | silent !tmux source-file ~/.tmux.conf"
