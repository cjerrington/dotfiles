# Edit .bash_aliases
alias edit='code ~/.bash_aliases'
alias reload='. ~/.bashrc'
alias me='whoami'

#setup python 
alias python=python3
alias pip=pip3

#external IP
alias exip='curl http://ipecho.net/plain; echo'
alias ip='ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk "{print $2}"'

# make directory and then cd to it
mkd () {
  mkdir -p $1
  cd $1
}

# extract compreessed files
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
 else
    if [ -f $1 ] ; then
        NAME=${1%.*}
        mkdir $NAME && cd $NAME
        case $1 in
          *.tar.bz2)   tar xvjf ../$1    ;;
          *.tar.gz)    tar xvzf ../$1    ;;
          *.tar.xz)    tar xvJf ../$1    ;;
          *.lzma)      unlzma ../$1      ;;
          *.bz2)       bunzip2 ../$1     ;;
          *.rar)       unrar x -ad ../$1 ;;
          *.gz)        gunzip ../$1      ;;
          *.tar)       tar xvf ../$1     ;;
          *.tbz2)      tar xvjf ../$1    ;;
          *.tgz)       tar xvzf ../$1    ;;
          *.zip)       unzip ../$1       ;;
          *.Z)         uncompress ../$1  ;;
          *.7z)        7z x ../$1        ;;
          *.xz)        unxz ../$1        ;;
          *.exe)       cabextract ../$1  ;;
          *)           echo "extract: '$1' - unknown archive method" ;;
        esac
    else
        echo "$1 - file does not exist"
    fi
fi
}

# Generates a tree view from the current directory
function tree(){
	pwd
	ls -R | grep ":$" |   \
	sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
}

# Generates a random password
function ranpass() {
	if [ -z $1 ]; then
		MAXSIZE=10
	else
		MAXSIZE=$1
	fi
	array1=(
	q w e r t y u i o p a s d f g h j k l z x c v b n m Q W E R T Y U I O P A S D
	F G H J K L Z X C V B N M 1 2 3 4 5 6 7 8 9 0
	\! \@ \$ \% \^ \& \* \! \@ \$ \% \^ \& \* \@ \$ \% \^ \& \*
	)
	MODNUM=${#array1[*]}
	pwd_len=0
	while [ $pwd_len -lt $MAXSIZE ]
	do
	    index=$(($RANDOM%$MODNUM))
	    echo -n "${array1[$index]}"
	    ((pwd_len++))
	done
	echo
}

# rename all the files which contain uppercase letters to lowercase in the current folder
function filestolower(){
  read -p "This will rename all the files and directories to lowercase in the current folder, continue? [y/n]: " letsdothis
  if [ "$letsdothis" = "y" ] || [ "$letsdothis" = "Y" ]; then
    for x in `ls`
      do
      skip=false
      if [ -d $x ]; then
	read -p "'$x' is a folder, rename it? [y/n]: " renamedir
	if [ "$renamedir" = "n" ] || [ "$renameDir" = "N" ]; then
	  skip=true
	fi
      fi
      if [ "$skip" == "false" ]; then
        lc=`echo $x  | tr '[A-Z]' '[a-z]'`
        if [ $lc != $x ]; then
          echo "renaming $x -> $lc"
          mv $x $lc
        fi
      fi
    done
  fi
}



# Short hand aliases
alias cls=clear
alias tolowercase="pbpaste | tr "[:upper:]" "[:lower:]" | pbcopy"
alias touppercase="pbpaste | tr "[:lower:]" "[:upper:]" | pbcopy"
