# formulasheet template

LaTeX template for formula sheets and tables of constants in
physics and mathematics. One A4 sheet in portrait, folded across
the middle: upper half constants, lower half formulas, each half
in two columns. Folded once, the sheet becomes a landscape A5
with the constants on one side and the formulas on the other.
Sans headings with a dark red rule and tables with the numbers in
a straight edge.

## Files

| File                    | Description                                |
|-------------------------|--------------------------------------------|
| `main.tex`              | The starting point — content goes here     |
| `formulasheetstyle.sty` | All formatting; rarely edited              |

The example content in `main.tex` is a complete formula sheet
for Physics 1.

## Getting started

1. Copy the whole folder into a new project
2. Open `main.tex` and replace the content
3. Compile:

```
latexmk -lualatex main
```

The style loads babel and siunitx itself. If the sheet needs
vector arrows, load `esvect` in the package block of `main.tex`
— the example does.

## Structure

```latex
\begin{half}{Physics 1}{Constants}
  ... two columns ...
\end{half}

\begin{half}{Physics 1}{Formulas}
  ... two columns ...
\end{half}
```

The document is set as landscape A5 pages, and `pgfpages` stacks
them two by two on an A4 sheet. Each half is one such page: a
title line at the top across the full width, two columns below,
and a page break at the end. The left column is filled completely
before the right one starts; force a column break with
`\columnbreak` where a topic would otherwise be split in a bad
place, and give the continuation its own heading, e.g.
`\topic{Pressure and temperature (cont.)}`. A heading is never
left alone at the bottom of a column.

If there is too much content, there is a page 3 — a second A4
sheet — and you see it in the page count, as anywhere else in
LaTeX. The style also says so in the log. Cut, move a column
break, or use `[tight]` and `\small` (below).

## Useful commands

### Headings

```latex
\topic{Motion and forces}
```

One level: a topic heading in sans, bold, dark red, with a thin
rule below.

### Constants

```latex
\begin{constants}
Planck's constant        & $h$ & \qty{6.63e-34}{J.s} \\
Speed of light in vacuum & $c$ & \qty{3.00e8}{m/s} \\
\end{constants}
```

Three columns: name, symbol, value. Symbol and value sit against
the equals sign, so the numbers get a straight edge. The name
wraps when needed. For tables where the name is enough — masses,
planetary data — there is a two-column version:

```latex
\begin{twocol}
Mass        & \qty{5.972e24}{kg} \\
Mean radius & \qty{6371}{km} \\
\end{twocol}
```

Numbers and units are written with siunitx (`\qty`, `\num`); the
style sets a slash in units.

### Formulas

```latex
\begin{formulas}
$v = at + v_0$ & $s = \dfrac{v + v_0}{2}\,t$ & $v^2 - v_0^2 = 2as$ \\
\end{formulas}

\begin{formulastwo}
$\mathit{COP} = \dfrac{Q}{E}$ & $\mathit{COP}_{\text{Carnot}} = \dfrac{T_1}{T_1 - T_2}$ \\
\end{formulastwo}

\formularow{$m_A v_A + m_B v_B = m_A v_{A0} + m_B v_{B0}$}
```

Three or two columns of formulas, left-aligned, with the space
shared evenly between the columns; a formula is never broken.
Empty cells are allowed. `\formularow` gives one formula the
full width.

Two rows of fractions right above each other may need a little
extra space: write `\\[3pt]` after the first. Often it is simpler
to reorder, so a row with fractions is followed by one without.

### When there is no room

```latex
\usepackage[tight]{formulasheetstyle}

\begin{half}[\small]{Physics 2}{Formulas}
```

`[tight]` shrinks the row spacing in the formula tables (from
1.62 to 1.45) and the space above headings. The optional argument
of `half` sets the font size for that half alone — put `\small`
on the one that is full, and leave the other at 10 pt. The row
spacing can also be set directly:
`\renewcommand{\formulastretch}{1.5}` in `main.tex`.

## Typography

- **Font:** NewComputerModern Book (OpenType, unicode-math)
- **Page layout:** landscape A5 pages with an 8 mm margin, two per
  A4 sheet (`pgfpages`, "2 on 1"); text area 194 × 132.5 mm per page,
  16 mm of space at the fold; two 93 mm columns
- **Fold marks:** short grey lines at the left and right edges
  at 148.5 mm
- **Headings:** one level, sans, bold, dark red, thin rule below
- **Tables:** `tabcolsep` 3 pt, `arraystretch` 1.12 in the
  constants tables and 1.62 in the formula tables
- **Page numbers:** none
