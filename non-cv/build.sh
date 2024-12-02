#!/bin/bash

rm ./output/intermediate/CharlesNWybleShortResume.md

IntermediateOutputFile="./output/intermediate/CharlesNWybleShortResume.md"

# Combine markdown files into single input file for pandoc

echo "Combining markdown files..."

#Pull in my contact info
cat "../common/Contact-Info.md" >> $IntermediateOutputFile
echo " " >> $IntermediateOutputFile

#Pull in my skills

echo "## Skills" >> "$IntermediateOutputFile"

#Table heading

echo "|Skill|Experience|Skil Details|" >> $IntermediateOutputFile
echo "|---|---|---|" >> $IntermediateOutputFile
#Table rows
IFS=$'\n\t'
for skill in \
$(cat ../common/Skills.csv); do
SKILL_NAME="$(echo $skill|awk -F '|' '{print $1}')"
SKILL_YEARS="$(echo $skill|awk -F '|' '{print $2}')"
SKILL_DETAIL="$(echo $skill|awk -F '|' '{print $3}')"
echo "|**$SKILL_NAME**|$SKILL_YEARS|$SKILL_DETAIL|" >> $IntermediateOutputFile
done
unset IFS

echo "\pagebreak" >> $IntermediateOutputFile

#Pull in my projects 
cat "./Projects.md" >> $IntermediateOutputFile
echo " " >> $IntermediateOutputFile

echo "\pagebreak" >> $IntermediateOutputFile

#Pull in my work history

echo " " >> $IntermediateOutputFile
echo "## Employment History" >> $IntermediateOutputFile

IFS=$'\n\t'
for position in \
$(cat ../common/WorkHistory.csv); do

COMPANY="$(echo $position|awk -F ',' '{print $1}')"
TITLE="$(echo $position|awk -F ',' '{print $2}')"
DATEOFEMPLOY="$(echo $position|awk -F ',' '{print $3}')"

echo " " >> "$HumanIntermediateOutputFile"
echo "**$COMPANY** | $TITLE | $DATEOFEMPLOY" >> $HumanIntermediateOutputFile
echo " " >> "$HumanIntermediateOutputFile"

cat ../cv/@ReachableCEO/Resume/CV/$COMPANY.md >> "$HumanIntermediateOutputFile"
echo " " >> "$HumanIntermediateOutputFile"
done
unset IFS




#Pull in my education info

echo " " >> $IntermediateOutputFile
cat "../common/Education.md" >> $IntermediateOutputFile

# Run pandoc to generate PDF into output dir

echo "Generating PDF..."

pandoc \
$IntermediateOutputFile \
--template eisvogel \
--metadata-file=./HumanOutput-NonCV.yml \
--from markdown \
--to=pdf \
--output /d/tsys/@ReachableCEO/resume.reachableceo.com/non-cv/CharlesNWybleShortResume.pdf