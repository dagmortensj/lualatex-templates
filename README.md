# lualatex-templates

Six LaTeX templates for academic and teaching work — a monograph, a
two-column article, lecture notes, problem sheets, classroom tests,
and a folded formula sheet — each in English and Norwegian. Copy a folder, edit `main.tex`,
compile.

Typeset with **LuaLaTeX** and `unicode-math`, OpenType fonts throughout.
A pdflatex edition lives in
[pdflatex-templates](https://github.com/dagmortensj/pdflatex-templates).

## Templates

English in `en/`, Norwegian in `no/`.

| Template | Format | What it is |
|---|---|---|
| **book** / **bok** | B5 or A4 | A monograph in CUP style: parts, chapters, drop caps, superscript citations |
| **ffv** | A4, two columns | An essayistic physics or mathematics article, numbered citations |
| **notes** / **notat** | A4 | Long-form notes: theorem and exercise environments, emphasis boxes, framed contents, Python listings |
| **handout** | A4 | Problem sheets: exercises with lettered parts, theorem environments, emphasis boxes, Python listings; optional unnumbered mode |
| **exam** / **prove** | A4, 12 pt | Classroom tests: title block with name, date, time and aids; Part 1 / Part 2 or Level 1–3; multiple-choice lists; "Page 2 of 5" on every page; optional cover page and booklet padding for duplex printing |
| **formulasheet** / **formelark** | A4, folded to A5 | A formula sheet: two landscape A5 pages stacked on one sheet — constants above the fold, formulas below, two columns each; fold marks; optional tight mode |

`notes`, `handout` and `exam` share their exercise environments, so a
problem set moves between them unchanged; `book` and `notes` share their
equation spacing, so the two read as a family. `exam` is `handout`
stripped of theorems and boxes and given what a test needs instead; it
is the only one that loads neither `hyperref` nor a bibliography
package, since a test is printed. `formulasheet` is the odd one out:
no prose, no exercises — two landscape A5 pages that `pgfpages` stacks
on one A4 sheet, tables in each, and the same fonts and dark red as
`exam`.

## Fonts and engine

**Compile with `lualatex`, not `pdflatex`.** The fonts are OpenType and
load through `unicode-math`. The wrong engine gives you a wall of errors
rather than a helpful message. Use `latexmk -lualatex`: `notes` and
`book` need biber, and `exam` needs a second pass for "Page 2 of 5".

| Template | Text | Mathematics |
|---|---|---|
| **book** | Garamond Libre, 12 pt | STIX Two Math at `Scale=0.90` |
| **ffv** | STIX Two Text, 10 pt | STIX Two Math |
| **notes** | NewComputerModern Book, 11 pt | NewCM Math Book |
| **handout** | NewComputerModern Book, 11 pt | NewCM Math Book |
| **exam** | NewComputerModern Book, 12 pt; NewCM Sans for headings | NewCM Math Book |
| **formulasheet** | NewComputerModern Book, 10 pt; NewCM Sans for headings | NewCM Math Book |

Three rules follow from `unicode-math` and hold for all six:

- **Bold maths is `\symbf` / `\symbfit` / `\symbfup`**, never `\bm`, which
  is incompatible and hard-errors on Greek. `\boldmath` does not work
  either: neither maths face has a bold weight, so it silently sets
  regular weight.
- **Do not load `amssymb`.** `unicode-math` supplies the symbols, and
  loading both breaks the build.
- **`mathtools` is not loaded.** It runs, but brings two `unicode-math`
  notices with it. `physics2` (module `ab.legacy`) replaces
  `\DeclarePairedDelimiter`, `tensor` replaces `\prescript`, and
  `unicode-math` has its own `\coloneq` / `\eqcolon`.

Those three are not the whole story — a maths package written for
pdflatex may or may not work here. Each template's README carries its own
table of what was checked.

`notes` and `handout` also load `esvect`, `siunitx`, `tensor` and
`physics2` ready to use, for vectors, units, tensor indices and bra-ket;
`exam` loads `esvect` and `siunitx`; `formulasheet` loads `siunitx`
and carries the `esvect` size fix for when `main.tex` loads it.

All twelve build with no warnings.

## Quick start

1. Copy the template folder into a new project
2. Read the copy's own `README.md`
3. Edit `main.tex` — the body is sectioned so you can find your way
4. `latexmk -lualatex main`

Every folder holds `main.tex`, a style file where all the formatting
lives, and its own `README.md`. `book`, `ffv` and `notes` add a `.bib`
with example entries; `book`, `notes` and `handout` add a `figures/`
folder with a stock figure; `formulasheet` ships only `main.tex`, its
style file and `README.md`. The bundled `main.pdf` shows what each one
produces before you compile anything.

`exam` has four package options — none, `[coverpage]`, `[booklet]` and
`[statuscheck]` — for a short test, a full-day test with a cover, the
same laid out for duplex printing and folding, and a levelled status
check. Its `README.md` shows each.

`formulasheet` has one, `[tight]`, for a sheet with more formulas than
10 pt has room for; the half that is full takes `\small` as an
argument. Too much content shows up the way it always does in LaTeX: as
an extra page, here a second A4 sheet.

## Languages

The two versions are functionally equivalent. What differs:

- **Babel** — `[english]` vs `[norsk]`
- **Filenames** — Norwegian folders use Norwegian names: `bok`,
  `referanser.bib`, `bokstil.sty`, `prove/provestil.sty`. `no/handout`
  is the exception, since the folder name is not translated and neither
  is its style file.
- **Command names** — the Norwegian `exam` (`prøve`) uses Norwegian
  commands: `\del`, `\nivå`, `\undertittel`, `\tid`, `\hjelpemidler`,
  `\poeng`, and options `forside`, `hefte`, `statussjekk`, `innrykk`;
  the English one `\exampart`, `\level`, `\subtitle`, `\duration`,
  `\aids`, `\points`, and `coverpage`, `booklet`, `statuscheck`,
  `indent`. The Norwegian `formulasheet` (`formelark`) uses `halvdel`,
  `\gruppe`, `konstanter`, `tabellto`, `formler`,
  `formlerto`, `\formelrad`, `\formelstrekk` and the option `tett`;
  the English one `half`, `\topic`, `constants`, `twocol`,
  `formulas`, `formulastwo`, `\formularow`, `\formulastretch` and
  `tight`. `parity-diff.sh` maps one onto the other.
- **Comments and placeholder text** — in the matching language
- **Numbers** — the Norwegian style files set `siunitx` to a decimal
  comma, a half-high dot in scientific notation, «til» in `\qtyrange` and
  «og» in `\qtylist`; the English ones keep siunitx's defaults

Layout, packages and typography are otherwise identical.

## Parity between the editions

The two editions are meant to differ only in language strings,
filenames and comments. `tools/parity-diff.sh` strips comments,
maps the Norwegian identifiers to their English counterparts, and
diffs each pair of style files and `main.tex` — run it from the
repository root after editing either edition. The script's header
lists the few legitimate residual differences.

## License

[MIT](LICENSE) — use, modify, and redistribute freely. Attribution is
appreciated but not required.

## Notes

These templates reflect my own conventions and aesthetic preferences for
academic and teaching documents. They are shared in case they are useful
to others — fork and adapt them freely.

## Acknowledgements

Developed in collaboration with Claude (Anthropic). The style-file
comments and README documentation were written by Claude and reviewed for
accuracy, but may still contain errors.
