#!/bin/bash

EmploymentPlatforms=(
  "glassdoor"
  "dice"
  "guru"
  "indeed"
  "linkedin"
  "teal"
  "upwork"
  "ziprecruiter"
)

#####################################
# Human readable CV
#####################################

HumanIntermediateOutputFile="./output/intermediate/human/CharlesNWybleCV.md"

rm $HumanIntermediateOutputFile

# Combine markdown files into single input file for pandoc

#Pull in my contact info
cat "../common/Contact-Info.md" >> $HumanIntermediateOutputFile
echo " " >> $HumanIntermediateOutputFile

echo "## Employment History" >> $HumanIntermediateOutputFile

#And here we do some magic...
#Pull in my :

# employer
# title
# start/end dates of employment 
# long form position summary data from each position

IFS=$'\n\t'
for position in \
$(cat ../common/WorkHistory.csv); do

COMPANY="$(echo $position|awk -F ',' '{print $1}')"
TITLE="$(echo $position|awk -F ',' '{print $2}')"
DATEOFEMPLOY="$(echo $position|awk -F ',' '{print $3}')"

echo " " >> "$HumanIntermediateOutputFile"
echo "**$COMPANY** | $TITLE | $DATEOFEMPLOY" >> $HumanIntermediateOutputFile
echo " " >> "$HumanIntermediateOutputFile"

cat ./$COMPANY.md >> "$HumanIntermediateOutputFile"
echo " " >> "$HumanIntermediateOutputFile"
done
unset IFS

#Pull in my education info
cat "../common/Education.md" >> $HumanIntermediateOutputFile

# Run pandoc/etc to generate HTML/PDF/DOC into output dir

#First html/pdf/doc, for resume.reachableceo.com use

pandoc \
$HumanIntermediateOutputFile \
--template eisvogel \
--metadata-file=../common/HumanOutput.yml \
--from markdown \
--to=pdf \
--output /d/tsys/@ReachableCEO/resume.reachableceo.com/cv/CharlesNWybleCV.pdf

exit

############################################################
# Machine readable CV for the various employment platforms
############################################################

for platform in "${EmploymentPlatforms[@]}"; do
MachineOutputIntermediateFile="./output/intermediate/machine/$platform/CharlesNWybleCV.md"
echo "Removing old resume for $platform..."
rm "$MachineOutputIntermediateFile"
done

#Per platform specific notes....
# Original idea here was to use the CSV file (| separated but whatever) and figure out (per platform) what was needed for formatting to be
# auto parsed
# ie

# function linkedin
# COMPANY=$1
# TITLE=$1
# EMPLOYMENTDATE=$1
# $COMPANY $EMPLYMENTDATE $TITLE

# function glassdoor
# COMPANY=$1
# TITLE=$1
# EMPLOYMENTDATE=$1
# $COMPANY $TITLE $EMPLOYMENTDATE

# This may still be developed

# glassdoor
# Appears to not try to parse.

# indeed
# Appears to not try to parse.

#  ziprecruiter
# ZipRecruiter (position parsing) (fixed manually, only one position wasn't properly captured)

#  linkedin
# TBD, not sure how/if/when it parses the uploaded document...

#  upwork
# Doesn't seem to parse the resume at all

#  roberthalf
# Robert Half (not sure if it parses resume or not)

#  dice
# DIce (skills)

#  teal
# tbd

#  guru
# tbd

# careerbuilder
# tbd

# oracle talent something something (most big companies appear to use this)
# tbd (once i apply for a job somewhere that uses that platform, i will update)


IFS=$'\n\t'
for platform in "${EmploymentPlatforms[@]}"; do
  echo "Creating pdf resume for $platform..."
  MachineOutputIntermediateFile="./output/intermediate/machine/$platform/CharlesNWybleCV.md"

  #Pull in my contact info
  cat "../common/@ReachableCEO/Resume/Common/Contact-Info.md" >> "$MachineOutputIntermediateFile"
  echo " " >> "$MachineOutputIntermediateFile"

  #Pull in my skills
  cat "../common/@ReachableCEO/Resume/Common/Skills.md" >> "$MachineOutputIntermediateFile"
  echo " " >> "$MachineOutputIntermediateFile"

  #And here we do some magic...
  #Pull in my employer/title/dates of employment and my long form position summary data from each position

IFS=$'\n\t'

for position in \
   $(cat ../common/WorkHistory.md|awk -F ',' '{print $1}'|sed -e 's/**//g'|sed '/##/d'|sed  '/^$/d');
do
   echo " " >> $MachineOutputIntermediateFile
   POSITION_FILE_NAME="$(echo $position | awk -F ',' '{print $1}')"
   cat "../cv/@ReachableCEO/Resume/CV/$POSITION_FILE_NAME.md" >> "$MachineOutputIntermediateFile"
   echo " " >> "$MachineOutputIntermediateFile"
done

  #Pull in my education info
  cat "../common/Education.md" >> "$MachineOutputIntermediateFile"

pandoc \
$MachineOutputIntermediateFile \
--template eisvogel \
--from markdown \
--to=pdf \
--output /d/tsys/@ReachableCEO/resume.reachableceo.com/cv/CharlesNWybleCV.pdf
done