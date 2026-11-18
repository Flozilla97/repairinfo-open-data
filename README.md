# repairinfo open data

Offene Daten zur Reparierbarkeit und Haltbarkeit von Elektrogeräten, aufbereitet von [repairinfo.app](https://www.repairinfo.app/daten-und-api/) (MMR Labs GmbH) aus der EU-Produktdatenbank EPREL und aus data.gouv.fr.

Open data on the repairability and durability of electrical devices, prepared by [repairinfo.app](https://www.repairinfo.app/en/data-and-api/) (MMR Labs GmbH) from the EU product database EPREL and from data.gouv.fr.

[Deutsch](#deutsch) · [English](#english)

---

## Deutsch

### Was die Daten sind

| Datei | Inhalt | Quelle | Lizenz |
| --- | --- | --- | --- |
| `data/ersatzteil-fristen.json` | Ersatzteil-Fristen je Produktgruppe aus den Ökodesign-Verordnungen: Teilelisten, Zeitraum, Lieferzeit, Fundstelle, Eintrag in Anhang II der Richtlinie (EU) 2024/1799 | EUR-Lex, eigene Auswertung | CC BY 4.0 |
| `data/produktgruppen.json` | Je Produktgruppe: welche Angabe gilt (Nr. 20 oder 21), EU-Reparierbarkeitsklasse, Ökodesign-Frist, Anhang II RL 2024/1799, französischer Index | EUR-Lex, Légifrance, eigene Auswertung | CC BY 4.0 |
| `data/pflicht-check.json` | Fragebaum `pflicht.v1` des Pflicht-Checks: welche Reparaturinformation ein Produkt vor dem Kauf braucht (DE, EN, FR) | eigene Auswertung | CC BY 4.0 |
| `data/quellen.json` | Alle Quellen der Website mit Titel, Herausgeber, Adresse und Datum | eigene Zusammenstellung | CC BY 4.0 |
| Smartphone-Register (nur live) | 1.119 Smartphones aus EPREL. Enthält ausschließlich EPREL-Werte und liegt deshalb nicht in diesem Repo (dauerhaft archiviert), sondern tagesaktuell unter https://www.repairinfo.app/presse/smartphone-register-2026.csv | EPREL |
| `data/rangliste.json` | Übersicht der Ranglisten nach dem französischen Reparierbarkeitsindex (Geschirrspüler, Staubsauger, Laptops, Rasenmäher/Hochdruckreiniger) mit Statistik je Inverkehrbringer | data.gouv.fr, ergänzt um EPREL-Werte | Licence Ouverte 2.0 (EPREL-Felder: siehe Lizenz) |
| `data/rangliste-geschirrspueler.json`, `-staubsauger.json`, `-laptops.json` | Alle Modelle je Kategorie mit Note und fünf Teilnoten des indice de réparabilité | data.gouv.fr | Licence Ouverte 2.0 |
| `data/rangliste-fernseher.json`, `-waschmaschinen.json` | Alle Modelle nach dem französischen indice de durabilité mit Teilnoten Reparierbarkeit und Zuverlässigkeit | data.gouv.fr | Licence Ouverte 2.0 |
| `data/indice/meta.json`, `data/indice/00.json` bis `99.json` | Bereinigter Auszug aus der konsolidierten Datei zum indice de réparabilité, je Modell mit GTIN, aufgeteilt nach den letzten zwei Ziffern der GTIN | data.gouv.fr | Licence Ouverte 2.0 |

Die Dateien enthalten **keine Preise, keine Partnerlinks, keine Produktbilder und keine personenbezogenen Daten**.

### Felder

**JSON-Kopf** (alle Dateien außer `indice/`): `license`, `licenseUrl`, `publisher`, `source`, `updated`, `note`; die Ranglisten zusätzlich `sourceUrl`, `sourceDataset`, `datasetDate`, `title`, `scale`, `method`.

**Ranglisten** (`rows[]`): `rank` (fortlaufend), `model` (Modellkennung des Inverkehrbringers), `placedOnMarketBy`, `score` (0 bis 10), `calculated` (Datum der Berechnung), `gtins[]`, bei Laptops `salesName`, `salesNameSource`, `brandName`, `deviceSlug` (Pfad der Geräteseite); beim Reparierbarkeitsindex `criteria[]` (fünf Teilnoten zu je 0 bis 20 in der Reihenfolge `criteriaOrder`: Dokumentation, Zerlegbarkeit, Verfügbarkeit Ersatzteile, Preis Ersatzteile, produktspezifisch) und `spareParts` (`yearsFrom`, `yearsTo`); beim Haltbarkeitsindex `repairability` und `reliability` (je 0 bis 10). Geschirrspüler tragen, wo zuordenbar, ein Objekt `eprel` (Registriernummer, Energieklasse, Geräusch, Maße, Wasser, Energie je 100 Zyklen). `image` ist in diesen Dateien immer `null`.

**`indice/NN.json`** (Kurzschlüssel): `g` GTIN-14, `m` Modell, `h` Inverkehrbringer, `k` Kategorie (französisch), `n` Note 0 bis 10, `d` Datum der Berechnung, `doc` Link zur Dokumentation, `det` Link zur Notentabelle, `t` Ersatzteile als `[Name, Jahre verfügbar, Lieferzeit in Tagen]`, `c` fünf Teilnoten (0 bis 20), `cs: 10` wenn der Inverkehrbringer auf einer 10er-Skala gemeldet hat (dann verdoppelt). `meta.json` nennt Quelldatei, Abrufdatum und wie viele Zeilen warum verworfen wurden.


### Methode, kurz

- Werte sind **Herstellerangaben**: aus EPREL (Energielabel-Datenbank der Europäischen Kommission) und aus dem französischen Reparierbarkeits- und Haltbarkeitsindex auf data.gouv.fr. repairinfo.app testet keine Geräte selbst.
- Die Ranglisten sortieren nur nach der veröffentlichten Note; gleiche Modelle (gleicher Name oder gleicher Barcode) werden zusammengeführt, der neueste Eintrag bleibt. Zeilen ohne gültige GTIN oder mit älterer Berechnung werden verworfen; die Zahlen stehen in `indice/meta.json`.
- Der französische Index ist ein **nationaler Wert**, kein Reparierbarkeitswert der EU.
- Ausführlich: [So bewerten wir](https://www.repairinfo.app/so-bewerten-wir/) · [Daten und API](https://www.repairinfo.app/daten-und-api/) · [Quellen](https://www.repairinfo.app/quellen/)

### Aktualität

Die Dateien hier sind eine Kopie der Dateien auf www.repairinfo.app. `scripts/aktualisieren.sh` holt den aktuellen Stand (ohne Schlüssel); eine GitHub Action macht das jede Woche. Maßgeblich ist immer die Fassung auf www.repairinfo.app mit ihrem Datum in `updated`.

### Zitierweise

> repairinfo.app (MMR Labs GmbH) nach EU-Datenbank EPREL und data.gouv.fr, Stand JJJJ-MM-TT. https://www.repairinfo.app/daten-und-api/

Maschinenlesbar: [`CITATION.cff`](CITATION.cff).

### Lizenz

- **Aufbereitung von repairinfo.app** (Auswahl, Struktur, eigene Auswertungen, Texte): [CC BY 4.0](LICENSE), Quellenangabe „repairinfo.app, MMR Labs GmbH“ mit Stand-Datum.
- **Daten aus data.gouv.fr**: [Licence Ouverte 2.0](https://www.etalab.gouv.fr/licence-ouverte-open-licence) (Etalab). Nennen: data.gouv.fr und Datum der letzten Aktualisierung; kein amtlicher Charakter. Ob die Lizenz der konsolidierten Datei auch Quelldaten einzelner Hersteller ohne Lizenzangabe erfasst, ist offen.
- **Ohne EPREL-Werte in diesem Repo:** Felder `eprel` (Energieklasse, Geräusch, Maße) sind aus den Ranglisten entfernt, weil EPREL aktuelle Kopien verlangt und dieses Repo bei Zenodo dauerhaft archiviert wird. Die vollständigen Dateien mit EPREL-Feldern gibt es live unter https://www.repairinfo.app/daten/.
- **Daten aus EPREL**: nach den [Nutzungsbedingungen der EPREL Public API](https://ec.europa.eu/assets/move-ener/eprel/EPREL%20Public/Public%20API%20Term%20and%20Conditions/API_TERMS_AND_CONDITIONS_EN.pdf). Quelle nennen („Quelle: EPREL, Europäische Kommission“), nicht den Eindruck einer Billigung durch die Kommission erwecken, Daten nicht als solche verkaufen, lokale Kopien aktuell halten.
- Die Daten erklären die Rechtslage und sind **keine Rechtsberatung**. Keine Gewähr für Vollständigkeit und Richtigkeit der Herstellerangaben.

### API und MCP-Server

Für einzelne Geräte gibt es eine Schnittstelle, ohne Anmeldung, nur lesend, 60 Aufrufe je Minute, ohne Preise und Partnerlinks:

- **MCP-Server** (Streamable HTTP): `https://www.repairinfo.app/mcp`, Werkzeuge `search_devices`, `get_device`, `top_devices`, `lookup_barcode`
- **REST**: `/api/v1/search`, `/api/v1/device`, `/api/v1/top`, `/api/v1/barcode`, OpenAPI unter [`/openapi.json`](https://www.repairinfo.app/openapi.json)

```bash
curl "https://www.repairinfo.app/api/v1/search?query=Fairphone"
```

Einrichtung in einem MCP-Client (Beispiel):

```json
{ "mcpServers": { "repairinfo": { "type": "http", "url": "https://www.repairinfo.app/mcp" } } }
```

Doku: [Daten und API](https://www.repairinfo.app/daten-und-api/) · [Für Entwickler](https://www.repairinfo.app/fuer-entwickler/) (dort auch Schlüssel für höhere Kontingente). `server.json` beschreibt den Server für die offizielle MCP-Registry.

Fehler in den Daten? Bitte ein Issue anlegen oder über [repairinfo.app/kontakt](https://www.repairinfo.app/kontakt/) melden.

---

**Zenodo-Archiv:** Die Releases werden auf Zenodo dauerhaft archiviert (DOI). Die Ranglisten für Fernseher, Waschmaschinen und Geschirrspüler fehlen dort, weil sie EPREL-Eckdaten enthalten. Die EPREL-Bedingungen verlangen aktuelle Kopien, ein dauerhaftes Archiv kann das nicht leisten. In diesem Repo bleiben sie und werden wöchentlich aktualisiert.

## English

### What the data is

| File | Content | Source | Licence |
| --- | --- | --- | --- |
| `data/ersatzteil-fristen.json` | Spare-part periods per product group from the EU ecodesign regulations: part lists, period, delivery time, legal reference, entry in Annex II of Directive (EU) 2024/1799 | EUR-Lex, own analysis | CC BY 4.0 |
| `data/produktgruppen.json` | Per product group: which pre-contractual information applies, EU repairability class, ecodesign period, Annex II Directive 2024/1799, French index | EUR-Lex, Légifrance, own analysis | CC BY 4.0 |
| `data/pflicht-check.json` | Decision tree `pflicht.v1`: which repair information a product needs before purchase (DE, EN, FR) | own analysis | CC BY 4.0 |
| `data/quellen.json` | All sources cited on the website with title, publisher, URL and date | own compilation | CC BY 4.0 |
| Smartphone register (live only) | 1,119 smartphones from EPREL. Contains only EPREL values and is therefore not stored in this permanently archived repo; get it up to date at https://www.repairinfo.app/presse/smartphone-register-2026.csv | EPREL |
| `data/rangliste.json` | Overview of rankings by the French repairability index (dishwashers, vacuum cleaners, laptops, lawn mowers/pressure washers) with statistics per company | data.gouv.fr, enriched with EPREL values | Licence Ouverte 2.0 (EPREL fields: see licence) |
| `data/rangliste-geschirrspueler.json` (dishwashers), `-staubsauger.json` (vacuums), `-laptops.json` | All models per category with score and five sub-scores of the French *indice de réparabilité* | data.gouv.fr | Licence Ouverte 2.0 |
| `data/rangliste-fernseher.json` (TVs), `-waschmaschinen.json` (washing machines) | All models by the French *indice de durabilité* with repairability and reliability sub-scores | data.gouv.fr | Licence Ouverte 2.0 |
| `data/indice/meta.json`, `data/indice/00.json` to `99.json` | Cleaned extract of the consolidated *indice de réparabilité* file, one record per GTIN, sharded by the last two GTIN digits | data.gouv.fr | Licence Ouverte 2.0 |

The files contain **no prices, no affiliate links, no product images and no personal data**. Field descriptions: see the German section above; JSON keys in the rankings are English, the short keys in `indice/` are `g` GTIN-14, `m` model, `h` company placing on the market, `k` category, `n` score 0–10, `d` calculation date, `doc` documentation link, `det` score table link, `t` spare parts `[name, years available, delivery days]`, `c` five sub-scores (0–20).

### Method in brief

Values are **manufacturer declarations** from EPREL (the European Commission's energy label database) and from the French repairability and durability indices on data.gouv.fr; repairinfo.app does not test devices. Rankings sort only by the published score. The French index is a **national score, not an EU repairability score**. Full method: [How we rate](https://www.repairinfo.app/en/how-we-rate/) · [Data and API](https://www.repairinfo.app/en/data-and-api/).

### How to cite

> repairinfo.app (MMR Labs GmbH), based on the EU database EPREL and data.gouv.fr, as of YYYY-MM-DD. https://www.repairinfo.app/daten-und-api/

### Licence

- **repairinfo.app's compilation** (selection, structure, own analyses, texts): [CC BY 4.0](LICENSE), credit "repairinfo.app, MMR Labs GmbH" with the date.
- **Data from data.gouv.fr**: [Licence Ouverte 2.0](https://www.etalab.gouv.fr/licence-ouverte-open-licence); name data.gouv.fr and the date of last update, without suggesting official status.
- **No EPREL values in this repo:** `eprel` fields (energy class, noise, dimensions) are removed from the rankings because EPREL requires up-to-date copies and this repo is archived permanently on Zenodo. The full files including EPREL fields are available live at https://www.repairinfo.app/daten/.
- **Data from EPREL**: under the [EPREL Public API terms](https://ec.europa.eu/assets/move-ener/eprel/EPREL%20Public/Public%20API%20Term%20and%20Conditions/API_TERMS_AND_CONDITIONS_EN.pdf): credit "Source: EPREL, European Commission", do not suggest endorsement by the Commission, do not sell the data as such, keep local copies up to date.
- Not legal advice. No warranty for manufacturer declarations.

### API and MCP server

Free, no sign-in, read-only, 60 calls per minute, no prices or affiliate links: MCP server `https://www.repairinfo.app/mcp` (Streamable HTTP; tools `search_devices`, `get_device`, `top_devices`, `lookup_barcode`) and REST `/api/v1/search`, `/device`, `/top`, `/barcode` described in [`/openapi.json`](https://www.repairinfo.app/openapi.json). Docs: [Data and API](https://www.repairinfo.app/en/data-and-api/).

### Updates

These files mirror www.repairinfo.app. `scripts/aktualisieren.sh` refreshes them (no keys needed); a GitHub Action runs it weekly. The version on www.repairinfo.app, with its `updated` date, is authoritative.

**Zenodo archive:** Releases are archived permanently on Zenodo (DOI). The TV, washing machine and dishwasher rankings are not included there because they contain EPREL key data. The EPREL terms require stored copies to be kept up to date, which a permanent archive cannot do. They stay in this repository and are updated weekly.
