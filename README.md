# lualatex-templates

Nine LaTeX templates — six for academic and teaching work (a monograph,
a two-column article, lecture notes, problem sheets, classroom tests,
and a folded formula sheet), two for literature (a novel and a poetry
collection) and one for an essay — each in English and Norwegian. Copy a folder, edit
`main.tex`, compile.

Typeset with **LuaLaTeX** and `unicode-math`, OpenType fonts throughout.
A pdflatex edition lives in
[pdflatex-templates](https://github.com/dagmortensj/pdflatex-templates);
the fiction, poetry and essay templates exist only here.

## Templates

English in `en/`, Norwegian in `no/`.

| Template | Format | What it is |
|---|---|---|
| **book-academic** / **bok-fag** | B5 or A4 | A monograph in CUP style: parts, chapters, drop caps, superscript citations |
| **ffv** | A4, two columns | An essayistic physics or mathematics article, numbered citations |
| **notes** / **notat** | A4 | Long-form notes: theorem and exercise environments, emphasis boxes, framed contents, Python listings |
| **handout** | A4 | Problem sheets: exercises with lettered parts, theorem environments, emphasis boxes, Python listings; optional unnumbered mode |
| **exam** / **prove** | A4, 12 pt | Classroom tests: title block with name, date, time and aids; Part 1 / Part 2 or Level 1–3; multiple-choice lists; "Page 2 of 5" on every page; optional cover page and booklet padding for duplex printing |
| **formulasheet** / **formelark** | A4, folded to A5 | A formula sheet: two landscape A5 pages stacked on one sheet — constants above the fold, formulas below, two columns each; fold marks; optional tight mode |
| **book-fiction** / **bok-fiksjon** | 128 × 204 mm | A novel, a story collection or short prose: justified text on a fixed line grid, chapter openings with a large centred number, titled stories on a recto, short prose one piece per page with an optional title, scene breaks, parts, contents, half-title, title page and colophon |
| **book-poetry** / **bok-dikt** | 140 × 216 mm or A5 | A poetry collection: one poem per page with an optional title, line breaks and indentation taken from the source, parts, half-title, title page, colophon, and contents by title or first line |
| **essay** | A4 | An essay: title, name and date at the top of the first page, running text on a fixed line grid, unnumbered headings, text breaks, block quotations and footnotes |

`notes`, `handout` and `exam` share their exercise environments, so a
problem set moves between them unchanged; `book-academic` and `notes` share their
equation spacing, so the two read as a family. `exam` is `handout`
stripped of theorems and boxes and given what a test needs instead; it
is the only one that loads neither `hyperref` nor a bibliography
package, since a test is printed. `formulasheet` is the odd one out:
no prose, no exercises — two landscape A5 pages that `pgfpages` stacks
on one A4 sheet, tables in each, and the same fonts and dark red as
`exam`.

The three `book-` templates share a prefix so they sort together: a
monograph, a novel and a poetry collection. `book-poetry` and
`book-fiction` use the same face as `book-academic` and the same names
for its front-matter commands, but share no code with it: no
mathematics, no citations and their own page sizes. `book-poetry` has
an environment that reads a poem as it is written. `book-fiction` grew
out of `book-poetry`, with the same front matter, parts and booklet
padding, and replaces the poem environment with running text on a
fixed line grid, numbered chapters, titled stories, short prose and
scene breaks.

## Fonts and engine

**Compile with `lualatex`, not `pdflatex`.** The fonts are OpenType and
load through `fontspec`, and in all but the two literary templates and
`essay` through `unicode-math`. The wrong engine gives you a wall of errors
rather than a helpful message. Use `latexmk -lualatex`: `notes` and
`book-academic` need biber, and `exam` needs a second pass for "Page 2 of 5".

Each template folder carries a `.latexmkrc` that selects LuaLaTeX, so a
plain `latexmk main` uses the right engine. It also covers editors that
call latexmk with `-pdf`, as the default recipe in VS Code's LaTeX
Workshop does. The file is hidden in Finder and Explorer; keep it when
you copy a folder. `main.tex` starts with `% !TEX program = lualatex`,
which TeXShop, TeXstudio and similar editors read. On Overleaf, set the
compiler to LuaLaTeX in the project menu.

| Template | Text | Mathematics |
|---|---|---|
| **book-academic** | Garamond Libre, 12 pt | STIX Two Math at `Scale=0.90` |
| **ffv** | STIX Two Text, 10 pt | STIX Two Math |
| **notes** | NewComputerModern Book, 11 pt | NewCM Math Book |
| **handout** | NewComputerModern Book, 11 pt | NewCM Math Book |
| **exam** | NewComputerModern Book, 12 pt; NewCM Sans for headings | NewCM Math Book |
| **formulasheet** | NewComputerModern Book, 10 pt; NewCM Sans for headings | NewCM Math Book |
| **book-fiction** | Garamond Libre, 11.75/15 bp | none — loads `fontspec`, not `unicode-math` |
| **book-poetry** | Garamond Libre, 12 pt | none — loads `fontspec`, not `unicode-math` |
| **essay** | Garamond Libre, 12/16 bp | none — loads `fontspec`, not `unicode-math` |

Three rules follow from `unicode-math` and hold for the six templates
that load it, which is all but `book-fiction`, `book-poetry` and
`essay`:

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

`notes` and `handout` also load `siunitx`, `tensor` and `physics2`
ready to use, for units, tensor indices and bra-ket; `exam` and
`formulasheet` load `siunitx`. Every style file except those of
`book-fiction`, `book-poetry` and `essay` gives
vector arrows with `\vv{F}` and `\vv{AB}` without an extra package (do
not load `esvect`), and switches on `\mathitalicsmode=1` so italic
correction works as in pdflatex.

All eighteen build with no warnings.

## Quick start

1. Copy the template folder into a new project
2. Read the copy's own `README.md`
3. Edit `main.tex` — the body is sectioned so you can find your way
4. `latexmk -lualatex main`

Every folder holds `main.tex`, a style file where all the formatting
lives, and its own `README.md`. `book-academic`, `ffv` and `notes` add
a `.bib` with example entries; `book-academic`, `notes` and `handout`
add a `figures/` folder with a stock figure; `formulasheet`,
`book-fiction`, `book-poetry` and `essay` ship only `main.tex`, the style file
and `README.md`. The bundled `main.pdf` shows what each one
produces before you compile anything.

`exam` has four package options — none, `[coverpage]`, `[booklet]` and
`[statuscheck]` — for a short test, a full-day test with a cover, the
same laid out for duplex printing and folding, and a levelled status
check. Its `README.md` shows each.

`formulasheet` has one, `[tight]`, for a sheet with more formulas than
10 pt has room for; the half that is full takes `\small` as an
argument. Too much content shows up the way it always does in LaTeX: as
an extra page, here a second A4 sheet.

`book-fiction` has two: `[booklet]`, as below, for a short story
printed at home as a folded booklet, and `[proof]` for the page on A4
with crop marks. Every line stands on a 15 bp grid, so the proof shows
the line and page breaks of print.

`book-poetry` has four: `[a5]` for printing at home on A5 with the same
text block, so line and page breaks match the 140 × 216 mm print
edition; `[booklet]` to pad the page count to a multiple of four, so a
folded booklet closes on a blank back; `[centered]` to centre each poem
on its longest line; and `[proof]` for the page on A4 with crop marks,
as in `book-academic`.

`essay` has none. It is `book-fiction` on A4: the same face and the
same fixed grid, at 12/16 bp over a 120 mm measure, with title, name
and date at the top of the first page instead of front matter.

## Languages

The two versions are functionally equivalent. What differs:

- **Babel** — `[english]` vs `[norsk]`
- **Filenames** — Norwegian folders use Norwegian names: `bok-fag`,
  `bok-fiksjon`, `bok-dikt`, `referanser.bib`, `bokstil.sty`,
  `prove/provestil.sty`. `no/handout`
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
  `tight`. The Norwegian `book-poetry` (`bok-dikt`) uses the environment
  `dikt`, `\del` and the options `sentrert` and `hefte`; the English one
  `poem`, `\part`, `centered` and `booklet`. The Norwegian
  `book-fiction` (`bok-fiksjon`) uses `\kapittel`, `\novelle`,
  `\kortprosa`, `\scenebrudd`, `\del`, `\innhold` and the option
  `hefte`; the English one `\chapter`, `\story`, `\shortprose`,
  `\scenebreak`, `\part`, `\contents` and `booklet`. The Norwegian
  `essay` uses `\overskrift` and `\tekstbrudd`; the English one
  `\heading` and `\textbreak`. `parity-diff.sh` maps one onto the
  other.
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
