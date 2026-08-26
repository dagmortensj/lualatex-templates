# article-template

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
\usepackage{ffvstyle}
```


## Typography

- **Text and mathematics:** STIX Two, 10 pt, via `unicode-math`
- **Engine:** LuaLaTeX (OpenType)
- **References:** numbered in citation order (`unsrtnat`)
- **Paragraphs:** indented, no line break
- **Language:** English hyphenation and punctuation via `babel`
- **Tables:** booktabs style without vertical lines
- **Figures:** caption in small with bold label

## BibTeX sources

- **Google Scholar** → Cite → BibTeX
- **Inspire-HEP** (inspirehep.net) — for physics
- **arXiv** → Export Citation → BibTeX
