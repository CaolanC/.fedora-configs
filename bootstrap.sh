ln -sf ~/.fedora-configs/nvim ~/.config/nvim
ln -sf ~/.fedora-configs/.zshrc ~/.zshrc

sudo dnf install -y $(cat ~/.fedora-configs/dnf-packages.txt)


bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
sudo chsh -s $(which zsh)

exec zsh

zinit self-update
source ~/.zshrc
exit

