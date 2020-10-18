" special for Mac OS

"自动载入ctags gtags
if version >= 800
    if executable('~/opt/bin/ctags')
        let g:gutentags_modules += ['~/opt/bin/ctags']
    endif
endif
