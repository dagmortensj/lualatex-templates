# Engine for this template: LuaLaTeX.
# latexmk reads this file automatically when run in this folder,
# from VS Code (LaTeX Workshop) as well as from the terminal.
$pdf_mode = 4;

# Some editors pass -pdf, which asks for pdflatex (LaTeX Workshop's
# default recipe does). Run LuaLaTeX in its place.
$pdflatex = 'lualatex %O %S';
