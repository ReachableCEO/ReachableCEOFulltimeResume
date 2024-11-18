#!/bin/bash

# Cleanup from previous run
rm ../output/intermediate/human/CharlesNWybleLongResume.md

# Array of employment platforms

employmentPlatforms=(
  "glassdoor"
  "guru"
  "indeed"
  "linkedin"
  "roberthalf"
  "teal"
  "upwork"
  "ziprecruiter"
)

# Combine markdown files into single input file for pandoc
#Pull in my contact info
cat "../../common/@ReachableCEO/Resume/Common/Contact-Info.md" >> ../output/intermediate/human/CharlesNWybleLongResume.md
echo " " >> ../output/intermediate/human/CharlesNWybleLongResume.md

#And here we do some magic...
#Pull in my employer/title/dates of employment and my long form position summary data from each position

IFS=$'\n\t'
for position in $(cat ../../common/WorkHistory.csv); do
echo " " >> ../output/intermediate/human/CharlesNWybleLongResume.md
echo $position | sed -e 's/|//g' >> ../output/intermediate/human/CharlesNWybleLongResume.md
POSITION_FILE_NAME="$(echo $position | awk -F '|' '{print $1}')"
cat "../@ReachableCEO/Resume/CV/$POSITION_FILE_NAME.md" >> ../output/intermediate/human/CharlesNWybleLongResume.md
echo " " >> ../output/intermediate/human/CharlesNWybleLongResume.md
done

#Pull in my education info
cat "../../common/@ReachableCEO/Resume/Common/Education.md" >> ../output/intermediate/human/CharlesNWybleLongResume.md

# Run pandoc/etc to generate HTML/PDF/DOC into output dir

#First html/pdf/doc, for resume.reachableceo.com use

pandoc \
  --from=markdown \
  --to=html \
  -o /d/tsys/@ReachableCEO/resume.reachableceo.com/cv/CharlesNWybleLongResume.html \
  -c resume-css-stylesheet.css \
	../output/intermediate/human/CharlesNWybleLongResume.md

#Fecond pdf, for the various employment platforms
#Todo, this is the big delivrable that we've been building to all day

#IFS=$'\n\t'
#for platform in ${employmentPlatforms[@]}; do
#echo "Creating resume for $platform..."
#pandoc \
#  --from=markdown \
#  --to=pdf \
#  -o /d/tsys/@ReachableCEO/resume.reachableceo.com/cv/CharlesNWybleLongResume.html \
#  -c resume-css-stylesheet.css \
#	../output/intermediate/machine/$platform/CharlesNWybleLongResume.md 
#done