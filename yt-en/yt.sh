#!/bin/bash
# Script creado por wr3nch

clear


function banner() {
    clear
    cat << "EOF"
       .---.
      /     \
      \.@-@./
      /`\_/`\
     //  _  \\
    | \     )|_
   /`\_`>  <_/ \
   \__/'---'\__/

¡¡¡WELCOME TO YT.SH!!!

Press "ENTER" to continue...
EOF
    read -p ""
echo ""   
}

banner

confirm_install() {
    echo "************************************"
    echo "*  Non installed dependences       *"
    echo "*  Do you want to install them?    *"
    echo "************************************"
    read -p "Write 'yes' to install: " confirm
    if [[ "$confirm" == "yes" ]]; then
        
        sudo pacman -S mpv --noconfirm
        sudo pacman -S yt-dlp --noconfirm
        sudo pacman -S python --noconfirm
        sudo pacman -S python-pip --noconfirm  

    else
        echo "The instalation was canceled."
        exit 1
    fi
}

if ! command -v yt-dlp &> /dev/null || ! command -v mpv &> /dev/null; then
    confirm_install
fi

clear

echo "Select an option:"
echo "1) Listen to Music (1)"
echo "2) Download Music (2)"
echo "3) Download a Playlist (3)"
echo "4) Download a Video (4)"

read -p "Set number (1-4): " option

case $option in
    1)
        echo "Executing Script 1..."
        sh Scripts/ytplay.sh
        ;;
    2)
        echo "Executing Script 2..."
        sh Scripts/yt-mp3-download.sh
        ;;
    3)
        echo "Executing Script 3..."
        sh Scripts/yt-playlist.sh
        ;;
    4)
        echo "Executing Script 4..."
        sh Scripts/ytvideod.sh
        ;;
    *)
        echo "Invalid option. Please, set a number from 1 to 4 and press ENTER."
        ;;
esac

