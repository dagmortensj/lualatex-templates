# essay-mal

LaTeX-mal for et essay på A4: tittel, navn og dato øverst på første
side, løpende tekst i fast linjegrid, unummererte overskrifter,
tekstbrudd, blokksitater og fotnoter. Bygger på `bok-fiksjon`, med
samme skrift og samme grid. Settes med **LuaLaTeX** i Garamond Libre.

## Filer

| Fil              | Beskrivelse                                 |
|------------------|---------------------------------------------|
| `main.tex`       | Utgangspunktet — tittel, navn, dato og tekst |
| `essaystil.sty`  | All formatering; endres sjelden             |

## Kom i gang

1. Kopier hele mappen til et nytt prosjekt
2. Åpne `main.tex` og fyll inn tittel, navn og dato
3. Bytt ut plassholderteksten med din egen
4. Kompiler med **lualatex**, ikke pdflatex:

```
latexmk -lualatex main
```

## Tittel, navn og dato

```latex
\title{Essayets tittel}
\subtitle{En undertittel}   % valgfri
\author{Navn Navnesen}
\date{\today}

\begin{document}
\maketitle
```

`\maketitle` setter tittelen øverst på første side, midtstilt: tittelen
i kapiteler i 20,7 pt på første linje, en kursiv undertittel to linjer
under om den er satt, navnet tre linjer under det og datoen i kursiv på
linja etter. Teksten begynner fire linjer under datoen, på niende linje
når tittelen står på én linje og det ikke er noen undertittel.

- **`\date{\today}`** gir dagens dato på norsk, «19. november 2026».
  Skriv en fast dato i stedet om essayet skal leveres med en bestemt
  dato.
- **`\date{}`** eller **`\author{}`** gir ingen linje for datoen eller
  navnet, og det som følger flytter seg opp.
- **Lange titler** brytes på inntil 80 % av satsbredden, uten orddeling.
  Med `\\` i tittelen bestemmer du selv hvor den brytes. Tittelen har
  halvannen linjes linjeavstand, og navnet begynner på første hele
  linje i gridet under den.

Tittelen og navnet går inn i PDF-ens metadata.

## Å skrive teksten

```latex
Første avsnitt. Det får ikke innrykk.

Neste avsnitt får innrykk.

\overskrift{En overskrift}

Første avsnitt etter overskriften, uten innrykk.

\tekstbrudd

Første avsnitt etter bruddet, igjen uten innrykk.
```

- **`\overskrift{Tittel}`** gir en unummerert overskrift i kapiteler,
  midtstilt, med én blank linje over og teksten på linja rett under.
  Rett etter tittelen eller en annen overskrift faller den blanke linja
  bort. Overskriften blir ikke stående alene nederst på en side med
  mindre enn to tekstlinjer under seg. Overskriftene står som bokmerker
  i PDF-en.
- **`\tekstbrudd`** gir én blank linje, og neste avsnitt uten innrykk,
  som `\scenebrudd` i `bok-fiksjon`. Faller bruddet nederst på en side,
  står siden med en tom linje til slutt; faller det helt øverst,
  forsvinner det.
- **Blokksitater** settes med `quote` (eller `quotation`), rykket inn
  2,5 em fra begge kanter, i samme skriftstørrelse som teksten og med én
  blank linje over og under. Uten blank linje etter `\end{quote}` i
  kilden fortsetter avsnittet uten innrykk.
- **Lister** (`itemize`, `enumerate`) står også i gridet, uten luft
  mellom punktene.
- **Fotnoter** med `\footnote{...}` står nederst på siden i 10/13 bp,
  også når siden er kort. Fotnotetallet i teksten er et ekte hevet tall
  fra fonten.

## Kommandoer

```latex
\title{...}                % Tittel
\subtitle{...}             % Undertittel, valgfri
\author{...}               % Navn
\date{...}                 % Dato
\maketitle                 % Tittel, navn og dato øverst på første side
\overskrift{Tittel}        % Unummerert overskrift
\tekstbrudd                % Blank linje mellom to deler av teksten
```

Malen har ingen pakkeopsjoner.

## Typografi

- **Skrift:** Garamond Libre, 12/16 bp, minuskeltall i teksten
- **Motor:** LuaLaTeX (`fontspec`, OpenType)
- **Format:** A4, ensidig
- **Satsflate:** 120 mm bred, 40 linjer i fast grid, rundt 70 tegn per
  linje
- **Marger:** 45 mm på hver side; toppen av satsflata 30 mm under
  arkets overkant, første grunnlinje 35,6 mm
- **Avsnitt:** justert, innrykk 1 gefirt, ingen luft mellom avsnitt
- **Tittel:** kapiteler i 20,7 pt med 24 bp linjeavstand; undertittel i
  kursiv, \large; navn og dato i brødtekststørrelse, datoen kursiv
- **Overskrifter:** kapiteler i brødtekststørrelse, midtstilt
- **Fotnoter:** 10/13 bp, nederst på siden
- **Sidetall:** midtstilt, to linjer under siste tekstlinje, på alle
  sider
- **Mikrotypografi:** protrusion, expansion og sperring av kapiteler

### Fast grid

Linjeavstanden er 16 bp overalt i teksten, og alt annet på siden er målt
i hele linjer: tittelblokken, overskriftene, tekstbruddene og sitatene.
Fotnotene står utenfor gridet; teksten over dem blir én eller flere hele
linjer kortere. Sidene strekkes ikke. En side har 40 linjer, med to
unntak: siste side slutter der teksten slutter, og en side blir én linje
kortere når siste linje i et avsnitt ellers ville stått alene øverst på
neste side.

### Hvorfor 120 mm

Garamond Libre i 12 bp gir rundt 70 tegn over 120 mm, omtrent det
lengste som leses godt i én spalte. En bredere satsflate ville gitt
smalere marger, men linjer som er tyngre å følge. De brede margene gir
plass til kommentarer når essayet skal leses av noen andre.

## Matematikk

Stilen laster ikke `unicode-math` og har ingen matematikkfont. Trenger
teksten en formel, last `unicode-math` i `main.tex` og velg en
matematikkfont der.
