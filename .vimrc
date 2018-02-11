"#####neobundle設定#####
if !&compatible
    set nocompatible
endif

set pythonhome=$HOME/.pyenv/versions/2.7.14
set pythondll=$HOME/.pyenv/versions/2.7.14/lib/libpython2.7.dylib
set pythonthreehome=$HOME/.pyenv/versions/3.6-dev
set pythonthreedll=$HOME/.pyenv/versions/3.6.4/lib/libpython3.6m.dylib

augroup vimrc
	autocmd!
augroup END

let DEIN_REPOSITORY_URL = 'https://github.com/Shougo/dein.vim'
let s:dein_cache_dir = expand('~/.cache/dein')
let s:dein_repository_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# 'dein.vim'
    if !isdirectory(s:dein_repository_dir)
        call system('git clone ' . DEIN_REPOSITORY_URL . ' ' . shellescape(s:dein_repository_dir))
    endif

    let &runtimepath = s:dein_repository_dir . ',' . &runtimepath
endif

let s:toml_file = expand('~/.vim/rc') . '/dein.toml'
let s:toml_lazy_file = expand('~/.vim/rc') . '/dein_lazy.toml'

if dein#load_state(s:dein_cache_dir)
    call dein#begin(s:dein_cache_dir)
    call dein#load_toml(s:toml_file, { 'lazy': 0 })
    call dein#load_toml(s:toml_lazy_file, { 'lazy': 1 })
    call dein#end()
    call dein#save_state()
endif

if has('vim_starting') && dein#check_install()
    call dein#install()
endif

filetype plugin indent on

"#####表示設定#####
set t_Co=256 "256色表示対応
colorscheme mrkn256 "カラースキーマを設定
set number "行番号を表示する
set title "編集中のファイル名を表示
set showmatch "括弧入力時の対応する括弧を表示
syntax on "コードの色分け
set tabstop=4 "インデントをスペース4つ分に設定
set smartindent "オートインデント
set list "改行やタブを可視化する
set shiftwidth=4 "オートインデントの幅をスペース4つ分に設定"
set expandtab "タブを空白に自動変換
set listchars=tab:>-,trail:-,eol:↲ "タブ，空白，改行文字を指定する
set laststatus=2 "ステータスラインを常に表示
set statusline=%F%r%h%= "ステータスラインの内容
set cursorline "カーソルラインの強調表示
set guifont=Myrica\ M:h18
highlight cursorline term=none cterm=none ctermfg=none ctermbg=black
highlight Normal ctermbg=none

set clipboard=unnamed,autoselect

"#####閉じ括弧#####
inoremap { {}<LEFT>
inoremap [ []<LEFT>
inoremap ( ()<LEFT>
inoremap < <><LEFT>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>


"#####検索設定#####
set ignorecase "大文字/小文字の区別なく検索する
set smartcase "検索文字列に大文字が含まれている場合は区別して検索する
set wrapscan "検索時に最後まで行ったら最初に戻る
set history=50 "検索履歴を50個残す
set hlsearch "検索後にマッチした単語をハイライトする

"#####バックアップ設定#####
set backup "バックアップを有効にする
set backupdir=~/vim_backup "バックアップディレクトリを指定する

"#####キーバインド設定#####
set backspace=start,eol,indent "挿入モード,行頭,インデントのBackspace有効化

"quickrun設定
let g:quickrun_config = {
    \ '_': {
    \     'runner': 'vimproc',
    \     'runner/vimproc/updatetime': 60,
    \     'split': '',
    \     'hook/time/enable': 1,
    \ },
\}
set splitbelow
nnoremap qr :QuickRun<CR>
nnoremap <expr><silent><C-c> quickrun#is_running() ? quickrun#sweep_sessions() : '\<C-c>'

"NERDTree設定
nnoremap <silent><C-d> :NERDTreeToggle<CR>

"deoplete設定
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<C-n>" :
    \ neosnippet#expandable_or_jumpable() ?
    \     "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"

"neosnippet用設定
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

"unite用設定
let g:unite_enable_start_insert = 0
nnoremap <silent> ,g :<C-u>Unite grep:. -buffer-name=search-buffer<CR>
nnoremap <silent> ,r :<C-u>UniteResume search-buffer<Cr>

if executable('ag')
	let g:unite_source_grep_command = 'ag'
	let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
	let g:unite_source_grep_recursive_opt = ''
endif

"lightline用設定
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], ['readonly', 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
	  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
  
function! MyReadonly()
	return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction
	
function! MyFilename()
	return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
		\ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
		\  &ft == 'unite' ? unite#get_status_string() :
		\  &ft == 'vimshell' ? vimshell#get_status_string() :
		\ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
		\ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction
	  
function! MyFugitive()
	try
		if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
			return fugitive#head()
		endif
	catch
	endtry
	return ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
	return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
	return winwidth(0) > 60 ? lightline#mode() : ''
endfunction


" JavaScript用ライブラリの設定
function! EnableJavaScriptLibrary()
	let g:used_javascript_libs = 'jquery,underscore,react,flux,jasmine,chai'
	let b:javascript_lib_use_jquery = 1
	let b:javascript_lib_use_underscore = 1
	let b:javascript_lib_use_react = 1
	let b:javascript_lib_use_flux = 1
	let b:javascript_lib_use_jasmine = 1
	let b:javascript_lib_use_chai = 1
endfunction

