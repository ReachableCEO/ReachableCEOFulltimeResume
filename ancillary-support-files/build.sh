#!/bin/bash

echo "Generating PDF..."

pandoc \
CharlesNWybleCandidateInfo.md \
--template eisvogel \
--metadata-file=./CandidateInfo.yml \
--from markdown \
--to=pdf \
--output ./CharlesNWybleCandidateInfo.pdf