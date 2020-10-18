if exists("g:kola_plugin") || &cp
	finish
endif

let g:kola_plugin = "v1"

let g:logfile = $HOME . "/.vim/vim.log"
if !exists("g:islogopen")
	let g:islogopen = 0
endif

