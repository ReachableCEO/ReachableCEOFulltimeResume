#!/bin/bash

rm ../output/intermediate/CharlesNWybleShortResume.md
rm /d/tsys/@ReachableCEO/resume.reachableceo.com/non-cv/CharlesNWybleShortResume.html

output_file="../output/intermediate/CharlesNWybleShortResume.md"


# Combine markdown files into single input file for pandoc

NonCvResumeInputFiles=(
  "../@ReachableCEO/Resume/Non-CV/Skills.md"
  "../@ReachableCEO/Resume/Non-CV/Projects.md"
)

#Pull in my contact info
cat "../../common/@ReachableCEO/Resume/Common/Contact-Info.md" >> $output_file
echo " " >> $output_file

#Pull in my skills
cat "../@ReachableCEO/Resume/Non-CV/Skills.md" >> $output_file
echo " " >> $output_file

#Pull in my projects 
cat "../@ReachableCEO/Resume/Non-CV/Projects.md" >> $output_file
echo " " >> $output_file

#Pull in my work history
cat "../@ReachableCEO/Resume/Non-CV/Work-History.md" >> $output_file
echo " " >> $output_file

#Pull in my education info
cat "../../common/@ReachableCEO/Resume/Common/Education.md" >> $output_file

# Run pandoc to generate HTML/PDF/DOC into output dir

#First html, for resume.reachableceo.com use

pandoc \
  --from=markdown \
  --to=html \
  -o /d/tsys/@ReachableCEO/resume.reachableceo.com/non-cv/CharlesNWybleShortResume.html \
  -c resume-css-stylesheet.css \
   $output_file