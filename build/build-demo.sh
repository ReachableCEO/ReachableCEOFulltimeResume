#!/usr/bin/env bash

# This is a demo used for testing the build pipeline end to end  in a self contained way.

# It's only used by developers of this repository for testing/validating changes.

# Your client repository has a build-pipeline-client.sh script and it uses
# build-pipeline-server.sh, not this script.

###################################################
# Modify these values to suit
###################################################


########################
# Contact info
########################

export CandidateName="First Middle Last"
export CandidatePhone="1 123 456 7890"
export CandidateLocation="Place 1/Place 2"
export CandidateEmail="candidate@domain.com"

########################
# Profile information
########################

export CandidateOneLineSummary="Super awesome and stuff."
export CandidateLinkedin="https://www.linkedin.com/"
export CandidateGithub="https://www.github.com/"
export CandidateTagline="Your.Tagline.Here."

########################
# Formatting options
########################

export CandidateLogo=""
export SourceCode="https://git.knownelement.com/reachableceo/MarkdownResume-Pipeline"
export URLCOLOR="blue"
export PAGEBACKGROUND="./background3.pdf"

##########################
# Candidate info sheet
##########################

export CandidatePreferredContactMethod="Email will get the fastest response."
export CandidateWorkAuthorization="US Citizen"
export CandidateEmploymentStatus="Not currently employed"
export CandidateCurrentLocation="City,State,Country etc"
export CandidateCurrentTimezone="Timezone"
export CandidateWorkableTimezones="Timezones"
export CandidateInterviewAvailability="Sometime"
export CandidateStartAvailability="Sometime"
export CandidateHighestEducation="Some education level"
export CandidateGraduationYear="Graduation year"
export CandidateSchoolName="School name"
export CandidateSchoolLocation="School location"
export CandidateLastProject="Last project"
export CandidateDOB="MM/DD"
export CandidateTotalExperience="epoch"


########################
#Compensation targets
########################

export CandidateRelocationNetMinimumAmount="1,987.11"

export CandidateRateSheetRemoteW2HourlyMinimum="\$12.34"
export CandidateRateSheetRemoteW2AnnualMinimum="\$123,456.00"
export CandidateRateSheetRemote1099HourlyMinimum="\$56.78"

export CandidateRateSheetRemoteW2HourlyPrefer="\$34.56"
export CandidateRateSheetRemoteW2AnnualPrefer="\$321,987.00"
export CandidateRateSheetRemote1099HourlyPrefer="\$78.90"

####################################################
#DO NOT CHANGE ANYTHING BELOW THIS LINE
####################################################

############################################################
# Setup globals
############################################################

readonly MO_PATH="bash ../vendor/git.knownelement.com/ExternalVendorCode/mo/mo"
readonly BUILD_OUTPUT_DIR="../build-output"
readonly BUILD_TEMP_DIR="../build-temp"
readonly BUILDYAML_JOBBOARD="$BUILD_TEMP_DIR/JobBoard.yml"
readonly BUILDYAML_CLIENTSUBMISSION="$BUILD_TEMP_DIR/ClientSubmission.yml"
readonly BUILDYAML_CANDIDATEINFOSHEET="$BUILD_TEMP_DIR/CandidateInfoSheet.yml"

CandidateInfoSheetMarkdownOutputFile="$BUILD_OUTPUT_DIR/CandidateInfoSheet.md"
CandidateInfoSheetPDFOutputFIle="$BUILD_OUTPUT_DIR/CandidateInfoSheet.pdf"

JobBoardMarkdownOutputFile="$BUILD_OUTPUT_DIR/job-board/Resume.md"
JobBoardPDFOutputFile="$BUILD_OUTPUT_DIR/job-board/Resume.pdf"
JobBoardMSWordOutputFile="$BUILD_OUTPUT_DIR/job-board/Resume.doc"

ClientSubmissionMarkdownOutputFile="$BUILD_OUTPUT_DIR/client-submission/Resume.md"
ClientSubmissionPDFOutputFile="$BUILD_OUTPUT_DIR/client-submission//Resume.pdf"
ClientSubmissionMSWordOutputFile="$BUILD_OUTPUT_DIR/client-submission/Resume.doc"

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

$MO_PATH ./BuildTemplate-CandidateInfoSheet.yml > $BUILDYAML_CANDIDATEINFOSHEET
$MO_PATH ./BuildTemplate-JobBoard.yml > $BUILDYAML_JOBBOARD
$MO_PATH ./BuildTemplate-ClientSubmission.yml > $BUILDYAML_CLIENTSUBMISSION

echo "Creating candidate info sheet..."

$MO_PATH ../Templates/CandidateInfoSheet/CandidateInfoSheet.md > $CandidateInfoSheetMarkdownOutputFile

pandoc \
"$CandidateInfoSheetMarkdownOutputFile" \
--template eisvogel \
--metadata-file="../build-temp/CandidateInfoSheet.yml" \
--from markdown \
--to=pdf \
--output $CandidateInfoSheetPDFOutputFIle

echo "Combining markdown files into single input file for pandoc..."

# Create contact info md file
$MO_PATH ../Templates/ContactInfo/ContactInfo-JobBoard.md > $BUILD_TEMP_DIR/ContactInfo-JobBoard.md
$MO_PATH ../Templates/ContactInfo/ContactInfo-ClientSubmit.md > $BUILD_TEMP_DIR/ContactInfo-ClientSubmit.md

#Pull in contact info
cat $BUILD_TEMP_DIR/ContactInfo-JobBoard.md >> $JobBoardMarkdownOutputFile
echo " " >> $JobBoardMarkdownOutputFile

cat $BUILD_TEMP_DIR/ContactInfo-ClientSubmit.md >> $ClientSubmissionMarkdownOutputFile
echo " " >> $ClientSubmissionMarkdownOutputFile

echo "## Career Highlights" >> $JobBoardMarkdownOutputFile
echo "## Career Highlights" >> $ClientSubmissionMarkdownOutputFile

cat ../Templates/SkillsAndProjects/Projects.md >> $JobBoardMarkdownOutputFile
echo "\pagebreak" >> $JobBoardMarkdownOutputFile

cat ../Templates/SkillsAndProjects/Projects.md >> $ClientSubmissionMarkdownOutputFile
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
$(cat ../Templates/WorkHistory/WorkHistory.csv); do

COMPANY="$(echo $position|awk -F ',' '{print $1}')"
TITLE="$(echo $position|awk -F ',' '{print $2}')"
DATEOFEMPLOY="$(echo $position|awk -F ',' '{print $3}')"

echo " " >> "$JobBoardMarkdownOutputFile"
echo "**$COMPANY | $TITLE | $DATEOFEMPLOY**" >> $JobBoardMarkdownOutputFile
echo " " >> "$JobBoardMarkdownOutputFile"

echo "**$COMPANY | $TITLE | $DATEOFEMPLOY**" >> $ClientSubmissionMarkdownOutputFile
echo " " >> "$ClientSubmissionMarkdownOutputFile"

echo " " >> "$JobBoardMarkdownOutputFile"
cat ../Templates/JobHistoryDetails/$COMPANY.md >> "$JobBoardMarkdownOutputFile"
echo " " >> "$JobBoardMarkdownOutputFile"

cat ../Templates/JobHistoryDetails/$COMPANY.md >> "$ClientSubmissionMarkdownOutputFile"
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
$(cat ../Templates/SkillsAndProjects/Skills.csv); do
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
--metadata-file="../build-temp/JobBoard.yml" \
--from markdown \
--to=pdf \
--output $JobBoardPDFOutputFile

echo "Generating MSWord output for job board version..."

pandoc \
"$JobBoardMarkdownOutputFile" \
--metadata-file="../build-temp/JobBoard.yml" \
--from markdown \
--to=docx \
--reference-doc=resume-docx-reference.docx \
--output $JobBoardMSWordOutputFile

echo "Generating PDF output for client submission version..."

pandoc \
"$ClientSubmissionMarkdownOutputFile" \
--template eisvogel \
--metadata-file="../build-temp/ClientSubmission.yml" \
--from markdown \
--to=pdf \
--output $ClientSubmissionPDFOutputFile

echo "Generating MSWord output for client submission version..."

pandoc \
"$ClientSubmissionMarkdownOutputFile" \
--metadata-file="../build-temp/ClientSubmission.yml" \
--from markdown \
--to=docx \
--reference-doc=resume-docx-reference.docx \
--output $ClientSubmissionMSWordOutputFile