#! /bin/bash
options_lang=("English" "Español")
options_es=("Instalación y Configuración" "Solo Instalación" "Solo Configuración")
options_en=("Installation and Configuration" "Installation Only" "Configuration Only")

selector_both=("Desktop (bspwm / sxhkd / polybar / feh / picom)" "rofi" "alacritty", "zsh" "fonts")
selector_conf=("bspwm" "sxhkd" "polybar" "feh" "rofi" "alacritty" "zsh")
selector_inst=("Desktop (bspwm / sxhkd / polybar / feh / picom)" "rofi" "alacritty", "zsh" "fonts")

declare -a selector_selection

step=1
selection=0
length=3

NEGRO="\e[30m"
ROJO="\e[31m"
VERDE="\e[32m"
AMARILLO="\e[33m"
AZUL="\e[34m"
MAGENTA="\e[35m"
CELESTE="\e[36m"
BLANCO="\e[37m"
NOCOLOR="\e[0m"

FONDO_NEGRO="\e[40m"
FONDO_ROJO="\e[41m"
FONDO_VERDE="\e[42m"
FONDO_AMARILLO="\e[43m"
FONDO_AZUL="\e[44m"
FONDO_MAGENTA="\e[45m"
FONDO_CELESTE="\e[46m"
FONDO_BLANCO="\e[47m"
FONDO_NINGUNO="\e[0m"

function clear_screen() {
    clear;
}

function title() {
	echo "
		██████╗ ███████╗███████╗██████╗ ████████╗ ██████╗ ██╗  ██╗
		██╔══██╗██╔════╝██╔════╝██╔══██╗╚══██╔══╝██╔═══██╗██║ ██╔╝
		██████╔╝█████╗  █████╗  ██████╔╝   ██║   ██║   ██║█████╔╝ 
		██╔═══╝ ██╔══╝  ██╔══╝  ██╔══██╗   ██║   ██║   ██║██╔═██╗ 
		██║     ███████╗███████╗██║  ██║   ██║   ╚██████╔╝██║  ██╗
		╚═╝     ╚══════╝╚══════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝

	"
}

function ctrl_c() {
	printf "\e[?25h"
    exit 0;
}


function print_data() {
    local array=("${!1}");
    index=0

    for option in "${array[@]}"; do
		if [ "${selector_selection[index]}" == "true" ]; then
			MARK="[X]"
		else
			MARK="[ ]"
		fi
		
        if [ "$index" == "$selection" ]; then
            printf "$NEGRO $FONDO_BLANCO $MARK $option $FONDO_NINGUNO \n"
        else
            printf "$ROJO $FONDO_NINGUNO $MARK $option \n"
        fi

        ((index++))
    done;

	if [ "$index" == "$selection" ]; then
		printf "\n \n     $NEGRO $FONDO_BLANCO     ACEPTAR     $FONDO_NINGUNO \n"
	else
		printf "\n \n     $ROJO $FONDO_NINGUNO     ACEPTAR     \n"
	fi
}

function handle_input() {
    read -r -s -n 1 key

	case $key in
		A)
			if [ "$selection" == "0" ]; then
				selection=length
			fi
			((selection--))
			;;
		B)
			((selection++))
			if [ "$selection" == "$length" ]; then
				selection=0;
			fi
			;;
		"")
			save_data
			;;
	esac
}


function save_data() {
	if [[ "$selection" == "$((length-1))" ]]; then

		if [ "$step" == "1" ]; then
			if [ "${selector_selection[0]}" == "true" ]; then
				lang="en"
			else
				lang="es"
			fi
		elif [ "$step" == "2" ]; then
			if [ "${selector_selection[0]}" == "true" ]; then
				operation="both"
			elif [ "${selector_selection[1]}" == "true" ]; then
				operation="inst"
			else
				operation="conf"
			fi
		fi
		((step++))
	else
		if [[ "$step" == "1" ||  "$step" == "2" ]]; then
			select_one "$selection"
		else
			if [ "${selector_selection[selection]}" == "true" ]; then
				selector_selection[selection]="false"
			else
				selector_selection[selection]="true"
			fi
		fi
	fi
}

function reset_list() {
	select_none
	selector_selection[0]=true
}

function select_one() {
	select_none
	selector_selection[$1]=true
}

function select_none() {
	for ((i = 0; i <= 10; i++)); do
		selector_selection[i]=false
	done
}

function select_all() {
	for ((i = 0; i <= 10; i++)); do
		selector_selection[i]=true
	done
}

function question_lang() {
	printf "\e[?25l"
	reset_list
	length=3
	while [ "$step" == "1" ]; do
		clear_screen
		title
    	print_data options_lang[@]
		handle_input
	done
}


function question_operation() {
	printf "\e[?25l"
	reset_list
	length=4
	while [ "$step" == "2" ]; do
		clear_screen
		title
		if [ "$lang" == "en" ]; then
    		print_data options_en[@]
		else
			print_data options_es[@]
		fi
		handle_input
	done
}

function question_options() {
	printf "\e[?25l"
	select_all

	while [ "$step" == "3" ]; do
		clear_screen
		title
		if [ "$operation" == "inst" ]; then
			length=6
			print_data selector_inst[@]
		elif [ "$operation" == "conf" ]; then
			length=8
			print_data selector_conf[@]
		else
			length=6
			print_data selector_both[@]
		fi
		handle_input
	done
}

function execute() {
	if [ "$operation" == "inst" ]; then
		if [ "${selector_selection[0]}" == "true" ]; then
			bash ./separate-files/desktop.sh
		fi

		if [ "${selector_selection[1]}" == "true" ]; then
			bash ./separate-files/rofi.sh
		fi

		if [ "${selector_selection[2]}" == "true" ]; then
			bash ./separate-files/alacritty.sh
		fi

		if [ "${selector_selection[3]}" == "true" ]; then
			bash ./separate-files/zsh.sh
		fi

		if [ "${selector_selection[4]}" == "true" ]; then
			bash ./separate-files/fonts.sh
		fi
	elif [ "$operation" == "conf" ]; then
		bash ./separate-files/configurations.sh "${selector_selection[@]}"
	else
		if [ "${selector_selection[0]}" == "true" ]; then
			bash ./separate-files/desktop.sh
			new_conf_array[0]=true
			new_conf_array[1]=true
			new_conf_array[2]=true
			new_conf_array[3]=true
		fi

		if [ "${selector_selection[1]}" == "true" ]; then
			bash ./separate-files/rofi.sh
			new_conf_array[4]=true
		fi

		if [ "${selector_selection[2]}" == "true" ]; then
			bash ./separate-files/alacritty.sh
			new_conf_array[5]=true
		fi

		if [ "${selector_selection[3]}" == "true" ]; then
			bash ./separate-files/zsh.sh
			new_conf_array[6]=true
		fi

		if [ "${selector_selection[4]}" == "true" ]; then
			bash ./separate-files/fonts.sh
		fi
		bash ./separate-files/configurations.sh "${new_conf_array[@]}"
	fi
}


function main() {
	sudo apt upgrade

	question_lang
	question_operation
	question_options

	execute
}

trap ctrl_c EXIT

main