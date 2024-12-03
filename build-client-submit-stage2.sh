#!/bin/bash

PDFOutputFIle="./output/client-submit/CharlesNWyble-Resume.pdf"

pandoc \
./output/client-submit/CharlesNWybleResume.md \
--template eisvogel \
--metadata-file=./CharlesNWyble-ClientSubmit.yml \
--from markdown \
--to=pdf \
--output $PDFOutputFIle