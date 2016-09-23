# Vim Studio

Vim Studio is only integrate some plugins to making vim more powerful and coding efficiently, and like a IDE. 

## Installation
./install.sh

## Usage
Open
```
vimp
```
except this, it still vim.

## Plugins

#### [CTags](http://ctags.sourceforge.net/)
Ctags generates an index (or tag) file of language objects found in source files that allows these items to be quickly and easily located by a text editor or other utility. A tag signifies a language object for which an index entry is available (or, alternatively, the index entry created for that object).

#### [Tagbar](https://github.com/majutsushi/tagbar)
A class outline viewer.
```
:TagbarToggle

// only press F8 if installed Vim-Studio
F8
```

#### [ctrlp](https://github.com/ctrlpvim/ctrlp.vim)
Find file.
```
Ctrl + p
```

#### [ag.vim](https://github.com/rking/ag.vim)
Content search, based on [the_silver_searcher](https://github.com/ggreer/the_silver_searcher)
```
:Ag [options] {pattern} [{directory}]
 
// search the current word
:Ag
```

#### [project](http://www.vim.org/scripts/script.php?script_id=69)
Organize/Navigate projects of files (like IDE/buffer explorer).
```
// Open
vim +Project
// or
:Project
 
// Read current directory recursively
\ + C
// Read only current directory
\ + c

Enter the Name of the Entry: [project name]
Enter the Absolute Directory to Load:  [project path]
Enter the CD parameter: [.]
Enter the File Filter: [enter or *.h *.c *.cpp Make*]
 
// udpate project
\ + R
// But this can not update new created directory, or add below lines can work.
Name=Path {
}
```


