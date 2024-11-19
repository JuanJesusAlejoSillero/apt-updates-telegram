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

# Función para dividir mensajes largos en fragmentos de hasta 20 líneas.
# La meta es evitar sobrepasar el límite de tamaño que tiene Telegram para los mensajes.
enviar_mensaje_largo() {
    local mensaje="$1"
    local max_lineas=20
    local lineas=0
    local mensaje_actual=""
    while IFS= read -r linea; do
        mensaje_actual+="$linea"$'\n'
        ((lineas++))
        if (( lineas == max_lineas )); then
            enviar_mensaje_telegram "$mensaje_actual"
            mensaje_actual=""
            lineas=0
        fi
    done <<< "$mensaje"
    # Enviar las líneas restantes
    if [[ -n "$mensaje_actual" ]]; then
        enviar_mensaje_telegram "$mensaje_actual"
    fi
}

# Obtener el idioma del sistema
system_language=$(echo $LANG | cut -d'_' -f1)

# Definir la palabra clave basada en el idioma
keyword="upgradable" # Por defecto, para idiomas que no sean español

if [ "$system_language" = "es" ]; then
    keyword="actualizable" # Si el idioma es español
fi

# Ejecutar apt update para actualizar la lista de paquetes
apt update > /dev/null 2>&1

# Obtener la fecha y hora actual
fecha_hora=$(obtener_fecha_hora)

# Guardar la salida de apt list --upgradable en una variable para no repetir su ejecución de forma innecesaria
apt_list_upgradable=$(apt list --upgradable 2>/dev/null)

# Obtener la cantidad de actualizaciones disponibles
cantidad_actualizaciones=$(echo "$apt_list_upgradable" | grep -c "$keyword")

# Obtener la lista detallada de actualizaciones disponibles
lista_actualizaciones=$(echo "$apt_list_upgradable" | grep "$keyword" | awk -F'/' '{print "- " $1}')

# Obtener la cantidad de actualizaciones por repositorio
cantidad_por_repo=$(echo "$apt_list_upgradable" | grep '/' | awk -F'/' '{print $2}' | awk '{print $1}' | sort | uniq -c | awk '{print $2 ": " $1}')

# Comprobar si existe el archivo /var/run/reboot-required
if [ -e "/var/run/reboot-required" ]; then
    mensaje="La máquina *$FQDN* necesita ser reiniciada.

Fecha y hora: $fecha_hora"
    enviar_mensaje_telegram "$mensaje"
fi

# Modificar el mensaje para incluir la lista de actualizaciones
if [ "$cantidad_actualizaciones" -gt 0 ]; then
    mensaje="¡Hay *$cantidad_actualizaciones* actualizaciones disponibles para *$FQDN*!

*Cantidad por repositorios:*
$cantidad_por_repo

*Lista de actualizaciones:*
$lista_actualizaciones

Fecha y hora: $fecha_hora"
else
    mensaje="No se encontraron actualizaciones disponibles para *$FQDN*.

Fecha y hora: $fecha_hora"
fi

# Dividir el mensaje si es necesario y enviarlo
enviar_mensaje_largo "$mensaje"

# Source:
# https://github.com/JuanJesusAlejoSillero/apt-updates-telegram
