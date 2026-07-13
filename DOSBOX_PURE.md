# DOSBox Pure persistence build

This branch is based on EmulatorJS `v4.3.0-pre` and includes the tested
Emscripten DOSBox Pure pthread core. It keeps DOS content ZIPs intact, flushes
all DOSBox Pure differencing-disk files to IDBFS, and exports the nominal SRAM,
`*.pure.zip`, `*-CDRIVE.sav`, and hashed virtual-disk saves as one ZIP bundle.
External bundles are restored after IDBFS is mounted and before the core starts.

## One-command Docker deployment

```bash
git clone -b custom/dosbox-pure-persistence \
  https://github.com/ysteen/EmulatorJS.git emulatorjs-dosbox-pure
cd emulatorjs-dosbox-pure
./scripts/deploy-dosbox-pure.sh
```

Place content under `roms/` and open `http://localhost:8080/`. By default the
page loads `roms/game.zip`. Other filenames and an optional BIOS archive can be
selected with query parameters:

```text
http://localhost:8080/?game=roms/ED5WINK.zip&bios=roms/win95-system.zip
```

Game and operating-system images are excluded from Git and the Docker image.
The content archive can contain DOSBox Pure's native `AUTOBOOT.DBP` file for
automatic installed-OS boot. Browser persistence is stored in IndexedDB for
the page origin; use EmulatorJS's export/import save controls to move the save
bundle between browsers.

The equivalent Compose command is:

```bash
docker compose -f compose.dosbox-pure.yml up -d --build
```

## Rebuilding the core

The exact core source and EmulatorJS build recipe are published separately:

- `ysteen/dosbox-pure`, branch `custom/emulatorjs-persistence`
- `ysteen/build`, branch `custom/dosbox-pure-persistence`

To rebuild both threaded core variants on an amd64 Docker host:

```bash
git clone -b custom/dosbox-pure-persistence \
  https://github.com/ysteen/build.git emulatorjs-build
cd emulatorjs-build
./build-dosbox-pure.sh
```

The build fork also contains the verified prebuilt `output/dosbox_pure.zip`
bundle. The two `.data` files from that bundle are committed to this repository
under `data/cores/`, so deployment does not download a core at runtime.
