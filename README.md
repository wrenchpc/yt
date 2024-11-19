# yt.sh
Una simple combinación de scrips que permiten descargar y escuchar música de Youtube además de descargar videos
Lo que vayas a descargar se va a guardar en la carpeta del usuario en una carpeta llamada YT

El archivo yt.sh es para las distribuciones basadas en arch

El yt-deb.sh es para distribuciones basadas en debian.

Estas son las dependencias:

snap, yt-dlp, mpv, python

El resto es super facil de usar. De nada!

(Se necesita de snap para instalar la dependencia de yt-dlp debido a que la original de debian "apt" está muy desactualizada y produce fallos en el script)
(si ya tenías previamente instalado yt-dlp con apt por favor remuevalo con 'sudo apt purge yt-dlp' e instalelo con apt o simplemente ejecute directamente el script de yt.sh o yt-deb.sh)

**yt-en is an english version of the script ;)**

sudo rm /etc/apt/preferences.d/nosnap.pref
sudo apt update
sudo apt install snapd
sudo snap install yt-dlp

Only if you haven't enabled the snap packages.


