dnf list installed | awk 'NR > 1 {print $1}' > ~/.fedora-configs/dnf-packages.txt
