#!/bin/bash
# Script creado por wr3nch

clear

echo -e "\n\033[1;31m"
echo "************************************"
echo "* DESCARGUE LA PLAYLIST QUE QUIERA:*"
echo "************************************"

desktop_path="$HOME/YTPlaylist"

# Crear la carpeta "YT" en el escritorio si no existe
yt_folder="$desktop_path/YT"
if [ ! -d "$yt_folder" ]; then
    echo "Creando la carpeta 'YTPlaylist' en el usuario..."
    mkdir -p "$yt_folder"
else
    echo ""
fi

# Solicitar la búsqueda del video o playlist
read -p "Introduce el enlace de la Playlist: " search_query

# Descargar el mejor audio en formato mp3 y renombrar con el índice de la playlist
echo "Descargando audio en formato MP3..."
yt-dlp -x --audio-format mp3 -o "$yt_folder/%(playlist_index)s-%(title)s.%(ext)s" "$search_query"

echo "¡Descarga completada!"

clear
./yt.sh
