#!/bin/sh
# Script hecho por wr3nch

clear
MUSIC_DIR="$HOME/YT/Playlist"

if [ ! -d "$MUSIC_DIR" ]; then
    echo "Error: La carpeta $MUSIC_DIR no existe."
    exit 1
fi

echo "¿Qué deseas hacer?"
echo "1) Elegir una canción específica de la carpeta."
echo "2) Reproducir toda la carpeta en bucle."
read -p "Selecciona una opción (1 o 2): " choice

if [ "$choice" = "1" ]; then
    echo "Canciones disponibles:"
    
    i=1
    for file in "$MUSIC_DIR"/*; do
        echo "$i. $(basename "$file")"
        i=$((i + 1))
    done

    read -p "Selecciona el número de la canción que deseas reproducir: " song_number

    total_files=$(ls -1 "$MUSIC_DIR"/* | wc -l)
    if [ "$song_number" -ge 1 ] && [ "$song_number" -le "$total_files" ]; then
        selected_file=$(ls -1 "$MUSIC_DIR"/* | sed -n "${song_number}p")
        echo "Reproduciendo $(basename "$selected_file")..."
        mpv "$selected_file"
    else
        echo "Número inválido. Saliendo..."
        exit 1
    fi

elif [ "$choice" = "2" ]; then
    echo "Reproduciendo toda la carpeta en bucle..."
    mpv --loop-playlist=inf "$MUSIC_DIR"/*
else
    echo "Opción no válida. Saliendo..."
    exit 1
fi

clear
sh yt.sh
