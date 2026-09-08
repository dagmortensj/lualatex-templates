# prøve-mal

LaTeX-mal for prøver i fysikk og matematikk på videregående.
Hentet fra handout-malen og strippet for det en prøve ikke
trenger (teoremer, bokser), med det den trenger lagt til:
tittelblokk med felt for navn, dato, tid og hjelpemidler,
Del 1 / Del 2 slik eksamen er delt, og «Side 2 av 5» nederst
på hver side.

## Filer

| Fil             | Beskrivelse                            |
|-----------------|----------------------------------------|
| `main.tex`      | Utgangspunktet — oppgavene skrives her |
| `provestil.sty` | All formatering; endres sjelden        |
| `figurer/`      | Legg figurer her; `\graphicspath` peker dit |

## Kom i gang

1. Kopier hele mappen til et nytt prosjekt
2. Åpne `main.tex` og fyll inn metadata og oppgaver
3. Kompiler med **lualatex**, ikke pdflatex:

```
latexmk -lualatex main
```

`latexmk` er ikke bare bekvemmelighet her: «Side 2 av 5» henter
totalen fra forrige kjøring (et merke i `.aux`), så dokumentet
trenger to runder.

## Tittelblokk

```latex
\title{Prøve i Fysikk 1}
\undertittel{Kapittel 3 og 4: Krefter og bevegelse}
\date{Torsdag 15. oktober 2026}
\tid{90 minutter}
\hjelpemidler{Del 1: ingen. Del 2: alle, unntatt kommunikasjon}
% \navnetikett{Kandidatnummer}   % standard er «Navn»
\maketitle
```

Tittel og undertittel i sans, venstrestilt. Under dem fire felt:
Navn (en åpen linje å skrive på), Dato, Tid og Hjelpemidler.
Et tomt felt vises som tomt — det er lettere å se at noe
mangler enn at noe er utelatt. `\visnavnfeltfalse` i preamblet
tar bort navnelinja, til en prøve som leveres digitalt.

## Forside, hefte eller ingen av delene

```latex
\usepackage[forside]{provestil}   % heldagsprøve, to deler
\usepackage[hefte]{provestil}     % samme, til tosidig utskrift og falsing
\usepackage{provestil}            % mindre prøve
```

Med `[forside]` får tittelblokka en egen side uten sidetall, og
alt som står mellom `\maketitle` og første `\del` — instrukser,
poengfordeling — blir stående der. Første `\del` — eller første
oppgave, om prøven ikke har deler — lukker forsiden og begynner på
«Side 1 av N», så N teller bare oppgavesidene. Går forsiden over
flere sider, står alle uten sidetall.
Uten valget står tittelblokka øverst på side 1 med oppgavene rett
under, slik en mindre prøve vil ha det.

`[hefte]` slår på `[forside]` og legger til det tosidig utskrift
trenger: en tom bakside på forsiden, så Del 1 begynner på en
høyreside; hver senere `\del` på en høyreside (en tom side skytes
inn ved behov, så Del 2 starter på et nytt ark og kan skilles fra
Del 1); og tomme sider til slutt til sidetallet er delelig med 4,
som et falset hefte krever. En side skutt inn mellom delene har
sidetall som de andre, så «Side 2 av 4» viser at ingenting mangler;
de tomme sidene til slutt står utenfor tellingen, som forsiden. Ikke bruk det
på en prøve som skrives ut ensidig.

## Statussjekk

```latex
\usepackage[statussjekk]{provestil}
...
\title{Statussjekk i R2}
\undertittel{Derivasjon}
\date{Mandag 5. oktober 2026}
\maketitle

\nivå{1}
\begin{oppgave} ... \end{oppgave}
\nivå{2}
...
```

Til en statussjekk i stedet for en prøve: tittelblokka blir tittel,
undertittel og dato — ingen navnelinje, tid eller hjelpemidler
(`\tid` og `\hjelpemidler` ignoreres), og ingen linje under; den
under første `\nivå` overtar. `\nivå` er `\del` med ordet
«Nivå»: samme overskrift, samme luft, valgfri undertekst i klammer —
pluss en tynn mørkerød linje under, så nivåene leses som blokker. Oppgavene
telles flatt over nivåene som ellers. Kommandonavnet har å, som er
lovlig under LuaLaTeX.

## Del 1 og Del 2

```latex
\del[Uten hjelpemidler]{1}
...
\clearpage
\del[Med hjelpemidler]{2}
```

`\del{1}` uten valgfritt argument gir bare «Del 1». Kommandoen
setter ikke sideskift selv (utenom forsidebruddet over) —
`\clearpage` foran Del 2 om Del 1 skal leveres inn for seg.

Oppgavene telles flatt gjennom hele prøven, Oppgave 1, 2, 3, og
fortsetter over delskillet. En mindre prøve uten deler sløyfer
`\del` helt; nummereringen blir den samme. Skal Del 2 begynne på
Oppgave 1 igjen: `\setcounter{oppgaveinner}{0}` rett etter `\del`.

## Oppgaver

```latex
\begin{oppgave}[Skråplan \poeng{4}]
Oppgavetekst.

\begin{deloppgaver}
  \item Første deloppgave.
  \item Andre deloppgave.
\end{deloppgaver}
\end{oppgave}
```

Samme omgivelse som i handout- og notat-malen, så en oppgave kan
flyttes hit uendret. Hodet står i fet sans ett steg opp —
«Oppgave 3 – Tittel» — og kroppen i antikva. `\poeng{4}` setter «(4 poeng)» i grått og
hører hjemme bakerst i tittelen; utelat den om prøven ikke oppgir
poeng. `\begin{deloppgaver}[resume]` fortsetter bokstavrekka etter
mellomtekst.

## Flervalg

```latex
Farten i horisontal retning er
\begin{flervalg}
  \item lik null
  \item konstant, men forskjellig fra null
  \item økende
  \item minkende
\end{flervalg}
```

Alternativene får A, B, C, D i sans uten parentes, så de skiller
seg fra deloppgavenes a), b). Lista kan stå rett i oppgaven eller
inne i en deloppgave. Luften mellom alternativene er større enn
mellom deloppgavene — alternativene er ofte brøker og andre
formler som ellers klumper seg. Sideskift er forbudt mellom
spørsmålet og A og mellom alternativene, men tillatt etter det
siste, så A–D holder alltid sammen med spørsmålet sitt.

## Python-kode

```latex
\begin{python}
for i in range(3):
    print(i)   # kommentar med æ, ø, å
\end{python}
```

Til programmeringsoppgaver i R2. Linjenummer gjør det mulig å
spørre om «linje 7». Hold kommentarene korte nok til at ingen
linje brekkes — brekker den, forskyves nummereringen.

## Annet

- `\separator` — kort mørkerød linje med luft rundt, til
  temaskifte eller foran en avsluttende instruks
- `[innrykk]` som pakkevalg henter tilbake avsnittsinnrykk i
  stedet for luft mellom avsnittene; kan kombineres med de andre
- `esvect` (`\vv{F}`), `siunitx` (norsk oppsett fra stilfila)
  og `tikz` lastes fra `main.tex`; fjern det som ikke trengs.
  Indekser hører utenfor pilen: `\vv{F}_1`, ikke `\vv{F_1}` —
  ellers spenner pilen over indeksen også

## Matematikk

Dette er et `unicode-math`-dokument: `\symbf` i stedet for `\bm`,
ingen `amssymb`, ingen `mathtools`. Se handout-malens `README.md`
for tabellen over hva som er verifisert og hva som erstatter hva.

## Typografi

- **Skrift:** NewComputerModern Book, tekst og matematikk;
  NewComputerModern Sans (Book) til tittel, deler og oppgavehoder
  — samme familie, samme x-høyde, ingen ekstra font
- **Størrelse:** 12 pt — ett steg over handout-en, fordi en prøve
  leses fort, under press, og ofte som kopi
- **Motor:** LuaLaTeX (`unicode-math`, OpenType)
- **Sideoppsett:** A4, 3,0 cm marger; satsbredde 150 mm
  (2,8 lilleboksalfabeter ved 12 pt)
- **Linjeavstand:** 1,04
- **Avsnitt:** luft (en halv grunnlinje), ikke innrykk
- **Sidetall:** «Side 2 av 5» sentrert nederst, også på side 1;
  forsiden (med `[forside]`) står utenfor tellingen
- **Overskrifter:** «Del 1» i `\Large` fet sans, undertekst i
  vanlig sans under; oppgavehoder i `\large` fet sans
- **Farger:** mørkerød linje under tittelblokka og i `\separator`;
  `darkorange` og `darkolive` til figurer, som i resten av familien
- **Ingen hyperref:** en prøve er trykt; referanser står i svart.
  Trengs lenker, last `hyperref` sist i `main.tex`
