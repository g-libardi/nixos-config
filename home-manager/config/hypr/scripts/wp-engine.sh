#!/usr/bin/env bash

throw() {
    echo "$1"
    read -p "Press Enter to exit..."
    exit 1
}

# Usa gum para solicitar um input do usuário
LWE_WALLPAPER_ID=$(gum input --placeholder "Wallpaper workshop link")

# Limpa o log
echo "" > /tmp/lew_util.log

# Verifica se o usuário digitou algo
if [ -n "$LWE_WALLPAPER_ID" ]; then
    # Executa o comando no Hyprland com o argumento fornecido
    LWE_WALLPAPER_ID=$(echo $LWE_WALLPAPER_ID | grep -oP '(?<=id=)\d+')
    echo "$LWE_WALLPAPER_ID selecionado. Iniciando o wallpaper..."
    pkill linux-wallpaper
    hyprctl dispatch exec "linux-wallpaperengine --screen-root HDMI-A-1 $LWE_WALLPAPER_ID &> /tmp/lew_util.log"
    # verifica se o comando foi executado com sucesso
    HAS_ERROR=$(grep -i "error" /tmp/lew_util.log)
    # if [ -z "$HAS_ERROR" ]; then
    #     throw "Erro ao iniciar o wallpaper. Verifique o log em /tmp/lew_util.log"
    #     cat /tmp/lew_util.log
    #     read -p "Press Enter to exit..."
    # fi
else
    echo "No input provided, wallpaper-engine will be closed."
    pkill linux-wallpaper
fi
read -p "Press Enter to exit..."
exit 0
