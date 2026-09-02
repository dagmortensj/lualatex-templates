# handout-template

LaTeX template for physics and mathematics handouts and problem sheets.
Calm, classic typography with theorem and exercise environments, lettered
subproblems, and dark red separator rules.

## Files

| File              | Description                                |
|-------------------|--------------------------------------------|
| `main.tex`        | Starting point — content lives here        |
| `handoutstyle.sty`| All formatting; rarely changed             |
| `figures/`        | Folder for figures; loaded automatically   |

## Getting started

1. Copy the entire folder to a new project
2. Open `main.tex` and fill in title, date, content
3. Compile with **lualatex**, not pdflatex:

```
latexmk -lualatex main
```

Or by hand:

```
lualatex main
lualatex main
```

The engine is not optional. The template loads NewComputerModern as an
OpenType font through `unicode-math`, which pdflatex cannot use.

(No bibliography by default — handouts and problem sheets
typically don't need one. Add `natbib` and a `.bib` file
if you ever do.)

## Useful commands

### Exercises

```latex
\begin{exercise}
Prompt for the exercise.

\begin{subproblems}
  \item First subproblem.
  \item Second subproblem.
\end{subproblems}
\end{exercise}
```

Exercises are numbered per section (e.g. Exercise 2.1, 2.2)
and use bold letter labels for subproblems (a, b, c), with
the same indent as ordinary lists. The `subproblems`
environment leaves ordinary `enumerate` lists untouched for
normal use.

Exercises are set at full width, without indentation,
separated from the prose by space: 4.5ex before and 6.75ex
after. Less room before ties the exercise to its lead-in;
more room after marks it as finished. Two consecutive
exercises share the larger distance — space never stacks.

Use `\begin{subproblems}[resume]` to continue the same letter
sequence after explanatory prose between subproblems.

### Unnumbered mode

```latex
\usepackage[unnumbered]{handoutstyle}
```

For a handout about a single topic: the section headings lose
their numbers, and exercises and theorems count flat through
the whole document — Exercise 1, 2, 3 and Theorem 1, 2, 3
instead of 1.1, 1.2. Everything else (fonts, spacing, heading
style) is unchanged. Without the option the template behaves
as before.

### Block paragraphs

```latex
\usepackage[blockparagraphs]{handoutstyle}
```

Paragraphs separated by space instead of indentation: half a
baseline between them, and no indent. Suits a handout that is
mostly exercises and short instructions. The title block and
the exercise head keep the same distances as otherwise. The
options combine: `[unnumbered,blockparagraphs]`. Do not load
the `parskip` package as well — the option does the job.

### Theorem-like environments

```latex
\begin{theorem}
  Statement of the theorem.
\end{theorem}

\begin{definition}
  Definition text.
\end{definition}

\begin{remark}
  A remark.
\end{remark}
```

All three share a single counter scoped to the section,
e.g. Theorem 1.1, Definition 1.2, Remark 1.3.

### Boxes: important and mainresult

```latex
\begin{important}
\begin{definition}
  ...
\end{definition}
\end{important}

\begin{mainresult}[Law of gravitation]   % title can be omitted
\begin{theorem}
  ...
\end{theorem}
\end{mainresult}
```

`important` sets thin dark red rules above and below the content —
for important definitions. `mainresult` sets a hairline frame
around the document's central result; with the optional argument
the title sits in letterspaced small caps breaking the top frame
rule, without it the frame stands clean. Both are wrappers around
the ordinary environments: numbering continues in the same
sequence as elsewhere, and the boxes break across pages. Use them
sparingly — box everything and the box is no longer a signal.

### Python code

```latex
\begin{python}
import numpy as np

def f(x):
    return np.sin(x)   # example function

print(f(np.pi / 2))
\end{python}
```

Typesets Python with Gruvbox Light syntax highlighting: coloured
keywords, strings, comments, and line numbers on a warm cream background,
framed top and bottom. UTF-8 input is enabled, so Norwegian characters
(æ, ø, å) work in surrounding text and in code comments.

### Separator

```latex
\separator
```

A thin dark red rule with vertical space on either side.
Use between content blocks — after an exercise, between
examples, or at a topic shift within a section.

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

### TikZ figures

TikZ is loaded from the custom packages block in `main.tex`, not from
`handoutstyle.sty` — remove the `\usepackage{tikz}` line there if a
document does not need native figures.

The style file defines three named colors. Their roles are fixed:

| Color        | RGB          | Role                                                         |
|--------------|--------------|--------------------------------------------------------------|
| `darkorange` | 184, 92, 0   | Primary figure accent: strokes, nodes, bars                  |
| `darkolive`  | 74, 107, 18  | Secondary figure accent: curves, fills                       |
| `darkred`    | 120, 20, 20  | Reserved — footnote rule and structural accents; not for figures |

Black and gray are available for axes, walls, and secondary labels.
Typical usage:

```latex
\draw[very thick, darkorange] (0,0) -- (2,0);
\node[circle, fill=darkorange, inner sep=1.4pt] at (1,0) {};
\fill[darkorange!12] (0,0) rectangle (2,1);
\draw[darkolive, thick, domain=0:3, samples=60]
    plot (\x, {sin(deg(\x))});
\draw[->, darkolive!75] (0,0) -- (1,1);
```

## Mathematics

These are `unicode-math` documents. If you are arriving from a pdflatex
preamble, three habits have to change:

| Instead of | Use | Why |
|---|---|---|
| `\bm{v}`, `\boldsymbol{v}` | `\symbf{v}`, `\symbfit`, `\symbfup` | `bm` is incompatible with `unicode-math`: silently un-bold on Latin letters, a hard error on Greek |
| `\boldmath` | `\symbf` | NewCM Math has no bold weight, so `\boldmath` sets regular-weight maths |
| `\usepackage{amssymb}` | nothing | `unicode-math` supplies the symbols; loading both breaks the build (`\eth already defined`) |

`\symbf` reaches NewCM Math's drawn Unicode bold alphabets in the same
font file, which is why it works on Greek where `\bm` does not.

The table is not exhaustive. A maths package written for pdflatex may or
may not work here — the four the template loads for you are verified, as
are `listings` and `tikz`.

### Packages the template loads

| Package | For | Example |
|---|---|---|
| `esvect` | vectors | `$\vv{F} = m\vv{a}$`, `$\vv{AB}$` |
| `siunitx` | units and numbers | `\qty{9.81}{\metre\per\second\squared}`, `\num{6.022e23}`, `\qtyrange{10}{20}{\kilo\metre}` |
| `tensor` | indexed tensors | `$\tensor{R}{^\rho_\sigma_\mu_\nu}$`, `$\tensor*[^{14}_{6}]{C}{}$` |
| `physics2` (`braket`) | bra-ket | `$\bra{\psi}$`, `$\ket{\phi}$`, `$\braket{\psi}{\phi}$` |

All four are verified under `unicode-math` with LuaLaTeX, and together they
add about 50 ms to a build — measurement noise.

`siunitx` keeps its English defaults in `main.tex` — decimal point, "to" in
`\qtyrange`, "and" in `\qtylist`. The `\sisetup` block sets only
`per-mode=symbol` (`m/s^2` rather than `m s^-2`) and `separate-uncertainty`.
The Norwegian templates set a decimal comma there instead.

The old `physics` package is not used here — it is unmaintained and written
for the pdflatex era. It does still work alongside `siunitx` if you add
`\AtBeginDocument{\RenewCommandCopy\qty\SI}`, at the cost of one `siunitx`
warning, but `physics2` covers the same ground without it. Add more of its
modules (`ab.legacy`, `nabla.legacy`, `op.legacy`, `diagmat`, `xmat`, …) as needed.

`physics2` has no derivatives, deliberately. Define your own — under
`unicode-math` the upright d is `\symup{d}`:

```latex
\newcommand{\dd}{\symup{d}}
\newcommand{\dv}[2]{\frac{\dd #1}{\dd #2}}
\newcommand{\pdv}[2]{\frac{\partial #1}{\partial #2}}
```

The `derivative` package is a fuller ready-made alternative if you prefer one.

`esvect` needs a font-shape fix under `unicode-math`: the package's own
font definition lists exact sizes only, while `unicode-math` asks for
fractional maths sizes, and without it the arrows in subscripts come out
about 9 % too small with a warning — the same fix the `overarrows` author
later adopted upstream. The fix lives in the style file, guarded by
`\IfPackageLoadedTF`, so `main.tex` just loads the package.

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
the style file — `\usepackage{mathtools}` then `\usepackage{handoutstyle}`.
That avoids its own load-order warning; the two `unicode-math` notices
remain, and they are yours to live with.

## Typography

- **Font:** NewComputerModern (Book weight), text and mathematics
- **Engine:** LuaLaTeX (`unicode-math`, OpenType)
- **Page size:** A4, symmetric margins (3.0 cm all round)
- **Measure:** 150 mm — 3.06 lowercase alphabets, wider than
  Bringhurst's 1.8–2.4 window; the leading compensates
- **Line spacing:** 1.04
- **Paragraphs:** indented, no line break — or space (half a
  baseline) instead of indentation with `[blockparagraphs]`
- **Microtypography:** protrusion, expansion, tracking enabled
- **Headings:** two levels, bold — section (`\large`), subsection (body
  size). No display sizes and no rules; the second level lets the same
  style carry lecture notes
- **Title block:** small caps, letterspaced, centered
- **Hyperlinks and rules:** dark red, print-safe

