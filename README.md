this is a code to make python env.



CentOS Linux release 7.2.1511 (Core)



$ yum install gcc zlib-devel bzip2 bzip2-devel readline readline-devel sqlite sqlite-devel openssl openssl-devel git



$ git clone https://github.com/yyuu/pyenv.git ~/.pyenv



$ vim .bash_profile



$ pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
bash_profileを反映。



$ source .bash_profile



$ pyenv install --list



$ pyenv install 3.5.1




$ python --version
Python 2.7.5



$ pyenv global 3.5.1
$ pyenv rehash
$ python --version
Python 3.5.1



$ pyenv versions
  system
* 3.5.1 (set by /root/.pyenv/version)



$ pyenv global system
$ python --version
Python 2.7.5
