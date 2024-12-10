#!/bin/bash
# Script hecho por wr3nch

clear
MUSIC_DIR="$HOME/YT/Playlist"

if [ ! -d "$MUSIC_DIR" ]; then
    echo "Error: La carpeta $MUSIC_DIR no existe."
    exit 1
fi

echo "¿Qué deseas hacer?"
echo "1) Elegir una carpeta específica dentro de 'Playlist'."
echo "2) Reproducir la música ya existente dentro de 'Playlist'."
read -p "Selecciona una opción (1 o 2): " main_choice

if [ "$main_choice" = "1" ]; then
    echo "Carpetas disponibles dentro de 'Playlist':"
    
    # Mostrar carpetas disponibles
    i=1
    for folder in "$MUSIC_DIR"/*/; do
        echo "$i. $(basename "$folder")"
        i=$((i + 1))
    done

    read -p "Selecciona el número de la carpeta que deseas reproducir: " folder_number

    total_folders=$(find "$MUSIC_DIR" -mindepth 1 -maxdepth 1 -type d | wc -l)
    if [ "$folder_number" -ge 1 ] && [ "$folder_number" -le "$total_folders" ]; then
        selected_folder=$(find "$MUSIC_DIR" -mindepth 1 -maxdepth 1 -type d | sed -n "${folder_number}p")
        echo "Has seleccionado la carpeta: $(basename "$selected_folder")"
        MUSIC_DIR="$selected_folder"
    else
        echo "Número inválido. Saliendo..."
        exit 1
    fi
fi

# Mostrar canciones disponibles
echo "Canciones disponibles en la carpeta $(basename "$MUSIC_DIR"):"

i=1
for file in "$MUSIC_DIR"/*; do
    echo "$i. $(basename "$file")"
    i=$((i + 1))
done

echo "¿Qué deseas hacer?"
echo "1) Reproducir una canción específica."
echo "2) Reproducir toda la carpeta en bucle."
read -p "Selecciona una opción (1 o 2): " choice

if [ "$choice" = "1" ]; then
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
