#!/bin/bash
# Hecho por wr3nch

clear

desktop_path="$HOME/YTVideos"

yt_folder="$desktop_path/YT"
if [ ! -d "$yt_folder" ]; then
    echo "Making folder 'YTVideos' on user's folder..."
    mkdir -p "$yt_folder"
else
    echo ""
fi

read -p "Introduce the URL of the Youtube video: " video_url

echo "Obtaining video quality..."
yt-dlp -F "$video_url"

read -p "Introduce the video format (ID) you want to download: " video_format_id

echo "Downloading video in quality $video_format_id ..."
yt-dlp -f "${video_format_id}+bestaudio" -o "$yt_folder/%(title)s.%(ext)s" "$video_url"

echo "DOWNLOAD COMPLETED!"

clear
./yt.sh
