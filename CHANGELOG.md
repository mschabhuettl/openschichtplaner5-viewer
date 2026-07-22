# Changelog

## [Unreleased]

### Changed

- **Öffentliches Repo mit publizierten Images.** Der Viewer wird als
  vorgebautes Multi-Arch-Image (amd64/arm64) nach ghcr publiziert
  (`ghcr.io/mschabhuettl/openschichtplaner5-viewer`, Tags `latest` + die
  gebündelte App-Version; eigener Versionsraum entfällt weiterhin —
  maßgeblich ist der `APP_IMAGE`-Pin im Dockerfile). `docker-compose.yml`
  nutzt standardmäßig das Registry-Image (lokaler Build weiter möglich,
  `build:`-Zeile aktivieren). Jeder Image-Build beweist die
  `SP5_READONLY`-Erzwingung am publizierten Image; `update-pins` stößt nach
  Pin-Bumps CI und Image-Build automatisch an. (Ersetzt das zwischenzeitliche
  Nur-lokal-bauen-Modell, das nie über dieses Changelog hinauskam.)

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
