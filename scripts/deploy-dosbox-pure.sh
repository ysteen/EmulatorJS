#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! docker compose version >/dev/null 2>&1; then
  echo "Docker with the Compose plugin is required." >&2
  exit 1
fi

mkdir -p "$ROOT/roms"
docker compose -f "$ROOT/compose.dosbox-pure.yml" up -d --build
docker compose -f "$ROOT/compose.dosbox-pure.yml" ps

echo "EmulatorJS DOSBox Pure: http://localhost:${EJS_PORT:-8080}/"
echo "Put game.zip and optional bios.zip under: $ROOT/roms"
