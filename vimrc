set backspace=indent,eol,start

" tab/indent
set expandtab " タブ入力を複数の空白入力に置き換える
set tabstop=2 " 画面上でタブ文字が占める幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent " 改行時に前の行のインデントを継続する
set smartindent " 改行時に前の行の構文をチェックし次の行のインデントを増減する
set shiftwidth=2 " smartindentで増減する幅

" serch
set incsearch
set ignorecase
set smartcase
set hlsearch
" ESCキー2度押しでハイライトの切り替え
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>"

set showmatch " 括弧の対応関係を一瞬表示するi"
set wildmenu " コマンドモードの保管
set history=5000 " コマンド履歴数

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" paste ignore auto indent settings
if &term =~ "xterm"
    let &t_SI .= "\e[?2004h"
    let &t_EI .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
endif

" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j

" 行頭・行末移動方向をキーの相対位置にあわせる
nnoremap 0 $
nnoremap 1 0

" 挿入モードでのカーソル移動
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-a> <Home>
inoremap <C-e> <End>
" カーソルから行頭まで削除
inoremap <C-u> <C-o>d0
" カーソルから行末まで削除
inoremap <C-k> <C-o>D
" 補完
inoremap <C-l> <C-p>

" カーソルから行頭までヤンク
"inoremap <silent> <C-y>e <Esc>ly0<Insert>
" カーソルから行末までヤンク
"inoremap <silent> <C-y>0 <Esc>ly$<Insert>

" 引用符, 括弧の設定
inoremap { {}<Left>
inoremap [ []<Left>
inoremap ( ()<Left>
inoremap " ""<Left>
inoremap ' ''<Left>
inoremap < <><Left>

"表示設定
"set number
set title

" color scheme settings
syntax on
set t_Co=256

" indentLine settings

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/nakamurakousuke/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/nakamurakousuke/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/unite.vim')
call dein#add('isRuslan/vim-es6')
call dein#add('tomasr/molokai')
call dein#add('bronson/vim-trailing-whitespace')
call dein#add('Yggdroot/indentLine')
call dein#add('scrooloose/nerdtree')
call dein#add('tpope/vim-endwise')


" Add or remove your plugins here:
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')

" You can specify revision/branch/tag.
call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------
