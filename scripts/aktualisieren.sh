#!/usr/bin/env bash
# Holt die offenen Datensätze von https://www.repairinfo.app nach data/.
# Fetches the open datasets from https://www.repairinfo.app into data/.
# Keine Schlüssel nötig / no keys needed. Aufruf / usage: bash scripts/aktualisieren.sh
set -euo pipefail
BASIS="https://www.repairinfo.app"
ZIEL="$(cd "$(dirname "$0")/.." && pwd)/data"
mkdir -p "$ZIEL/indice"

holen() { # $1 = Pfad auf der Website, $2 = Zieldatei
  local tmp; tmp="$(mktemp)"
  curl -fsS --retry 3 -A "repairinfo-open-data-sync" "$BASIS$1" -o "$tmp"
  case "$2" in *.json) python3 -m json.tool "$tmp" >/dev/null ;; esac  # nur gültiges JSON übernehmen
  mv "$tmp" "$2"
}

for f in pflicht-check ersatzteil-fristen produktgruppen quellen \
         rangliste rangliste-geschirrspueler rangliste-staubsauger rangliste-laptops \
         rangliste-fernseher rangliste-waschmaschinen; do
  holen "/daten/$f.json" "$ZIEL/$f.json"
done

holen "/daten/indice/meta.json" "$ZIEL/indice/meta.json"
for i in $(seq -w 0 99); do
  holen "/daten/indice/$i.json" "$ZIEL/indice/$i.json"
done

holen "/presse/smartphone-register-2026.csv" "$ZIEL/smartphone-register-2026.csv"

echo "Fertig / done: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
