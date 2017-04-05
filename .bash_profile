if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

bind -r '\C-s'
stty -ixon

export PATH=$PATH:/opt/TEE-CLC-11.0.0
