#!/bin/bash
# Script creado por wr3nch

clear

echo -e "\n\033[1;31m"
echo "************************************"
echo "*  DESCARGUE LA MÚSICA QUE QUIERA: *"
echo "************************************"

desktop_path="$HOME/YT"

# Crear la carpeta "YT" en el escritorio si no existe
yt_folder="$desktop_path/Music"
if [ ! -d "$yt_folder" ]; then
    echo "Creando la carpeta 'YT/Music' en el usuario..."
    mkdir -p "$yt_folder"
else
    echo ""
fi
read -p "Ingrese su búsqueda: " search_query

search_query=$(echo "$search_query" | sed 's/ /+/g')

# Ejecutar la búsqueda y reproducción (Necesarios yt-dpl y mpv)
echo "Buscando y descargando el mejor audio en formato MP3..."
yt-dlp -x --audio-format mp3 "ytsearch:$search_query" --no-playlist -f bestaudio -o "$yt_folder/%(title)s.%(ext)s"
clear
sh yt.sh
