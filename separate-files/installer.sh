#!/bin/bash

NEGRO="\e[30m"
ROJO="\e[31m"
VERDE="\e[32m"
AMARILLO="\e[33m"
AZUL="\e[34m"
MAGENTA="\e[35m"
CELESTE="\e[36m"
BLANCO="\e[37m"
NOCOLOR="\e[0m"

# Función para verificar si un paquete está instalado
package_installed() {
    dpkg -l | grep -q "^ii  $1 "
}

# Separar la cadena de entrada en nombres de paquetes
IFS=' ' read -ra packages <<< "$1"

# Instalación de paquetes uno por uno
for package_name in "${packages[@]}"; do
    # Verificamos si el paquete ya está instalado
    if package_installed "$package_name"; then
        printf "$VERDE[✓] $package_name ya está instalado \n $NOCOLOR"
    else
        # Instalamos el paquete
        printf "$AZUL[-] Instalando $package_name \n $NOCOLOR"
        sudo apt -y install $package_name > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            printf "$VERDE\t[✓] $package_name se instaló correctamente \n $NOCOLOR"
        else
            printf "$ROJO\t[-] $package_name no se instaló correctamente \n $NOCOLOR"
        fi
    fi
done

function ctrl_c() {
    printf "\e[?25h"
    exit 0; 
} 

trap ctrl_c EXIT
