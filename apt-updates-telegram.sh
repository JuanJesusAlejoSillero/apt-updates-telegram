#!/bin/bash
# ---------------------------------------------------------------------------------------------------
# Script de bash para recibir notificaciones sobre las actualizaciones de paquetes mediante Telegram
# ---------------------------------------------------------------------------------------------------

# Token de la API de Bots de Telegram (Sustituye 'TOKEN_DEL_BOT' con el token real de tu bot)
BOT_TOKEN="TOKEN_DEL_BOT"

# ID de tu chat en Telegram (Sustituye 'ID_DEL_CHAT' con tu ID de chat real)
CHAT_ID="ID_DEL_CHAT"

# FQDN del servidor para enviarlo en los mensajes y así poder identificarlo fácilmente
FQDN=$(hostname -f)

# Función para obtener la fecha y hora actual
obtener_fecha_hora() {
    date "+%d/%m/%Y %H:%M:%S"
}

# Función para enviar un mensaje a través de la API de Bots de Telegram
enviar_mensaje_telegram() {
    local mensaje="$1"
    curl -s -X POST "https://api.telegram.org/bot$BOT_TOKEN/sendMessage" \
        -d "chat_id=$CHAT_ID" \
        -d "text=$mensaje" \
        -d parse_mode="markdown" >/dev/null
}

# Obtener la fecha y hora actual
fecha_hora=$(obtener_fecha_hora)

# Comprobar actualizaciones y almacenar el resultado
actualizaciones=$(apt update 2>&1)

# Comprobar si existe el archivo /var/run/reboot-required
if [ -e "/var/run/reboot-required" ]; then
    mensaje="La máquina *$FQDN* necesita ser reiniciada.

Fecha y hora: $fecha_hora"
    enviar_mensaje_telegram "$mensaje"
fi

# Comprobar si hay actualizaciones disponibles
if echo "$actualizaciones" | grep -q 'apt list --upgradable'; then
    mensaje="¡Hay actualizaciones disponibles para *$FQDN*!:

$actualizaciones

Fecha y hora: $fecha_hora"
else
    # Si no hay actualizaciones disponibles, enviar un mensaje indicándolo
    mensaje="No se encontraron actualizaciones disponibles para *$FQDN*.

Fecha y hora: $fecha_hora"
fi

# Llamar a la función para enviar el mensaje
enviar_mensaje_telegram "$mensaje"

# Source:
# https://github.com/JuanJesusAlejoSillero/apt-updates-telegram
