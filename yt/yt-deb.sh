#!/bin/bash
# Script creado por wr3nch

clear
confirm_install() {
    echo "************************************"
    echo "*  Componentes necesarios no       *"
    echo "*  instalados. Desea instalarlos?  *"
    echo "************************************"
    read -p "Escriba 'si' para instalar: " confirm
    if [[ "$confirm" == "si" ]]; then
        
	sudo apt update
        sudo apt install snap --yes
        sudo snap install mpv
        sudo snap install yt-dlp

    else
        echo "La instalación fue cancelada."
        exit 1
    fi
}

if ! command -v yt-dlp &> /dev/null || ! command -v mpv &> /dev/null; then
    confirm_install
fi

clear
sh yt.sh
