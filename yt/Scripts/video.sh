#!/bin/bash

clear

echo "¿Que te gustaría hacer?:"
echo "1) Mirar video"
echo "2) Descargar video"
echo "3) Cortar y descargar video"
echo "4) Volver"

read -p "Elige una opción (1 o 2): " choice

case $choice in

    1)
        sh Scripts/videoplay.sh
        ;;
    2)
        sh Scripts/ytvideod.sh
        ;;
    3)
        sh Scripts/cutvid.sh
        ;;
    4)
	sh yt.sh
	;;
    *)
        echo "Opción inválida. Saliendo..."
        exit 1
        ;;
esac
clear
