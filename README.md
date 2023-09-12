# **Notificador de Actualizaciones por Telegram**

Este repositorio contiene un script de Bash que te permite recibir notificaciones en tu cuenta de Telegram cada vez que haya actualizaciones disponibles en tu sistema. Puedes configurar este script para que se ejecute periódicamente a través de un *timer de systemd* o *cronjob* y recibir notificaciones instantáneas sobre las actualizaciones disponibles.

## **Requisitos**

Antes de utilizar este script, asegúrate de tener lo siguiente:

- Una cuenta de Telegram.
- Un bot de Telegram y su correspondiente token. Puedes obtenerlo siguiendo las instrucciones en la documentación oficial de Telegram.
- Tener `apt` como gestor de paquetes en tu sistema. Si utilizas un gestor diferente, deberás adaptar este script.
- Tener `curl` instalado.

## **Configuración**

Sigue estos pasos para configurar el script:

1. Clona este repositorio en tu sistema:

```bash
git clone https://github.com/JuanJesusAlejoSillero/apt-updates-telegram.git
```

2. Edita el archivo `apt-updates-telegram.sh` y edita las siguientes variables con tus valores:

- BOT_TOKEN: El token de tu bot de Telegram. Se obtiene de [botfather](https://t.me/botfather).
- CHAT_ID: El ID del chat donde deseas recibir las notificaciones. Puedes obtenerlo de varias formas. Las instrucciones completas están en mi [blog](https://blog.juanje.net/).

3. Dale permisos de ejecución al script:

```bash
chmod +x apt-updates-telegram.sh
```

4. Prueba su funcionamiento ejecutándolo manualmente:

```bash
./apt-updates-telegram.sh
```

Si todo ha ido bien recibirás una notificación informándote de las actualizaciones disponibles.

## **Programar la ejecución del script**

Instrucciones disponibles en mi este post:

[Notificador de Actualizaciones por Telegram](https://blog.juanje.net/)

---

✒️ **Documentación realizada por Juan Jesús Alejo Sillero.**
