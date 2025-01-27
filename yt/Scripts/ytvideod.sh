#!/bin/bash

clear

desktop_path="$HOME/YT"
yt_folder="$desktop_path/Videos"
if [ ! -d "$yt_folder" ]; then
    mkdir -p "$yt_folder"
else
    echo ""
fi

read -p "Introduce una búsqueda o la URL del video de YouTube: " input

if [[ "$input" =~ ^https?:// ]]; then
    video_url="$input"
else
    echo "Buscando videos relacionados..."
    results=$(yt-dlp "ytsearch10:$input" --print "%(id)s %(title)s")
    echo "$results" | awk '{print NR, $0}' | head -n 10
    read -p "Selecciona el número del video que deseas descargar: " selection
    video_id=$(echo "$results" | awk "NR==$selection {print \$1}")
    video_url="https://www.youtube.com/watch?v=$video_id"
fi

echo "Obteniendo las calidades disponibles para el video..."
yt-dlp -F "$video_url"

read -p "Introduce el formato de video (ID) que deseas descargar: " video_format_id

echo "Descargando el video en calidad $video_format_id con audio en la carpeta YT..."
yt-dlp -f "${video_format_id}+bestaudio" --merge-output-format mp4 -o "$yt_folder/%(title)s.%(ext)s" "$video_url"

echo "¡Descarga completada!"

clear
sh yt.sh

