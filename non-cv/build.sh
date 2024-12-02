#!/bin/bash


##########################################################
#Global variables
##########################################################

IntermediateOutputFile="./output/intermediate/CharlesNWybleShortResume.md"
FinalOutputFilePDF="/d/tsys/@ReachableCEO/resume.reachableceo.com/non-cv/CharlesNWybleShortResume.pdf"
#FinalOutputFileHTML="/d/tsys/@ReachableCEO/resume.reachableceo.com/non-cv/CharlesNWybleShortResume.pdf"
#FinalOutputFileDOC="/d/tsys/@ReachableCEO/resume.reachableceo.com/non-cv/CharlesNWybleShortResume.pdf"

cleanup()

{

rm ./output/intermediate/CharlesNWybleShortResume.md

}



# Combine markdown files into single input file for pandoc

echo "Combining markdown files..."

createMdContact()

{
#Pull in my contact info
cat "../common/Contact-Info.md" >> $IntermediateOutputFile
echo " " >> $IntermediateOutputFile

}

createMdSkills()

{

#Pull in my skills

echo "## Skills" >> "$IntermediateOutputFile"

#Table heading

echo "|Skill|Experience|Skil Details|" >> $IntermediateOutputFile
echo "|---|---|---|" >> $IntermediateOutputFile
#Table rows
IFS=$'\n\t'
for skill in \
$(cat ./Skills.csv); do
SKILL_NAME="$(echo $skill|awk -F '|' '{print $1}')"
SKILL_YEARS="$(echo $skill|awk -F '|' '{print $2}')"
SKILL_DETAIL="$(echo $skill|awk -F '|' '{print $3}')"
echo "|**$SKILL_NAME**|$SKILL_YEARS|$SKILL_DETAIL|" >> $IntermediateOutputFile
done
unset IFS

echo "\pagebreak" >> $IntermediateOutputFile

}

createMdProjects()

{

#Pull in my projects 

echo "## Projects" >> "$IntermediateOutputFile"

echo 
cat "./Projects.md" >> $IntermediateOutputFile
echo " " >> $IntermediateOutputFile

echo "\pagebreak" >> $IntermediateOutputFile

}

createMdWorkHistory()

{

#Pull in my work history

echo " " >> $IntermediateOutputFile
echo "## Employment History" >> $IntermediateOutputFile

IFS=$'\n\t'
for position in \
$(cat ../common/WorkHistory.csv); do

COMPANY="$(echo $position|awk -F ',' '{print $1}')"
TITLE="$(echo $position|awk -F ',' '{print $2}')"
DATEOFEMPLOY="$(echo $position|awk -F ',' '{print $3}')"

echo " " >> "$IntermediateOutputFile"
echo "**$COMPANY** | $TITLE | $DATEOFEMPLOY" >> $IntermediateOutputFile
echo " " >> "$IntermediateOutputFile"
done
unset IFS

}

generateFinalOutputFilePdf()

{

# Run pandoc to generate PDF into output dir

echo "Generating PDF..."

pandoc \
$IntermediateOutputFile \
--template eisvogel \
--metadata-file=./HumanOutput-NonCV.yml \
--from markdown \
--to=pdf \
--output $FinalOutputFilePDF

}

cleanup
createMdContact
createMdSkills
createMdProjects
createMdWorkHistory
generateFinalOutputFilePdf