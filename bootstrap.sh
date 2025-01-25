ln -sf ~/.fedora-configs/nvim ~/.config/nvim
ln -sf ~/.fedora-configs/.zshrc ~/.zshrc
ln -sf ~/.fedora-configs/bin ~/bin

sudo dnf install -y $(cat ~/.fedora-configs/dnf-packages.txt)


bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
sudo chsh -s $(which zsh)

sudo systemctl start tlp
sudo systemctl enable tlp

exec zsh

zinit self-update
source ~/.zshrc
exit

