#!/bin/bash

echo "ACTUALIZANDO..."

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

REPO_URL="https://github.com/wrenchpc/yt.git"

TEMP_DIR=$(mktemp -d)

git clone "$REPO_URL" "$TEMP_DIR"

if [ $? -eq 0 ]; then
    echo "Repositorio clonado correctamente."

    rm -rf "$SCRIPT_DIR"/*

    cp -r "$TEMP_DIR"/* "$SCRIPT_DIR"

    echo "Archivos actualizados en la carpeta del script."
else
    echo "Error al clonar el repositorio."
    exit 1
fi

rm -rf "$TEMP_DIR"

clear

