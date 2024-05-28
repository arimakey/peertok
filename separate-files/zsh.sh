#!/bin/bash

# Instalamos ZSH
# sudo ./separate-files/installer.sh "zsh"

# touch $HOME/.zshrc
# sudo touch $HOME/.zshrc

# echo "[⚙️] Cambiando la terminal por defecto"
# Configuramos ZSH como SHELL por defecto
# sudo chsh -s $(which zsh) > /dev/null 2>&1
# chsh -s $(which zsh) > /dev/null 2>&1



# Instalamos ohmyZSH!
# echo "[-] Instalando OhMyZSH!"
# zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /dev/null 2>&1
# sudo zsh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" > /dev/null 2>&1
# echo "[✓] OhMyZSH! se instaló correctamente"


# function ctrl_c() {
#     printf "\e[?25h"
#     exit 0; 
# } 

# trap ctrl_c EXIT
