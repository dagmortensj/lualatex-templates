# formelark-mal

LaTeX-mal for formelark og konstanttabeller til fysikk og
matematikk. Ett A4-ark i stående format, brettet på tvers i
midten: øvre halvdel konstanter, nedre halvdel formler, hver
halvdel i to spalter. Brettet én gang blir arket et liggende
A5-ark med konstantene på den ene siden og formlene på den
andre. Overskrifter i sans med mørkerød strek og tabeller med
tallene i rett kant.

## Filer

| Fil                 | Beskrivelse                                |
|---------------------|--------------------------------------------|
| `main.tex`          | Utgangspunktet — innholdet skrives her     |
| `formelarkstil.sty` | All formatering; endres sjelden            |

Eksempelinnholdet i `main.tex` er et komplett formelark til
Fysikk 1.

## Kom i gang

1. Kopier hele mappen til et nytt prosjekt
2. Åpne `main.tex` og bytt ut innholdet
3. Kompiler:

```
latexmk -lualatex main
```

Stilen laster babel og siunitx selv. Trenger arket vektorpiler,
last `esvect` i pakkeblokken i `main.tex` — eksemplet gjør det.

## Oppbygning

```latex
\begin{halvdel}{Fysikk 1}{Konstanter}
  ... to spalter ...
\end{halvdel}

\begin{halvdel}{Fysikk 1}{Formler}
  ... to spalter ...
\end{halvdel}
```

Dokumentet settes som liggende A5-sider, og `pgfpages` legger
to og to av dem oppå hverandre på et A4-ark. Hver halvdel er én
slik side: en tittellinje øverst over full bredde, to spalter
under, og sideskift til slutt. Venstre spalte fylles helt før
høyre begynner; tving et spaltebytte med `\columnbreak` der et
tema ellers deles på et dumt sted, og gi fortsettelsen en egen
overskrift, f.eks. `\gruppe{Trykk og temperatur (forts.)}`. En
overskrift blir aldri stående alene nederst i en spalte.

Er det for mye innhold, blir det en side 3 — altså et nytt
A4-ark — og det ser du på sidetallet, som ellers i LaTeX.
Stilen sier også fra i loggen. Kutt, flytt et spaltebytte,
eller bruk `[tett]` og `\small` (under).

## Nyttige kommandoer

### Overskrifter

```latex
\gruppe{Bevegelse og krefter}
```

Ett nivå: temaoverskrift i sans, fet, mørkerød, med tynn strek
under.

### Konstanter

```latex
\begin{konstanter}
Plancks konstant   & $h$ & \qty{6.63e-34}{J.s} \\
Lysfarten i vakuum & $c$ & \qty{3.00e8}{m/s} \\
\end{konstanter}
```

Tre kolonner: navn, symbol, verdi. Symbol og verdi står inn mot
likhetstegnet, så tallene får en rett kant. Navnet brytes om ved
behov. For tabeller der navnet er nok — masser, planetdata —
finnes en tokolonneversjon:

```latex
\begin{tabellto}
Masse        & \qty{5.972e24}{kg} \\
Middelradius & \qty{6371}{km} \\
\end{tabellto}
```

Tall og enheter skrives med siunitx (`\qty`, `\num`); stilen
setter desimalkomma, halvhøy prikk i standardform og skråstrek
i enheter.

### Formler

```latex
\begin{formler}
$v = at + v_0$ & $s = \dfrac{v + v_0}{2}\,t$ & $v^2 - v_0^2 = 2as$ \\
\end{formler}

\begin{formlerto}
$\mathit{COP} = \dfrac{Q}{E}$ & $\mathit{COP}_{\text{Carnot}} = \dfrac{T_1}{T_1 - T_2}$ \\
\end{formlerto}

\formelrad{$m_A v_A + m_B v_B = m_A v_{A0} + m_B v_{B0}$}
```

Tre eller to kolonner med formler, venstrestilt, med luften
fordelt jevnt mellom kolonnene; en formel brytes aldri. Tomme
celler er lov. `\formelrad` gir én formel hele bredden.

To rader med brøker rett over hverandre kan trenge litt ekstra
luft: skriv `\\[3pt]` etter den første. Enklere er ofte å
stokke om, så en rad med brøker etterfølges av en uten.

### Når det ikke er plass

```latex
\usepackage[tett]{formelarkstil}

\begin{halvdel}[\small]{Fysikk 2}{Formler}
```

`[tett]` krymper radavstanden i formeltabellene (fra 1,62 til
1,45) og luften over overskriftene. Det valgfrie argumentet til
`halvdel` setter skriftstørrelsen for den halvdelen alene — sett
`\small` på den som er full, og la den andre stå i 10 pt.
Radavstanden kan også settes direkte:
`\renewcommand{\formelstrekk}{1.5}` i `main.tex`.

## Typografi

- **Font:** NewComputerModern Book (OpenType, unicode-math)
- **Sideoppsett:** liggende A5-sider med 8 mm marg, to på hvert
  A4-ark (`pgfpages`, «2 on 1»); satsflate 194 × 132,5 mm per side,
  16 mm luft ved bretten; to spalter på 93 mm
- **Brettemerker:** korte grå streker i venstre og høyre kant
  ved 148,5 mm
- **Overskrifter:** ett nivå, sans, fet, mørkerød, tynn strek under
- **Tabeller:** `tabcolsep` 3 pt, `arraystretch` 1,12 i
  konstanttabellene og 1,62 i formeltabellene
- **Sidetall:** ingen
