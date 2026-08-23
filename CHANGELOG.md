# Changelog

## [Unreleased]

### Changed

- **Öffentliches Repo ohne publizierte Images.** Der Viewer publiziert keine
  eigenen Docker-Images mehr (kein ghcr, kein PyPI) — das Repo liefert nur
  Code, Dockerfile und docker-compose für den lokalen Build. Der
  ghcr-Publish-Workflow ist entfernt, die bereits publizierten Viewer-Pakete
  auf ghcr sind gelöscht. `docker-compose.yml` baut standardmäßig lokal
  (`docker compose up -d --build`, Image-Name
  `openschichtplaner5-viewer:local`). Das App-Basis-Image
  (`ghcr.io/mschabhuettl/openschichtplaner5`, Version per `APP_IMAGE`-Pin)
  wird weiterhin von ghcr gezogen — nur der Viewer selbst wird nicht
  publiziert. Die CI beweist die `SP5_READONLY`-Erzwingung weiterhin am lokal
  gebauten Image; `update-pins` hebt den Pin und stößt die CI an. (Ersetzt
  den zwischenzeitlichen ghcr-Publish-Ansatz, der nie über dieses Changelog
  hinauskam.)

## [0.1.2] - 2026-07-03

### Changed

- Basis-Image auf openschichtplaner5 1.21.39 (schnellerer Seitenaufbau,
  Zusatzfelder im Mitarbeiter-Profil, sauberer Leerzustand in
  „Mein Kalender" — alles in der Leseansicht wirksam).

## [0.1.1] - 2026-07-03

### Changed

- Basis-Image auf openschichtplaner5 1.21.36 (u. a. Tages-Schichtmodelle,
  Einsatzplan-Auflisten-Modi, Felddarstellungsmodi, Zusatzfeld-
  Bezeichnungen — alles in der Leseansicht sichtbar).

## [0.1.0] - 2026-07-02

### Added

- **Rein lesender Viewer als Konfigurations-Derivat** des App-Images:
  gleiche Ansichten, gleiche Anmeldung — aber `SP5_READONLY` ist im Image
  unübersteuerbar erzwungen (auch ein explizites `SP5_READONLY=0` beim Start
  wird überschrieben). Jede Schreibaktion wird serverseitig mit 403
  abgelehnt, für alle Rollen; die Oberfläche zeigt dauerhaft ein
  Schreibschutz-Banner.
- docker-compose mit read-only-DBF-Mount als Normalbetrieb; kombinierbar mit
  `SP5_CORE_ONLY` (Original-Funktionsumfang).
