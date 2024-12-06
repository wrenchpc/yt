#!/bin/bash

clear

echo "¿Que te gustaría hacer?:"
echo "1. Escuchar música"
echo "2. Descargar música"
echo "3. Escuchar una playlist"
echo "4. Descargar una playlist"

read -p "Elige una opción (1 o 4): " choice

case $choice in
    1)
        echo "Ejecutando Script 1..."
        sh Scripts/ytplay.sh
        ;;
    2)
        echo "Ejecutando Script 2..."
        sh Scripts/yt-mp3-download.sh
        ;;
    3)
        echo "Ejecutando Script 3..."
        sh Scripts/playlistplay.sh
        ;;
    4)
        echo "Ejecutando Script 4..."
        sh Scripts/yt-playlist.sh
        ;;
    *)
        echo "Opción inválida. Saliendo..."
        exit 1
        ;;
esac
clear
