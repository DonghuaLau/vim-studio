#! /bin/sh

# color definition
RED='\033[0;31m'
NC='\033[0m'

# check command exists
function is_command_exist()
{
	cmd=$1
	exist=`whereis ${cmd} | wc -w | awk '{ if(int($1) > 1){ printf("1"); }else{ printf("0"); } }'`
	echo ${exist}
}

# check alias exists
function is_alias_exist()
{
	cmd=$1
	exist=`alias ${cmd} 2>&1 | grep 'not found' | wc -l | awk '{ if(int($1) > 1){ printf("1"); }else{ printf("0"); } }'`
	echo ${exist}
}

# check package installation
function is_package_installed()
{
	pkg=$1
	exist=`rpm -q ${pkg} | grep -v 'is not installed' | wc -l`
	echo ${exist}
}


# check hua-vim installation
hua_vim_version=`cat ~/.vimrc 2>&1 | grep hua_vim_version | awk -F"'" '{print $2}'`
if [ "SS${hua_vim_version}" != "SS" ]; then
	echo "hua-vim has installed."
	exit
else
	echo "hua-vim will be installing."
fi

# check vim installation
is=$(is_command_exist 'vim')
if [ ${is} == 1 ]; then
	echo "vim is found."
else
	echo ''
	echo -e "    ${RED}vim is not found, install vim first.${NC}"
	echo ''
	exit
fi

# check ctags installation
is=$(is_command_exist 'ctags')
if [ ${is} == 1 ]; then
	echo "ctags is found."
else
	echo ''
	echo -e "    ${RED}ctags is not found, install ctags first.${NC}"
	echo ''
	exit
fi

# check the_silver_searcher installation
is=$(is_package_installed 'the_silver_searcher')
if [ ${is} == 1 ]; then
	echo "the_silver_searcher is found."
else
	echo -e "    ${RED}the_silver_searcher is not found, install the_silver_searcher first.${NC}"
	echo ''
	echo "   rpm -Uvh http://download.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-8.noarch.rpm  (CentOS 7)"
	echo "   or"
	echo "   rpm -Uvh http://mirrors.yun-idc.com/epel/6/x86_64/epel-release-6-8.noarch.rpm  (CentOS 6)"
	echo "   yum install the_silver_searcher"
	echo ''
	exit
fi

# backup ~/.vim and ~/.vimrc
suffix=`date +"%Y%m%d%H%M"`
if [ -d ~/.vim ] ; then
	mv ~/.vim ~/.vim_backup.${suffix}
	echo "backup ~/.vim to ~/.vim_backup.${suffix}"
fi
if [ -f ~/.vimrc ] ; then
	cp -rf ~/.vimrc ~/.vimrc_backup.${suffix}
	echo "backup ~/.vimrc to ~/.vimrc_backup.${suffix}"
fi

# install hua-vim
cp -rf ./vim ~/.vim
cat ./vimrc >> ~/.vimrc

# check vimp alias
is=$(is_alias_exist 'vimp')
if [ ${is} == 1 ]; then
	echo "vimp alias is found."
else
	echo '' >> ~/.bash_profile
	echo "alias vimp='vim +Project'" >> ~/.bash_profile
	echo '' >> ~/.bash_profile
	echo -e "vimp alias added, remember to execute: ${RED}source ~/.bash_profile${NC}."
fi

echo "hua-vim install complete."

