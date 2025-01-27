#!/bin/bash

clear

echo "¿Que te gustaría hacer?:"
echo "1) Mirar video"
echo "2) Descargar video"
echo "3) Cortar y descargar video"
echo "4) Descargar Video Playlist"

read -p "Elige una opción (1 o 3): " choice

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
        sh Scripts/yt-video-playlist.sh
        ;;
    *)
        echo "Opción inválida. Saliendo..."
        exit 1
        ;;
esac
clear
