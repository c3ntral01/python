#!/bin/bash

yum install gcc zlib-devel bzip2 bzip2-devel readline readline-devel sqlite sqlite-devel openssl openssl-devel git -y

if [ ! -e ./.pyenv ];then
  git clone https://github.com/yyuu/pyenv.git ~/.pyenv
fi

touch ~/.bash_profile

RET=$(sudo cat ~/.bash_profile |grep -i pyenv_root |wc -l)

if [ ${RET} -lt 2 ];then
  VAR1='$HOME/.pyenv'
  VAR2='$PYENV_ROOT/bin:$PATH'
  VAR3='$(pyenv init -)'
cat << EOS >> ~/.bash_profile

export PYENV_ROOT="${VAR1}"
export PATH="${VAR2}"
eval "${VAR3}"
EOS
fi

if [ ! -e ~/.pyenv/plugins/pyenv-virtualenv ];then
  git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
fi

RET2=$(sudo cat ~/.bash_profile |grep -i virtualenv-init |wc -l)

if [ ${RET2} -lt 1 ];then
  VAR4='eval "$(pyenv virtualenv-init -)" >> ~/.bash_profile'
  VAR5='$SHELL -l'
  echo "${VAR4}" >> ~/.bash_profile
  exec "${VAR5}"
fi
