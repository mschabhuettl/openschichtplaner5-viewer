# syntax=docker/dockerfile:1

# ── openschichtplaner5-viewer ─────────────────────────────────────────────────
# KEIN Fork: Konfigurations-Derivat des App-Images. Der Shim erzwingt
# SP5_READONLY=1 unübersteuerbar; alles andere (Ansichten, Auth, Backends)
# ist die unveränderte App. APP_IMAGE-Pin wird von update-pins nachgezogen.
ARG APP_IMAGE="ghcr.io/mschabhuettl/openschichtplaner5:1.21.44"
FROM ${APP_IMAGE}

COPY viewer-entrypoint.sh /usr/local/bin/viewer-entrypoint.sh
RUN chmod 755 /usr/local/bin/viewer-entrypoint.sh
ENTRYPOINT ["/usr/local/bin/viewer-entrypoint.sh"]
CMD ["python", "-m", "uvicorn", "sp5api.main:app", "--host", "0.0.0.0", "--port", "8000"]
