#!/bin/bash
# Hecho por wr3nch
clear
if ! command -v yt-dlp &> /dev/null; then
    echo "Error: yt-dlp no está instalado. Instálalo e intenta de nuevo."
    exit 1
fi

if ! command -v mpv &> /dev/null; then
    echo "Error: mpv no está instalado. Instálalo e intenta de nuevo."
    exit 1
fi

read -p "Introduce el término de búsqueda: " search_term

echo "Buscando en YouTube..."
yt-dlp "ytsearch10:$search_term" --get-title --get-id > results.txt

echo "Resultados encontrados:"
awk 'NR % 2 == 1 { printf "%d. %s\n", (NR + 1) / 2, $0 }' results.txt

read -p "Selecciona un número (1-10): " choice

if ! echo "$choice" | grep -Eq '^[1-9]$|^10$'; then
    echo "Opción invalida. Saliendo..."
    rm results.txt
    exit 1
fi

video_id=$(awk "NR == $((choice * 2)) { print }" results.txt)

rm results.txt

echo "Resoluciones disponibles:"
echo "1. Mejor calidad disponible"
echo "2. 1080p"
echo "3. 720p"
echo "4. 480p"
echo "5. 360p"
read -p "Selecciona una resolución (1-5): " resolution_choice

case $resolution_choice in
    1) format="bestvideo+bestaudio/best";;
    2) format="bestvideo[height<=1080]+bestaudio/best";;
    3) format="bestvideo[height<=720]+bestaudio/best";;
    4) format="bestvideo[height<=480]+bestaudio/best";;
    5) format="bestvideo[height<=360]+bestaudio/best";;
    *) 
        echo "Opción de resolución inválida. Usando la mejor calidad por defecto."
        format="bestvideo+bestaudio/best"
        ;;
esac

video_url="https://www.youtube.com/watch?v=$video_id"
echo "Descargando temporalmente para garantizar la sincronización de audio y video..."
yt-dlp -f "$format" -o - "$video_url" | mpv -

clear
sh yt.sh
