# bok-fiksjon-mal

LaTeX-mal for en roman, en novellesamling eller en samling kortprosa:
løpende tekst i fast linjegrid, kapitler med stort tall, noveller og
kortprosa med titler, scenebrudd, deler, innholdsfortegnelse og
forstoff. Settes med **LuaLaTeX** i Garamond Libre.

## Filer

| Fil               | Beskrivelse                                 |
|-------------------|---------------------------------------------|
| `main.tex`        | Utgangspunktet — forstoff og tekst          |
| `fiksjonstil.sty` | All formatering; endres sjelden             |

## Kom i gang

1. Kopier hele mappen til et nytt prosjekt
2. Åpne `main.tex` og fyll inn tittel, forfatter og kolofon
3. Bytt ut plassholderteksten med din egen
4. Kompiler med **lualatex**, ikke pdflatex:

```
latexmk -lualatex main
```

## Å skrive teksten

```latex
\kapittel

Første avsnitt i kapittelet. Det får ikke innrykk.

Neste avsnitt får innrykk.

\scenebrudd

Første avsnitt i en ny scene, igjen uten innrykk.

\kapittel[Epilog]

Et kapittel med et ord i stedet for tall.
```

- **`\kapittel`** begynner et nytt kapittel på ny side, høyre eller
  venstre. Tallet står midtstilt i lufta over teksten, og teksten
  begynner elleve linjer ned. Kapitlene nummereres av seg selv.
- **`\kapittel[Prolog]`** gir et unummerert kapittel med ordet som
  tittel der tallet ellers ville stått. Telleren går ikke, så en
  prolog skyver ikke nummereringen.
- **`\scenebrudd`** gir én blank linje, og neste avsnitt uten innrykk.
  Faller bruddet nederst på en side, står siden med en tom linje til
  slutt; faller det helt øverst, forsvinner det.
- **Avsnitt** skilles med en blank linje i kilden, som ellers i LaTeX,
  og får innrykk på én gefirt.

## Novellesamling og kortprosa

```latex
\innhold

\novelle{Sommerhuset}

Første avsnitt i novellen.

\novelle{Det siste toget fra Dombås\\ den vinteren far ble syk}

\kortprosa[Måker]

En kort tekst med tittel.

\kortprosa

En kort tekst uten tittel.
```

- **`\novelle{Tittel}`** begynner på en høyreside, med samme åpning som
  et kapittel: tittelen på femte linje og teksten på tolvte.
- **`\kortprosa[Tittel]`** begynner på en ny side, høyre eller venstre,
  med tittelen på fjerde linje og teksten én tom linje under. Uten
  tittel, **`\kortprosa`**, begynner teksten på fjerde linje. Én tekst
  per side; en lengre tekst fortsetter på neste side som vanlig.
- **Titler** står oppreist i \large, midtstilt, og brytes over flere
  linjer når de er lange, hver linje på neste gridlinje. Med `\\` i
  tittelen bestemmer du selv hvor den brytes. I innholdsfortegnelsen
  og bokmerkene blir `\\` et mellomrom.
- **`\innhold`** setter innholdsfortegnelsen: deler, noveller og
  kortprosa med tittel, med sidetall mot høyre kant og ingen
  punktledere. Kapitler og kortprosa uten tittel står ikke der. Legg
  kommandoen sist i forstoffet eller bakerst i boka, eller utelat den.

`\kapittel`, `\novelle` og `\kortprosa` kan blandes, for eksempel en
lang novelle delt i nummererte kapitler, eller noen korte tekster
mellom de lange. Kapitler inne i en novelle nummereres fra 1 i hver
novelle og står under novellen i bokmerkene.

## Kommandoer

```latex
\halftitlepage             % Smusstittel (kommentert ut i main.tex)
\booktitlepage             % Tittelside (\title, \subtitle, \author, \date)
\colophonpage{...}         % Kolofon på baksiden av tittelsiden
\dedicationpage{...}       % Dedikasjon
\innhold                   % Innholdsfortegnelse (kommentert ut i main.tex)
\del{Første del}           % Delside, høyreside med blank bakside
\kapittel                  % Nytt kapittel, nummerert
\kapittel[Prolog]          % Nytt kapittel med et ord i stedet for tall
\novelle{Tittel}           % Ny novelle, på høyreside
\kortprosa[Tittel]         % Ny kort tekst, tittel valgfri
\scenebrudd                % Blank linje mellom to scener
```

Forstoffet er valgfritt: slett eller kommenter ut linjene du ikke
trenger i `main.tex`, så holder sidefallet seg riktig. Uten `\del`
kommer kapitlene fortløpende. Med `\del` fortsetter kapitteltellingen
gjennom delene.

Kapitler, noveller, kortprosa med tittel og deler står som bokmerker i
PDF-en, også uten `\innhold`. Malen har ingen omslagsside. Et omslag med rygg og
bakside avhenger av trykkeriet og sidetallet, og lages som en egen PDF.

## Pakkeopsjoner

| Opsjon      | Virkning |
|-------------|----------|
| ingen       | 128 × 204 mm, til trykk |
| `hefte`     | Blanke sider til slutt til sidetallet er delelig med fire, så et falset og stiftet hefte får en blank bakside. For en kort tekst: sidene får plass uskalert på hver A5-halvdel av et A4-ark med hefteutskrift i utskriftsdialogen |
| `korrektur` | Siden uendret, sentrert på A4 med skjæremerker. Samme linje- og sidebrudd som trykk, med luft rundt til merknader |

Opsjonene kan kombineres: `\usepackage[korrektur,hefte]{fiksjonstil}`.

Malen har ikke `a5` slik `bok-dikt` har. En roman er for tykk til å
stiftes som A5-hefte, og til korrekturlesing gir `korrektur` den
samme siden med mer plass rundt.

## Typografi

- **Skrift:** Garamond Libre, 11,75/15 bp, minuskeltall i teksten
- **Motor:** LuaLaTeX (`fontspec`, OpenType)
- **Format:** 128 × 204 mm
- **Satsflate:** 97 mm bred, 30 linjer i fast grid
- **Marger:** innside 14 mm, utside 17 mm; toppen av versalene i første
  linje 17 mm under arkets overkant
- **Avsnitt:** justert, innrykk 1 gefirt, ingen luft mellom avsnitt
- **Kapittelstart og novelle:** teksten på tolvte linje, tallet i 17 bp
  med ordinære tall eller tittelen i \large på femte; noveller på
  høyreside
- **Kortprosa og innhold:** tittelen på fjerde linje, teksten én tom
  linje under
- **Delsider:** tittelen i kapiteler i 17,3 pt på tiende linje, så delen står
  litt over kapittelnummeret
- **Tittelside:** forfatteren øverst, tittelen i kapiteler i 20,7 pt, sjangeren
  i kursiv under, forlaget nederst
- **Sidetall:** midtstilt, to linjer under siste tekstlinje (20 mm over
  nederkanten), også på kapittelsider; forstoff og delsider uten
- **Mikrotypografi:** protrusion, expansion og sperring av kapiteler

### Hvor målene kommer fra

Format, marger, kjegle og antall linjer er målt fra en norsk roman satt
i Adobe Garamond 11,75/15. Adobe Garamond er en kommersiell skrift, så
malen bruker Garamond Libre. De to har nesten samme tetthet: en
simulering av linjebrytingen med Garamond Libres metrikker gir rundt 57
tegn per linje over 97 mm, det samme som i forbildet. Punktene er `bp`,
det InDesign bruker, så tallene kan sammenlignes direkte.

### Hvorfor fast grid

Linjeavstanden er 15 bp overalt, og alt annet på siden er målt i hele
linjer: kapittelstarten, scenebruddene og sidetallets plass. Linjene på
to motstående sider står derfor i samme høyde, og linjene på baksiden
av bladet står rett bak linjene på forsiden. Det som skinner gjennom,
skjules av teksten og synes ikke i mellomrommene.

### Sidefall

Sidene strekkes ikke. En side har 30 linjer, med to unntak: siste side
i et kapittel slutter der teksten slutter, og en side blir én linje
kortere når siste linje i et avsnitt ellers ville stått alene øverst
på neste side. Første linje i et avsnitt får stå alene nederst; å
flytte også den ville gitt korte sider langt oftere.

### Tall

Teksten bruker minuskeltall (1984, 2026), som står i linje med de små
bokstavene. Kapitteltallene bruker ordinære tall: et stort enkeltstående
minuskeltall ville hengt under linja for 3, 4, 5, 7 og 9 og ikke for de
andre, og kapittelstartene ville sett ujevne ut.

## Matematikk

Stilen laster ikke `unicode-math` og har ingen matematikkfont. Trenger
teksten en formel, last `unicode-math` i `main.tex` og velg en
matematikkfont der.
