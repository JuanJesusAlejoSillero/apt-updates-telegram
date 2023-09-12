# **Recibe avisos sobre las actualizaciones de tu servidor en Telegram**

Este repositorio contiene un script de Bash que te permite recibir notificaciones en tu cuenta de Telegram cada vez que haya actualizaciones disponibles en tu sistema.

Para que este script se ejecute periódicamente ver el apartado: [**Programar la ejecución del script**](#programar-la-ejecución-del-script).

## **Requisitos**

Antes de utilizar este script, asegúrate de tener lo siguiente:

- Una cuenta de Telegram.
- Un bot de Telegram y su correspondiente token.
- El ID de nuestro chat con el bot.
- `apt` como gestor de paquetes en tu sistema. Si utilizas un gestor diferente, deberás adaptar este script.
- `curl` instalado.
- Poder ejecutar comandos como `root` (ya sea como usuario `root` directamente, o con `sudo` o `doas`). En mi caso lo haré como `root` (usando `su -`).

> Si no dispones de un bot de telegram, su token o el ID de tu chat con él, puedes seguir las instrucciones disponibles en este post:
>
> [Recibe avisos sobre las actualizaciones de tu servidor en Telegram](https://blog.juanje.net/blog/2023/09/recibe-avisos-sobre-las-actualizaciones-de-tu-servidor-en-telegram/)

## **Configuración y uso del script**

Sigue estos pasos para configurar el script:

1. Accede como `root` y clona este repositorio en tu sistema:

    ```bash
    su -

    git clone https://github.com/JuanJesusAlejoSillero/apt-updates-telegram.git
    ```

2. Edita el archivo `apt-updates-telegram.sh` y modifica las siguientes variables con tus valores:

    - BOT_TOKEN: El token de tu bot de Telegram. Se obtiene de [botfather](https://t.me/botfather).
    - CHAT_ID: El ID del chat donde deseas recibir las notificaciones. Puedes obtenerlo de varias  formas. Las instrucciones completas están en mi [blog](https://blog.juanje.net/).

    ```bash
    nano -cl apt-updates-telegram/apt-updates-telegram.sh
    ```

3. Dale permisos de ejecución al script:

    ```bash
    chmod +x apt-updates-telegram/apt-updates-telegram.sh
    ```

4. Prueba su funcionamiento ejecutándolo manualmente:

    ```bash
    ./apt-updates-telegram/apt-updates-telegram.sh
    ```

Si todo ha ido bien recibirás un mensaje informándote de las actualizaciones disponibles, o, en su defecto, de la ausencia de estas:

![script-1](img/script-1.png)

## **Programar la ejecución del script**

Instrucciones disponibles en:

[Recibe avisos sobre las actualizaciones de tu servidor en Telegram - # Programar la ejecución del script](https://blog.juanje.net/blog/2023/09/recibe-avisos-sobre-las-actualizaciones-de-tu-servidor-en-telegram/#programar-la-ejecuci%C3%B3n-del-script)

---

> **Por favor, si te ha sido útil el script considera darle una estrella al repositorio de GitHub y/o compartirlo para que llegue a más gente**
>
> ![github-star](img/github-star.gif)

---

✒️ **Documentación realizada por Juan Jesús Alejo Sillero.**
