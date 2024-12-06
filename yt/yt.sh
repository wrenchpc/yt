#!/bin/bash
# Script creado por wr3nch

clear


function banner() {
    clear
    cat << "EOF"
       .---.
      /     \
      \.@-@./
      /`\_/`\
     //  _  \\
    | \     )|_
   /`\_`>  <_/ \
   \__/'---'\__/

¡¡¡BIENVENIDO AL YT.SH!!!

Presiona "ENTER" para continuar...
EOF
    read -p ""
echo ""   
}

banner

confirm_install() {
    echo "************************************"
    echo "*  Componentes necesarios no       *"
    echo "*  instalados. Desea instalarlos?  *"
    echo "************************************"
    read -p "Escriba 'si' para instalar: " confirm
    if [[ "$confirm" == "si" ]]; then
        
        sudo pacman -S mpv --noconfirm
        sudo pacman -S yt-dlp --noconfirm
        sudo pacman -S python --noconfirm
        sudo pacman -S python-pip --noconfirm  

    else
        echo "La instalación fue cancelada."
        exit 1
    fi
}

if ! command -v yt-dlp &> /dev/null || ! command -v mpv &> /dev/null; then
    confirm_install
fi

clear

echo "Seleccione la opción:"
echo "1) Música"
echo "2) Video"
echo "3) Actualizar YT.SH"
echo "4) SALIR"

read -p "Ingrese el número (1-4): " option

case $option in
    1)
        echo "Ejecutando Script 1..."
        sh Scripts/music.sh
        ;;
    2)
        echo "Ejecutando Script 2..."
        sh Scripts/video.sh
        ;;
    3)
	sh actualizar.sh
	;;
    4)
	exit
	;;
    *)
        sh yt.sh
	;;
esac

