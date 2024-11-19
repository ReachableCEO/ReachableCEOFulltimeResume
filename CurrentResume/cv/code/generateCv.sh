#!/bin/bash

# Array of employment platforms

EmploymentPlatforms=(
  "glassdoor"
  "dice"
  "guru"
  "indeed"
  "linkedin"
  "roberthalf"
  "teal"
  "upwork"
  "ziprecruiter"
)

HumanOutputFile="../output/intermediate/human/CharlesNWybleLongResume.md"

# Cleanup from previous run
rm ../output/intermediate/human/CharlesNWybleLongResume.md


for platform in "${EmploymentPlatforms[@]}"; do
MachineOutputIntermediateFile="../output/intermediate/machine/$platform/CharlesNWybleLongResume.md"
echo "Removing old resume for $platform..."
rm "$MachineOutputIntermediateFile"
done


#####################################
# Human readable CV
#####################################

# Combine markdown files into single input file for pandoc
#Pull in my contact info
cat "../../common/@ReachableCEO/Resume/Common/Contact-Info.md" >> $HumanOutputFile
echo " " >> $HumanOutputFile

#And here we do some magic...
#Pull in my employer/title/dates of employment and my long form position summary data from each position

IFS=$'\n\t'
for position in $(cat ../../common/WorkHistory.csv); do
echo " " >> $HumanOutputFile
echo $position | sed -e 's/|//g' >> $HumanOutputFile
POSITION_FILE_NAME="$(echo $position | awk -F '|' '{print $1}')"
cat "../@ReachableCEO/Resume/CV/$POSITION_FILE_NAME.md" >> $HumanOutputFile
echo " " >> $HumanOutputFile
done

#Pull in my education info
cat "../../common/@ReachableCEO/Resume/Common/Education.md" >> $HumanOutputFile

# Run pandoc/etc to generate HTML/PDF/DOC into output dir

#First html/pdf/doc, for resume.reachableceo.com use

pandoc \
  --from=markdown \
  --to=html \
  -o /d/tsys/@ReachableCEO/resume.reachableceo.com/cv/CharlesNWybleLongResume.html \
  -c resume-css-stylesheet.css \
  $HumanOutputFile

############################################################
# Machine readable CV for the various employment platforms
############################################################

#Per platform specific needs....
# ZipRecruiter (position parsing)
# DIce (skills)
# Robert Half (doesn't even let you upload a resume???!?)

IFS=$'\n\t'
for platform in "${EmploymentPlatforms[@]}"; do
  echo "Creating pdf resume for $platform..."
  MachineOutputIntermediateFile="../output/intermediate/machine/$platform/CharlesNWybleLongResume.md"

  #Pull in my contact info
  cat "../../common/@ReachableCEO/Resume/Common/Contact-Info.md" >> "$MachineOutputIntermediateFile"
  echo " " >> "$MachineOutputIntermediateFile"

  #Pull in my skills
  cat "../../common/@ReachableCEO/Resume/Common/Skills.md" >> "$MachineOutputIntermediateFile"
  echo " " >> "$MachineOutputIntermediateFile"

  #And here we do some magic...
  #Pull in my employer/title/dates of employment and my long form position summary data from each position

  IFS=$'\n\t'
  for position in $(cat ../../common/WorkHistory.csv); do
  echo " " >> $MachineOutputIntermediateFile
  echo $position | sed -e 's/|//g' >> $MachineOutputIntermediateFile
  POSITION_FILE_NAME="$(echo $position | awk -F '|' '{print $1}')"
  cat "../@ReachableCEO/Resume/CV/$POSITION_FILE_NAME.md" >> "$MachineOutputIntermediateFile"
  echo " " >> "$MachineOutputIntermediateFile"
  done

  #Pull in my education info
  cat "../../common/@ReachableCEO/Resume/Common/Education.md" >> "$MachineOutputIntermediateFile"

  pandoc \
   --from=markdown \
   --to=pdf\
  -o /d/tsys/@ReachableCEO/resume.reachableceo.com/cv/machine/$platform/CharlesNWybleLongResume.pdf \
  -c resume-css-stylesheet.css \
  "$MachineOutputIntermediateFile"
done