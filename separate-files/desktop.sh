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

root_file="$HOME/.inst"
intentos=3  # Número máximo de intentos

# Instalamos sxhkd
sudo ./separate-files/installer.sh "sxhkd"

# Instalamos bspwm
sudo ./separate-files/installer.sh "bspwm"

# instalamos la polybar
sudo ./separate-files/installer.sh "polybar"

# Instalamos feh
sudo ./separate-files/installer.sh "feh"

# Instalando dependecias adicionales
sudo ./separate-files/installer.sh "libconfig-dev libdbus-1-dev libegl-dev libev-dev libgl-dev libepoxy-dev libpcre2-dev libpixman-1-dev libx11-xcb-dev libxcb1-dev libxcb-composite0-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-glx0-dev libxcb-image0-dev libxcb-present-dev libxcb-randr0-dev libxcb-render0-dev libxcb-render-util0-dev libxcb-shape0-dev libxcb-util-dev libxcb-xfixes0-dev libxext-dev meson ninja-build uthash-dev"
sudo ./separate-files/installer.sh "libpcre3 libpcre3-dev libxcb-xinerama0-dev"

# Clonar el repositorio de GitHub en el directorio base

while [ $intentos -gt 0 ]; do
    printf "$AZUL[↓] Clonando Picom$NOCOLOR \n"
    rm -rf $HOME/.inst/picom
    git -C "$root_file" clone https://github.com/ibhagwan/picom.git > /dev/null 2>&1
    
    if [ $? -eq 0 ]; then
        printf "$VERDE\t[✓] Repositorio clonado exitosamente$NOCOLOR \n"
        break
    else
    	printf "$ROJO\t[x] No se pudo clonar. Intentado otra vez$NOCOLOR \n"
        intentos=$((intentos - 1)) 
    fi
done

if [ $intentos -eq 0 ]; then
    printf "$ROJO[x] No se pudo clonar. Porfavor instale picom manualmente o intente más tarde$NOCOLOR \n"
    exit 0
fi

# Actualizar los submódulos
git -C "$root_file/picom" submodule update --init --recursive --jobs 8 > /dev/null 2>&1

# Crear un directorio de construcción separado
build_dir="$root_file/picom/build"

# Configurar y compilar picom
echo "[⚙️] Configurando la instalacion de picom"
meson --buildtype=release -Dprefix=/usr/local "$build_dir" "$root_file/picom" > /dev/null 2>&1
echo "[🔨] Building Picom"
ninja -C "$build_dir" -j $(nproc) > /dev/null 2>&1

# Instalar picom
echo -e "   [-] Instalando Picom"
sudo ninja -C "$build_dir" install > /dev/null 2>&1
echo -e "   [✓] Picom se instaló correctamente"


function ctrl_c() {
	printf "\e[?25h"
    exit 0;
}

trap ctrl_c EXIT
