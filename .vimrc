set encoding=utf-8
scriptencoding utf-8

"モードラインを有効化
set modeline
"ファイル形式別プラグイン,インデントの有効化
filetype plugin indent on
"構文ハイライトの有効化
syntax on

"vim-plugを自動でインストール
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
let g:plug_threads = 1

"plugin
call plug#begin('~/.vim/plugged')
Plug 'w0ng/vim-hybrid'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"ハイライト系
Plug 'slim-template/vim-slim'
Plug 'chr4/nginx.vim'
Plug 'posva/vim-vue'
call plug#end()

"normal
nnoremap j gj
nnoremap gj j
nnoremap k gk
nnoremap gk k
nnoremap <C-e> $
nnoremap <C-a> ^

"insert
inoremap <C-b> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-f> <Right>

"画面分割の設定
nnoremap s <Nop>
nnoremap ss :vsplit<Return><C-w>w
nnoremap sv :split<Return><C-w>w
nnoremap <Space> <C-w>w
nnoremap sh <C-w>h
nnoremap sk <C-w>k
nnoremap sj <C-w>j
nnoremap sl <C-w>l

"colorscheme
set background=dark
colorscheme hybrid
"行番号の色の設定
hi lineNr ctermfg=243 guifg=#707880
hi CursorLine ctermbg=236

"行番号の表示
set number
"タイトルの表示
set title
"ステータスラインの表示
set laststatus=2
"ステータスラインのフォーマットの設定
set statusline=%F%m%h%w\ %<[ENC=%{&fenc!=''?&fenc:&enc}]\ [FMT=%{&ff}]\ [TYPE=%Y]\ %=[CODE=0x%02B]\ [POS=%l/%L(%02v)]
"入力中のコマンドの表示
set showcmd
"コマンド補完の設定
set wildmenu
"現在のモードの表示
set showmode
"現在の行を強調表示
set cursorline
"ビープ音の無効化
set visualbell t_vb=
set noerrorbells
"対応する括弧を表示
set showmatch
"スワップファイルの無効化
set noswapfile
"バックアップファイルの無効化
set nobackup

"検索時に小文字で入力した場合、大文字と区別しない
set ignorecase
set smartcase
"インクリメントサーチの有効化
set incsearch
"検索語のハイライト表示
set hlsearch
"ESC連打でハイライトの無効化
nnoremap <ESC><ESC> :nohlsearch<CR>

"Tabの可視化
set list listchars=tab:>-
"Tabで半角スペースを入力
set expandtab
"行頭でのTabの表示幅
set shiftwidth=2
"行頭以外でのTabの表示幅
set tabstop=2
"改行時のインデントの保持
set autoindent

"全角スペースの可視化
highlight FullWidthSpace
  \ cterm=underline
  \ ctermfg=LightGreen
  \ gui=underline
  \ guifg=LightGreen
augroup FullWidthSpace
  autocmd!
  autocmd VimEnter,WinEnter * call matchadd("FullWidthSpace", "　")
augroup END
"行末スペースの可視化
highlight EndSpace
  \ ctermbg=199
  \ guibg=Cyan
augroup EndSpace
  autocmd!
  autocmd VimEnter,WinEnter * match EndSpace /\s\+$/
augroup END

"ヤンクをクリップボードに保存
set clipboard+=unnamed

"TODO 動きません
"クリップボードから貼り付けた文の整形
if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
    set paste
    return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

"インサートモードでステータスラインの色の変更
augroup InsertHook
  autocmd!
  autocmd InsertEnter * hi StatusLine ctermbg=221
  autocmd InsertLeave * hi StatusLine ctermbg=234
augroup END

"NERD TREE
noremap <C-n> :NERDTreeToggle<CR>
