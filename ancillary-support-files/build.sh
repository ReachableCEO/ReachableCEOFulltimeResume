#!/bin/bash

echo "Generating PDF..."

PandocMetadataFile="CandidateInfoSheet.yml"
PDFOutputFile="/d/tsys/@ReachableCEO/resume.reachableceo.com/recruiter/CharlesNWybleCandidateInfo.pdf"

pandoc \
CharlesNWybleCandidateInfo.md \
--template eisvogel \
--metadata-file="$PandocMetadataFile" \
--from markdown \
--to=pdf \
--output $PDFOutputFile