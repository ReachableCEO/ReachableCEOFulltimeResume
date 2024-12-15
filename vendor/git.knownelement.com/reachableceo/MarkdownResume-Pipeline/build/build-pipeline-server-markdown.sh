#!/usr/bin/env bash

set -euo pipefail

#####################################################################################################
#Markdown to PDF/MSWord Resumek and candidate info sheet
#####################################################################################################

#############################################
# Create the candidate information PDF
#############################################

# Expand variables into rendered YAML files. These will be used by pandoc to create the output artifacts

$MO_PATH $YamlInputTemplateFileJobBoard > $BUILDYAML_JOBBOARD
$MO_PATH $YamlInputTemplateFileClientSubmission > $BUILDYAML_CLIENTSUBMISSION
$MO_PATH $YamlInputTemplateFileClientSubmission > $BUILDYAML_CANDIDATEINFOSHEET

echo "Creating candidate info sheet..."

$MO_PATH $PipelineClientWorkingDir/Templates/MarkdownResume/CandidateInfoSheet/CandidateInfoSheet.md > "$CandidateInfoSheetMarkdownOutputFile"

pandoc \
"$CandidateInfoSheetMarkdownOutputFile" \
--template $PANDOC_TEMPLATE \
--metadata-file="$BUILDYAML_CANDIDATEINFOSHEET" \
--from markdown \
--to=pdf \
--output $CandidateInfoSheetPDFOutputFile



echo "Combining markdown files into single input file for pandoc..."

# Create contact info md file
$MO_PATH "$PipelineClientWorkingDir/Templates/MarkdownResume/ContactInfo/ContactInfo-JobBoard.md" > "$BUILD_TEMP_DIR/ContactInfo-JobBoard.md"
$MO_PATH "$PipelineClientWorkingDir/Templates/MarkdownResume/ContactInfo/ContactInfo-ClientSubmit.md" > "$BUILD_TEMP_DIR/ContactInfo-ClientSubmit.md"

#Pull in contact info
cat "$BUILD_TEMP_DIR/ContactInfo-JobBoard.md" >> "$JobBoardMarkdownOutputFile"
echo " " >> "$JobBoardMarkdownOutputFile"

cat "$BUILD_TEMP_DIR/ContactInfo-ClientSubmit.md" >> "$ClientSubmissionMarkdownOutputFile"
echo " " >> "$ClientSubmissionMarkdownOutputFile"

echo "## Career Highlights" >> "$JobBoardMarkdownOutputFile"
echo "## Career Highlights" >> "$ClientSubmissionMarkdownOutputFile"

cat "$PipelineClientWorkingDir/Templates/MarkdownResume/SkillsAndProjects/Projects.md" >> "$JobBoardMarkdownOutputFile"
echo "\pagebreak" >> "$JobBoardMarkdownOutputFile"

cat  "$PipelineClientWorkingDir/Templates/MarkdownResume/SkillsAndProjects/Projects.md" >> "$ClientSubmissionMarkdownOutputFile"
echo "\pagebreak" >> "$ClientSubmissionMarkdownOutputFile"

echo " " >> "$JobBoardMarkdownOutputFile"
echo "## Employment History" >> "$JobBoardMarkdownOutputFile"
echo " " >> "$JobBoardMarkdownOutputFile"

echo " " >> "$ClientSubmissionMarkdownOutputFile"
echo "## Employment History" >> "$ClientSubmissionMarkdownOutputFile"
echo " " >> "$ClientSubmissionMarkdownOutputFile"

#And here we do some magic...
#Pull in :

# employer
# title
# start/end dates of employment 
# long form position summary data from each position

IFS=$'\n\t'
for position in \
$(cat "$PipelineClientWorkingDir/Templates/MarkdownResume/WorkHistory/WorkHistory.csv"); do

COMPANY="$(echo $position|awk -F ',' '{print $1}')"
TITLE="$(echo $position|awk -F ',' '{print $2}')"
DATEOFEMPLOY="$(echo $position|awk -F ',' '{print $3}')"

echo " " >> "$JobBoardMarkdownOutputFile"
echo "**$COMPANY | $TITLE | $DATEOFEMPLOY**" >> "$JobBoardMarkdownOutputFile"
echo " " >> "$JobBoardMarkdownOutputFile"

echo "**$COMPANY | $TITLE | $DATEOFEMPLOY**" >> "$ClientSubmissionMarkdownOutputFile"
echo " " >> "$ClientSubmissionMarkdownOutputFile"

echo " " >> "$JobBoardMarkdownOutputFile"
cat "$PipelineClientWorkingDir/Templates/MarkdownResume/JobHistoryDetails/$COMPANY.md" >> "$JobBoardMarkdownOutputFile"
echo " " >> "$JobBoardMarkdownOutputFile"

cat "$PipelineClientWorkingDir/Templates/MarkdownResume/JobHistoryDetails/$COMPANY.md" >> "$ClientSubmissionMarkdownOutputFile"
echo " " >> "$ClientSubmissionMarkdownOutputFile"
done

#Pull in my skills and generate a beautiful table.

echo "\pagebreak" >> "$JobBoardMarkdownOutputFile"
echo " " >> "$JobBoardMarkdownOutputFile"
echo "## Skills" >> "$JobBoardMarkdownOutputFile"
echo " " >> "$JobBoardMarkdownOutputFile"

echo "\pagebreak" >> "$ClientSubmissionMarkdownOutputFile"
echo " " >> "$ClientSubmissionMarkdownOutputFile"
echo "## Skills" >> "$ClientSubmissionMarkdownOutputFile"
echo " " >> "$ClientSubmissionMarkdownOutputFile"

#Table heading
echo "|Skill|Experience|Skill Details|" >> "$JobBoardMarkdownOutputFile"
echo "|---|---|---|" >> "$JobBoardMarkdownOutputFile"

echo "|Skill|Experience|Skill Details|" >> "$ClientSubmissionMarkdownOutputFile"
echo "|---|---|---|" >> "$ClientSubmissionMarkdownOutputFile"

#Table rows
IFS=$'\n\t'
for skill in \
$(cat "$PipelineClientWorkingDir/Templates/MarkdownResume/SkillsAndProjects/Skills.csv"); do
SKILL_NAME="$(echo $skill|awk -F '|' '{print $1}')"
SKILL_YEARS="$(echo $skill|awk -F '|' '{print $2}')"
SKILL_DETAIL="$(echo $skill|awk -F '|' '{print $3}')"
echo "|**$SKILL_NAME**|$SKILL_YEARS|$SKILL_DETAIL|" >> "$JobBoardMarkdownOutputFile"
echo "|**$SKILL_NAME**|$SKILL_YEARS|$SKILL_DETAIL|" >> "$ClientSubmissionMarkdownOutputFile"

done
unset IFS

echo "Generating PDF output for job board version..."

pandoc \
"$JobBoardMarkdownOutputFile" \
--template $PANDOC_TEMPLATE \
--metadata-file="$BUILDYAML_JOBBOARD" \
--from markdown \
--to=pdf \
--output "$JobBoardPDFOutputFile"

echo "Generating PDF output for client submission version..."

pandoc \
"$ClientSubmissionMarkdownOutputFile" \
--template "$PANDOC_TEMPLATE" \
--metadata-file="$BUILDYAML_CLIENTSUBMISSION" \
--from markdown \
--to=pdf \
--output "$ClientSubmissionPDFOutputFile"

echo "Generating MSWord output for job board version..."

pandoc \
"$JobBoardMarkdownOutputFile" \
--metadata-file="$BUILDYAML_JOBBOARD" \
--from markdown \
--to=docx \
--reference-doc="$WordOutputReferenceDoc" \
--output "$JobBoardMSWordOutputFile"

echo "Generating MSWord output for client submission version..."

pandoc \
"$ClientSubmissionMarkdownOutputFile" \
--metadata-file="$BUILDYAML_CLIENTSUBMISSION" \
--from markdown \
--to=docx \
--reference-doc="$WordOutputReferenceDoc" \
--output "$ClientSubmissionMSWordOutputFile"