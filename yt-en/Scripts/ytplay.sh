#!/bin/bash
# Script creado por wr3nch

clear

echo -e "\n\033[1;31m"
echo "************************************"
echo "*  SEARCH THE MUSIC YOU WANT  :    *"
echo "************************************"

read -p "Search: " search_query

search_query=$(echo "$search_query" | sed 's/ /+/g')

yt-dlp "ytsearch:$search_query" --no-playlist -f bestaudio -o - | mpv --no-video -

./yt.sh
