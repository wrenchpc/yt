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

	#archbtw
        sudo pacman -S mpv --noconfirm
        sudo pacman -S yt-dlp --noconfirm
        sudo pacman -S python --noconfirm
        sudo pacman -S python-pip --noconfirm  

	#debian
	sudo apt update
        sudo apt install snap --yes
        sudo snap install mpv
        sudo snap install yt-dlp

	#termux
	pkg install mpv python python-pip
 	pip install -U yt-dlp
	
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

echo "1) Buscar una URL"
echo "2) Música"
echo "3) Video"
echo "4) Actualizar YT.SH"
echo "5) SALIR"

read -p "Ingrese el número (1-5): " option

case $option in
    
    1)
        clear
	sh Scripts/search.sh
        ;;
    2)
        clear
	sh Scripts/music.sh
        ;;
    3)
        clear
	sh Scripts/video.sh
        ;;
    4)
	sh actualizar.sh
	;;
    5)
	exit
	;;
    *)
        ./yt.sh
	;;
esac

