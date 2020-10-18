
" detect OS
let s:names = split(system('uname -s'), "\n")
let s:uname = get(s:names, 0)

if s:uname == "Darwin"
	let g:os = "mac"
	exec "source " . g:vspath . "/config/mac.vim"
elseif s:uname == "Linux"
	let g:os = "linux"
	exec "source " . g:vspath . "/config/linux.vim"
endif


" vim-plug
call plug#begin()

    Plug 'skywind3000/asyncrun.vim'
    Plug 'rstacruz/sparkup', {'rtp': 'vim/'} " for html code
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' } " F7
    Plug 'scrooloose/nerdcommenter'
    Plug 'https://github.com/majutsushi/tagbar.git'
    Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
    Plug 'https://github.com/rking/ag.vim.git'
    Plug 'https://github.com/vimplugin/project.vim.git'
    Plug 'jiangmiao/auto-pairs' " 括号自动补全
    Plug 'octol/vim-cpp-enhanced-highlight'
    Plug 'vim-scripts/vim-auto-save'
    "Plug 'vim-scripts/Conque-Shell' " has python errors
    
    " 状态栏
    if g:os == "mac"
        Plug 'vim-airline/vim-airline'
        Plug 'vim-airline/vim-airline-themes'
    elseif g:os == "linux"
        Plug 'itchyny/lightline.vim' " suit me better than vim-airline on linux
    endif
    
    " 符号索引
    Plug 'vim-scripts/gtags.vim'
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'skywind3000/gutentags_plus'
    "Plug 'skywind3000/vim-preview' " 感觉效果不大，与ctrl + w + ]差不多"
    
    " 代码补全方案一
    "
    
    " 代码补全方案二（YCM），安装复杂，还未体验
    "Plug 'Valloric/YouCompleteMe', {'do':'./install.py --clang-completer --go-completer --java-completer'}
    Plug 'Valloric/YouCompleteMe'
    "Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
    "Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
    
    " 语法错误提示
    "Plug 'w0rp/ale' " not working
    
    " golang
    "Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } " 闪动严重
    "Plug 'volgar1x/vim-gocode' " 操作结果不可预知，用法不对？
    
    "Plug 'godlygeek/tabular'
    "Plug 'plasticboy/vim-markdown' " 没体会到多大的用处
    
    " 待体验的插件
    "Plug 'Yggdroot/LeaderF', { 'do': './install.sh' } " 据说比ctrlp性能好
    "Plug 'artur-shaik/vim-javacomplete2'
    
    Plug 'deepzliu/vim-studio' 

call plug#end()

" 对应语言需要安装相应的检查工具 (yum无法安装ale_linters)
" https://github.com/w0rp/ale
"	let g:ale_linters = {
"		\   'cpp': ['cppcheck','clang','gcc'],
"		\   'c': ['cppcheck','clang', 'gcc'],
"		\   'python': ['pylint'],
"		\   'bash': ['shellcheck'],
"		\   'go': ['golint'],
"		\}
"let g:ale_linters_explicit = 1 "除g:ale_linters指定，其他不可用
"let g:ale_linters = {
"	\   'cpp': ['cppcheck'],
"	\   'c': ['cppcheck'],
"	\}
"let g:ale_completion_enabled = 1
"let g:ale_sign_column_always = 1
"let g:ale_completion_delay = 500
"let g:ale_echo_delay = 20
"let g:ale_lint_delay = 500
"let g:ale_echo_msg_format = '[%linter%] %code: %%s'
"let g:ale_lint_on_text_changed = 'normal'
"let g:ale_lint_on_insert_leave = 1
"let g:airline#extensions#ale#enabled = 1
""let g:ale_set_quickfix = 1
""let g:ale_open_list = 1"打开quitfix对话框
"let g:ale_statusline_format = ['X %d', '⚡ %d', '~ ok']
"let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
"let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
"let g:ale_c_cppcheck_options = '-Wall -O2 -std=c99'
"let g:ale_cpp_cppcheck_options = '-Wall -O2 -std=c++14'
"
"let g:ale_sign_error = ">>"
"let g:ale_sign_warning = "--"
""map <F7> ::ALEToggle<CR>

"自动载入ctags gtags
if version >= 800

	"let g:gutentags_trace = 1 " for debug

    "let $GTAGSCONF = '/data/home/deepliu/opt/gtags/share/gtags/gtags.conf'

	" cscope
	"set cscopetag                  " 使用 cscope 作为 tags 命令
	"set cscopeprg='gtags-cscope'   " 使用 gtags-cscope 代替 cscope
	
	" gtags
	let GtagsCscope_Auto_Load = 1
	let CtagsCscope_Auto_Map = 1
	let GtagsCscope_Quiet = 1

    " gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
    let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

    " 所生成的数据文件的名称
    let g:gutentags_ctags_tagfile = '.tags'

    " 同时开启 ctags 和 gtags 支持：
    let g:gutentags_modules = []

    if executable('gtags-cscope') && executable('gtags')
        let g:gutentags_modules += ['gtags_cscope']
    endif

    " 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
    let g:gutentags_cache_dir = expand('~/.cache/tags')

    " 配置 ctags 的参数
    let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
    let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
    let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

    " 如果使用 universal ctags 需要增加下面一行
    let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

    " 禁用 gutentags 自动加载 gtags 数据库的行为
    " 避免多个项目数据库相互干扰
    " 使用plus插件解决问题
    let g:gutentags_auto_add_gtags_cscope = 0

    "预览 quickfix 窗口 ctrl-w z 关闭
    "Plug 'skywind3000/vim-preview'
    "P 预览 大p关闭
    autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
    autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
	" 往上滚动预览窗口
    noremap <Leader>u :PreviewScroll -1<cr> 
	" 往下滚动预览窗口
    noremap <leader>d :PreviewScroll +1<cr> 
endif

let g:ycm_server_python_interpreter = g:python3
let g:ycm_global_ycm_extra_conf = g:vspath . '/config/ycm_extra_conf.py'

" Add highlighting for function definition in C++
"function! EnhanceCppSyntax()
"	syn match cppFuncDef "::\~\?\zs\h\w*\ze([^)]*\()\s*\(const\)\?\)\?$"
"	hi def link cppFuncDef Special
"endfunction 

" tagbar plugin setting
" ag.vim plugin setting
set runtimepath^=~/.vim
"let g:ag_prg="<custom-ag-path-goes-here> --vimgrep"
let g:ag_working_path_mode="r"

"let g:ConqueTerm_PyVersion = 3 " 本机的 python 是 2.7,所以这里设置成 2
"let g:ConqueTerm_StartMessages = 0 "去掉烦人的警告


" jce 
augroup filetype
  au! BufRead,BufNewFile *.jce setfiletype jce
augroup end

"map <F2> :call FormatCode()<CR>
func! FormatCode()
	exec "w"
	if &filetype == 'C' || &filetype == 'h'
	   exec "%!astyle --style=allman --indent=tab"
	elseif &filetype == 'cpp'
	   exec "%!astyle --style=allman --indent=tab"
	return
	endif
	exec "w"
endfunc
command! -nargs=0 Fmt :call FormatCode()<CR>


" vim-airline setting
let g:airline_section_b = '%{strftime("%c")}'
let g:airline_section_y = 'BN: %{bufnr("%")}'
set laststatus=2  "永远显示状态栏
let g:airline_powerline_fonts = 1  " 支持 powerline 字体
let g:airline#extensions#tabline#enabled = 1 "显示窗口tab和buffer
let g:airline_theme='bubblegum'
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'


" show tab number
"set tabline=%!ShowTabNo()  " custom tab pages line


if g:os == "linux"
    let g:lightline = { 'colorscheme': 'default' }
endif

" vim-auto-save
let g:auto_save = 1
" 设置updatetime  值不可变,为默认的 200
let g:auto_save_no_updatetime = 1
let g:updatetime = 5
" 插入模式下不进行自动保存
let g:auto_save_in_insert_mode = 1
" 保存时不在状态栏提示保存时间
"let g:auto_save_silent = 1  

" ============== custom setting ===================
" Deepliu
"let g:syntastic_python_python_exec = '/data/home/deepliu/opt/python-3.6.5/bin/python3' 
let NERDTreeIgnore = ['\.o$', '\.tar.gz$', '\.so', '\.pyc$', 'unit_test', 'pressure_test']

syntax on
set ts=4
set expandtab " replace tab as blank
"set fileencodings=cp936
"set fileencodings=utf8
set mouse-=a
set ruler
"color koehler
"color darkblue 
color desert
set scrolloff=3
set relativenumber
set number
set nobackup
"set nowritebackup
set nopaste " paste without indent
set nocindent
set hlsearch

"let g:islogopen = 1

""set foldenable              " 开始折叠
"set foldmethod=syntax       " 设置语法折叠
"set foldmethod=marker		 " this works, but not like it
"set foldcolumn=0            " 设置折叠区域的宽度
"setlocal foldlevel=2        " 设置折叠层数为
"set foldlevelstart=99       " 打开文件是默认不折叠代码
"
""set foldclose=all          " 设置为自动关闭折叠                
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
                            " 用空格键来开关折叠
