# notat-mal

LaTeX-mal for langformede notater i teoretisk fysikk og matematikk.
CUP-inspirert boktypografi i artikkelformat, med teorem- og
oppgaveomgivelser, en JHEP-aktig innrammet innholdsfortegnelse, og
nummererte siteringer.

## Filer

| Fil               | Beskrivelse                                |
|-------------------|--------------------------------------------|
| `main.tex`        | Utgangspunktet — innholdet skrives her     |
| `notatstil.sty`   | All formatering; endres sjelden            |
| `referanser.bib`  | BibTeX-referanser; legg til dine egne her  |
| `figurer/`        | Mappe for figurer; lastes automatisk       |

## Kom i gang

1. Kopier hele mappen til et nytt prosjekt
2. Åpne `main.tex` og fyll inn tittel, forfatter, sammendrag
3. Legg referanser inn i `referanser.bib`
4. Kompiler med **lualatex**, ikke pdflatex:

```
latexmk -lualatex main
```

Eller for hånd:

```
lualatex main
biber    main
lualatex main
lualatex main
```

Motoren er ikke valgfri. Malen laster NewComputerModern som OpenType-font
gjennom `unicode-math`, og det kan ikke pdflatex bruke.

## Nyttige kommandoer

### Siteringer

```latex
\cite{nokkel}              % [1]
\cite{n1,n2,n3}            % [1-3] (sortert og komprimert)
```

### Innholdsfortegnelse

```latex
\framedtoc
```

Setter innholdsfortegnelsen med en linje over og under
(JHEP-stil), uten punktledere. I malen ligger den på egen side,
mellom forsiden og brødteksten. Vanlig `\tableofcontents`
fungerer fortsatt om du heller vil ha en uinnrammet liste.

### Teoremomgivelser

```latex
\begin{teorem}
  Formuleringen av teoremet.
\end{teorem}

\begin{definisjon}
  Definisjonstekst.
\end{definisjon}

\begin{merknad}
  En merknad.
\end{merknad}
```

Alle tre deler én teller knyttet til seksjonen,
f.eks. Teorem 2.1, Definisjon 2.2, Merknad 2.3.

### Bokser: viktig og hovedresultat

```latex
\begin{viktig}
\begin{definisjon}
  ...
\end{definisjon}
\end{viktig}

\begin{hovedresultat}[Gravitasjonsloven]   % tittelen kan sløyfes
\begin{teorem}
  ...
\end{teorem}
\end{hovedresultat}
```

`viktig` setter tynne mørkerøde linjer over og under innholdet —
til viktige definisjoner. `hovedresultat` setter en hårfin ramme
rundt dokumentets sentrale resultat; med valgfritt argument står
tittelen i sperrede kapiteler brutt inn i den øvre rammelinjen,
uten står rammen ren. Begge er omslag rundt de vanlige
omgivelsene: nummereringen fortsetter i samme rekke som ellers,
og boksene er brytbare over sideskift. Bruk dem sparsomt —
bokses alt, er boksen ikke lenger et signal.

### Oppgaver

```latex
\begin{oppgave}
Oppgavetekst.

\begin{deloppgaver}
  \item Første deloppgave.
  \item Andre deloppgave.
\end{deloppgaver}
\end{oppgave}
```

Oppgaver nummereres per seksjon (f.eks. Oppgave 4.1, 4.2),
uavhengig av teoremtelleren, og bruker fete bokstavetiketter
for deloppgaver (a, b, c), med samme innrykk som vanlige
lister. `deloppgaver`-omgivelsen lar vanlige `enumerate`-lister
være urørt.

Oppgavene settes i full bredde, uten innrykk, skilt fra
prosaen av luft: 4,5 ex før og 6,75 ex etter. Mindre rom før
binder oppgaven til innledningen sin; større rom etter
markerer at den er ferdig. To oppgaver på rad deler den
største avstanden — luften stables aldri.

Bruk `\begin{deloppgaver}[resume]` for å fortsette samme
bokstavsekvens etter forklarende tekst mellom deloppgaver.

### Python-kode

```latex
\begin{python}
import numpy as np

def f(x):
    return np.sin(x)   # eksempelfunksjon

print(f(np.pi / 2))
\end{python}
```

Setter Python-kode med Gruvbox Light syntaksutheving: fargede
nøkkelord, strenger, kommentarer og linjenummer på en varm kremfarget
bakgrunn, rammet opp og ned. UTF-8 er aktivert, så norske tegn
(æ, ø, å) fungerer i den omgivende teksten og i kodekommentarer.

### Separator

```latex
\separator
```

En tynn mørkerød linje med vertikalt mellomrom på begge sider.
Bruk mellom innholdsblokker — etter en oppgave, mellom
eksempler, eller ved temaskifter innen en seksjon. Den kan
kalles hvor som helst i den vanlige tekstflyten.

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

### TikZ-figurer

TikZ lastes fra pakkeblokken i `main.tex`, ikke fra `notatstil.sty`
— fjern `\usepackage{tikz}`-linjen der om et dokument ikke trenger
native figurer.

Stilfilen definerer tre navngitte farger med faste roller:

| Farge        | RGB          | Rolle                                                          |
|--------------|--------------|----------------------------------------------------------------|
| `darkorange` | 184, 92, 0   | Primær figuraksent: streker, noder, søyler                     |
| `darkolive`  | 74, 107, 18  | Sekundær figuraksent: kurver, fyll                             |
| `darkred`    | 120, 20, 20  | Reservert — hyperlenker og separatorlinje; ikke til figurer    |

Svart og grå er tilgjengelig for akser, vegger og sekundære etiketter.
Typisk bruk:

```latex
\draw[very thick, darkorange] (0,0) -- (2,0);
\node[circle, fill=darkorange, inner sep=1.4pt] at (1,0) {};
\fill[darkorange!12] (0,0) rectangle (2,1);
\draw[darkolive, thick, domain=0:3, samples=60]
    plot (\x, {sin(deg(\x))});
\draw[->, darkolive!75] (0,0) -- (1,1);
```

### Tabeller

Bruk `booktabs` (\toprule, \midrule, \bottomrule) — unngå
vertikale streker.

## Matematikk

Dette er `unicode-math`-dokumenter. Kommer du fra et pdflatex-preamble,
er det tre vaner som må endres:

| I stedet for | Bruk | Hvorfor |
|---|---|---|
| `\bm{v}`, `\boldsymbol{v}` | `\symbf{v}`, `\symbfit`, `\symbfup` | `bm` er inkompatibel med `unicode-math`: stille ikke-fet på latinske bokstaver, hard feil på gresk |
| `\boldmath` | `\symbf` | NewCM Math har ingen fet vekt, så `\boldmath` setter matte i vanlig vekt |
| `\usepackage{amssymb}` | ingenting | `unicode-math` leverer symbolene; lastes begge, brekker bygget (`\eth already defined`) |

`\symbf` når NewCM Math sine tegnede fete Unicode-alfabeter i samme
fontfil, og det er derfor den virker på gresk der `\bm` ikke gjør det.

Tabellen er ikke uttømmende. En mattepakke skrevet for pdflatex kan
fungere eller ikke — de fire malen laster for deg er verifisert, likeså
`listings` og `tikz`.

### Pakker malen laster

| Pakke | Til | Eksempel |
|---|---|---|
| `esvect` | vektorer | `$\vv{F} = m\vv{a}$`, `$\vv{AB}$` |
| `siunitx` | enheter og tall | `\qty{9.81}{\metre\per\second\squared}`, `\num{6.022e23}`, `\qtyrange{10}{20}{\kilo\metre}` |
| `tensor` | indekserte tensorer | `$\tensor{R}{^\rho_\sigma_\mu_\nu}$`, `$\tensor*[^{14}_{6}]{C}{}$` |
| `physics2` (`braket`) | bra-ket | `$\bra{\psi}$`, `$\ket{\phi}$`, `$\braket{\psi}{\phi}$` |

Alle fire er verifisert under `unicode-math` med LuaLaTeX, og til sammen
koster de rundt 50 ms i byggetid — altså målestøy.

`siunitx` er satt opp norsk i `main.tex`: desimalkomma, «til» i
`\qtyrange`, «og» i `\qtylist`, og `m/s^2` framfor `m s^-2`. Endre
`\sisetup`-blokka om du vil ha noe annet.

Den gamle `physics`-pakka brukes ikke her — den er uten vedlikehold og
skrevet for pdflatex-tida. Den virker riktignok sammen med `siunitx` om du
legger til `\AtBeginDocument{\RenewCommandCopy\qty\SI}`, mot én
`siunitx`-advarsel, men `physics2` dekker det samme uten. Last flere av
modulene (`ab.legacy`, `nabla.legacy`, `op.legacy`, `diagmat`, `xmat`, …) ved behov.

`physics2` har ingen deriverte, med vilje. Lag dine egne — under
`unicode-math` er oppreist d `\symup{d}`:

```latex
\newcommand{\dd}{\symup{d}}
\newcommand{\dv}[2]{\frac{\dd #1}{\dd #2}}
\newcommand{\pdv}[2]{\frac{\partial #1}{\partial #2}}
```

Pakka `derivative` er et fyldigere ferdiglaget alternativ om du vil ha ett.

`esvect` trenger en fontfiks under `unicode-math`: pakkas egen
fontdefinisjon lister bare eksakte størrelser, mens `unicode-math` ber om
brøkne mattestørrelser, og uten den blir pilene i subskript rundt 9 % for
små — med advarsel. Det er samme fiks som forfatteren av `overarrows`
senere tok inn upstream. Fiksen bor i stilfila, vaktet med
`\IfPackageLoadedTF`, så `main.tex` bare laster pakka.

### mathtools

Lastes bevisst ikke. Den kjører under LuaLaTeX, men å laste den får
`unicode-math` til å melde fra om to kommandoer den overtar, og å dempe
det krever maskineri en stilfil ikke har noe med å bære. Alt den tilbyr
har en ekvivalent som er native eller bedre vedlikeholdt:

| `mathtools` | Bruk i stedet |
|---|---|
| `\DeclarePairedDelimiter` | `physics2` med modulen `ab.legacy` — `\abs`, `\abs*`, `\norm`, `\eval` |
| `\prescript` | `tensor` — `\tensor*[^{14}_{6}]{C}{}` |
| `\dcases` | `cases` med `\displaystyle` i hver rad |
| `\coloneqq`, `\eqqcolon` | `\coloneq`, `\eqcolon`, `\Coloneq` — `unicode-math` sine egne, enkelt q |
| `\overbracket` | `\overbrace` |

Alle fem verifisert. Vil du ha `mathtools` likevel, last den *over*
stilfila — `\usepackage{mathtools}` og så `\usepackage{notatstil}`. Det
unngår pakkas egen rekkefølge-advarsel; de to `unicode-math`-meldingene
består, og dem får du leve med.

## Typografi

- **Skrift:** NewComputerModern (Book-vekt), tekst og matematikk
- **Motor:** LuaLaTeX (`unicode-math`, OpenType)
- **Sideoppsett:** A4, symmetriske marger (3,0 cm hele veien rundt)
- **Satsbredde:** 150 mm — 3,06 lilleboksalfabeter, bredere enn
  Bringhursts vindu på 1,8–2,4; kjegla kompenserer
- **Linjeavstand:** 1,07
- **Avsnitt:** innrykk, ikke linjeskift
- **Mikrotypografi:** protrusion, expansion, tracking aktivert
- **Seksjoner:** nummererte, fete overskrifter
- **Underunderseksjoner:** stille run-in-overskrift, holdt utenfor innholdsfortegnelsen
- **Siteringer:** numeriske i hakeparenteser, sortert og komprimert
- **Bibliografi:** biblatex `numeric-comp` med biber (i siteringsrekkefølge)
- **Hyperlenker:** mørkerød, trygt for trykk
- **Innholdsfortegnelse:** JHEP-stil, rammet av vannrette linjer

## Legge til flere teoremomgivelser

```latex
\theoremstyle{plain}
\newtheorem{lemma}[teorem]{Lemma}
\newtheorem{proposisjon}[teorem]{Proposisjon}

\theoremstyle{definition}
\newtheorem{eksempel}[teorem]{Eksempel}
```

`[teorem]`-argumentet betyr at den nye omgivelsen deler
samme teller som teorem — holder nummereringen sammenhengende
gjennom hele dokumentet.

## BibTeX-kilder

- **Google Scholar** → Cite → BibTeX
- **Inspire-HEP** (inspirehep.net) — for fysikk
- **arXiv** → Export Citation → BibTeX
