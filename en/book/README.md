# book-template

LaTeX book template in CUP style with superscript citations.
Typeset with **LuaLaTeX** — Garamond Libre for text, STIX Two Math
for mathematics.

## Files

| File                   | Description                                    |
|------------------------|------------------------------------------------|
| `main.tex`             | Starting point — structure and content         |
| `bookstyle.sty`        | All formatting; frozen, rarely changed         |
| `references.bib`       | BibTeX references; add your own here           |
| `content/chapter1.tex` | Example chapter; copy and create more          |
| `figures/`             | Folder for figures; loaded automatically       |

## Getting started

1. Copy the entire folder to a new project
2. Open `main.tex` and fill in title, author, dedication
3. Write chapters in the `content/` folder and include with `\input{content/...}`
4. Add references to `references.bib`
5. Compile with **lualatex**, not pdflatex:

```
latexmk -lualatex main
```

Or by hand:

```
lualatex main
bibtex   main
lualatex main
lualatex main
```

The engine is not optional. The template loads `unicode-math` and
OpenType fonts, neither of which pdflatex can use.

## Structure

The book is divided into three phases:

| Phase         | Command         | Contents                                         |
|---------------|-----------------|--------------------------------------------------|
| Front matter  | `\frontmatter`  | Title, dedication, TOC, preface, acknowledgments |
| Main matter   | `\mainmatter`   | Introduction, parts and chapters                 |
| Back matter   | `\backmatter`   | Bibliography, index                              |

## Useful commands

### Page templates

```latex
\booktitlepage             % Title page
\dedicationpage{...}       % Dedication (recto, centered italic)
\booktoc                   % Table of contents
\frontchapter{Preface}     % Unnumbered chapter in front matter
```

### Chapter opening with drop cap

```latex
\chapter{Chapter Title}
\chapteropening{T}{he first sentence}
continues here. The opening paragraph must be long enough
to fill the vertical space reserved by the drop cap, otherwise
the next section heading will collide with the drop cap.
```

### Citations

```latex
\cite{key}                 % superscript: ¹
\cite{k1,k2,k3}            % sorted and compressed: ¹⁻³
```

Placement: directly after the word, not after punctuation.

### Equations

```latex
\begin{equation}
  E = mc^2.
  \label{eq:einstein}
\end{equation}
% Reference with \eqref{eq:einstein}
```

### Figures

```latex
\begin{figure}[t]
  \centering
  \includegraphics[width=0.8\linewidth]{filename}
  \caption{Figure caption.}
  \label{fig:label}
\end{figure}
```

### Tables

Use `booktabs` (\toprule, \midrule, \bottomrule) — avoid
vertical lines.

## Mathematics

The engine change swaps the old `amsmath` + `amssymb` + `bm` stack for
`unicode-math`. What that means in practice:

| Instead of | Use | Why |
|---|---|---|
| `\bm{v}`, `\boldsymbol{v}` | `\symbf{v}`, `\symbfit`, `\symbfup` | `bm` is incompatible with `unicode-math`: silently un-bold on Latin letters, a hard error on Greek |
| `\boldmath` | `\symbf` | STIX Two Math has no bold weight, so `\boldmath` sets regular-weight maths |
| `\usepackage{amssymb}` | nothing | `unicode-math` supplies the symbols; loading both breaks the build (`\eth already defined`) |
| `\vec`, `\overrightarrow` | `\usepackage[e]{esvect}`, `\vv{F}` | the collection's vector convention, if a document wants arrows |

`\symbf` selects STIX Two's designed Unicode bold alphabets from the same
font file, so it works for Greek as well as Latin. Maths inside a bold
heading stays regular weight — a consequence of the face, not a fault.

More generally: this is a `unicode-math` document compiled with LuaLaTeX.
Maths packages written for pdflatex may or may not work, and the list
above is not exhaustive. `physics2`, `tensor`, `esvect` and `siunitx` are verified.

`mathtools` is deliberately **not** loaded. It works under LuaLaTeX, but
loading it makes `unicode-math` emit two notices about commands it takes
over, and silencing those needs machinery the style file has no business
carrying. What it offers has native or better-maintained equivalents:

| `mathtools` | Use instead |
|---|---|
| `\DeclarePairedDelimiter` | `physics2` with the `ab.legacy` module — `\abs`, `\abs*`, `\norm`, `\eval` |
| `\prescript` | `tensor` — `\tensor*[^{14}_{6}]{C}{}` |
| `\dcases` | `cases` with `\displaystyle` in each row |
| `\coloneqq`, `\eqqcolon` | `\coloneq`, `\eqcolon`, `\Coloneq` — `unicode-math`'s own, single q |
| `\overbracket` | `\overbrace` |

All five verified under `unicode-math`. If you want `mathtools` anyway,
load it **above** the style file — that avoids its load-order warning,
though the two `unicode-math` notices remain:

```latex
\usepackage{mathtools}
\usepackage{bookstyle}
```


## Typography

- **Text:** Garamond Libre, 12 pt
- **Mathematics:** STIX Two Math at `Scale=0.90`
- **Engine:** LuaLaTeX (`unicode-math`, OpenType)
- **Page size:** B5 (print) or A4 (draft), via `\documentclass`
- **Measure:** 120 mm — 2.36 lowercase alphabets, inside Bringhurst's
  1.8–2.4 window
- **Margins:** inner 2.4 cm, outer 3.2 cm, top 2.6 cm, bottom 3.9 cm
- **Line spacing:** 1.02 (baseline 14.79 pt = 5.20 mm)
- **Paragraphs:** indented 1.25 em, no inter-paragraph skip
- **Microtypography:** protrusion, expansion, tracking enabled
- **Sections:** unnumbered, but appear in TOC
- **Citations:** superscript numbers, placed exactly where written
- **Bibliography:** `1.` instead of `[1]`, sorted by citation order

### Why the outer margin is the wide one

The two inner margins meet over the spine and read as a single space;
the fore-edge is where the thumb goes. So outer > inner, as in
classical book work. 2.4 cm inner still clears a perfect binding.

The generous fore-edge earns its keep twice: it is also the room an
oversized display equation can hang into when a chapter needs it.

### Why 12 pt, and why the leading is what it is

Point size here is optical, not nominal. Garamond Libre's x-height is
0.407 em against Times' 0.473, so it reads smaller than its point size
suggests:

| Garamond Libre | x-height | optically equals |
|----------------|----------|------------------|
| 11 pt          | 4.48 pt  | Times 9.47 pt    |
| 12 pt          | 4.88 pt  | Times 10.33 pt   |

CUP monographs sit around 10–10.5 pt Times, so 12 pt lands in range and
11 pt falls below it. 11 pt would also force the measure down to about
112 mm to stay inside the alphabet window, at the cost of equation
width.

The leading follows from the same comparison. A CUP page set Times
10.5/13 leaves 3.28 pt of clear air between one line's descenders and
the next line's ascenders; Garamond Libre at 12 pt needs baseline
14.79 pt to leave the same. Its baseline-to-x-height ratio still comes
out at 3.03 against CUP's 2.62 — the page reads a shade more open than
a Times-set book. That residue is the face itself, small eye and long
extenders, and closing it would drive descenders into the line above.

### Maths scaling

STIX Two Math is drawn against STIX Two *Text*, whose x-height it
matches at 1.013. Garamond Libre has a lower x-height, so a strict
match would call for `Scale=0.86`. The template uses 0.90 — 6 % above
— deliberately: displayed expressions stand alone and carry indices
that need air. Above 0.95 the maths starts to tower over the prose.

The scale matters most in tensor notation. STIX Two Math shrinks a
sub-subscript to 55 % (against 50 % for most alternatives) and has
larger glyphs to begin with, which is the difference between legible
and unreadable in `R^ρ{}_σμν`.

## Changing paper size

```latex
\documentclass[12pt,twoside,b5paper]{book}   % print
\documentclass[12pt,twoside,a4paper]{book}   % draft
```

The **measure** is held constant across the two, not the margins:
both give a 120 mm text block, so an A4 draft breaks lines exactly as
the printed B5 will, with 4 cm left over for notes. Page breaks still
differ — A4 is taller.

## BibTeX sources

- **Google Scholar** → Cite → BibTeX
- **Inspire-HEP** (inspirehep.net) — for physics
- **arXiv** → Export Citation → BibTeX
