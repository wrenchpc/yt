#!/bin/bash
# made by wr3nch

clear

desktop_path="$HOME/YT"

yt_folder="$desktop_path/Videos/CUTS"
if [ ! -d "$yt_folder" ]; then
    echo "Making folder 'YT/Videos/CUTS' on the user's folder..."
    mkdir -p "$yt_folder"
else
    echo ""
fi


read -p "Introduce the URL of the video: " video_url
read -p "Insert initial minute (time mm:ss): " start_time
read -p "Insert final minute (formato mm:ss): " end_time

yt-dlp -F "$video_url"

read -p "Introduce the video format (ID) you want to download: " video_format_id

yt-dlp -f "${video_format_id}+bestaudio" -o "$yt_folder/%(title)s.%(ext)s" \
    --postprocessor-args "ffmpeg:-ss $start_time -to $end_time" "$video_url"

echo "DONE! Watch: $yt_folder"
sh yt.sh
