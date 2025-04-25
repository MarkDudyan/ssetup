#!/bin/bash

PS1_color_function='
PS1_color() {
    if [ -n "$force_color_prempt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            color_prompt=yes
        else
            color_prompt=
        fi
    fi

    if [ "$color_prompt" = yes ]; then
        PS1='"'"'\\[\\033[01;35m\\]$(debian_chroot:+($debian_chroot))\\[\\033[01;32m\\]\\u@\\h\\[\\033[00m\\]:\\[\\033[01;34m\\]\\w\\[\\033[00m\\]\\$ '"'"'
    else
        PS1='"'"'\\033[01;35m$(debian_chroot:+($debian_chroot))\\u@\\h:\\w\\$\\033[00m '"'"'
    fi
}
'

# Проверяем, существует ли .bashrc
if [ ! -f ~/.bashrc ]; then
    touch ~/.bashrc
fi

# Проверяем, не добавлена ли уже функция
if ! grep -q "PS1_color()" ~/.bashrc; then
# Добавляем функцию в .bashrc
    echo -e "\n# Custom colored PS1 prompt" >> ~/.bashrc
    echo "$PS1_color_function" >> ~/.bashrc
    echo -e "\n# Activate colored prompt" >> ~/.bashrc
    echo "PS1_color" >> ~/.bashrc
    
    echo "Функция PS1_color успешно добавлена в ~/.bashrc"
    source ~/.bashrc
else
    echo "Функция PS1_color уже существует в ~/.bashrc"
fi
