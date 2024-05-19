#!/bin/bash

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
        echo "[✓] $package_name ya está instalado"
    else
        # Instalamos el paquete
        echo "[-] Instalando $package_name"
        sudo apt -y install $package_name > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            echo -e "   [✓] $package_name se instaló correctamente"
        else
            echo -e "   [-] $package_name no se instaló correctamente"
        fi
    fi
done

function ctrl_c() {
    printf "\e[?25h"
    exit 0; 
} 

trap ctrl_c EXIT
