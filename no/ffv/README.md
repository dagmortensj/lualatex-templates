# artikkel-template

Tokolonne LaTeX-artikkelmal for norskspråklige, essayistiske
fysikk- og matematikkartikler. Settes med **LuaLaTeX** — STIX Two
til både tekst og matematikk.

## Filer

| Fil               | Beskrivelse                                      |
|-------------------|--------------------------------------------------|
| `main.tex`        | Utgangspunktet — fyll inn tittel og innhold      |
| `ffvstil.sty`     | All formatering; trenger sjelden endres          |
| `referanser.bib`  | BibTeX-referanser; legg til dine egne her        |

## Kom i gang

1. Kopier hele mappen til et nytt prosjekt
2. Åpne `main.tex` og fyll inn tittel, forfatter og tekst
3. Legg referanser inn i `referanser.bib`
4. Kompiler med **lualatex**, ikke pdflatex:

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

## Nyttige kommandoer

### Siteringer
```latex
\cite{nokkel}            % [1]
\cite{nokkel1,nokkel2}   % [1,2]
```

### Ligninger
```latex
\begin{equation}
  E = mc^2.
  \label{eq:einstein}
\end{equation}
% Referer med \eqref{eq:einstein}
```

### Figurer i én kolonne
```latex
\begin{figure}[t]
  \centering
  \includegraphics[width=\linewidth]{filnavn}
  \caption{Figurtekst.}
  \label{fig:etikett}
\end{figure}
```

### Figurer over begge kolonner
```latex
\begin{figure*}[t]
  \centering
  \includegraphics[width=0.9\linewidth]{filnavn}
  \caption{Bred figurtekst.}
  \label{fig:bred}
\end{figure*}
```

Merk: `figure*` flyter bare til topp eller bunn av sider.

### Tabeller
Bruk `booktabs` (\toprule, \midrule, \bottomrule) — unngå
vertikale streker.

```latex
\begin{table}[t]
  \centering
  \caption{Tabelltekst.}
  \label{tab:etikett}
  \begin{tabular}{lcr}
    \toprule
    Kolonne 1 & Kolonne 2 & Kolonne 3 \\
    \midrule
    ...
    \bottomrule
  \end{tabular}
\end{table}
```

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
\usepackage{ffvstil}
```


## Typografi

- **Tekst og matematikk:** STIX Two, 10 pt, via `unicode-math`
- **Motor:** LuaLaTeX (OpenType)
- **Referanser:** nummererte i siteringsrekkefølge (`unsrtnat`)
- **Avsnitt:** innrykk, ikke linjeskift
- **Språk:** norsk orddeling og tegnsetting via `babel`
- **Tabeller:** booktabs-stil uten vertikale streker
- **Figurer:** figurtekst i small med fet etikett

## BibTeX-kilder

- **Google Scholar** → Cite → BibTeX
- **Inspire-HEP** (inspirehep.net) — for fysikk
- **arXiv** → Export Citation → BibTeX
