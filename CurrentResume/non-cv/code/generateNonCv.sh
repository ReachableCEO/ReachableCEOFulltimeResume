#!/bin/bash

# Combine markdown files into single input file for pandoc

NonCvResumeInputFiles=(
  "../../common/@ReachableCEO/Resume/Common/Contact-Info.md"
  "../@ReachableCEO/Resume/Non-CV/Skills.md"
  "../@ReachableCEO/Resume/Non-CV/Projects.md"
  "../@ReachableCEO/Resume/Non-CV/Work-History.md"
  "../../common/@ReachableCEO/Resume/Common/Education.md"
)

rm ../output/intermediate/CharlesNWybleShortResume.md

IFS=$'\n\t'
for file in "${NonCvResumeInputFiles[@]}"; do
  cat $file >> ../output/intermediate/CharlesNWybleShortResume.md
done
unset IFS

# Run pandoc to generate HTML/PDF/DOC into output dir

#pandoc \
#	< ../output/intermediate/CharlesNWybleShortResume.md \
#     	--from=markdown \
#	    --output=../output/final/CharlesNWybleShortResume.pdf

pandoc \
  --from=markdown \
  --to=html \
  -o ../output/final/CharlesNWybleShortResume.html \
  -c resume-css-stylesheet.css \
	../output/intermediate/CharlesNWybleShortResume.md 