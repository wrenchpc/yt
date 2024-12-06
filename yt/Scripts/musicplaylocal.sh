#!/bin/bash
# Script hecho por wr3nch

clear
MUSIC_DIR="$HOME/YT/Music"

if [[ ! -d "$MUSIC_DIR" ]]; then
    echo "Error: La carpeta $MUSIC_DIR no existe."
    exit 1
fi

echo "¿Qué deseas hacer?"
echo "1) Elegir una canción específica de la carpeta."
echo "2) Reproducir toda la carpeta en bucle."
read -p "Selecciona una opción (1 o 2): " choice

if [[ "$choice" == "1" ]]; then
    echo "Canciones disponibles:"
    
    files=("$MUSIC_DIR"/*)
    for i in "${!files[@]}"; do
        echo "$((i + 1)). $(basename "${files[i]}")"
    done

    read -p "Selecciona el número de la canción que deseas reproducir: " song_number

    if [[ "$song_number" -ge 1 && "$song_number" -le "${#files[@]}" ]]; then
        selected_file="${files[song_number - 1]}"
        echo "Reproduciendo $(basename "$selected_file")..."
        mpv "$selected_file"
    else
        echo "Número inválido. Saliendo..."
        exit 1
    fi

elif [[ "$choice" == "2" ]]; then
    echo "Reproduciendo toda la carpeta en bucle..."
    mpv --loop-playlist=inf "$MUSIC_DIR"/*

else
    echo "Opción no válida. Saliendo..."
    exit 1
fi
clear
sh yt.sh
