#!/bin/bash


echo "Generating PDF output for job board version..."

PDFOutputFile="D:/tsys/@Reachableceo/resume.reachableceo.com/job-board/CharlesNWyble-Resume.pdf"
MSWordOutputFile="D:/tsys/@Reachableceo/resume.reachableceo.com/job-board/CharlesNWyble-Resume.doc"
MarkdownInputFile="../MarkdownOutput/job-board/CharlesNWybleResume.md "
PandocMetadataFile="./CharlesNWyble-JobBoard.yml"

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