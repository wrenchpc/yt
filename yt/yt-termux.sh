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
        
	pkg update
        pkg install mpv -y
        pkg install python -y
        pkg install python-pip -y
	pip install yt-dlp -y

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
