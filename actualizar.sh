#!/bin/bash
# Actualiza automaticamente desde el repositorio de github

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

REPO_URL="https://github.com/wrenchpc/yt.git"

TARGET_FOLDER="yt"

TEMP_DIR=$(mktemp -d)

git init "$TEMP_DIR"

cd "$TEMP_DIR"

git remote add origin "$REPO_URL"

git config core.sparseCheckout true

echo "$TARGET_FOLDER" >> .git/info/sparse-checkout

git pull origin main

if [ $? -eq 0 ]; then
    echo "Carpeta '$TARGET_FOLDER' clonada correctamente."

    cp -r "$TEMP_DIR/$TARGET_FOLDER"/* "$SCRIPT_DIR"

    echo "Archivos actualizados en la carpeta del script."
else
    echo "Error al clonar la carpeta."
    exit 1
fi

rm -rf "$TEMP_DIR"

( cd "$PWD" 2>/dev/null )

echo "Ejecutando el script..."

if [[ -f "yt.sh" ]]; then
    ./yt.sh
else
    echo "No se encontró el archivo yt.sh"
fi

clear
