#!/bin/bash
mkdir ./resources/Cousine_Font

echo "[↓] Descargando fuentes"
# Descargar la fuente desde la URL oficial
wget -q --show-progress -O ./resources/Cousine_Font/Cousine.zip https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.0/Cousine.zip

# Extraer la fuente del archivo zip
unzip -q ./resources/Cousine_Font/Cousine.zip -d ./resources/Cousine_Font/

# Instalamos la fuente en el sistema
sudo cp -r ./resources/Cousine_Font/* /usr/share/fonts/truetype/
echo "[+] Fuentes instaladas"

# Actualizamos la caché de fuentes
sudo fc-cache -f -v >/dev/null 2>&1
echo "[+] Caché de fuentes actualizada"

# Limpiamos el archivo zip descargado
rm ./resources/Cousine_Font/Cousine.zip

echo "[✓] Las fuentes se instalaron correctamente"

function ctrl_c() {
    printf "\e[?25h"
    exit 0; 
} 

trap ctrl_c EXIT
