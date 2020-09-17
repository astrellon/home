CWD=`pwd`
cd ~

TO_LINK=(.bashrc .bash_profile .i3 .i3status.conf .vim .vimrc .easystroke .compton.conf)

echo `pwd`
for link in ${TO_LINK[@]}; do
    if [[ ! -f $link && ! -L $link ]]; then
        echo "Creating " $link
        ln -s "${CWD%%/}/$link"
    fi
done

echo "Creating VSCode links"
mkdir -p ~/.config/Code/User

ln -s ${CWD%%/}/vscode/settings.json ~/.config/Code/User/settings.json
ln -s ${CWD%%/}/vscode/snippets ~/.config/Code/User/snippets

apt-get install vim easystroke sakura vlc htop curl xdotool
