# openschichtplaner5-viewer

Rein lesender Viewer für Schichtplaner5-Daten — dieselben Ansichten wie
[OpenSchichtplaner5](https://github.com/mschabhuettl/openschichtplaner5),
aber **garantiert ohne Schreibzugriff**: `SP5_READONLY` ist im Image hart
erzwungen (auch `-e SP5_READONLY=0` wird überschrieben), die gebündelte API
lehnt jede Schreibaktion serverseitig mit 403 ab — für alle Rollen.

Dieses Repo liefert bewusst **kein vorgebautes Image** — das Image wird lokal
aus dem öffentlichen App-Basis-Image gebaut (`FROM
ghcr.io/mschabhuettl/openschichtplaner5:<Pin>` + Entrypoint-Shim).

## Schnellstart (lokaler Build)

```bash
git clone git@github.com:mschabhuettl/openschichtplaner5-viewer.git
cd openschichtplaner5-viewer
SP5_DB_PATH=/pfad/zu/sp5/Daten docker compose up -d --build
```

Alternativ ohne Compose:

```bash
docker build -t openschichtplaner5-viewer:local .
docker run -d -p 8080:8000 \
  -v /pfad/zu/sp5/Daten:/app/data:ro \
  openschichtplaner5-viewer:local
```

Die DBF-Quelle wird **read-only** gemountet (Normalbetrieb) — der Viewer kann
parallel zu einer schreibenden osp5-Instanz oder direkt auf einem Backup-/
Netzlaufwerk-Bestand laufen. `SP5_CORE_ONLY=true` beschränkt zusätzlich auf
den Original-Funktionsumfang. Architektur-Begründung (kein Fork):
[docs/architecture.md](docs/architecture.md).

## Aktualisieren

Neue App-Version übernehmen = `APP_IMAGE`-Pin im [Dockerfile](Dockerfile)
heben (macht der Workflow `update-pins` per Commit) und lokal neu bauen:
`docker compose up -d --build`.
