# lualatex-templates

A small collection of personal LaTeX templates for academic and
teaching work — books, articles, lecture notes, problem sheets.
Each template is self-contained and available in both English and
Norwegian.

They are typeset with **LuaLaTeX** and `unicode-math`, using OpenType
fonts throughout. An earlier pdflatex edition of the same four templates
lives in [latex-templates](https://github.com/dagmortensj/latex-templates).

## Templates

Each template has an English version in `en/` and a Norwegian
version in `no/`:

| Template    | Description              | Features                                                                    |
|-------------|--------------------------|-----------------------------------------------------------------------------|
| **book**    | CUP-style monograph      | parts, chapters, drop caps, superscript citations                           |
| **ffv**     | JHEP two-column article  | STIX2 typography, numbered citations                                        |
| **handout** | Problem sheets           | theorem environments, exercises, python code                                |
| **notes**   | CUP-style lecture notes  | theorem environments, exercises, python code; framed TOC, numbered citations|

All templates include figure and table support.

## Fonts and engine

**All four templates compile with `lualatex`, not `pdflatex`.** They load
OpenType fonts through `unicode-math`, which pdflatex cannot use; running
the wrong engine produces a wall of errors rather than a helpful message.

| Template    | Text                     | Mathematics          |
|-------------|--------------------------|----------------------|
| **book**    | Garamond Libre           | STIX Two Math (0.90) |
| **ffv**     | STIX Two Text            | STIX Two Math        |
| **handout** | NewComputerModern (Book) | NewCM Math (Book)    |
| **notes**   | NewComputerModern (Book) | NewCM Math (Book)    |

All four use `unicode-math`, and share three rules:

- **Bold mathematics is `\symbf` / `\symbfit` / `\symbfup`**, never `\bm`.
  `bm` is incompatible with `unicode-math` and hard-errors on Greek.
  `\boldmath` does not work either: neither STIX Two Math nor NewCM Math
  has a bold weight, so it silently sets regular-weight maths.
- **`amssymb` must not be loaded.** `unicode-math` supplies the symbols,
  and loading both breaks the build.
- **`mathtools` is not loaded.** It works under LuaLaTeX, but pulls two
  `unicode-math` notices with it. `physics2` (module `ab.legacy`) replaces
  `\DeclarePairedDelimiter`, `tensor` replaces `\prescript`, and
  `unicode-math` has its own `\coloneq` / `\eqcolon`. Each template's
  README carries the full table.

More broadly, these are `unicode-math` documents: maths packages written
for pdflatex may or may not work, and the three rules above are not an
exhaustive list. Each template's README carries its own table.

All four build with no warnings.

## Quick start

1. Copy the template folder you want into a new project
2. Open the new copy's `README.md` for template-specific guidance
3. Edit `main.tex` — the document body is sectioned for easy navigation
4. Compile with `latexmk -lualatex main` (each template's README
   documents the exact command and run order)

Each template ships with:

- `main.tex` — the document body, with example content demonstrating the template's features
- A style file (`bookstyle.sty`, `notesstyle.sty`, `handoutstyle.sty`, ...) — all formatting lives here
- A `.bib` file with example bibliography entries
- A `figures/` (or `figurer/`) folder with a stock figure
- A `README.md` documenting the template's features and conventions

The bundled `main.pdf` lets you preview what each template produces without compiling.

## Languages

The English (`en/`) and Norwegian (`no/`) versions are functionally
equivalent. The differences are:

- **Babel** — `[english]` vs `[norsk]`
- **Filenames** — Norwegian versions use Norwegian names
  (`bok` instead of `book`, `referanser.bib` instead of `references.bib`,
  `bokstil.sty` instead of `bookstyle.sty`, etc.)
- **Comments and placeholder text** — written in the matching language
- **Number formatting** — the Norwegian `notes` and `handout` set `siunitx`
  to a decimal comma, «til» in `\qtyrange` and «og» in `\qtylist`; the
  English ones keep siunitx's defaults (decimal point, "to", "and")

The layout, packages, and typography are otherwise identical between the
two versions.

## License

[MIT](LICENSE) — use, modify, and redistribute freely. Attribution is
appreciated but not required.

## Notes

These templates reflect my own conventions and aesthetic preferences
for academic and teaching documents. They're shared in case they're
useful to others — feel free to fork and adapt to your own needs.

## Acknowledgements

These templates were developed in collaboration with Claude (Anthropic).
Comments in style files and README documentation were written by Claude
and reviewed for accuracy, but may contain errors or imprecisions.
