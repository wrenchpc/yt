#!/bin/bash
# Script creado por wr3nch
clear
if ! command -v yt-dlp &> /dev/null; then
    echo "Error: yt-dlp no está instalado. Instálalo e intenta de nuevo."
    exit 1
fi

if ! command -v mpv &> /dev/null; then
    echo "Error: mpv no está instalado. Instálalo e intenta de nuevo."
    exit 1
fi

read -p "Introduce el término de búsqueda (canción, artista, etc.): " search_term

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

audio_id=$(awk "NR == $((choice * 2)) { print }" results.txt)

rm results.txt

audio_url="https://www.youtube.com/watch?v=$audio_id"
echo "Reproduciendo solo el audio..."
yt-dlp -f "bestaudio" -o - "$audio_url" | mpv --no-video -

clear
sh yt.sh
