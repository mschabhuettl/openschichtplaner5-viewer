# Architektur — Konfigurations-Derivat statt Fork

## Entscheidung

`openschichtplaner5-viewer` dupliziert KEINEN Code. Das Image ist
`FROM ghcr.io/mschabhuettl/openschichtplaner5:<Pin>` plus einen
Entrypoint-Shim, der `SP5_READONLY=1` unübersteuerbar setzt. Alles andere —
Ansichten, Login, Rollen, Backends, Health — ist die unveränderte App.

## Warum so

- **Die Durchsetzung lebt in der API, nicht im Image.** `SP5_READONLY`
  (openschichtplaner5-api ≥ 1.25.0) lehnt jede Schreibmethode zentral vor dem
  Routing mit 403 ab — auch für Administratoren; ein Vollrouten-
  Ablehnungstest (>100 Schreibrouten) ist Teil der API-Suite. Das Frontend
  (app ≥ 1.21.29) blendet Schreib-Bedienelemente aus und zeigt dauerhaft ein
  Banner. Ein Fork müsste genau diese Garantien duplizieren und driften lassen.
- **Der Shim macht das Flag zur Eigenschaft des Images.** `docker run -e
  SP5_READONLY=0 …viewer` bleibt read-only (der Shim exportiert das Flag nach
  der Env-Auswertung). Beweis im Repo-Smoke-Test.
- **Updates sind ein Pin-Bump.** `update-pins` zieht `APP_IMAGE` auf das
  neueste App-Release; der Viewer erbt Fixes und Ansichten automatisch.

## Betrieb

Normalbetrieb ist der READ-ONLY-Mount der DBF-Quelle (`:ro` in der Compose) —
zusammen mit dem API-Gate doppelt abgesichert. `SP5_CORE_ONLY` bleibt frei
kombinierbar (Viewer im Original-Funktionsumfang).
