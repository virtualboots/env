#!/bin/bash
cd $( dirname ${BASH_SOURCE[0]} )

echo install dot files
pushd dotfiles > /dev/null
    for file in *
    do
        if [ -f ~/.$file ]; then
            if cmp -s $PWD/$file ~/.$file ; then
                echo $file: skipped
            else
                if [ -f ~/.$file.bak ]; then
                    echo "$file: sorry, ~/.$file.bak exist, can't backup"
                    exit 1
                else
                    echo $file: backuped, installed
                    mv ~/.$file ~/.$file.bak
                    ln -fs $PWD/$file ~/.$file
                fi 
            fi
        else
            echo $file: installed
            ln -fs $PWD/$file ~/.$file
        fi 
    done
popd > /dev/null

echo
echo setup vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

