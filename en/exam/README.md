# exam template

LaTeX template for tests in physics and mathematics at upper
secondary level. Derived from the handout template and stripped
of what a test does not need (theorems, boxes), with what it does
need added: a title block with fields for name, date, time and
aids, Part 1 / Part 2 the way the Norwegian exams are split, and
"Page 2 of 5" at the foot of every page.

## Files

| File            | Description                                  |
|-----------------|----------------------------------------------|
| `main.tex`      | The starting point — the exercises go here   |
| `examstyle.sty` | All formatting; rarely changed               |
| `figures/`      | Put figures here; `\graphicspath` points to it |

## Getting started

1. Copy the whole folder into a new project
2. Open `main.tex` and fill in the metadata and exercises
3. Compile with **lualatex**, not pdflatex:

```
latexmk -lualatex main
```

`latexmk` is not just convenience here: "Page 2 of 5" takes the
total from the previous run (a label in `.aux`), so the document
needs two passes.

## Title block

```latex
\title{Physics 1 Test}
\subtitle{Chapters 3 and 4: Forces and motion}
\date{Thursday 15 October 2026}
\duration{90 minutes}
\aids{Part 1: none. Part 2: all, except communication}
% \namelabel{Candidate number}   % default is "Name"
\maketitle
```

Title and subtitle in sans, left-aligned. Below them four fields:
Name (an open line to write on), Date, Time and Aids. An empty
field is shown as empty — it is easier to see that something is
missing than that something was left out. `\shownamefieldfalse`
in the preamble removes the name line, for a test submitted
digitally.

## Cover page, booklet, or neither

```latex
\usepackage[coverpage]{examstyle}   % full-day test, two parts
\usepackage[booklet]{examstyle}     % the same, for duplex printing and folding
\usepackage{examstyle}              % smaller test
```

With `[coverpage]` the title block gets a page of its own without
a page number, and everything between `\maketitle` and the first
`\exampart` — instructions, mark allocation — stays there. The
first `\exampart` — or the first exercise, if the test has no
parts — closes the cover and begins on "Page 1 of N", so N counts
only the exercise pages. Should the cover run over several pages,
all of them are unnumbered. Without the option the title block
sits at the top of page 1 with the exercises straight below, as
a smaller test wants.

`[booklet]` turns on `[coverpage]` and adds what duplex printing
needs: a blank back on the cover, so Part 1 begins on a right-hand
page; every later `\exampart` on a right-hand page (a blank page
is inserted when needed, so Part 2 starts on a fresh sheet and
can be separated from Part 1); and blank pages at the end until
the page count is divisible by 4, as a folded booklet requires. A
page inserted between the parts carries a page number like the
others, so "Page 2 of 4" shows nothing is missing; the blank
pages at the end sit outside the count, like the cover. Do not
use it for a test printed single-sided.

## Status check

```latex
\usepackage[statuscheck]{examstyle}
...
\title{Status check, Mathematics R2}
\subtitle{Differentiation}
\date{Monday 5 October 2026}
\maketitle

\level{1}
\begin{exercise} ... \end{exercise}
\level{2}
...
```

For a status check rather than a test: the title block becomes
title, subtitle and date — no name line, time or aids
(`\duration` and `\aids` are ignored), and no rule below; the one
under the first `\level` takes over. `\level` is `\exampart` with
the word "Level": the same heading, the same spacing, an optional
subline in brackets — plus a thin dark-red rule underneath, so
the levels read as blocks. The exercises count flat across the
levels as elsewhere.

## Part 1 and Part 2

```latex
\exampart[Without aids]{1}
...
\clearpage
\exampart[With aids]{2}
```

`\exampart{1}` without the optional argument gives just "Part 1".
The command does not break the page itself (apart from the cover
break above) — `\clearpage` before Part 2 if Part 1 is to be
handed in separately.

The exercises count flat through the whole test, Exercise 1, 2,
3, continuing across the part boundary. A smaller test without
parts simply omits `\exampart`; the numbering is the same. To
restart Part 2 at Exercise 1: `\setcounter{exerciseinner}{0}`
right after `\exampart`.

## Exercises

```latex
\begin{exercise}[Incline \points{4}]
Exercise text.

\begin{subproblems}
  \item First subproblem.
  \item Second subproblem.
\end{subproblems}
\end{exercise}
```

The same environment as in the handout and notes templates, so
an exercise can be moved here unchanged. The head is set in bold
sans one step up — "Exercise 3 – Title" — and the body in roman.
`\points{4}` sets "(4 points)" in grey and belongs at the end of
the title; leave it out if the test does not state points.
`\begin{subproblems}[resume]` continues the letter sequence after
intervening text.

## Python code

```latex
\begin{python}
for i in range(3):
    print(i)   # comment with æ, ø, å
\end{python}
```

For programming exercises. Line numbers make it possible to ask
about "line 7". Keep comments short enough that no line wraps —
if one does, the numbering shifts.

## Other

- `\separator` — a short dark-red rule with air around it, for a
  change of topic or before a closing instruction
- `[indent]` as a package option brings back paragraph
  indentation instead of space between paragraphs; combines with
  the others
- `esvect` (`\vv{F}`), `siunitx` and `tikz` are loaded from
  `main.tex`; remove what is not needed. Indices belong outside
  the arrow: `\vv{F}_1`, not `\vv{F_1}` — otherwise the arrow
  spans the index too

## Mathematics

This is a `unicode-math` document: `\symbf` instead of `\bm`, no
`amssymb`, no `mathtools`. See the handout template's `README.md`
for the table of what has been verified and what replaces what.

## Typography

- **Typeface:** NewComputerModern Book, text and mathematics;
  NewComputerModern Sans (Book) for the title, parts and exercise
  heads — the same family, the same x-height, no extra font
- **Size:** 12 pt — one step above the handout, because a test is
  read quickly, under pressure, and often as a copy
- **Engine:** LuaLaTeX (`unicode-math`, OpenType)
- **Page layout:** A4, 3.0 cm margins; 150 mm measure
  (2.8 lowercase alphabets at 12 pt)
- **Leading:** 1.04
- **Paragraphs:** space (half a baseline), not indentation
- **Page numbers:** "Page 2 of 5" centred at the foot, page 1
  included; the cover (with `[coverpage]`) sits outside the count
- **Headings:** "Part 1" in `\Large` bold sans, subline in regular
  sans below; exercise heads in `\large` bold sans
- **Colours:** dark-red rule under the title block and in
  `\separator`; `darkorange` and `darkolive` for figures, as in
  the rest of the family
- **No hyperref:** a test is printed; references are set in
  black. If links are needed, load `hyperref` last in `main.tex`
