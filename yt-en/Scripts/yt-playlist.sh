#!/bin/bash
# Script creado por wr3nch

clear

echo -e "\n\033[1;31m"
echo "************************************"
echo "* DOWNLOAD THE PLAYLIST YOU WANT  :*"
echo "************************************"

desktop_path="$HOME/YT"

# Crear la carpeta "YT" en el escritorio si no existe
yt_folder="$desktop_path/Playlist"
if [ ! -d "$yt_folder" ]; then
    echo "Making folder 'YT/Playlist' on user's folder..."
    mkdir -p "$yt_folder"
else
    echo ""
fi

# Solicitar la búsqueda del video o playlist
read -p "Introduce playlist's URL: " search_query

# Descargar el mejor audio en formato mp3 y renombrar con el índice de la playlist
echo "Downloading MP3 format..."
yt-dlp -x --audio-format mp3 -o "$yt_folder/%(playlist_index)s-%(title)s.%(ext)s" "$search_query"

echo "DOWNLOAD COMPLETED!"

clear
sh yt.sh
