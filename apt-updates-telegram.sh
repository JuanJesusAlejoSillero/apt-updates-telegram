#!/bin/bash

# Token de la API de Bots de Telegram (Sustituye 'YOUR_BOT_TOKEN' con el token real de tu bot)
BOT_TOKEN="TOKEN_DEL_BOT"

# ID de tu chat en Telegram (Sustituye 'YOUR_CHAT_ID' con tu ID de chat real)
CHAT_ID="ID_DEL_CHAT"

# FQDN del servidor para enviarlo en los mensajes y así poder identificar fácilmente
FQDN=$(hostname -f)

# Función para enviar un mensaje a través de la API de Bots de Telegram
enviar_mensaje_telegram() {
    local mensaje="$1"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
         -d "chat_id=$CHAT_ID" \
         -d "text=$mensaje" \
         -d parse_mode="markdown" > /dev/null
}

# Comprobar actualizaciones y almacenar el resultado
actualizaciones=$(apt update 2>&1)

# Comprobar si existe el archivo /var/run/reboot-required
if [ -e "/var/run/reboot-required" ]; then
    mensaje="El servidor *$FQDN* necesita ser reiniciado."
    enviar_mensaje_telegram "$mensaje"
fi

# Comprobar si hay actualizaciones disponibles
if echo "$actualizaciones" | grep -q 'apt list --upgradable'; then
    mensaje="¡Hay actualizaciones disponibles en *$FQDN*!:

$actualizaciones"
else
    # Si no hay actualizaciones disponibles, enviar un mensaje indicándolo
    mensaje="No se encontraron actualizaciones disponibles en *$FQDN*."
fi

# Llamar a la función para enviar el mensaje
enviar_mensaje_telegram "$mensaje"
