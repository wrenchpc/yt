clear
echo "¿Qué desea compartir?"

echo "1) Carpeta de Música"
echo "2) Carpeta de Playlists"
echo "3) Carpeta de Videos"

read -p "Ingrese el número del (1-3): " option

# Generar un puerto dinámico entre 8000 y 9000
PORT=$(shuf -i 8000-9000 -n 1)

case $option in
    1)
        clear
        python -m http.server --directory $HOME/YT/Music $PORT &
        SERVER_PID=$! &
        trap "echo 'Cerrando el servidor...'; kill $SERVER_PID" SIGINT &
        wait &
        ;;
    2)
        clear
        python -m http.server --directory $HOME/YT/Playlist $PORT &
        SERVER_PID=$! &
        trap "echo 'Cerrando el servidor...'; kill $SERVER_PID" SIGINT &
        wait &
        ;;
    3)
        clear
        python -m http.server --directory $HOME/YT/Videos $PORT &
        SERVER_PID=$! &
        trap "echo 'Cerrando el servidor...'; kill $SERVER_PID" SIGINT &
        wait &
        ;;
    *)
        ./yt.sh
        ;;
esac

ssh -R 80:localhost:$PORT nokey@localhost.run

