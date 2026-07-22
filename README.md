# openschichtplaner5-viewer

Rein lesender Viewer für Schichtplaner5-Daten — dieselben Ansichten wie
[OpenSchichtplaner5](https://github.com/mschabhuettl/openschichtplaner5),
aber **garantiert ohne Schreibzugriff**: `SP5_READONLY` ist im Image hart
erzwungen (auch `-e SP5_READONLY=0` wird überschrieben), die gebündelte API
lehnt jede Schreibaktion serverseitig mit 403 ab — für alle Rollen.

Vorgebaute Multi-Arch-Images (amd64/arm64) werden automatisch nach ghcr
publiziert: `ghcr.io/mschabhuettl/openschichtplaner5-viewer` — Tags: `latest`
sowie die App-Version, die das Image bündelt (z. B. `1.22.0`; der Viewer hat
keinen eigenen Versionsraum, er IST die App in Nur-Lese-Konfiguration). Jeder
Build beweist die Read-only-Erzwingung am publizierten Image, bevor er grün
wird.

## Schnellstart

```bash
git clone https://github.com/mschabhuettl/openschichtplaner5-viewer.git
cd openschichtplaner5-viewer
SP5_DB_PATH=/pfad/zu/sp5/Daten docker compose up -d
```

Alternativ ohne Compose:

```bash
docker run -d -p 8080:8000 \
  -v /pfad/zu/sp5/Daten:/app/data:ro \
  ghcr.io/mschabhuettl/openschichtplaner5-viewer:latest
```

Lokal bauen statt Registry-Image: im `docker-compose.yml` die `build: .`-Zeile
aktivieren und `docker compose up -d --build` (bzw.
`docker build -t openschichtplaner5-viewer:local .`).

Die DBF-Quelle wird **read-only** gemountet (Normalbetrieb) — der Viewer kann
parallel zu einer schreibenden osp5-Instanz oder direkt auf einem Backup-/
Netzlaufwerk-Bestand laufen. `SP5_CORE_ONLY=true` beschränkt zusätzlich auf
den Original-Funktionsumfang. Architektur-Begründung (kein Fork):
[docs/architecture.md](docs/architecture.md).

## Aktualisieren

Neue App-Version übernehmen = `APP_IMAGE`-Pin im [Dockerfile](Dockerfile)
heben — das erledigt der Workflow `update-pins` per Commit und stößt CI
(Read-only-Beweis) und den Image-Build automatisch an. Betreiber ziehen dann
einfach das neue Image (`docker compose pull && docker compose up -d`).
