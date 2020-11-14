func! SimpleLog(msg)
	if(g:islogopen != 0)
		call writefile([a:msg], g:logfile, "a")
	endif
endfunc

func! GccCompile(clean)
	let s:sdir = expand("%:p:h")

	if(a:clean == 1)
		exec "AsyncRun cd " . s:sdir . "; make clean; make -j8;"
	else
		exec "AsyncRun cd " . s:sdir . "; make -j8;"
	endif

	exec "rightbelow :copen 8"
	"exec "bo :copen 8"
	exec "wincmd k"
endfunc

func! OpenWithTag()
	exec ":tab split"
	exec ":tag ".expand("<cword>")
	"exec ":TagbarToggle"
	exec ":Project"
	exec "wincmd l"
endfunc

func! TagbarToggleEx()
	exec ':TagbarToggle'
	if !exists('t:tagbar_buf_name')
		wincmd h
		"exec ':vertical resize 24'
		exec 'wincmd l'
		echo "close tagbar"
	else
		echo "open tagbar"
	endif
	"echo "tagbar toggle"
endfunc

func! LineInfo()

	let s:n = line(".")
	let s:str = getline(s:n)
	let s:wd = expand("<cword>")
	let s:sfile = expand("%:p")

	exec ":new"
	" let l:winnr = winnr()			

	" echo "\n"
	" echo "~ line:"line(".")", col:"col(".")", pos: "getpos(".")", len:"col("$")
	" echo "[content]"s:str
	" echo "[word]:"s:wd
	" echo "[script files]:" . s:sfile

	" let l:winnr = winnr()			
	" echo "[winnr]:" . l:winnr

	"let s:in = inputdialog("input sth")
	"let s:in = input("[input something] ")
	"echo "\n[your input]"s:in

endfunc

func! LineRight(n)
	let s:line = line(".")
	let s:col = col(".") + a:n
	let s:maxcol = col("$")
	if s:col > s:maxcol
		let s:line += 1
		let s:col = s:col - s:maxcol
	end
	let s:pos = [0, s:line, s:col, 0]
	call setpos(".", s:pos)
endfunc

func! LineLeft(n)
	let s:line = line(".")
	let s:col = col(".") - a:n
	echo "column: "s:col
	if s:col < 0
		let s:line -= 1
		let s:pos = [0, s:line, 1, 0]
		call setpos(".", s:pos)
		let s:pos = [0, s:line, col("$") + s:col, 0]
		call setpos(".", s:pos)
	else
		let s:pos = [0, s:line, s:col, 0]
		call setpos(".", s:pos)
	end
endfunc

func! LineDown(n)
	let s:line = line(".") + a:n
	let s:col = col(".")
	let s:pos = [0, s:line, s:col, 0]
	call setpos(".", s:pos)
endfunc

func! LineUp(n)
	let s:line = line(".") - a:n
	let s:col = col(".")
	let s:pos = [0, s:line, s:col, 0]
	call setpos(".", s:pos)
endfunc

func QueryWord(args)

	if empty(a:args)
		let l:word = expand("<cword>")
	else
		let l:word = a:args
	end

	"echo "query word: " . l:word

	let s:buf = system("dict " . l:word)
	echo s:buf
endfunc

" support golang, add following to ~/.ctags
"   --langdef=Go
"   --langmap=Go:.go
"   --regex-Go=/func([ \t]+\([^)]+\))?[ \t]+([a-zA-Z0-9_]+)/\2/d,func/
"   --regex-Go=/var[ \t]+([a-zA-Z_][a-zA-Z0-9_]+)/\1/d,var/
"   --regex-Go=/type[ \t]+([a-zA-Z_][a-zA-Z0-9_]+)/\1/d,type/

func GenTags(args)
    let s:cmd = "AsyncRun ctags --languages=-all --languages=+c,c++,go -R ."
    exec s:cmd
    echo "generate C/C++, golang tags"
endfunc

func GenPtags()
    let s:cmd = "AsyncRun " . g:vspath . "/scripts/ptags.sh"
    exec s:cmd
    echo "generate python tags"
endfunc

function ShowTabNo()
    let s = '' " complete tabline goes here
    " loop through each tab page
    for t in range(tabpagenr('$'))
        " set highlight
        if t + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif
        " set the tab page number (for mouse clicks)
        let s .= '%' . (t + 1) . 'T' " !!!
        let s .= ' '
        " set page number string
        let s .= t + 1 . ' '
        " get buffer names and statuses
        let n = ''      "temp string for buffer names while we loop and check buftype
        let m = 0       " &modified counter
        let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
        " loop through each buffer in a tab
        for b in tabpagebuflist(t + 1)
            " buffer types: quickfix gets a [Q], help gets [H]{base fname}
            " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
            if getbufvar( b, "&buftype" ) == 'help'
                let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' ) " !!!
            elseif getbufvar( b, "&buftype" ) == 'quickfix'
                let n .= '[Q]' " !!!
            else
			
                "let n .= pathshorten(bufname(b)) " !!!
                let pfile = pathshorten(bufname(b))
				let n .= fnamemodify(pfile, ":t")
            endif
            " check and ++ tab's &modified count
            if getbufvar( b, "&modified" )
                let m += 1
            endif
            " no final ' ' added...formatting looks better done later
            if bc > 1
                let n .= ' '
            endif
            let bc -= 1
        endfor

        " add modified label [n+] where n pages in tab are modified
        if m > 0
            let s .= '[' . m . '+]'
        endif

        " select the highlighting for the buffer names
        " my default highlighting only underlines the active tab
        " buffer names.
        if t + 1 == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        " add buffer names
        if n == ''
            let s.= '[New]'
        else
            let s .= n
        endif
        " switch to no underlining and add final space to buffer list
        let s .= ' '
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s .= '%#TabLineFill#%T'
    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        "let s .= '%=%#TabLineFill#999Xclose'
        let s .= '%=%#TabLineFill#X'
    endif
    return s
endfunction


"autocmd InsertLeave * :call SimpleLog("insert leave file: " . @%)
" autocmd TabEnter * :call SimpleLog("enter file: " . @%)
" autocmd CursorMoved * :call SimpleLog("cursor moved in normal mode, file: " . @% . ", pos: " . join(getpos("."), ":"))
" autocmd CursorMovedI * :call SimpleLog("cursor moved in insert mode, file: " . @%)
" 
" call SimpleLog("open file: ".@%)

" auto save
au InsertLeave * write

map <C-\> :call OpenWithTag()<CR>
nmap <F7> :NERDTreeToggle<CR>
nmap <F8> :TagbarToggle<CR>
nmap <F10> :call GccCompile(1)<CR>
nmap <F11> :call GccCompile(1)<CR>
"nmap <silent><F8> :call TagbarToggleEx()<CR> " not working
nmap \l :call LineInfo()<CR>
nmap \F :echo expand('%:p')<CR> " get file with full path
"nmap \s :sh<CR> " reserve for Conque-Shell
nmap <leader>s :sh<CR>
"nmap <leader>s :ConqueTermSplit bash<CR>
nmap \e :qa<CR>
nmap <silent> <C-L> :call LineRight(20)<CR>
nmap <silent> <C-H> :call LineLeft(20)<CR>
nmap <silent> <C-J> :call LineDown(5)<CR>
nmap <silent> <C-K> :call LineUp(5)<CR>
" vmap <silent> <C-J> :call LineDown(5)<CR>
" vmap <silent> <C-K> :call LineUp(5)<CR>

"map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
nmap <F9> :Project<CR>:exec('wincmd l')<CR>

nmap \n :cn<CR>
nmap \b :cp<CR>
nmap \x :cclose<CR>
nmap \r :exec("AsyncRun myctags")<CR>

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

nmap <silent> \q :call QueryWord("")<CR>
command! -nargs=* Qw :call QueryWord(<q-args>)
command! -nargs=* Gentags :call GenTags(<q-args>)
command! -nargs=0 Genptags :call GenPtags()
command! -nargs=0 Nonum :set nonumber | :set norelativenumber
command! -nargs=0 Num :set number | :set relativenumber
command! -nargs=0 Noautocode :set nocindent | :set nosmartindent | :set noautoindent | :set paste
command! -nargs=0 Autocode :set cindent | :set smartindent | :set autoindent | :set nopaste 
command! Hex :%!xxd
command! Unhex :%!xxd -r
command! -nargs=0 GBK :e ++enc=cp936
command! -nargs=0 UTF8 :e ++enc=utf8
