#!/bin/bash
# Script creado por wr3nch

clear

# Variable para ejecutar las opciones
execute_matrix() {
    bash Scripts/m.sh
    exit
}

execute_tetris() {
    bash Scripts/t.sh
    exit
}

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
    read -n 1 key
    if [[ "$key" == "M" || "$key" == "m" ]]; then
        execute_matrix
    elif [[ "$key" == "T" || "$key" == "t" ]]; then
        execute_tetris
    fi  
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
	sudo pacman -S openssh --noconfirm
 	sudo pacman -S jq --noconfirm

	#debian
	sudo apt update
 	sudo apt install python3 --yes
        sudo apt install snap --yes
        sudo snap install mpv
        sudo snap install yt-dlp
	sudo apt install openssh-server --yes
	sudo apt install jq --yes
 
	#termux
	pkg install mpv python python-pip openssh jq --yes
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
echo "2) Suscripciones"
echo "3) Música"
echo "4) Video"
echo "5) Compartir"
echo "6) Actualizar YT.SH"
echo "7) SALIR"

read -p "Ingrese el número (1-7): " option

case $option in
    
    1)
        clear
        sh Scripts/search.sh
        ;;

    2)
        clear
        bash Scripts/suscr.sh
        ;;
    3)
        clear
        sh Scripts/music.sh
        ;;
    4)
        clear
        sh Scripts/video.sh
        ;;
    5)
        sh Scripts/ssh.sh
        ;;
    6)
        sh actualizar.sh
        ;;
    7)
        exit
        ;;
    *)
        ./yt.sh
        ;;
esac

