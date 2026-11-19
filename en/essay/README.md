# essay template

LaTeX template for an essay on A4: title, name and date at the top of
the first page, running text on a fixed line grid, unnumbered headings,
text breaks, block quotations and footnotes. Built on `book-fiction`,
with the same face and the same grid. Typeset with **LuaLaTeX** in
Garamond Libre.

## Files

| File              | Description                                  |
|-------------------|----------------------------------------------|
| `main.tex`        | The starting point — title, name, date and text |
| `essaystyle.sty`  | All formatting; rarely changed               |

## Getting started

1. Copy the whole folder to a new project
2. Open `main.tex` and fill in title, name and date
3. Replace the placeholder text with your own
4. Compile with **lualatex**, not pdflatex:

```
latexmk -lualatex main
```

## Title, name and date

```latex
\title{Title of the Essay}
\subtitle{A subtitle}       % optional
\author{First Lastname}
\date{\today}

\begin{document}
\maketitle
```

`\maketitle` sets the title at the top of the first page, centred: the
title in small caps at 20.7 pt on the first line, an italic subtitle two
lines below if one is set, the name three lines below that and the date
in italic on the line after. The text begins four lines below the date,
on the ninth line when the title takes one line and there is no
subtitle.

- **`\date{\today}`** gives today's date in English, "November 19,
  2026". Write a fixed date instead if the essay is to be handed in with
  a given date.
- **`\date{}`** or **`\author{}`** gives no line for the date or the
  name, and what follows moves up.
- **Long titles** break at up to 80 % of the measure, without
  hyphenation. With `\\` in the title you decide where it breaks. The
  title has a line and a half of leading, and the name begins on the
  first whole grid line below it.

The title and the name go into the PDF's metadata.

## Writing the text

```latex
The first paragraph. It has no indent.

The next paragraph is indented.

\heading{A heading}

The first paragraph after the heading, without indent.

\textbreak

The first paragraph after the break, again without indent.
```

- **`\heading{Title}`** gives an unnumbered heading in small caps,
  centred, with one blank line above and the text on the line right
  below. Straight after the title or another heading the blank line is
  dropped. The heading is not left alone at the foot of a page with
  fewer than two lines of text below it. Headings appear as bookmarks
  in the PDF.
- **`\textbreak`** gives one blank line, and the next paragraph without
  indent, as `\scenebreak` in `book-fiction`. If the break falls at the
  foot of a page, the page ends with an empty line; if it falls at the
  very top, it disappears.
- **Block quotations** use `quote` (or `quotation`), indented 2.5 em
  from both edges, in the same size as the text and with one blank line
  above and below. Without a blank line after `\end{quote}` in the
  source, the paragraph continues without indent.
- **Lists** (`itemize`, `enumerate`) stand on the grid too, with no
  space between items.
- **Footnotes** with `\footnote{...}` stand at the foot of the page in
  10/13 bp, also when the page is short. The footnote number in the
  text is a true superior figure from the font.

## Commands

```latex
\title{...}                % Title
\subtitle{...}             % Subtitle, optional
\author{...}               % Name
\date{...}                 % Date
\maketitle                 % Title, name and date at the top of page one
\heading{Title}            % Unnumbered heading
\textbreak                 % Blank line between two parts of the text
```

The template has no package options.

## Typography

- **Face:** Garamond Libre, 12/16 bp, old-style figures in the text
- **Engine:** LuaLaTeX (`fontspec`, OpenType)
- **Format:** A4, one-sided
- **Text block:** 120 mm wide, 40 lines on a fixed grid, about 70
  characters a line
- **Margins:** 45 mm on each side; the top of the text block 30 mm
  below the top edge of the sheet, the first baseline 35.6 mm
- **Paragraphs:** justified, indent 1 em, no space between paragraphs
- **Title:** small caps at 20.7 pt with 24 bp leading; subtitle in
  italic, \large; name and date at text size, the date in italic
- **Headings:** small caps at text size, centred
- **Footnotes:** 10/13 bp, at the foot of the page
- **Page numbers:** centred, two lines below the last line of text, on
  every page
- **Microtypography:** protrusion, expansion and letterspaced small caps

### Fixed grid

The line spacing is 16 bp throughout the text, and everything else on
the page is measured in whole lines: the title block, the headings, the
text breaks and the quotations. Footnotes stand off the grid; the text
above them becomes one or more whole lines shorter. Pages are not
stretched. A page has 40 lines, with two exceptions: the last page ends
where the text ends, and a page is one line short when the last line of
a paragraph would otherwise stand alone at the top of the next page.

### Why 120 mm

Garamond Libre at 12 bp gives about 70 characters over 120 mm, about
the longest that reads well in a single column. A wider text block
would give narrower margins, but lines that are harder to follow. The
wide margins leave room for comments when someone else is to read the
essay.

## Mathematics

The style does not load `unicode-math` and has no maths font. If the
text needs a formula, load `unicode-math` in `main.tex` and choose a
maths font there.
