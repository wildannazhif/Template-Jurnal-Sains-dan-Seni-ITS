#!/bin/sh
# build.sh -- Kompilasi main.tex menjadi main.pdf (pdfLaTeX + BibTeX).
# Prasyarat: latexmk, pdflatex, bibtex, IEEEtran.bst (paket texlive-publishers).
#   Debian/Ubuntu: sudo apt install texlive-latex-base texlive-latex-recommended \
#     texlive-latex-extra texlive-fonts-recommended texlive-bibtex-extra \
#     texlive-publishers texlive-lang-other latexmk
# Pemakaian: ./scripts/build.sh
set -eu
cd "$(dirname "$0")/.."
latexmk -pdf -interaction=nonstopmode -halt-on-error main.tex
echo "OK: main.pdf"
ls -lh main.pdf
