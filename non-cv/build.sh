#!/bin/bash

rm ./output/intermediate/CharlesNWybleShortResume.md

IntermediateOutputFile="./output/intermediate/CharlesNWybleShortResume.md"

# Combine markdown files into single input file for pandoc

NonCvResumeInputFiles=(
  "../@ReachableCEO/Resume/Non-CV/Skills.md"
  "../@ReachableCEO/Resume/Non-CV/Projects.md"
)

#Pull in my contact info
cat "../common/@ReachableCEO/Resume/Common/Contact-Info.md" >> $IntermediateOutputFile
echo " " >> $IntermediateOutputFile

#Pull in my skills

echo "## Skills" >> "$IntermediateOutputFile"

#Table heading



#|       |       |       |
#|  ---  |  ---  |  ---  |
#|       |       |       |
#|       |       |       |


echo "|Skill|Experience|Skil Details|" >> $IntermediateOutputFile
echo "|---|---|---|" >> $IntermediateOutputFile
#Table rows
IFS=$'\n\t'
for skill in \
$(cat ../common/@ReachableCEO/Resume/Common/Skills.csv); do
SKILL_NAME="$(echo $skill|awk -F '|' '{print $1}')"
SKILL_YEARS="$(echo $skill|awk -F '|' '{print $2}')"
SKILL_DETAIL="$(echo $skill|awk -F '|' '{print $3}')"
echo "|**$SKILL_NAME**|$SKILL_YEARS|$SKILL_DETAIL|" >> $IntermediateOutputFile
done
unset IFS

#Pull in my projects 
cat "./@ReachableCEO/Resume/Non-Cv/Projects.md" >> $IntermediateOutputFile
echo " " >> $IntermediateOutputFile

#Pull in my work history

cat "../common/WorkHistory.md" >> $IntermediateOutputFile
echo " " >> $IntermediateOutputFile

#Pull in my education info
cat "../common/@ReachableCEO/Resume/common/Education.md" >> $IntermediateOutputFile
echo " " >> $IntermediateOutputFile

# Run pandoc to generate PDF into output dir

pandoc \
$IntermediateOutputFile \
--template eisvogel \
--metadata-file=../common/HumanOutput.yml \
--from markdown \
--to=pdf \
--output /d/tsys/@ReachableCEO/resume.reachableceo.com/non-cv/CharlesNWybleShortResume.pdf