# dikt-mal

LaTeX-mal for en diktsamling: ett dikt per side, valgfri tittel,
forstoff og innhold. Settes med **LuaLaTeX** i Garamond Libre.

## Filer

| Fil            | Beskrivelse                                 |
|----------------|---------------------------------------------|
| `main.tex`     | Utgangspunktet — forstoff og dikt           |
| `diktstil.sty` | All formatering; endres sjelden             |

## Kom i gang

1. Kopier hele mappen til et nytt prosjekt
2. Åpne `main.tex` og fyll inn tittel, forfatter og kolofon
3. Bytt ut plassholderdiktene med dine egne
4. Kompiler med **lualatex**, ikke pdflatex:

```
latexmk -lualatex main
```

## Å skrive et dikt

```latex
\begin{dikt}[Tittel]
Hver linje i kilden er en linje i diktet.
En lang linje brytes av seg selv og får hengende innrykk.

En blank linje gir ny strofe.
    Mellomrom først på linja rykker den inn.
\end{dikt}
```

- **Tittelen er valgfri.** `\begin{dikt}` uten klammer gir et dikt uten
  tittel. Det begynner der tittelen ellers ville stått, og står i
  innholdet med første linje i kursiv.
- **Linjeskift** i kilden er linjeskift i diktet. `\\` trengs ikke.
- **Lange linjer** brytes når de er bredere enn satsflata (omtrent 60
  tegn), og fortsettelsen rykkes inn 3 em.
- **Strofer** skilles med en blank linje. Flere blanke linjer gir ikke
  mer luft.
- **Innrykk:** hvert mellomrom først på linja er 0,5 em; et
  tabulatortegn teller som fire. Mellomrom inne i linja beholdes, så
  tre mellomrom gir tre ordmellomrom.
- **Lange dikt** fortsetter på neste side og deles mellom to strofer,
  ikke inne i en.

Inne i et dikt er linjeslutt og mellomrom aktive tegn. To følger av
det: et `%` sist på en linje spiser linjeskiftet, og lengder med
mellomrom i (`1em plus 2pt`) kan ikke skrives der.

## Kommandoer

```latex
\halftitlepage             % Smusstittel (kommentert ut i main.tex)
\booktitlepage             % Tittelside (\title, \subtitle, \author, \date)
\colophonpage{...}         % Kolofon på baksiden av tittelsiden
\dedicationpage{...}       % Dedikasjon
\del{I}                    % Delside, høyreside med blank bakside
\poemtoc                   % Innhold
```

Alle er valgfrie og uavhengige av hverandre: slett eller kommenter ut
linjene du ikke trenger i `main.tex`, så holder sidefallet seg riktig.
Uten `\del` kommer diktene fortløpende.

`\poemtoc` står sist i forstoffet i `main.tex`. Flytt kommandoen til
slutten av fila om du vil ha innholdet bakerst.

Malen har ingen omslagsside. Et omslag med rygg og bakside avhenger av
trykkeriet og sidetallet, og lages som en egen PDF.

## Pakkeopsjoner

| Opsjon      | Virkning |
|-------------|----------|
| ingen       | 140 × 216 mm, til trykk. `main.tex` har `hefte` slått på fra start |
| `a5`        | A5, til egen utskrift. Samme satsflate, så linje- og sidebrudd er identiske med 140 × 216 mm |
| `hefte`     | Blanke sider til slutt til sidetallet er delelig med fire, så et falset og stiftet hefte får en blank bakside. Skriv ut med hefteutskrift i utskriftsdialogen |
| `sentrert`  | Hvert dikt midtstilt etter sin lengste linje; linjene er fortsatt venstrestilte. Trenger to bygg, som latexmk tar av seg selv |
| `korrektur` | Siden uendret, sentrert på A4 med skjæremerker |

Opsjonene kan kombineres: `\usepackage[a5,hefte]{diktstil}`.

## Typografi

- **Skrift:** Garamond Libre, 12/16 pt
- **Motor:** LuaLaTeX (`fontspec`, OpenType)
- **Format:** 140 × 216 mm, eller A5 med `a5`
- **Satsflate:** 98 × 162 mm, 29 linjer, lik i begge formater
- **Marger, 140 × 216:** innside 22 mm, utside 20 mm, topp 24 mm, bunn 30 mm
- **Marger, A5:** innside 26 mm, utside 24 mm, topp 21 mm, bunn 27 mm
- **Dikt:** venstrestilt, tittel i kursiv på fjerde linje i satsflata,
  første linje på sjette
- **Sidetall:** midtstilt nederst; forstoff, innhold og delsider uten
- **Mikrotypografi:** protrusion og sperring av kapiteler; ingen
  expansion

### Hvorfor 12 pt

Garamond Libre har lite øye (x-høyde 0,407 em), så 12 pt leser som
Times i omtrent 10,3 pt. 11 pt tilsvarer 9,5 pt og blir smått på en
bokside. Linjeavstanden på 16 pt er romsligere enn bokmalens,
siden dikt leses linje for linje.

### Hvorfor disse margene

140 × 216 mm (5,5 × 8,5 tommer) er det vanlige formatet for
diktsamlinger. Satsbredden er valgt for den lengste linja, ikke for
lesbarhet i løpende tekst. Innsida er litt bredere enn utsida: diktene
står venstrestilt, så høyre del av satsflata er som regel luft, og
innsida trenger sitt til limfresing.

## Matematikk

Stilen laster ikke `unicode-math` og har ingen matematikkfont. Trenger
et dikt en formel, last `unicode-math` i `main.tex` og velg en
matematikkfont der.
