# Esto ejecutalo en la versión de Linux mint, Dará la opción de instalar snaps para tener la versión
# Más actualizada de yt-dlp y sin problemas en su versión de debian.

sudo rm /etc/apt/preferences.d/nosnap.pref
sudo apt update
sudo apt install snapd
sudo snap install yt-dlp
echo "LINUX MINT COMPLETED"
sh yt/yt.sh
