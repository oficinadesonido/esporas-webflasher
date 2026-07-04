# Esporas — Web Flasher (público)

Página para flashear la placa azul (ESP32-S3) del sintetizador **Esporas** desde el
navegador, con [ESP Web Tools](https://esphome.github.io/esp-web-tools/). Repo
público **solo con el binario de firmware** (no incluye el código fuente).

## 🔗 Publicado en
**https://oficinadesonido.github.io/esporas-webflasher/**

## Para flashear (jko o cualquiera)
1. Abre el link en **Chrome o Edge de escritorio** (no funciona en móvil ni Safari).
2. Conecta la placa por USB.
3. Pulsa **Instalar / Flash**, elige el puerto y espera. La placa se reinicia sola.
   - Si no aparece el puerto: mantén **BOOT**, pulsa **RESET**, suelta BOOT, reintenta.

## Para publicar una versión nueva (Daniel)
El firmware fuente vive en el repo privado `jkocontreras/Esporas`
(`firmware/src/esporas/`). Tras cambiarlo:

```bash
./actualizar.sh
```
Recompila el sketch, copia los binarios a `firmware/` y sube. GitHub Pages se
actualiza en ~1 min.

## Contenido
- `index.html` — la página con el botón de flasheo (ESP Web Tools por CDN unpkg).
- `manifest.json` — apunta a las 4 partes del firmware (`ESP32-S3`).
- `firmware/` — binarios (~1.4 MB, 4 partes): `bootloader.bin` @ 0x0,
  `partitions.bin` @ 0x8000, `boot_app0.bin` @ 0xe000, `esporas-app.bin` @ 0x10000.
- `actualizar.sh` — recompila, refresca los binarios y publica.
