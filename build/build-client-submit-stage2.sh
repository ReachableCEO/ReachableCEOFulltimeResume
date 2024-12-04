#!/bin/bash

echo "Generating PDF output for client submission version..."

PDFOutputFile="D:/tsys/@Reachableceo/resume.reachableceo.com/client-submit/CharlesNWyble-Resume.pdf"
MSWordOutputFile="D:/tsys/@Reachableceo/resume.reachableceo.com/client-submit/CharlesNWyble-Resume.doc"
MarkdownInputFile="../MarkdownOutput/client-submit/CharlesNWybleResume.md "
PandocMetadataFile="./CharlesNWyble-ClientSubmit.yml"

pandoc \
"$MarkdownInputFile" \
--template eisvogel \
--metadata-file="$PandocMetadataFile" \
--from markdown \
--to=pdf \
--output $PDFOutputFile

echo "Generating MSWord output for client submission version..."

pandoc \
"$MarkdownInputFile" \
--metadata-file="$PandocMetadataFile" \
--from markdown \
--to=docx \
--reference-doc=resume-docx-reference.docx \
--output $MSWordOutputFile