#!/bin/bash

MarkdownInputFile="../MarkdownOutput/job-board/CharlesNWybleResume.md"

# Run pandoc/etc to generate HTML/PDF/DOC into output dir

#First html/pdf/doc, for resume.reachableceo.com use

pandoc \
$MarkdownInputFile \
--template eisvogel \
--metadata-file=./CharlesNWyble-JobBoard.yml \
--from markdown \
--to=pdf \
--output /d/tsys/@ReachableCEO/resume.reachableceo.com/CharlesNWybleResume.pdf