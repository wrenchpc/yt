#!/bin/bash

clear

echo "¿Que te gustaría hacer?:"
echo "1) Escuchar música"
echo "2) Descargar Música"
echo "3) Escuchar Playlist"
echo "4) Descargar Playlist"
echo "5) Volver"

read -p "Elige una opción (1 o 4): " choice

case $choice in
    1)
        sh Scripts/ytplay.sh
        ;;
    2)
        sh Scripts/yt-mp3-download.sh
        ;;
    3)
        sh Scripts/playlistplay.sh
        ;;
    4)
        sh Scripts/yt-playlist.sh
        ;;
    5)
	sh yt.sh
	;;
    *)
        echo "Opción inválida. Saliendo..."
        exit 1
        ;;
esac
clear
