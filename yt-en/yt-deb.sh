#!/bin/bash
# Script created by wr3nch

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
    echo "*  Dependences are not installed   *"
    echo "*  Do you want to install them?    *"
    echo "************************************"
    read -p "Write 'yes' to install: " confirm
    if [[ "$confirm" == "yes" ]]; then

	sudo apt install snap -y        
        sudo apt install mpv -y
        sudo snap install yt-dlp -y
	sudo apt install python -y
        sudo apt install python-pip -y

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
echo "3) Download Playlist (3)"
echo "4) Download Video (4)"
echo "5) Update YT.SH (5)"
echo "6) EXIT (6)"

read -p "Set a number (1-6): " option

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
    5)
	sh update.sh
	;;
    6) 
	exit
	;;
    *)
        ./yt-deb.sh
	;;
esac

