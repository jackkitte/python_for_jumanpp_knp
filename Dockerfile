FROM jackkitte/jumanpp_knp
LABEL maintainer="tamash"

WORKDIR /home/tamash
ENV DEBIAN_FRONTEND noninteractive

# Install pyenv
RUN git clone git://github.com/yyuu/pyenv.git ${HOME}/.pyenv
RUN git clone https://github.com/yyuu/pyenv-pip-rehash.git ${HOME}/.pyenv/plugins/pyenv-pip-rehash
ENV PYENV_ROOT ${HOME}/.pyenv
ENV PATH $PYENV_ROOT/bin:$PATH
ENV PIPENV_VENV_IN_PROJECT true
RUN echo 'eval "$(pyenv init -)"' >> .zshrc

# Install Pipenv
RUN sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y install python3.7-dev
RUN curl --silent https://bootstrap.pypa.io/get-pip.py | sudo python3.7

# Backwards compatility
RUN sudo rm -fr /usr/bin/python3 && sudo ln /usr/bin/python3.7 /usr/bin/python3

RUN sudo pip3 install pipenv

# workディレクトリへzshでattach
WORKDIR /home/tamash/work
ENTRYPOINT [ "/bin/zsh" ]