#!/bin/bash

clear

echo "¿Que te gustaría hacer?:"
echo "1. Descargar video"
echo "2. Cortar y descargar video"

read -p "Elige una opción (1 o 2): " choice

case $choice in
    1)
        echo "Ejecutando Script 1..."
        sh Scripts/ytvideod.sh
        ;;
    2)
        echo "Ejecutando Script 2..."
        sh Scripts/cutvid.sh
        ;;
    *)
        echo "Opción inválida. Saliendo..."
        exit 1
        ;;
esac
clear
