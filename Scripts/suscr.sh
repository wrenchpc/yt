#!/bin/bash
# Creado por wr3nch

SCRIPT_DIR=$(dirname "$(realpath "$0")")
SUBSCRIPTIONS_DIR="$HOME/YT/Suscripciones"

# Crear la carpeta Suscripciones si no existe
mkdir -p "$SUBSCRIPTIONS_DIR"

# Definir el archivo de suscripciones en la nueva ubicación
SUBSCRIPTIONS_FILE="$SUBSCRIPTIONS_DIR/suscripciones.txt"

if [ ! -f "$SUBSCRIPTIONS_FILE" ]; then
    touch "$SUBSCRIPTIONS_FILE"
fi

mostrar_suscripciones() {
    if [ -s "$SUBSCRIPTIONS_FILE" ]; then
        clear
        echo "Selecciona un canal para ver sus videos:"
        select canal in $(cat "$SUBSCRIPTIONS_FILE" | sort -t ':' -k2 | cut -d: -f2 | tr '\n' ' '); do
            if [ -n "$canal" ]; then
                canal_id=$(grep ":$canal" "$SUBSCRIPTIONS_FILE" | cut -d: -f1)
                mostrar_videos "$canal_id" "$canal"
                break
            else
                echo "Selección no válida"
                sleep 2
            fi
        done
    else
        echo "No tienes suscripciones guardadas."
        sleep 2
    fi
}

mostrar_videos() {
    canal_id=$1
    canal_nombre=$2
    echo "Obteniendo videos del canal $canal_nombre (ID: $canal_id)..."
    
    # Obtener la lista de videos correctamente
    videos=$(yt-dlp --flat-playlist -j "https://www.youtube.com/channel/$canal_id/videos" 2>/dev/null)

    if [ -z "$videos" ]; then
        echo "No se pudieron obtener los videos del canal."
        return
    fi

    echo "Últimos 10 videos del canal $canal_nombre:"
    i=1
    video_ids=()
    video_titles=()

    # Procesar y mostrar los primeros 10 videos correctamente
    while IFS= read -r video; do
        video_id=$(echo $video | jq -r '.id')
        titulo=$(echo $video | jq -r '.title')
        echo "$i. $titulo"
        video_ids+=("$video_id")
        video_titles+=("$titulo")
        let i++
        
        if [ $i -gt 10 ]; then
            break
        fi
    done <<< "$videos"

    read -p "Selecciona el número del video que quieres ver: " numero_video
    video_id=${video_ids[$((numero_video - 1))]}
    video_title=${video_titles[$((numero_video - 1))]}

    echo "Has seleccionado: $video_title"
    echo "¿Qué deseas hacer?"
    echo "1. Solo audio"
    echo "2. Reproducir video"
    read -p "Selecciona una opción: " opcion_audio_video

    case $opcion_audio_video in
        1)
            echo "Reproduciendo solo audio..."
            yt-dlp -f bestaudio -o - "https://www.youtube.com/watch?v=$video_id" | mpv --no-video -
            ;;
        2)
            echo "Obteniendo las resoluciones disponibles..."
            resoluciones=$(yt-dlp -F "https://www.youtube.com/watch?v=$video_id")

            if [ -z "$resoluciones" ]; then
                echo "No se encontraron resoluciones disponibles."
                return
            fi
            
            echo "Resoluciones disponibles:"
            i=1
            resolucion_ids=()
            resolucion_options=()

            while IFS= read -r linea; do
                formato=$(echo "$linea" | awk '{print $1}')
                resolucion=$(echo "$linea" | grep -oP '\d+p(\sHDR|\s60fps|)' | head -n 1)
                
                if [[ -n "$resolucion" ]]; then
                    case $resolucion in
                        2160p*) resolucion="4K (2160p)" ;;
                        1440p*) resolucion="1440p" ;;
                        1080p*) resolucion="1080p" ;;
                        720p*)  resolucion="720p" ;;
                        480p*)  resolucion="480p" ;;
                        360p*)  resolucion="360p" ;;
                        144p*)  resolucion="144p" ;;
                        *) continue ;;
                    esac

                    echo "$i. $resolucion"
                    resolucion_ids+=("$formato")
                    resolucion_options+=("$resolucion")
                    let i++
                fi
            done <<< "$resoluciones"

            if [ $i -eq 1 ]; then
                echo "No se encontraron resoluciones válidas."
                return
            fi

            read -p "Selecciona la resolución (1-$((i - 1))): " resolucion_numero
            resolucion_id=${resolucion_ids[$((resolucion_numero - 1))]}
            resolucion_option=${resolucion_options[$((resolucion_numero - 1))]}

            echo "Reproduciendo video en resolución $resolucion_option con audio..."
            yt-dlp -f "$resolucion_id+bestaudio" -o - "https://www.youtube.com/watch?v=$video_id" | mpv -
            ;;
        *)
            echo "Opción no válida"
            ;;
    esac
}

suscribirse_a_canal() {
    read -p "Ingresa la URL del canal de YouTube: " canal_url
    
    canal_id=$(yt-dlp --print channel_url --playlist-items 1 "$canal_url" 2>/dev/null | sed 's#https://www.youtube.com/channel/##')
    
    if [ -z "$canal_id" ]; then
        echo "No se pudo obtener la ID del canal."
        return
        sleep 2
    fi
    
    read -p "Ingresa el nombre que quieres asignar a este canal (No uses espacios): " canal_nombre

    echo "$canal_id:$canal_nombre" >> "$SUBSCRIPTIONS_FILE"
    sort -o "$SUBSCRIPTIONS_FILE" "$SUBSCRIPTIONS_FILE"
    echo "Te has suscrito a: $canal_nombre"
    echo "Regresando..."
    sleep 2
}

# Menú principal
clear
echo "Bienvenido al gestor de suscripciones de YouTube"
echo "1) Suscripciones"
echo "2) Suscribirse a un canal"
echo "3) Eliminar suscripciones"
read -p "Selecciona una opción: " opcion

case $opcion in
    1)
        mostrar_suscripciones
        ;;
    2)
        suscribirse_a_canal
        ;;
    3)
        read -p "¿Estás seguro de que quieres eliminar las suscripciones? (s/n): " respuesta
        if [[ "$respuesta" == "s" || "$respuesta" == "S" ]]; then
            if [[ -f "$SUBSCRIPTIONS_FILE" ]]; then
                rm "$SUBSCRIPTIONS_FILE"
                echo "Archivo eliminado."
            else
                echo "El archivo de suscripciones no existe."
            fi
        else
            echo "Operación cancelada."
        fi
        echo "Volviendo.."
        sleep 2
        ;;
    *)
        echo "Opción no válida"
        ;;
esac
./yt.sh

