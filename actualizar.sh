#!/bin/bash
# Automatically updates the github repository

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
    echo "Carpeta '$TARGET_FOLDER' actualizada."

    cp -r "$TEMP_DIR/$TARGET_FOLDER"/* "$SCRIPT_DIR"

    echo "Archivos actualizados."
else
    echo "Error al clonar."
    exit 1
fi

rm -rf "$TEMP_DIR"
clear

cat << "EOF"

Actualizado Exitosamente

EOF
