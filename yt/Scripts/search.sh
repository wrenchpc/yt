#!/bin/bash
# Hecho por wr3nch
cat << "EOF"
__   _______ ____  _   _
\ \ / /_   _/ ___|| | | |
 \ V /  | | \___ \| |_| |
  | |   | |_ ___) |  _  |
  |_|   |_(_)____/|_| |_|


EOF

read -p "     Búsqueda: " search_term

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

video_url="https://www.youtube.com/watch?v=$video_id"
echo "Enlace del video seleccionado: $video_url"
echo "Presiona "ENTER" para finalizar."
read
