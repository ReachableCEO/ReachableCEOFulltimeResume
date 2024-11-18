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

# Run pandoc to generate PDF/DOC into output dir
