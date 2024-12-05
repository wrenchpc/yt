#!/bin/bash
# Hecho por wr3nch

clear

desktop_path="$HOME/YT"

yt_folder="$desktop_path/Videos/Cortados"
if [ ! -d "$yt_folder" ]; then
    echo "Creando la carpeta 'YT/Videos/Cortados' en el usuario..."
    mkdir -p "$yt_folder"
else
    echo ""
fi


read -p "Ingresa la URL del video: " video_url
read -p "Ingresa el minuto inicial (formato mm:ss): " start_time
read -p "Ingresa el minuto final (formato mm:ss): " end_time

yt-dlp -F "$video_url"

read -p "Introduce el formato de video (ID) que deseas descargar: " video_format_id

yt-dlp -f "${video_format_id}+bestaudio" -o "$yt_folder/%(title)s.%(ext)s" \
    --postprocessor-args "ffmpeg:-ss $start_time -to $end_time" "$video_url"

echo "Descarga y recorte completados. Revisa la carpeta: $yt_folder"
sh yt.sh
