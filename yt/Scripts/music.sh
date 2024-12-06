#!/bin/bash

clear

echo "¿Que te gustaría hacer?:"
echo "1) Escuchar música"
echo "2) Escuchar música descargada"
echo "3) Escuchas playlist descargada"
echo "4) Descargar música"
echo "5) Escuchar una playlist"
echo "6) Descargar una playlist"

read -p "Elige una opción (1 o 6): " choice

case $choice in
    1)
        sh Scripts/ytplay.sh
        ;;

    2)
        sh Scripts/musicplaylocal.sh
        ;;

    3)
        sh Scripts/musicplaylistlocal.sh
        ;;
    4)
        sh Scripts/yt-mp3-download.sh
        ;;
    5)
        sh Scripts/playlistplay.sh
        ;;
    6)
        sh Scripts/yt-playlist.sh
        ;;
    *)
        echo "Opción inválida. Saliendo..."
        exit 1
        ;;
esac
clear
