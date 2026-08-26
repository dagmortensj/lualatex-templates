# bok-mal

LaTeX-bokmal i CUP-stil med superskriftsiteringer.
Settes med **LuaLaTeX** — Garamond Libre til tekst, STIX Two Math
til matematikk.

## Filer

| Fil                    | Beskrivelse                                  |
|------------------------|----------------------------------------------|
| `main.tex`             | Utgangspunktet — struktur og innhold         |
| `bokstil.sty`          | All formatering; frosset, endres sjelden     |
| `referanser.bib`       | BibTeX-referanser; legg til dine egne her    |
| `innhold/kapittel1.tex`| Eksempelkapittel; kopiér og lag flere        |
| `figurer/`             | Mappe for figurer; lastes automatisk         |

## Kom i gang

1. Kopier hele mappen til et nytt prosjekt
2. Åpne `main.tex` og fyll inn tittel, forfatter, dedikasjon
3. Skriv kapitler i `innhold/`-mappen og inkluder med `\input{innhold/...}`
4. Legg referanser inn i `referanser.bib`
5. Kompiler med **lualatex**, ikke pdflatex:

```
latexmk -lualatex main
```

Eller for hånd:

```
lualatex main
bibtex   main
lualatex main
lualatex main
```

Motoren er ikke valgfri. Malen laster `unicode-math` og OpenType-fonter,
og ingen av delene kan pdflatex bruke.

## Struktur

Boken er delt i tre faser:

| Fase           | Kommando        | Innhold                                       |
|----------------|-----------------|-----------------------------------------------|
| Frontmateriale | `\frontmatter`  | Tittel, dedikasjon, innhold, forord, takk     |
| Hovedmateriale | `\mainmatter`   | Innledning, deler og kapitler                 |
| Bakmateriale   | `\backmatter`   | Bibliografi, indeks                           |

## Nyttige kommandoer

### Sidemaler

```latex
\booktitlepage             % Tittelside
\dedicationpage{...}       % Dedikasjon (recto, sentrert kursiv)
\booktoc                   % Innholdsfortegnelse
\frontchapter{Forord}      % Unummerert kapittel i frontmateriale
```

### Kapittelåpning med initial

```latex
\chapter{Kapitteltittel}
\chapteropening{D}{en første setningen}
fortsetter her. Åpningsavsnittet må være langt nok
til å fylle ut høyden av initialen, ellers vil neste
seksjonsoverskrift krasje med initialen.
```

### Siteringer

```latex
\cite{nokkel}              % superskript: ¹
\cite{n1,n2,n3}            % sortert og komprimert: ¹⁻³
```

Plassering: rett etter ordet, ikke etter tegnsetting.

### Ligninger

```latex
\begin{equation}
  E = mc^2.
  \label{eq:einstein}
\end{equation}
% Referer med \eqref{eq:einstein}
```

### Figurer

```latex
\begin{figure}[t]
  \centering
  \includegraphics[width=0.8\linewidth]{filnavn}
  \caption{Figurtekst.}
  \label{fig:etikett}
\end{figure}
```

### Tabeller

Bruk `booktabs` (\toprule, \midrule, \bottomrule) — unngå
vertikale streker.

## Matematikk

Motorbyttet erstatter den gamle stabelen `amsmath` + `amssymb` + `bm` med
`unicode-math`. Hva det betyr i praksis:

| I stedet for | Bruk | Hvorfor |
|---|---|---|
| `\bm{v}`, `\boldsymbol{v}` | `\symbf{v}`, `\symbfit`, `\symbfup` | `bm` er inkompatibel med `unicode-math`: stille ikke-fet på latinske bokstaver, hard feil på gresk |
| `\boldmath` | `\symbf` | STIX Two Math har ingen fet vekt, så `\boldmath` setter matte i vanlig vekt |
| `\usepackage{amssymb}` | ingenting | `unicode-math` leverer symbolene; lastes begge, brekker bygget (`\eth already defined`) |
| `\vec`, `\overrightarrow` | `\usepackage[e]{esvect}`, `\vv{F}` | samlingens vektorkonvensjon, om et dokument vil ha piler |

`\symbf` henter STIX Two sine tegnede fete Unicode-alfabeter fra samme
fontfil, og virker derfor på gresk så vel som latinsk. Matte inne i en fet
overskrift står i vanlig vekt — det følger av fonten og er ingen feil.

Mer generelt: dette er et `unicode-math`-dokument kompilert med LuaLaTeX.
Mattepakker skrevet for pdflatex kan fungere eller ikke, og lista over er
ikke uttømmende. `physics2`, `tensor`, `esvect` og `siunitx` er verifisert.

`mathtools` lastes bevisst **ikke**. Den virker under LuaLaTeX, men å laste
den får `unicode-math` til å melde fra om to kommandoer den overtar, og å
dempe det krever maskineri stilfila ikke har noe med å bære. Det den
tilbyr har native eller bedre vedlikeholdte ekvivalenter:

| `mathtools` | Bruk i stedet |
|---|---|
| `\DeclarePairedDelimiter` | `physics2` med modulen `ab.legacy` — `\abs`, `\abs*`, `\norm`, `\eval` |
| `\prescript` | `tensor` — `\tensor*[^{14}_{6}]{C}{}` |
| `\dcases` | `cases` med `\displaystyle` i hver rad |
| `\coloneqq`, `\eqqcolon` | `\coloneq`, `\eqcolon`, `\Coloneq` — `unicode-math` sine egne, enkelt q |
| `\overbracket` | `\overbrace` |

Alle fem verifisert under `unicode-math`. Vil du ha `mathtools` likevel,
last den **over** stilfila — det unngår rekkefølge-advarselen, men de to
`unicode-math`-meldingene består:

```latex
\usepackage{mathtools}
\usepackage{bokstil}
```


## Typografi

- **Tekst:** Garamond Libre, 12 pt
- **Matematikk:** STIX Two Math med `Scale=0.90`
- **Motor:** LuaLaTeX (`unicode-math`, OpenType)
- **Sideoppsett:** B5 (trykk) eller A4 (utkast), via `\documentclass`
- **Satsbredde:** 120 mm — 2,36 lilleboksalfabeter, innenfor Bringhursts
  vindu på 1,8–2,4
- **Marger:** innside 2,4 cm, utside 3,2 cm, topp 2,6 cm, bunn 3,9 cm
- **Linjeavstand:** 1,02 (baseline 14,79 pt = 5,20 mm)
- **Avsnitt:** innrykk 1,25 em, ikke linjeskift
- **Mikrotypografi:** protrusion, expansion, tracking aktivert
- **Seksjoner:** unummererte, men i innholdsfortegnelse
- **Siteringer:** superskript-tall, plassert nøyaktig der de står
- **Bibliografi:** `1.` istedenfor `[1]`, sortert i siteringsrekkefølge

### Hvorfor utsidemargen er den brede

De to innsidemargene møtes over ryggen og leses som ett rom; ytterkanten
er der tommelen ligger. Derfor utside > innside, som i klassisk bokarbeid.
2,4 cm innside klarer likevel en limbinding.

Den romslige ytterkanten gjør nytte to ganger: den er også plassen en
overdimensjonert ligning kan henge ut i når et kapittel trenger det.

### Hvorfor 12 pt, og hvorfor kjegla er som den er

Punktstørrelse er her optisk, ikke nominell. Garamond Libres x-høyde er
0,407 em mot Times' 0,473, så den leser mindre enn punktstørrelsen tilsier:

| Garamond Libre | x-høyde | tilsvarer optisk |
|----------------|---------|------------------|
| 11 pt          | 4,48 pt | Times 9,47 pt    |
| 12 pt          | 4,88 pt | Times 10,33 pt   |

CUP-monografier ligger rundt 10–10,5 pt Times, så 12 pt treffer innenfor
og 11 pt faller under. 11 pt ville dessuten tvunget satsbredden ned mot
112 mm for å holde seg i alfabetvinduet, på bekostning av ligningsbredde.

Kjegla følger av samme sammenligning. En CUP-side satt Times 10,5/13 har
3,28 pt ren luft mellom én linjes underlengder og neste linjes
overlengder; Garamond Libre ved 12 pt trenger baseline 14,79 pt for å gi
det samme. Forholdet baseline/x-høyde havner likevel på 3,03 mot CUPs
2,62 — siden leser en anelse mer åpen enn en Times-satt bok. Den resten er
fonten selv, lite øye og lange lengder, og å lukke den ville drevet
underlengdene opp i linja over.

### Matteskalering

STIX Two Math er tegnet mot STIX Two *Text*, hvis x-høyde den matcher med
1,013. Garamond Libre har lavere x-høyde, så en streng match ville tilsagt
`Scale=0.86`. Malen bruker 0,90 — 6 % over — bevisst: viste uttrykk står
isolert og bærer indekser som trenger luft. Over 0,95 begynner matten å
rage over prosaen.

Skaleringen betyr mest i tensornotasjon. STIX Two Math krymper en
indeks-i-indeks til 55 % (mot 50 % for de fleste alternativene) og har
større glyffer i utgangspunktet, og det er forskjellen på lesbar og
uleselig i `R^ρ{}_σμν`.

## Endre papirstørrelse

```latex
\documentclass[12pt,twoside,b5paper]{book}   % trykk
\documentclass[12pt,twoside,a4paper]{book}   % utkast
```

Det er **satsbredden** som holdes konstant mellom de to, ikke margene:
begge gir en sats på 120 mm, så et A4-utkast brekker linjer nøyaktig som
den trykte B5-en, med 4 cm igjen til notater. Sidebrudd blir likevel
ulike — A4 er høyere.

## BibTeX-kilder

- **Google Scholar** → Cite → BibTeX
- **Inspire-HEP** (inspirehep.net) — for fysikk
- **arXiv** → Export Citation → BibTeX
