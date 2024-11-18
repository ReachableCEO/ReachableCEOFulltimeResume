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

# Array of my various job positions

positions=(
  "Insight Global"
  "TCS  Apple Computer"
  "Shein.com"
  "3M" 
  "Dell Residency  Confidential End CLients (government sector)"
  "TippingPoint"
  "HostGator"
  "RippleTV"
  "Walt Disney Internet Group"
  "Electronic Clearing House" 
  "GSI Commerce"
)

# Combine markdown files into single input file for pandoc
#Pull in my contact info
cat "../../common/@ReachableCEO/Resume/Common/Contact-Info.md" >> ../output/intermediate/human/CharlesNWybleLongResume.md

#And here we do some magic...
#Pull in my long form position summary data from each position

IFS=$'\n\t'
for position in $(cat ../../common/WorkHistory.csv|awk -F '|' '{print $1}'); do
 cat "../@ReachableCEO/Resume/CV/$position.md" >> ../output/intermediate/human/CharlesNWybleLongResume.md
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