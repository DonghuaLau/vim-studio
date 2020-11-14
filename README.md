# Vim Studio

总有一款适合自己的IDE。 

脚本开发参考：
* [官方文档](https://www.vim.org/scripts/) 
* [w3cschool文档](https://www.w3cschool.cn/vim/nckx1pu0.html)

## 插件及用法

#### [CTags](http://ctags.sourceforge.net/)
```
ctags --languages=-all --languages=+c,c++ -R
:tag <symbol>
```

#### [Tagbar](https://github.com/majutsushi/tagbar)
A class outline viewer.
```
:TagbarToggle
# 或者
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

#### [NERD Commenter](https://github.com/preservim/nerdcommenter)
代码注释，作用于行或者可视化模式选择的文本。
```
# 很多命令与gutentags_plus冲突，可视化模式下不冲突。

# 行注释
[n] + \ + cn

# 块注释
[n] + \ + cm

# 格式化块注释
[n] + \ + cs

# 左右对齐的行注释
[n] + \ + cb

# 去掉注释
[n] + \ + c + u
```

#### astyle
代码格式化（asytle是命令工具，还不好使）
```
:Fmt
```

#### [vim-go](https://github.com/fatih/vim-go)

```
# Mac上安装最新版本vim
brew install vim --with-lua --with-override-system-vi
```

#### [vim-markdown](https://github.com/fatih/vim-markdown)
```
zr: reduces fold level throughout the buffer
zR: opens all folds
zm: increases fold level throughout the buffer
zM: folds everything all the way
za: open a fold your cursor is on
zA: open a fold your cursor is on recursively
zc: close a fold your cursor is on
zC: close a fold your cursor is on recursively
```

#### gtags

与下述插件配置使用：
* vim-gutentags: 自动生成tags，依赖ctags。
* gutentags_plus
* vim-preview: 

```
# mac上安装
brew install global

\ + cg # 查看光标下符号的定义
\ + cs # 查看光标下符号的引用
\ + cc # 查看有哪些函数调用了该函数
\ + cf # 查找光标下的文件
\ + ci # 查找哪些文件 include 了本文件

```

#### vim-easy-align

可视化模式下选择需要对齐的文本，输入```ga```进入EasyAlign模式，然后按下面的方式对齐：
```
# 默认向左对齐
*<space>

# 向右对齐
<enter>*<space>

# 居中对齐
<enter><enter>*<space>
```

其中，```<space>```表示按空格对齐，可替换为其它需要对齐的字符，支持```=:.|&#,```。更多用法见：https://github.com/junegunn/vim-easy-align

#### 远程编辑文件

```
# host可以是.ssh/config中的Host，最好配置密钥
# 目录也可以打开，还支持FTP、SFTP、HTTP(read only)、rsync
vim scp://user@host/filepath
vim scp://deep@vmhost128//home/deep/nohup.out
```

**常见问题**

* ERROR: no gtags database for this project, check gutentags's documents

解决方法：确认项目目录是否符合g:gutentags_project_root的配置


#### [YouCompleteMe](https://github.com/ycm-core/YouCompleteMe)
安装教程：[官方](https://github.com/ycm-core/YouCompleteMe#macos), [辅助](https://vimjc.com/vim-youcompleteme-install.html)。

（mac下似乎不安装macvim也没什么问题）
