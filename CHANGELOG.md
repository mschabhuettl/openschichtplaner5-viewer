# Changelog

## [Unreleased]

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
