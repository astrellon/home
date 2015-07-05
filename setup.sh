CWD=`pwd`
cd ~

TO_LINK=(.bashrc .bash_profile .i3 .i3status.conf .vim .vimrc .easystroke .compton.conf)

echo `pwd`
for link in ${TO_LINK[@]}; do
    if [[ ! -f $link && ! -L $link ]]; then
        echo "Creating " $link
        ln -s ${CWD%%/}/$link
    fi
done
