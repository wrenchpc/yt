#!/bin/bash

clear

desktop_path="$HOME/YT"
yt_folder="$desktop_path/Videos/Cortados"
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
    
    if [ -z "$video_id" ]; then
        echo "Selección inválida. Saliendo."
        exit 1
    fi

    video_url="https://www.youtube.com/watch?v=$video_id"
fi

read -p "Ingresa el minuto inicial (formato mm:ss): " start_time
read -p "Ingresa el minuto final (formato mm:ss): " end_time

echo "Obteniendo las calidades disponibles para el video..."
yt-dlp -F "$video_url"

read -p "Introduce el formato de video (ID) que deseas descargar: " video_format_id

echo "Descargando y recortando el video..."
yt-dlp -f "${video_format_id}+bestaudio" -o "$yt_folder/%(title)s.%(ext)s" \
    --merge-output-format mp4 \
    --remux-video mp4 \
    --postprocessor-args "ffmpeg:-ss $start_time -to $end_time" "$video_url"

echo "Descarga y recorte completados. Revisa la carpeta: $yt_folder"

sh yt.sh

