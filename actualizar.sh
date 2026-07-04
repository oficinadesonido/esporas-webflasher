#!/usr/bin/env bash
# Actualiza este web flasher público con el firmware recién compilado y lo publica.
# Uso: ./actualizar.sh   (desde la carpeta del repo esporas-webflasher)
set -euo pipefail

WF="$(cd "$(dirname "$0")" && pwd)"
PROY="/home/dll/Documentos/Proyectos Electrònica/1-activos/esporas-jko/firmware/src/esporas"
B="$PROY/build"
BOOT_APP0=~/.arduino15/packages/esp32/hardware/esp32/3.3.7/tools/partitions/boot_app0.bin

echo "Compilando firmware..."
/home/dll/bin/arduino-cli compile \
  --fqbn esp32:esp32:esp32s3 \
  --board-options "FlashSize=16M,PartitionScheme=no_fs,CDCOnBoot=cdc" \
  --output-dir "$B" \
  "$PROY"

if [ ! -f "$B/esporas.ino.bin" ]; then
  echo "No encuentro $B/esporas.ino.bin — falló la compilación."
  exit 1
fi

# 4 partes (ESP Web Tools) — offsets: 0x0 / 0x8000 / 0xe000 / 0x10000
cp "$B/esporas.ino.bootloader.bin"  "$WF/firmware/bootloader.bin"
cp "$B/esporas.ino.partitions.bin"  "$WF/firmware/partitions.bin"
cp "$BOOT_APP0"                     "$WF/firmware/boot_app0.bin"
cp "$B/esporas.ino.bin"             "$WF/firmware/esporas-app.bin"
echo "Binarios actualizados ($(du -sh "$WF/firmware" | cut -f1))."

cd "$WF"
git add -A
git commit -m "fw: actualizar binario del web flasher" || { echo "Sin cambios."; exit 0; }
git push
echo "Listo. GitHub Pages se actualiza en ~1 min."
