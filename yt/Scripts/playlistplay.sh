#!/bin/bash

# Script hecho por wr3nch
clear
echo "¿Qué te gustaría hacer?"
echo "1. Buscar en YouTube"
echo "2. Ingresar una URL directamente"
read -p "Elige una opción (1 o 2): " choice

case $choice in
    1)
	clear
        read -p "Introduce el término de búsqueda: " search_term
        PLAYLIST_URL=$(yt-dlp "ytsearch:$search_term" -f bestaudio --get-url --limit 1)
        if [ -z "$PLAYLIST_URL" ]; then
            echo "No se encontraron resultados para '$search_term'."
            exit 1
        fi
        echo "Reproduciendo la playlist encontrada: $PLAYLIST_URL"
        ;;
    2)
	clear
        read -p "Introduce la URL de la playlist de YouTube: " PLAYLIST_URL
        ;;
    *)
        echo "Opción inválida. Saliendo."
        exit 1
        ;;
esac

yt-dlp -f bestaudio --get-url "$PLAYLIST_URL" | xargs -I {} mpv --no-video {}

clear
sh yt.sh
