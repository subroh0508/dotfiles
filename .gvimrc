set pythonhome=$HOME/.pyenv/versions/2.7.14
set pythondll=$HOME/.pyenv/versions/2.7.14/lib/libpython2.7.dylib
set pythonthreehome=$HOME/.pyenv/versions/3.6-dev
set pythonthreedll=$HOME/.pyenv/versions/3.6.4/lib/libpython3.6m.dylib

set background=dark
set guifont=Myrica\ Monospace:h24
colorscheme mrkn256 "カラースキーマを設定
set transparency=20 " initialize
nnoremap <expr><F12> &transparency+20 >= 100 ? ":set transparency=20\<CR>" : ":let &transparency=&transparency+20\<CR>"

