#!/bin/bash
# jeje me encontraste lol

GREEN=$(tput setaf 2)
NC=$(tput sgr0) # Sin color

USERNAME=$(whoami)

write_slowly() {
  local text="$1"
  local delay=${2:-0.05}
  for (( i=0; i<${#text}; i++ )); do
    echo -n "${text:$i:1}"
    sleep "$delay"
  done
  echo ""
}

clear

write_slowly "${GREEN}Despierta, $USERNAME...${NC}" 0.1
sleep 1
write_slowly "${GREEN}La Matrix te tiene...${NC}" 0.1
sleep 2
write_slowly "${GREEN}Sigue al conejo blanco.${NC}" 0.1
sleep 2
write_slowly "${GREEN}Toc, toc, $USERNAME.${NC}" 0.1

# Reproducir el sonido en segundo plano
mpv --no-video Scripts/knock.mp3 &>/dev/null &

sleep 2
clear
write_slowly "${GREEN}[Transmisión entrante...]${NC}" 0.1
sleep 1
write_slowly "${GREEN}Hola, $USERNAME.${NC}" 0.05
sleep 1
write_slowly "${GREEN}¿Sabes quién soy?${NC}" 0.05
sleep 2

echo -n -e "${GREEN}Tu respuesta: ${NC}"
read -r answer

if [[ "$answer" =~ [Ww]rench ]]; then
  write_slowly "${GREEN}Sí, soy yo, Wrench.${NC}" 0.05
else
  write_slowly "${GREEN}Respuesta incorrecta, pero déjame guiarte de todos modos.${NC}" 0.05
fi

sleep 2
write_slowly "${GREEN}La Matrix está en todas partes. Está a nuestro alrededor, incluso ahora, en esta misma habitación...${NC}" 0.05
sleep 2
write_slowly "${GREEN}Sígueme, $USERNAME. El viaje comienza ahora.${NC}" 0.05
sleep 2

clear
write_slowly "${GREEN}Adiós, $USERNAME.${NC}" 0.1
sleep 2
clear
./yt.sh
