#!/bin/bash
root_file="$HOME/.inst"

function rofi() {
    echo "[⚙️] Cargando la configuración de ROFI"
    # Elimina la configuración de rofi existente
    rm -rf "$HOME/.config/rofi" > /dev/null 2>&1

    # Copiamos la nueva configuración de rofi a la carpeta .config
    mkdir -p "$HOME/.config/rofi" > /dev/null 2>&1
    cp -p -r "./.config/rofi/dark.rasi" "$HOME/.config/rofi/config.rasi" > /dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo "  [✓] Rofi se configuró correctamente"
    else
        echo "  [x] Hubo un problema configurando Rofi"
    fi
}

function alacritty() {
    echo "[⚙️] Cargando la configuración de ALACRITTY"
    # Elimina la configuración de alacritty existente
    rm -rf "$HOME/.config/alacritty" > /dev/null 2>&1

    # Copiamos la nueva configuración de alacritty
    cp -p -r "./.config/alacritty" "$HOME/.config/alacritty" > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "  [✓] Alacritty se configuró correctamente"
    else
        echo "  [x] Hubo un problema configurando Alacritty"
    fi
}

function sxhkd() {
    echo "[⚙️] Cargando la configuración de SXHKD"
    # Elimina la configuración de sxhkd existente
    rm -rf "$HOME/.config/sxhkd" > /dev/null 2>&1

    # Creamos las carpeta de configuración de sxhkd
    mkdir -p "$HOME/.config/sxhkd" > /dev/null 2>&1

    # Copiamos la nueva configuración de sxhkd
    cp -r "./.config/sxhkd" "$HOME/.config/" > /dev/null 2>&1

    if [ $? -eq 0 ]; then
        echo "  [✓] Sxhkd se configuró correctamente"
    else
        echo "  [x] Hubo un problema configurando Sxhkd"
    fi
}


function bspwm() {
    echo "[⚙️] Cargando la configuración de BSPWM"
    # Elimina la configuración de bspwm existente
    rm -rf "$HOME/.config/bspwm" > /dev/null 2>&1

    # Creamos la carpeta de configación de bspwm
    mkdir -p "$HOME/.config/bspwm" > /dev/null 2>&1

    # Copiamos las configuraciones para bspwm y le damos permisos de ejecución
    cp -r "./.config/bspwm" "$HOME/.config/"
    chmod +x "$HOME/.config/bspwm/bspwmrc"

    if [ $? -eq 0 ]; then
        echo "  [✓] Bspwm se configuró correctamente"
    else
        echo "  [x] Hubo un problema configurando Bspwm"
    fi
}

function polybar() {
    echo "[⚙️] Cargando la configuración de POLYBAR"
    # Elimina la configuración de polybar existente
    rm -rf "$HOME/.config/polybar" > /dev/null 2>&1

    # Carpeta de Configuración del polybar
    mkdir -p "$HOME/.config/polybar/" > /dev/null 2>&1

    # Copiar la nueva configuracion para la polybar
    cp -r "./.config/polybar" "$HOME/.config/"
    rm -f "$HOME/.config/polybar/config"
    chmod +x "$HOME/.config/polybar/launch.sh"

    if [ $? -eq 0 ]; then
        echo "  [✓] Polybar se configuró correctamente"
    else
        echo "  [x] Hubo un problema configurando Polybar"
    fi
}

function feh() {
    echo "[⚙️] Cargando la configuración de FEH"
    # Elimina la configuración de feh existente
    rm -rf "$root_file/wallpapers" > /dev/null 2>&1

    # Creamos una carpeta para los fondos de pantalla
    mkdir "$root_file/wallpapers/" > /dev/null 2>&1

    # Movemos el fondo a la carpeta destino
    cp "./resources/wallpaper.jpg" "$root_file/wallpapers/"

    if [ $? -eq 0 ]; then
        echo "  [✓] Feh se configuró correctamente"
    else
        echo "  [x] Hubo un problema configurando Feh"
    fi
}

function zsh() {
    echo "[⚙️] Cargando la configuración de ZSH"
    rm -rf $HOME/.zshrc
    cp ./.config/.zshrc $HOME/.zshrc
    
    if [ $? -eq 0 ]; then
        echo "  [✓] Zsh se configuró correctamente"
    else
        echo "  [x] Hubo un problema configurando Zsh"
    fi
}

function ctrl_c() {
    printf "\e[?25h"
    exit 0; 
} 

trap ctrl_c EXIT

if [ "$1" == "true" ]; then
    bspwm
fi
if [ "$2" == "true" ]; then
    sxhkd
fi
if [ "$3" == "true" ]; then
    polybar
fi
if [ "$4" == "true" ]; then
    feh
fi
if [ "$5" == "true" ]; then
    rofi
fi
if [ "$6" == "true" ]; then
    alacritty
fi
if [ "$6" == "true" ]; then
    zsh
fi