#!/bin/bash
# Hecho por wr3nch

clear

desktop_path="$HOME/YT"

yt_folder="$desktop_path/Videos"
if [ ! -d "$yt_folder" ]; then
    echo "Creando la carpeta 'YT/Videos' en el usuario..."
    mkdir -p "$yt_folder"
else
    echo ""
fi

read -p "Introduce la URL del video de YouTube: " video_url

echo "Obteniendo las calidades disponibles para el video..."
yt-dlp -F "$video_url"

read -p "Introduce el formato de video (ID) que deseas descargar: " video_format_id

echo "Descargando el video en calidad $video_format_id con audio en la carpeta YT..."
yt-dlp -f "${video_format_id}+bestaudio" -o "$yt_folder/%(title)s.%(ext)s" "$video_url"

echo "¡Descarga completada!"

clear
./yt.sh
