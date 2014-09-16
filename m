#!/bin/bash
# copyright (c) 2014 Julian Wergieluk  <julian@wergieluk.com>

set -e; set -u

PROBLEMS="`pwd`/../problem-pool/probability-theory.tex `pwd`/../problem-pool/statistics.tex `pwd`/../problem-pool/elementary-probability.tex"
TMP="/tmp"


for KEYS in ue-blatt-??.txt; do
    NO=`echo ${KEYS:9:2} | bc`
    TEX=${KEYS/.txt/.tex}
    PDF=${KEYS/.txt/.pdf}

    if [[ $KEYS -nt $PDF  ]]; then
        cat sheet-head.tex | sed -r "s/SHEETNO/$NO/g" > $TMP/$TEX
        pe $KEYS $PROBLEMS | sed -r "s/SHEETNO/$NO/g" >> $TMP/$TEX
        cat sheet-tail.tex | sed -r "s/SHEETNO/$NO/g" >> $TMP/$TEX
        pdflatex    -output-directory   $TMP $TMP/$TEX
#        biber       --output_directory  $TMP ${TEX/.tex/}
        pdflatex    -output-directory   $TMP $TMP/$TEX
        cp $TMP/${KEYS/.txt/.pdf} `pwd`
    fi
done

