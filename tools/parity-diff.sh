#!/usr/bin/env bash
# ============================================================
# parity-diff.sh — structural diff between the no/ and en/
# templates.
#
# The two language editions are meant to be functionally
# identical: only language strings, filenames and comments may
# differ. This script strips comments and blank lines, maps
# the Norwegian identifiers to their English counterparts, and
# diffs each pair of .sty and main.tex files. Run it from the
# repository root after editing either edition:
#
#   tools/parity-diff.sh
#
# Expected residual differences (legitimate, language-driven):
#   - no styles set \proofname to «Bevis»; English keeps the
#     amsthm default
#   - the Norwegian styles' siunitx hook sets decimal comma,
#     half-high dot, «til» and «og»; the English hook keeps
#     siunitx's defaults for those
#   - \providecommand guards may differ where babel supplies
#     one language but not the other
#   - the exam style's visible strings: Del/Part, Nivå/Level,
#     Navn/Name, Dato/Date, Tid/Time, Hjelpemidler/Aids,
#     Oppgave/Exercise, poeng/points, «Side … av»/"Page … of",
#     and the option-warning text
#   - the formula-sheet style's page-count warning text
# Anything else is drift.
# ============================================================
set -u
cd "$(dirname "$0")/.." || exit 1

# Norwegian -> English identifier map. Order matters: longer
# names first, so e.g. 'deloppgaver' is mapped before
# 'oppgave' can eat its middle.
map() {
  sed -e 's/formelarkstil/formulasheetstyle/g' \
      -e 's/formelarktett/formulasheettight/g' \
      -e 's/formelark/formulasheet/g' \
      -e 's/formelstrekk/formulastretch/g' \
      -e 's/formelrad/formularow/g' \
      -e 's/formlerto/formulastwo/g' \
      -e 's/formler/formulas/g' \
      -e 's/halvdel/half/g' \
      -e 's/brettemerke/foldmark/g' \
      -e 's/gruppe/topic/g' \
      -e 's/konstanter/constants/g' \
      -e 's/tabellto/twocol/g' \
      -e 's/{tett}/{tight}/g' \
      -e 's/\[tett\]/[tight]/g' \
      -e 's/handoutunummerert/handoutunnumbered/g' \
      -e 's/unummerert/unnumbered/g' \
      -e 's/handoutblokkavsnitt/handoutblockparagraphs/g' \
      -e 's/blokkavsnitt/blockparagraphs/g' \
      -e 's/boksnullteoremluft/boxzerothmspace/g' \
      -e 's/overskriftsluk/headingswallow/g' \
      -e 's/deloppgaver/subproblems/g' \
      -e 's/flervalg/multiplechoice/g' \
      -e 's/oppgaveinner/exerciseinner/g' \
      -e 's/oppgave/exercise/g' \
      -e 's/provestatussjekk/examstatuscheck/g' \
      -e 's/statussjekk/statuscheck/g' \
      -e 's/forsideaapen/coveropen/g' \
      -e 's/lukkforside/closecover/g' \
      -e 's/proveforside/examcoverpage/g' \
      -e 's/forside/coverpage/g' \
      -e 's/provehefte/exambooklet/g' \
      -e 's/hefte/booklet/g' \
      -e 's/proveblokkavsnitt/examblockparagraphs/g' \
      -e 's/innrykk/indent/g' \
      -e 's/tomside/blankpage/g' \
      -e 's/delhode/parthead/g' \
      -e 's/dellinje/partrule/g' \
      -e 's/skrivsisteside/writelastpage/g' \
      -e 's/sisteside/lastpage/g' \
      -e 's/fyllopp/padout/g' \
      -e 's/\\del\([^a-zA-Z]\)/\\exampart\1/g' \
      -e 's/\\nivå/\\level/g' \
      -e 's/undertittel/subtitle/g' \
      -e 's/hjelpemidler/aids/g' \
      -e 's/navnetikett/namelabel/g' \
      -e 's/visnavnfelt/shownamefield/g' \
      -e 's/feltetikett/fieldlabel/g' \
      -e 's/\\tid\([^a-zA-Z]\)/\\duration\1/g' \
      -e 's/@tid\([^a-zA-Z]\)/@duration\1/g' \
      -e 's/poeng/points/g' \
      -e 's/proveex/examex/g' \
      -e 's/provestil/examstyle/g' \
      -e 's/prove/exam/g' \
      -e 's/notatstil/notesstyle/g' \
      -e 's/notatex/notesex/g' \
      -e 's/bokstil/bookstyle/g' \
      -e 's/ffvstil/ffvstyle/g' \
      -e 's/teorem/theorem/g' \
      -e 's/definisjon/definition/g' \
      -e 's/merknad/remark/g' \
      -e 's/hovedresultat/mainresult/g' \
      -e 's/viktig/important/g' \
      -e 's/boksgrunn/boxbase/g' \
      -e 's/ingress/lead/g' \
      -e 's/referanser/references/g' \
      -e 's/figurer/figures/g' \
      -e 's|innhold/kapittel1|content/chapter1|g' \
      -e 's/norsk/english/g'
}

# Strip comments (unescaped %) and blank lines.
strip() {
  sed -e 's/\(^\|[^\\]\)%.*/\1/' -e 's/[[:space:]]*$//' "$1" | grep -v '^[[:space:]]*$'
}

fail=0
compare() {  # compare <no-file> <en-file>
  local no_f="$1" en_f="$2" out
  out=$(diff <(strip "$no_f" | map) <(strip "$en_f") 2>&1)
  if [ -n "$out" ]; then
    fail=1
    printf '\n=== %s <-> %s ===\n%s\n' "$no_f" "$en_f" "$out"
  else
    printf '=== %s <-> %s: OK\n' "$no_f" "$en_f"
  fi
}

compare no/bok/bokstil.sty        en/book/bookstyle.sty
compare no/bok/main.tex           en/book/main.tex
compare no/bok/innhold/kapittel1.tex en/book/content/chapter1.tex
compare no/notat/notatstil.sty    en/notes/notesstyle.sty
compare no/notat/main.tex         en/notes/main.tex
compare no/ffv/ffvstil.sty        en/ffv/ffvstyle.sty
compare no/ffv/main.tex           en/ffv/main.tex
compare no/handout/handoutstyle.sty en/handout/handoutstyle.sty
compare no/handout/main.tex       en/handout/main.tex
compare no/prove/provestil.sty    en/exam/examstyle.sty
compare no/prove/main.tex         en/exam/main.tex
compare no/formelark/formelarkstil.sty en/formulasheet/formulasheetstyle.sty
compare no/formelark/main.tex     en/formulasheet/main.tex

if [ "$fail" -eq 0 ]; then
  printf '\nAll pairs structurally identical.\n'
else
  printf '\nDifferences above: language strings and the documented residuals are fine; anything else is drift.\n'
fi
