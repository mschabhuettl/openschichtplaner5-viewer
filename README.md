# openschichtplaner5-viewer

Rein lesender Viewer für Schichtplaner5-Daten — dieselben Ansichten wie
[OpenSchichtplaner5](https://github.com/mschabhuettl/openschichtplaner5),
aber **garantiert ohne Schreibzugriff**: `SP5_READONLY` ist im Image hart
erzwungen (auch `-e SP5_READONLY=0` wird überschrieben), die gebündelte API
lehnt jede Schreibaktion serverseitig mit 403 ab — für alle Rollen.

## Schnellstart

```bash
docker run -d -p 8080:8000 \
  -v /pfad/zu/sp5/Daten:/app/data:ro \
  ghcr.io/mschabhuettl/openschichtplaner5-viewer:latest
```

Die DBF-Quelle wird **read-only** gemountet (Normalbetrieb) — der Viewer kann
parallel zu einer schreibenden osp5-Instanz oder direkt auf einem Backup-/
Netzlaufwerk-Bestand laufen. `SP5_CORE_ONLY=true` beschränkt zusätzlich auf
den Original-Funktionsumfang. Architektur-Begründung (kein Fork):
[docs/architecture.md](docs/architecture.md).
