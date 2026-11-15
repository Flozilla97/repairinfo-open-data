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

# Ohne EPREL-Werte (15.11.2026): EPREL verlangt aktuelle Kopien inkl. Korrekturen und Löschungen; dieses Repo wird
# dauerhaft bei Zenodo archiviert. Felder "eprel" werden daher entfernt, das Smartphone-Register (reine EPREL-Werte)
# liegt nur live unter https://www.repairinfo.app/presse/smartphone-register-2026.csv.
# Without EPREL values: EPREL requires up-to-date copies; this repo is archived permanently on Zenodo.
rm -f "$ZIEL/smartphone-register-2026.csv"
python3 - "$ZIEL" <<'PY'
import json, glob, sys
def ohne(x):
    if isinstance(x, dict): return {k: ohne(v) for k, v in x.items() if not (k == "eprel" and isinstance(v, (dict, list)))}
    if isinstance(x, list): return [ohne(v) for v in x]
    return x
for f in glob.glob(sys.argv[1] + "/*.json"):
    d = json.load(open(f, encoding="utf-8"))
    d2 = ohne(d)
    if d2 != d:
        d2.pop("eprelFields", None); d2.pop("eprelTermsUrl", None)
        json.dump(d2, open(f, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
PY

echo "Fertig / done: $(date -u +%Y-%m-%dT%H:%M:%SZ)"
