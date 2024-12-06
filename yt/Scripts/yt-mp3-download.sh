#!/bin/bash
# Script creado por wr3nch

clear
desktop_path="$HOME/YT"

yt_folder="$desktop_path/Music"
if [ ! -d "$yt_folder" ]; then
    echo "Creando la carpeta 'YT/Music' en el usuario..."
    mkdir -p "$yt_folder"
else
    echo ""
fi
if ! command -v yt-dlp &> /dev/null; then
    echo "Error: yt-dlp no está instalado. Instálalo e intenta de nuevo."
    exit 1
fi

read -p "Introduce el término de búsqueda (canción, artista, etc.): " search_term

echo "Buscando en YouTube..."
yt-dlp "ytsearch10:$search_term" --get-title --get-id > results.txt

echo "Resultados encontrados:"
awk 'NR % 2 == 1 { printf "%d. %s\n", (NR + 1) / 2, $0 }' results.txt

read -p "Selecciona un número (1-10): " choice

if ! [[ "$choice" =~ ^[1-9]$|^10$ ]]; then
    echo "Opción inválida. Saliendo..."
    rm results.txt
    exit 1
fi

audio_id=$(awk "NR == $((choice * 2)) { print }" results.txt)

rm results.txt

audio_url="https://www.youtube.com/watch?v=$audio_id"


echo "Buscando y descargando el mejor audio en formato MP3..."
yt-dlp -x --audio-format mp3 "$audio_url" --no-playlist -f bestaudio -o "$yt_folder/%(title)s.%(ext)s"
clear
sh yt.sh
