#!/bin/bash

echo "Generating PDF..."

pandoc \
CharlesNWybleCandidateInfo.md \
--template eisvogel \
--metadata-file=./CandidateInfo.yml \
--from markdown \
--to=pdf \
--output /d/tsys/@ReachableCEO/resume.reachableceo.com/CharlesNWybleCandidateInfo.pdf