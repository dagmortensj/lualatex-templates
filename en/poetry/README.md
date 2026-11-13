# poetry template

LaTeX template for a poetry collection: one poem per page, optional
titles, front matter and contents. Typeset with **LuaLaTeX** in
Garamond Libre.

## Files

| File              | Description                              |
|-------------------|------------------------------------------|
| `main.tex`        | Starting point — front matter and poems  |
| `poetrystyle.sty` | All formatting; rarely changed           |

## Getting started

1. Copy the whole folder into a new project
2. Open `main.tex` and fill in title, author and colophon
3. Replace the placeholder poems with your own
4. Compile with **lualatex**, not pdflatex:

```
latexmk -lualatex main
```

## Writing a poem

```latex
\begin{poem}[Title]
Each line in the source is a line of the poem.
A long line is broken by itself and gets a hanging indent.

A blank line gives a new stanza.
    Spaces at the start of a line indent it.
\end{poem}
```

- **The title is optional.** `\begin{poem}` without brackets gives a
  poem without a title. It begins where the title would have stood, and
  is listed in the contents by its first line in italics.
- **Line breaks** in the source are line breaks in the poem. `\\` is
  not needed.
- **Long lines** are broken when they are wider than the text block
  (about 60 characters), and the continuation is indented 3 em.
- **Stanzas** are separated by a blank line. Several blank lines give
  no more space.
- **Indentation:** each space at the start of a line is 0.5 em; a tab
  character counts as four. Spaces inside a line are kept, so three
  spaces give three word spaces.
- **Long poems** continue on the next page and are divided between two
  stanzas, not inside one.

Inside a poem, end of line and space are active characters. Two things
follow: a `%` at the end of a line swallows the line break, and lengths
with spaces in them (`1em plus 2pt`) cannot be written there.

## Commands

```latex
\halftitlepage             % Half-title (commented out in main.tex)
\booktitlepage             % Title page (\title, \subtitle, \author, \date)
\colophonpage{...}         % Colophon on the back of the title page
\dedicationpage{...}       % Dedication
\part{I}                   % Part page, recto with a blank verso
\poemtoc                   % Contents
```

All are optional and independent of one another: delete or comment
out the lines you do not need in `main.tex`, and the pagination stays
right. Without `\part` the poems simply follow one another.

`\poemtoc` stands last in the front matter in `main.tex`. Move the
command to the end of the file for contents at the back.

The template has no cover page. A cover with spine and back depends on
the printer and the page count, and is made as a separate PDF.

## Package options

| Option     | Effect |
|------------|--------|
| none       | 140 × 216 mm, for print. `main.tex` has `booklet` switched on from the start |
| `a5`       | A5, for printing at home. Same text block, so line and page breaks are identical to 140 × 216 mm |
| `booklet`  | Blank pages at the end until the page count is divisible by four, so a folded and stapled booklet has a blank back. Print with booklet printing in the print dialog |
| `centered` | Each poem centred on its longest line; the lines stay flush left. Needs two runs, which latexmk does by itself |
| `proof`    | The page untouched, centred on A4 with crop marks |

The options combine: `\usepackage[a5,booklet]{poetrystyle}`.

## Typography

- **Text:** Garamond Libre, 12/16 pt
- **Engine:** LuaLaTeX (`fontspec`, OpenType)
- **Page size:** 140 × 216 mm, or A5 with `a5`
- **Text block:** 98 × 162 mm, 29 lines, the same in both formats
- **Margins, 140 × 216:** inner 22 mm, outer 20 mm, top 24 mm, bottom 30 mm
- **Margins, A5:** inner 26 mm, outer 24 mm, top 21 mm, bottom 27 mm
- **Poems:** flush left, title in italics on the fourth line of the
  text block, first line on the sixth
- **Page numbers:** centred at the bottom; none on front matter,
  contents and part pages
- **Microtypography:** protrusion and tracking of small caps; no
  expansion

### Why 12 pt

Garamond Libre has a small eye (x-height 0.407 em), so 12 pt reads as
Times at about 10.3 pt. 11 pt corresponds to 9.5 pt and is small on a
book page. The 16 pt leading is more open than the book template's,
since poems are read line by line.

### Why these margins

140 × 216 mm (5.5 × 8.5 in) is the usual trim size for poetry
collections. The measure is chosen for the longest line, not for
readability in running text. The inner margin is a little wider than
the outer: the poems are set flush left, so the right part of the text
block is mostly air, and the inner margin needs its share for the
binding.

## Mathematics

The style does not load `unicode-math` and has no maths font. If a poem
needs a formula, load `unicode-math` in `main.tex` and choose a maths
font there.
