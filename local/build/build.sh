#!/usr/bin/env bash


###################################################
# Modify these values to suit
###################################################


########################
# Contact info
########################

export CandidateName="Charles N Wyble"
export CandidatePhone="1 818 280 7059"
export CandidateLocation="Austin TX / Raleigh NC / Remote"
export CandidateEmail="reachableceo@reachableceo.com"

########################
# Profile information
########################

export CandidateOneLineSummary="Super awesome and stuff."
export CandidateLinkedin="https://www.linkedin.com/"
export CandidateGithub="https://www.github.com/reachableceo"
export CandidateTagline="Tenacity. Velocity. Focus."

########################
# Formatting options
########################

export CandidateLogo="D:\tsys\@ReachableCEO\ReachableCEO.png"
export SourceCode="https://git.knownelement.com/reachableceo/MarkdownResume-Pipeline"
export URLCOLOR="blue"
export PAGEBACKGROUND="../vendor/git.knownelement.com/ExternalVendorCode/pandoc-latex-template/examples/page-background/backgrounds/background3.pdf"

##########################
# Candidate info sheet
##########################

export CandidatePreferredContactMethod="Email will get the fastest response."
export CandidateWorkAuthorization="US Citizen"
export CandidateEmploymentStatus="Not currently employed"
export CandidateCurrentLocation="Austin, TX"
export CandidateCurrentTimezone="CST"
export CandidateWorkableTimezones="PST/CST/EST"
export CandidateInterviewAvailability="Immediate"
export CandidateStartAvailability="Two weeks"
export CandidateHighestEducation="High School"
export CandidateGraduationYear="2002"
export CandidateSchoolName="Osborne Christian School"
export CandidateSchoolLocation="Los Angeles, CA"
export CandidateLastProject="CDK Global October 2024"
export CandidateDOB="09/14"
export CandidateTotalExperience="22 years"


########################
#Compensation targets
########################

export CandidateRelocationNetMinimumAmount="5,000.00"

export CandidateRateSheetRemoteW2HourlyMinimum="\$60.00"
export CandidateRateSheetRemoteW2AnnualMinimum="\$120,000.00"
export CandidateRateSheetRemote1099HourlyMinimum="\$75.00"

export CandidateRateSheetRemoteW2HourlyPrefer="\$70.00"
export CandidateRateSheetRemoteW2AnnualPrefer="\$140,000.00"
export CandidateRateSheetRemote1099HourlyPrefer="\$85.00"

####################################################
#DO NOT CHANGE ANYTHING BELOW THIS LINE
####################################################

############################################################
# Setup globals
############################################################

readonly MO_PATH="bash ../../vendor/git.knownelement.com/reachableceo/MarkdownResume-Pipeline/vendor/git.knownelement.com/ExternalVendorCode/mo/mo"
readonly BUILD_OUTPUT_DIR="D:/tsys/@ReachableCEO/resume.reachableceo.com/"
readonly BUILD_TEMP_DIR="../build-temp"
readonly BUILDYAML_JOBBOARD="$BUILD_TEMP_DIR/JobBoard.yml"
readonly BUILDYAML_CLIENTSUBMISSION="$BUILD_TEMP_DIR/ClientSubmission.yml"
readonly BUILDYAML_CANDIDATEINFOSHEET="$BUILD_TEMP_DIR/CandidateInfoSheet.yml"

CandidateInfoSheetMarkdownOutputFile="$BUILD_TEMP_DIR/CandidateInfoSheet.md"
CandidateInfoSheetPDFOutputFIle="$BUILD_OUTPUT_DIR/recruiter/CandidateInfoSheet.pdf"

JobBoardMarkdownOutputFile="$BUILD_TEMP_DIR/JobBoard-Resume.md"
JobBoardPDFOutputFile="$BUILD_OUTPUT_DIR/job-board/CharlesNWyble-Resume.pdf"
JobBoardMSWordOutputFile="$BUILD_OUTPUT_DIR/job-board/CharlesNWyble-Resume.doc"

ClientSubmissionMarkdownOutputFile="$BUILD_TEMP_DIR/ClientSubmit-Resume.md"
ClientSubmissionPDFOutputFile="$BUILD_OUTPUT_DIR/client-submit/CharlesNWyble-Resume.pdf"
ClientSubmissionMSWordOutputFile="$BUILD_OUTPUT_DIR/client-submit/CharlesNWyble-Resume.doc"

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