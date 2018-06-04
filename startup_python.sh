#!/bin/bash

# Get Linux distribution name
get_os_distribution() {
    if   [ -e /etc/debian_version ] ||
         [ -e /etc/debian_release ]; then
        # Check Ubuntu or Debian
        if [ -e /etc/lsb-release ]; then
            # Ubuntu
            distri_name="ubuntu"
        else
            # Debian
            distri_name="debian"
        fi
    elif [ -e /etc/fedora-release ]; then
        # Fedra
        distri_name="fedora"
    elif [ -e /etc/redhat-release ]; then
        if [ -e /etc/oracle-release ]; then
            # Oracle Linux
            distri_name="oracle"
        elif [ -e /etc/centos-release ]; then
            # CentOS
            distri_name="centos"
        else
            # Red Hat Enterprise Linux
            distri_name="redhat"
        fi
    elif [ -e /etc/arch-release ]; then
        # Arch Linux
        distri_name="arch"
    elif [ -e /etc/turbolinux-release ]; then
        # Turbolinux
        distri_name="turbol"
    elif [ -e /etc/SuSE-release ]; then
        # SuSE Linux
        distri_name="suse"
    elif [ -e /etc/mandriva-release ]; then
        # Mandriva Linux
        distri_name="mandriva"
    elif [ -e /etc/vine-release ]; then
        # Vine Linux
        distri_name="vine"
    elif [ -e /etc/gentoo-release ]; then
        # Gentoo Linux
        distri_name="gentoo"
    else
        # Other
        echo "unkown distribution"
        distri_name="unkown"
    fi

    echo ${distri_name}
}

RET3=$(get_os_distribution)

if [ ${RET3} = 'centos' ]; then
  yum install gcc zlib-devel bzip2 bzip2-devel readline readline-devel sqlite sqlite-devel openssl openssl-devel git -y
elif [ ${RET3} = 'ubuntu' ]; then
  apt-get install build-essential zlib1g-dev libssl-dev libbz2-dev libreadline-dev libsqlite3-dev tk-dev python-tk python3-tk -y
fi

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
