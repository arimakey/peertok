# PeerTok 🔒

Este proyecto tiene como objetivo personalizar el entorno Linux de Parrot, adaptándolo a las necesidades del usuario. Incluye modificaciones en la interfaz, configuraciones y selección de software para ofrecer una experiencia optimizada en seguridad y funcionalidad.

## Índice

1. [Capturas de Pantalla](#capturas-de-pantalla)
2. [Actualizaciones](#actualizaciones)
3. [Consideraciones](#consideraciones)
4. [Instalación](#instalación)
5. [Por Desarrollar](#por-desarrollar)

## Capturas de Pantalla 📸 <a name="capturas-de-pantalla"></a>

![Captura de Pantalla 1](https://raw.githubusercontent.com/ArimaKey/peertok/main/screenshots/02.webp)
![Captura de Pantalla 2](https://raw.githubusercontent.com/ArimaKey/peertok/main/screenshots/03.webp)
![Captura de Pantalla 3](https://raw.githubusercontent.com/ArimaKey/peertok/main/screenshots/01.webp)

## Actualizaciones 🔄 <a name="actualizaciones"></a>

- Se ha eliminado el soporte parcial para Arch Linux.
- Se han actualizado los comandos secundarios.

## Consideraciones 🛠️ <a name="consideraciones"></a>

El script debe ejecutarse desde un usuario no privilegiado. En caso de usar Arch Linux, es necesario haber instalado y configurado `sudo`. Además, se requiere x11 para iniciar la instalación.

## Instalación 💻 <a name="instalación"></a>

Para clonar el repositorio:

```bash
git clone https://github.com/ArimaKey/peertok.git
```

Accede al repositorio clonado:

```bash
cd peertok
```

Asignamos permisos de ejecución:

```bash
chmod +x install.sh
```

Ejecuta el script principal `install.sh`. No lo ejecutes como superusuario:

```bash
bash ./install.sh
```

Comando abreviado:

```bash
git clone https://github.com/ArimaKey/peertok.git && cd peertok && chmod +x install.sh && ./install.sh
```

## Por Desarrollar 🚧 <a name="por-desarrollar"></a>

- Agregar un modo de `instalación personalizada`.
- Integrar `ly` en la versión de Parrot.
- Ofrecer soporte para laptops con indicador de batería, botones de volumen y brillo.
- Implementar atajos de teclado para diversos programas.
- Personalizar aún más la consola, ya que actualmente utiliza un estilo predeterminado de Oh My Zsh!.
