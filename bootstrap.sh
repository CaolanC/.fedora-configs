sudo dnf install -y $(cat ~/.fedora-configs/dnf-packages.txt)

bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
chsh -s $(which zsh)

source ~/.zshrc

zinit self-update
