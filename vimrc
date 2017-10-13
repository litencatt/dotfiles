syntax on
set noswapfile

set backspace=indent,eol,start
set scrolloff=5
set ruler

" tab/indent
set tabstop=2     " 画面上でタブ文字が占める幅
set shiftwidth=2  " smartindentで増減する幅
set softtabstop=2 " 連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent    " 改行時に前の行のインデントを継続する
set expandtab     " タブ入力を複数の空白入力に置き換える
set smartindent   " 改行時に前の行の構文をチェックし次の行のインデントを増減する

augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.php setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.py  setlocal tabstop=4 softtabstop=4 shiftwidth=4
    autocmd BufNewFile,BufRead *.rb  setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.md  setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.erb setlocal tabstop=2 softtabstop=2 shiftwidth=2
    autocmd BufNewFile,BufRead *.js  setlocal tabstop=2 softtabstop=2 shiftwidth=2
augroup END
autocmd BufWrite *.{rb} set fenc=utf-8

"表示設定
set number
set title
set encoding=utf-8
set fileencoding=utf-8
""set fileencodings=iso-2022-jp,cp932,sjis,euc-jp,utf-8
set fileencodings=utf-8,euc-jp

" color scheme settings
set t_Co=256

" serch
set incsearch
set ignorecase
set smartcase
set hlsearch
" ESCキー2度押しでハイライトの切り替え
nnoremap <Esc><Esc> :<C-u>set nohlsearch!<CR>"

set showmatch " 括弧の対応関係を一瞬表示する"
set wildmenu " コマンドモードの保管
set history=5000 " コマンド履歴数

" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste
" paste seggins
set clipboard+=unnamed
set clipboard+=autoselect

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
"inoremap <silent> <C-j> j

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

" NERDTree remap
nnoremap <silent><C-e> :NERDTreeToggle<CR>

" gtags
" 検索結果Windowを閉じる
nnoremap <C-t> <C-w><C-w><C-w>q
" Grep 準備
"nnoremap <C-g> :Gtags -g
" このファイルの関数一覧
nnoremap <C-l> :Gtags -f %<CR><CR>
" カーソル以下の定義元を探す
nnoremap <C-j> :Gtags <C-r><C-w><CR><CR>
"map <C-j> :GtagsCursor<CR><CR>
" カーソル以下の使用箇所を探す
nnoremap <C-i> :Gtags -r <C-r><C-w><CR><CR>
" 次の検索結果
nnoremap <C-n> :cn<CR>
" 前の検索結果
nnoremap <C-p> :cp<CR>

" vim tab settings
nnoremap sn gt
nnoremap sp gT
nnoremap st :<C-u>tabnew<CR>

" Change Emmet key binding
let g:user_emmet_leader_key = '<C-y>'

let g:neocomplete#enable_at_startup = 1
nnoremap qr :Quick<CR>
" quickrun.vim
let g:quickrun_config = {
\    '_': {
\        'outputter/buffer/split': ':botright 8sp',
\        'outputter/buffer/close_on_empty': ':1',
\        'runner': 'vimproc',
\        'runner/vimproc/updatetime': '5',
\    },
\}


"-----------------------------------------
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('$HOME/.cache/dein')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')
call dein#add('Shougo/unite.vim')
call dein#add('tomasr/molokai')
call dein#add('bronson/vim-trailing-whitespace')
call dein#add('Yggdroot/indentLine')
call dein#add('scrooloose/nerdtree')
call dein#add('tpope/vim-endwise')

call dein#add('vim-scripts/gtags.vim')
call dein#add('kana/vim-fakeclip')

call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/neocomplete')
call dein#add('Shougo/vimproc')
call dein#add('thinca/vim-quickrun')

call dein#add('isRuslan/vim-es6')
call dein#add('slim-template/vim-slim')
call dein#add('posva/vim-vue')
call dein#add('mattn/emmet-vim')

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
