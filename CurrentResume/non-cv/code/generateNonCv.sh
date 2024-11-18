#!/bin/bash

rm ../output/intermediate/CharlesNWybleShortResume.md
rm /d/tsys/@ReachableCEO/resume.reachableceo.com/non-cv/CharlesNWybleShortResume.html

# Combine markdown files into single input file for pandoc

NonCvResumeInputFiles=(
  "../../common/@ReachableCEO/Resume/Common/Contact-Info.md"
  "../@ReachableCEO/Resume/Non-CV/Skills.md"
  "../@ReachableCEO/Resume/Non-CV/Projects.md"
  "../@ReachableCEO/Resume/Non-CV/Work-History.md"
  "../../common/@ReachableCEO/Resume/Common/Education.md"
)

IFS=$'\n\t'
for file in "${NonCvResumeInputFiles[@]}"; do
  cat $file >> ../output/intermediate/CharlesNWybleShortResume.md
done
unset IFS

# Run pandoc to generate HTML/PDF/DOC into output dir

#First html, for resume.reachableceo.com use

pandoc \
  --from=markdown \
  --to=html \
  -o /d/tsys/@ReachableCEO/resume.reachableceo.com/non-cv/CharlesNWybleShortResume.html \
  -c resume-css-stylesheet.css \
	../output/intermediate/CharlesNWybleShortResume.md