#!/usr/bin/env bash

echo "Cleaning up from previous runs..."

rm $BUILDYAML_CANDIDATEINFOSHEET
rm $CandidateInfoSheetMarkdownOutputFile
rm $CandidateInfoSheetPDFOutputFIle

rm $BUILDYAML_JOBBOARD
rm $JobBoardMarkdownOutputFile
rm $JobBoardPDFOutputFile
rm $JobBoardMSWordOutputFile

rm $BUILDYAML_CLIENTSUBMISSION
rm $ClientSubmissionMarkdownOutputFile
rm $ClientSubmissionPDFOutputFile
rm $ClientSubmissionMSWordOutputFile

# Expand variables into rendered YAML files. These will be used by pandoc to create the output artifacts

$MO_PATH $PipelineClientWorkingDir/build/BuildTemplate-CandidateInfoSheet.yml > $BUILDYAML_CANDIDATEINFOSHEET
$MO_PATH $PipelineClientWorkingDir/build/BuildTemplate-JobBoard.yml > $BUILDYAML_JOBBOARD
$MO_PATH $PipelineClientWorkingDir/build/BuildTemplate-ClientSubmission.yml > $BUILDYAML_CLIENTSUBMISSION

echo "Creating candidate info sheet..."

$MO_PATH $PipelineClientWorkingDir/Templates/CandidateInfoSheet/CandidateInfoSheet.md > $CandidateInfoSheetMarkdownOutputFile

pandoc \
"$CandidateInfoSheetMarkdownOutputFile" \
--template eisvogel \
--metadata-file="$PipelineClientWorkingDir/build-temp/CandidateInfoSheet.yml" \
--from markdown \
--to=pdf \
--output $CandidateInfoSheetPDFOutputFIle

echo "Combining markdown files into single input file for pandoc..."

# Create contact info md file
$MO_PATH $PipelineClientWorkingDir/Templates/ContactInfo/ContactInfo-JobBoard.md > $BUILD_TEMP_DIR/ContactInfo-JobBoard.md
$MO_PATH $PipelineClientWorkingDir/Templates/ContactInfo/ContactInfo-ClientSubmit.md > $BUILD_TEMP_DIR/ContactInfo-ClientSubmit.md

#Pull in contact info
cat $BUILD_TEMP_DIR/ContactInfo-JobBoard.md >> $JobBoardMarkdownOutputFile
echo " " >> $JobBoardMarkdownOutputFile

cat $BUILD_TEMP_DIR/ContactInfo-ClientSubmit.md >> $ClientSubmissionMarkdownOutputFile
echo " " >> $ClientSubmissionMarkdownOutputFile

echo "## Career Highlights" >> $JobBoardMarkdownOutputFile
echo "## Career Highlights" >> $ClientSubmissionMarkdownOutputFile

cat $PipelineClientWorkingDir/Templates/SkillsAndProjects/Projects.md >> $JobBoardMarkdownOutputFile
echo "\pagebreak" >> $JobBoardMarkdownOutputFile

cat  $PipelineClientWorkingDir/Templates/SkillsAndProjects/Projects.md >> $ClientSubmissionMarkdownOutputFile
echo "\pagebreak" >> $ClientSubmissionMarkdownOutputFile

echo " " >> $JobBoardMarkdownOutputFile
echo "## Employment History" >> $JobBoardMarkdownOutputFile
echo " " >> $JobBoardMarkdownOutputFile

echo " " >> $ClientSubmissionMarkdownOutputFile
echo "## Employment History" >> $ClientSubmissionMarkdownOutputFile
echo " " >> $ClientSubmissionMarkdownOutputFile

#And here we do some magic...
#Pull in :

# employer
# title
# start/end dates of employment 
# long form position summary data from each position

IFS=$'\n\t'
for position in \
$(cat $PipelineClientWorkingDir/Templates/WorkHistory/WorkHistory.csv); do

COMPANY="$(echo $position|awk -F ',' '{print $1}')"
TITLE="$(echo $position|awk -F ',' '{print $2}')"
DATEOFEMPLOY="$(echo $position|awk -F ',' '{print $3}')"

echo " " >> "$JobBoardMarkdownOutputFile"
echo "**$COMPANY | $TITLE | $DATEOFEMPLOY**" >> $JobBoardMarkdownOutputFile
echo " " >> "$JobBoardMarkdownOutputFile"

echo "**$COMPANY | $TITLE | $DATEOFEMPLOY**" >> $ClientSubmissionMarkdownOutputFile
echo " " >> "$ClientSubmissionMarkdownOutputFile"

echo " " >> "$JobBoardMarkdownOutputFile"
cat $PipelineClientWorkingDir/Templates/JobHistoryDetails/$COMPANY.md >> "$JobBoardMarkdownOutputFile"
echo " " >> "$JobBoardMarkdownOutputFile"

cat $PipelineClientWorkingDir/Templates/JobHistoryDetails/$COMPANY.md >> "$ClientSubmissionMarkdownOutputFile"
echo " " >> "$ClientSubmissionMarkdownOutputFile"
done

#Pull in my skills and generate a beautiful table.

echo "\pagebreak" >> $JobBoardMarkdownOutputFile
echo " " >> "$JobBoardMarkdownOutputFile"
echo "## Skills" >> "$JobBoardMarkdownOutputFile"
echo " " >> "$JobBoardMarkdownOutputFile"

echo "\pagebreak" >> $ClientSubmissionMarkdownOutputFile
echo " " >> "$ClientSubmissionMarkdownOutputFile"
echo "## Skills" >> "$ClientSubmissionMarkdownOutputFile"
echo " " >> "$ClientSubmissionMarkdownOutputFile"

#Table heading
echo "|Skill|Experience|Skill Details|" >> $JobBoardMarkdownOutputFile
echo "|---|---|---|" >> $JobBoardMarkdownOutputFile

echo "|Skill|Experience|Skill Details|" >> $ClientSubmissionMarkdownOutputFile
echo "|---|---|---|" >> $ClientSubmissionMarkdownOutputFile

#Table rows
IFS=$'\n\t'
for skill in \
$(cat $PipelineClientWorkingDir/Templates/SkillsAndProjects/Skills.csv); do
SKILL_NAME="$(echo $skill|awk -F '|' '{print $1}')"
SKILL_YEARS="$(echo $skill|awk -F '|' '{print $2}')"
SKILL_DETAIL="$(echo $skill|awk -F '|' '{print $3}')"
echo "|**$SKILL_NAME**|$SKILL_YEARS|$SKILL_DETAIL|" >> $JobBoardMarkdownOutputFile
echo "|**$SKILL_NAME**|$SKILL_YEARS|$SKILL_DETAIL|" >> $ClientSubmissionMarkdownOutputFile

done
unset IFS

echo "Generating PDF output for job board version..."

pandoc \
"$JobBoardMarkdownOutputFile" \
--template eisvogel \
--metadata-file="$PipelineClientWorkingDir/build-temp/JobBoard.yml" \
--from markdown \
--to=pdf \
--output $JobBoardPDFOutputFile

echo "Generating MSWord output for job board version..."

pandoc \
"$JobBoardMarkdownOutputFile" \
--metadata-file="$PipelineClientWorkingDir/build-temp/JobBoard.yml" \
--from markdown \
--to=docx \
--reference-doc="$PipelineClientWorkingDir/build/resume-docx-reference.docx" \
--output $JobBoardMSWordOutputFile

echo "Generating PDF output for client submission version..."

pandoc \
"$ClientSubmissionMarkdownOutputFile" \
--template eisvogel \
--metadata-file="$PipelineClientWorkingDir/build-temp/ClientSubmission.yml" \
--from markdown \
--to=pdf \
--output $ClientSubmissionPDFOutputFile

echo "Generating MSWord output for client submission version..."

pandoc \
"$ClientSubmissionMarkdownOutputFile" \
--metadata-file="$PipelineClientWorkingDir/build-temp/ClientSubmission.yml" \
--from markdown \
--to=docx \
--reference-doc="$PipelineClientWorkingDir/build/resume-docx-reference.docx" \
--output $ClientSubmissionMSWordOutputFile