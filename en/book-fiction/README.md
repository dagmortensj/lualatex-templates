# book-fiction template

LaTeX template for a novel, a collection of short stories or a
collection of short prose: running text on a fixed line grid, chapters
with a large number, stories and short prose with titles, scene breaks,
parts, a table of contents and front matter. Typeset with **LuaLaTeX**
in Garamond Libre.

## Files

| File               | Description                                 |
|--------------------|---------------------------------------------|
| `main.tex`         | The starting point — front matter and text  |
| `fictionstyle.sty` | All formatting; rarely changed              |

## Getting started

1. Copy the whole folder to a new project
2. Open `main.tex` and fill in title, author and colophon
3. Replace the placeholder text with your own
4. Compile with **lualatex**, not pdflatex:

```
latexmk -lualatex main
```

## Writing the text

```latex
\chapter

The first paragraph of the chapter. It has no indent.

The next paragraph is indented.

\scenebreak

The first paragraph of a new scene, again without indent.

\chapter[Epilogue]

A chapter with a word instead of a number.
```

- **`\chapter`** begins a new chapter on a new page, recto or verso.
  The number stands centred in the space above the text, and the text
  begins eleven lines down. Chapters are numbered automatically.
- **`\chapter[Prologue]`** gives an unnumbered chapter with the word as
  a title where the number would otherwise be. The counter does not
  advance, so a prologue does not push the numbering.
- **`\scenebreak`** gives one blank line, and the next paragraph without
  indent. If the break falls at the foot of a page, the page ends with
  an empty line; if it falls at the very top, it disappears.
- **Paragraphs** are separated by a blank line in the source, as
  elsewhere in LaTeX, and are indented by one em.

## Story collections and short prose

```latex
\contents

\story{The Summer House}

The first paragraph of the story.

\story{The Last Train from Dombås\\ the Winter Father Fell Ill}

\shortprose[Gulls]

A short piece with a title.

\shortprose

A short piece without a title.
```

- **`\story{Title}`** begins on a recto, with the same opening as a
  chapter: the title on the fifth line and the text on the twelfth.
- **`\shortprose[Title]`** begins on a new page, recto or verso, with
  the title on the fourth line and the text one empty line below.
  Without a title, **`\shortprose`**, the text begins on the fourth
  line. One piece per page; a longer piece runs on to the next page as
  usual.
- **Titles** are upright in \large, centred, and break over several
  lines when they are long, each line on the next grid line. With `\\`
  in the title you decide where it breaks. In the table of contents and
  the bookmarks `\\` becomes a space.
- **`\contents`** sets the table of contents: parts, stories and short
  prose with a title, with page numbers against the right edge and no
  leader dots. Chapters and untitled short prose are not listed. Put
  the command last in the front matter or at the back of the book, or
  leave it out.

`\chapter`, `\story` and `\shortprose` can be mixed, for instance a
long story divided into numbered chapters, or a few short pieces
between the long ones. Chapters inside a story are numbered from 1 in
each story and sit under the story in the bookmarks.

`\chapter` and `\part` replace the class commands of the same name and
take different arguments: no title, and an optional word in brackets.

## Commands

```latex
\halftitlepage             % Half-title (commented out in main.tex)
\booktitlepage             % Title page (\title, \subtitle, \author, \date)
\colophonpage{...}         % Colophon on the back of the title page
\dedicationpage{...}       % Dedication
\contents                  % Table of contents (commented out in main.tex)
\part{Part One}            % Part page, recto with a blank verso
\chapter                   % New chapter, numbered
\chapter[Prologue]         % New chapter with a word instead of a number
\story{Title}              % New story, on a recto
\shortprose[Title]         % New short piece, title optional
\scenebreak                % Blank line between two scenes
```

The front matter is optional: delete or comment out the lines you do
not need in `main.tex`, and the page sequence stays right. Without
`\part` the chapters run on. With `\part` the chapter count runs on
through the parts.

Chapters, stories, short prose with a title and parts appear as
bookmarks in the PDF, also without `\contents`. The template has no
cover page. A cover with spine and back depends
on the printer and the page count, and is made as a separate PDF.

## Package options

| Option    | Effect |
|-----------|--------|
| none      | 128 × 204 mm, for print |
| `booklet` | Blank pages at the end until the page count is divisible by four, so a folded and stapled booklet gets a blank back. For a short text: the pages fit unscaled on each A5 half of an A4 sheet with booklet printing in the print dialogue |
| `proof`   | The page untouched, centred on A4 with crop marks. The same line and page breaks as print, with room around for notes |

The options combine: `\usepackage[proof,booklet]{fictionstyle}`.

Unlike `book-poetry`, the template has no `a5` option. A novel is too
thick to staple as an A5 booklet, and for proofreading `proof` gives
the same page with more room around it.

## Typography

- **Face:** Garamond Libre, 11.75/15 bp, old-style figures in the text
- **Engine:** LuaLaTeX (`fontspec`, OpenType)
- **Format:** 128 × 204 mm
- **Text block:** 97 mm wide, 30 lines on a fixed grid
- **Margins:** inner 14 mm, outer 17 mm; the top of the capitals in the
  first line 17 mm below the top edge of the sheet
- **Paragraphs:** justified, indent 1 em, no space between paragraphs
- **Chapter and story opening:** the text on the twelfth line, the
  number in 24 bp lining figures or the title in \large on the fifth;
  stories on a recto
- **Short prose and contents:** the title on the fourth line, the text
  one empty line below
- **Part pages:** the title in small capitals on the tenth line
- **Folio:** centred, two lines below the last line of text (20 mm
  above the bottom edge), on chapter pages too; front matter and part
  pages without
- **Microtypography:** protrusion, expansion and letterspacing of small
  capitals

### Where the measurements come from

Format, margins, leading and number of lines are measured from a
Norwegian novel set in Adobe Garamond 11.75/15. Adobe Garamond is a
commercial face, so the template uses Garamond Libre. The two have
almost the same density: a simulation of the line breaking with
Garamond Libre's metrics gives about 57 characters per line over
97 mm, the same as in the model. The points are `bp`, the point
InDesign uses, so the numbers compare directly.

### Why a fixed grid

The leading is 15 bp throughout, and everything else on the page is
measured in whole lines: the chapter opening, the scene breaks and the
position of the folio. The lines on two facing pages therefore stand
at the same height, and the lines on the back of the leaf stand
directly behind the lines on the front. What shows through is hidden
by the text and does not appear in the spaces between.

### Page breaking

The pages are not stretched. A page has 30 lines, with two exceptions:
the last page of a chapter ends where the text ends, and a page is one
line short when the last line of a paragraph would otherwise stand
alone at the top of the next page. The first line of a paragraph may
stand alone at the foot; moving it as well would give short pages far
more often.

### Figures

The text uses old-style figures (1984, 2026), which sit with the
lowercase letters. The chapter numbers use lining figures: a large
old-style figure standing alone would hang below the line for 3, 4, 5,
7 and 9 and not for the others, and the chapter openings would look
uneven.

## Mathematics

The style does not load `unicode-math` and has no maths font. If the
text needs a formula, load `unicode-math` in `main.tex` and choose a
maths font there.
