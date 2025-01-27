#!/bin/bash
# Script creado por wr3nch

clear

desktop_path="$HOME/YT"

yt_folder="$desktop_path/YoutubePlaylist"
if [ ! -d "$yt_folder" ]; then
    echo "Creando la carpeta 'YT/YoutubePlaylists' en el usuario..."
    mkdir -p "$yt_folder"
else
    echo ""
fi

echo "¿Cómo deseas descargar la playlist?"
echo "1) En Playlist (Playlists nombradas por nombres)"
read -p "Selecciona una opción (1-2): " option

read -p "Introduce el enlace de la Playlist: " search_query

case $option in
    1)
        echo "Obteniendo el nombre de la playlist..."
        playlist_name=$(yt-dlp --get-filename -o "%(playlist_title)s" "$search_query" 2>/dev/null | sed -n '1p')

        playlist_folder="$yt_folder/$playlist_name"
        mkdir -p "$playlist_folder"

        echo "Descargando la playlist '$playlist_name' en la carpeta correspondiente..."
        yt-dlp -f bestvideo+bestaudio --merge-output-format mp4 -o "$playlist_folder/%(playlist_index)s-%(title)s.%(ext)s" "$search_query"
        ;;
    *)
        echo "Opción no válida. Saliendo del script."
        exit 1
        ;;
esac

echo "¡Descarga completada!"
# Fin del script

