dnf list installed | awk 'NR > 1 {print $1}' > ~/.fedora-configs/dnf-packages.txt
sudo dnf install -y $(cat ~/.fedora-configs/dnf-packages.txt)

bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
chsh -s $(which zsh)

source ~/.zshrc

zinit self-update
