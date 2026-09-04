# ffv-template

Two-column LaTeX article template for English-language, essayistic
physics and mathematics articles. Typeset with **LuaLaTeX** — STIX Two
for both text and mathematics.

## Files

| File              | Description                                      |
|-------------------|--------------------------------------------------|
| `main.tex`        | Starting point — fill in title and content       |
| `ffvstyle.sty`    | All formatting; rarely needs changing            |
| `references.bib`  | BibTeX references; add your own here             |

## Getting started

1. Copy the entire folder to a new project
2. Open `main.tex` and fill in title, author, and text
3. Add references to `references.bib`
4. Compile with **lualatex**, not pdflatex:

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

## Useful commands

### Citations
```latex
\cite{key}             % [1]
\cite{key1,key2}       % [1,2]
```

### Equations
```latex
\begin{equation}
  E = mc^2.
  \label{eq:einstein}
\end{equation}
% Reference with \eqref{eq:einstein}
```

### Single-column figures
```latex
\begin{figure}[t]
  \centering
  \includegraphics[width=\linewidth]{filename}
  \caption{Figure caption.}
  \label{fig:label}
\end{figure}
```

### Figures spanning both columns
```latex
\begin{figure*}[t]
  \centering
  \includegraphics[width=0.9\linewidth]{filename}
  \caption{Wide figure caption.}
  \label{fig:wide}
\end{figure*}
```

Note: `figure*` floats only to the top or bottom of pages.

### Tables
Use `booktabs` (\toprule, \midrule, \bottomrule) — avoid
vertical lines.

```latex
\begin{table}[t]
  \centering
  \caption{Table caption.}
  \label{tab:label}
  \begin{tabular}{lcr}
    \toprule
    Column 1 & Column 2 & Column 3 \\
    \midrule
    ...
    \bottomrule
  \end{tabular}
\end{table}
```

## Mathematics

These are `unicode-math` documents. If you are arriving from a pdflatex
preamble, three habits have to change:

| Instead of | Use | Why |
|---|---|---|
| `\bm{v}`, `\boldsymbol{v}` | `\symbf{v}`, `\symbfit`, `\symbfup` | `bm` is incompatible with `unicode-math`: silently un-bold on Latin letters, a hard error on Greek |
| `\boldmath` | `\symbf` | STIX Two Math has no bold weight, so `\boldmath` sets regular-weight maths |
| `\usepackage{amssymb}` | nothing | `unicode-math` supplies the symbols; loading both breaks the build (`\eth already defined`) |
| `\vec`, `\overrightarrow` | `\usepackage[e]{esvect}`, `\vv{F}` | the collection's vector convention, if a document wants arrows |

`\symbf` reaches STIX Two's drawn Unicode bold alphabets in the same font
file, which is why it works on Greek where `\bm` does not. Maths inside a
bold heading stays regular weight: the face has no bold maths, and that
is the face, not a fault.

The table is not exhaustive. A maths package written for pdflatex may or
may not work here — `esvect`, `siunitx`, `tensor` and `physics2` are
verified.

### mathtools

Not loaded, deliberately. It runs under LuaLaTeX, but loading it makes
`unicode-math` report two commands it takes over, and quieting that needs
machinery a style file has no business carrying. Everything it offers has
an equivalent that is native or better maintained:

| `mathtools` | Use instead |
|---|---|
| `\DeclarePairedDelimiter` | `physics2` with the `ab.legacy` module — `\abs`, `\abs*`, `\norm`, `\eval` |
| `\prescript` | `tensor` — `\tensor*[^{14}_{6}]{C}{}` |
| `\dcases` | `cases` with `\displaystyle` in each row |
| `\coloneqq`, `\eqqcolon` | `\coloneq`, `\eqcolon`, `\Coloneq` — `unicode-math`'s own, single q |
| `\overbracket` | `\overbrace` |

All five verified. If you want `mathtools` regardless, load it *above*
the style file — `\usepackage{mathtools}` then `\usepackage{ffvstyle}`.
That avoids its own load-order warning; the two `unicode-math` notices
remain, and they are yours to live with.

## Typography

- **Text and mathematics:** STIX Two, 10 pt, via `unicode-math`
- **Engine:** LuaLaTeX (OpenType)
- **References:** numbered in citation order (`unsrtnat`)
- **Paragraphs:** indented, no line break
- **Align rows:** `\jot` = 8 pt (default 3 pt) — more air between the
  rows of `align`, shared by all the templates
- **Language:** English hyphenation and punctuation via `babel`
- **Tables:** booktabs style without vertical lines
- **Figures:** caption in small with bold label

## BibTeX sources

- **Google Scholar** → Cite → BibTeX
- **Inspire-HEP** (inspirehep.net) — for physics
- **arXiv** → Export Citation → BibTeX
