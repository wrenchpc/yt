#!/bin/bash
# Script creado por wr3nch

clear

desktop_path="$HOME/YT"

yt_folder="$desktop_path/Playlist"
if [ ! -d "$yt_folder" ]; then
    echo "Creando la carpeta 'YT/Playlist' en el usuario..."
    mkdir -p "$yt_folder"
else
    echo ""
fi

read -p "Introduce el enlace de la Playlist: " search_query

echo "Descargando audio en formato MP3..."
yt-dlp -x --audio-format mp3 -o "$yt_folder/%(playlist_index)s-%(title)s.%(ext)s" "$search_query"

echo "¡Descarga completada!"

clear
sh yt.sh
