clear
echo "¿Que desea compartir?"

echo "1) Carpeta de Música"
echo "2) Carpeta de Playlists"
echo "3) Carpeta de Videos"

read -p "ingrese el número del (1-3): " option

case $option in

   1)
	clear
	python -m http.server --directory $HOME/YT/Music 8080 &
	SERVER_PID=$! &
	trap "echo 'Cerrando el servidor...'; kill $SERVER_PID" SIGINT &
	wait &
	;;
   2)
	clear
	python -m http.server --directory $HOME/YT/Playlist 8080 &
	SERVER_PID=$! &
	trap "echo 'Cerrando el servidor...'; kill $SERVER_PID" SIGINT &
	wait &
	;;
   3)
	clear
	python -m http.server --directory $HOME/YT/Music 8080 &
	SERVER_PID=$! &
	trap "echo 'Cerrando el servidor...'; kill $SERVER_PID" SIGINT &
	wait &
	;;
   *)
	./yt.sh
	;;
esac

ssh -R 80:localhost:8080 nokey@localhost.run
