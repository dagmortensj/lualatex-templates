# handout-mal

LaTeX-mal for fysikk- og matematikknotater og oppgavesett.
Rolig, klassisk typografi med teorem- og oppgaveomgivelser,
delte deloppgaver med bokstaver, og mørkerøde separatorlinjer.

## Filer

| Fil               | Beskrivelse                                |
|-------------------|--------------------------------------------|
| `main.tex`        | Utgangspunktet — innholdet skrives her     |
| `handoutstyle.sty`| All formatering; endres sjelden            |
| `figurer/`        | Mappe for figurer; lastes automatisk       |

## Kom i gang

1. Kopier hele mappen til et nytt prosjekt
2. Åpne `main.tex` og fyll inn tittel, dato, innhold
3. Kompiler med **lualatex**, ikke pdflatex:

```
latexmk -lualatex main
```

Eller for hånd:

```
lualatex main
lualatex main
```

Motoren er ikke valgfri. Malen laster NewComputerModern som OpenType-font
gjennom `unicode-math`, og det kan ikke pdflatex bruke.

(Ingen bibliografi som standard — handouts og oppgavesett
trenger sjelden det. Legg til `natbib` og en `.bib`-fil
hvis du noen gang skulle trenge det.)

## Nyttige kommandoer

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

Oppgaver nummereres per seksjon (f.eks. Oppgave 2.1, 2.2)
og bruker magre bokstavetiketter for deloppgaver (a, b, c),
med samme innrykk som vanlige lister. `deloppgaver`-omgivelsen
lar vanlige `enumerate`-lister være urørt til vanlig bruk.

Oppgavene settes i full bredde, uten innrykk, skilt fra
prosaen av luft: 4,5 ex før og 6,75 ex etter. Mindre rom før
binder oppgaven til innledningen sin; større rom etter
markerer at den er ferdig. To oppgaver på rad deler den
største avstanden — luften stables aldri.

Bruk `\begin{deloppgaver}[resume]` for å fortsette samme
bokstavsekvens etter forklarende tekst mellom deloppgaver.

### Unummerert modus

```latex
\usepackage[unummerert]{handoutstyle}
```

For en handout som handler om én ting: seksjonsoverskriftene
mister nummeret sitt, og oppgaver og teoremer telles flatt
gjennom hele dokumentet — Oppgave 1, 2, 3 og Teorem 1, 2, 3 i
stedet for 1.1, 1.2. Alt annet (fonter, luft, overskriftsstil)
er uendret. Uten valget oppfører malen seg som før.

### Blokkavsnitt

```latex
\usepackage[blokkavsnitt]{handoutstyle}
```

Avsnitt skilt med luft i stedet for innrykk: en halv grunnlinje
mellom dem, og ingen innrykk. Passer en handout som er mest
oppgaver og korte instrukser. Tittelblokka og oppgavehodet
holder samme avstander som ellers. Valgene kan kombineres:
`[unummerert,blokkavsnitt]`. Ikke last `parskip`-pakka i
tillegg — valget gjør jobben.

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
f.eks. Teorem 1.1, Definisjon 1.2, Merknad 1.3.

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

En tynn mørkerød linje med vertikalt mellomrom på begge
sider. Bruk mellom innholdsblokker — etter en oppgave,
mellom eksempler, eller ved temaskifter innen en seksjon.

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

TikZ lastes fra pakkeblokken i `main.tex`, ikke fra `handoutstyle.sty`
— fjern `\usepackage{tikz}`-linjen der om et dokument ikke trenger
native figurer.

Stilfilen definerer tre navngitte farger med faste roller:

| Farge        | RGB          | Rolle                                                             |
|--------------|--------------|-------------------------------------------------------------------|
| `darkorange` | 184, 92, 0   | Primær figuraksent: streker, noder, søyler                        |
| `darkolive`  | 74, 107, 18  | Sekundær figuraksent: kurver, fyll                                |
| `darkred`    | 120, 20, 20  | Reservert — fotnotelinje og strukturaksenter; ikke til figurer    |

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

`siunitx` settes opp norsk av stilfila i det øyeblikket pakka lastes:
desimalkomma, halvhøy prikk i standardform (`6,63 · 10^-34`, ikke kryss),
«til» i `\qtyrange`, «og» i `\qtylist`, og `m/s^2` framfor `m s^-2`. En
`\sisetup` i `main.tex` overstyrer om du vil ha noe annet.

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
stilfila — `\usepackage{mathtools}` og så `\usepackage{handoutstyle}`. Det
unngår pakkas egen rekkefølge-advarsel; de to `unicode-math`-meldingene
består, og dem får du leve med.

## Typografi

- **Skrift:** NewComputerModern (Book-vekt), tekst og matematikk
- **Motor:** LuaLaTeX (`unicode-math`, OpenType)
- **Sideoppsett:** A4, symmetriske marger (3,0 cm hele veien rundt)
- **Satsbredde:** 150 mm — 3,06 lilleboksalfabeter, bredere enn
  Bringhursts vindu på 1,8–2,4; kjegla kompenserer
- **Linjeavstand:** 1,04
- **Align-rader:** `\jot` = 8 pt (standard er 3 pt) — mer luft mellom
  radene i `align`, felles for alle malene
- **Avsnitt:** innrykk, ikke linjeskift — eller luft (en halv
  grunnlinje) i stedet for innrykk med `[blokkavsnitt]`
- **Mikrotypografi:** protrusion, expansion, tracking aktivert
- **Overskrifter:** to nivåer, fete — seksjon (`\large`), underseksjon
  (kroppsstørrelse). Ingen displaystørrelser og ingen streker; nivå to
  gjør at samme stil kan bære forelesningsnotater
- **Tittelblokk:** kapiteler, sperret, sentrert
- **Hyperlenker og linjer:** mørkerøde, trygt for trykk
