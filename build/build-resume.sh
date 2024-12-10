#!/bin/bash

# A client script to setup variables for and execute:
#../vendor/git.knownelement.com/reachableceo/MarkdownResume-Pipeline/build/build-pipeline-server.sh


#############################################################################
#SET THIS OR NOTHING WILL WORK
export PipelineClientWorkingDir="D:/tsys/@ReachableCEO/MarkdownResume-Pipeline-ClientExample/local"
#SET THIS OR NOTHING WILL WORK
#############################################################################

#############################################################################
#If you want a quick demo, you can leave the below values un-changed. Otherwise
#modify them to refelect your details/preferences.
#############################################################################

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
export PAGEBACKGROUND="$PipelineClientWorkingDir/build/background3.pdf"

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

##################################################################
# Setup globals for use by the build-pipeline-server.sh script
##################################################################


export MO_PATH="bash ../../vendor/git.knownelement.com/ExternalVendorCode/mo/mo"
export BUILD_OUTPUT_DIR="$PipelineClientWorkingDir/build-output"
export BUILD_TEMP_DIR="$PipelineClientWorkingDir/build-temp"
export BUILDYAML_JOBBOARD="$BUILD_TEMP_DIR/JobBoard.yml"
export BUILDYAML_CLIENTSUBMISSION="$BUILD_TEMP_DIR/ClientSubmission.yml"
export BUILDYAML_CANDIDATEINFOSHEET="$BUILD_TEMP_DIR/CandidateInfoSheet.yml"

export CandidateInfoSheetMarkdownOutputFile="$BUILD_OUTPUT_DIR/CandidateInfoSheet.md"
export CandidateInfoSheetPDFOutputFIle="$BUILD_OUTPUT_DIR/CandidateInfoSheet.pdf"

export JobBoardMarkdownOutputFile="$BUILD_OUTPUT_DIR/job-board/Resume.md"
export JobBoardPDFOutputFile="$BUILD_OUTPUT_DIR/job-board/Resume.pdf"
export JobBoardMSWordOutputFile="$BUILD_OUTPUT_DIR/job-board/Resume.doc"

export ClientSubmissionMarkdownOutputFile="$BUILD_OUTPUT_DIR/client-submission/Resume.md"
export ClientSubmissionPDFOutputFile="$BUILD_OUTPUT_DIR/client-submission/Resume.pdf"
export ClientSubmissionMSWordOutputFile="$BUILD_OUTPUT_DIR/client-submission/Resume.doc"

# Call the build-pipeline-server in the vendored repository to produce output artifacts

bash ../../vendor/git.knownelement.com/reachableceo/MarkdownResume-Pipeline/build/build-pipeline-server.sh
