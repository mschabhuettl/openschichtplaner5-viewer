#!/bin/sh
# Viewer-Erzwingung: SP5_READONLY ist in diesem Image NICHT abschaltbar.
# Auch ein explizites `-e SP5_READONLY=0` beim Start wird hier überschrieben —
# die Instanz bleibt garantiert rein lesend (Durchsetzung serverseitig in der
# gebündelten API: 403 für jede Schreibmethode, vor dem Routing).
export SP5_READONLY=1
exec /usr/local/bin/docker-entrypoint.sh "$@"
