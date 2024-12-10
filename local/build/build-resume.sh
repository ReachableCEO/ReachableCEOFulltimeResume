#!/bin/bash

# A client script to setup variables for and execute:
#../vendor/git.knownelement.com/reachableceo/MarkdownResume-Pipeline/build/build-pipeline-server.sh


#############################################################################
#SET THIS OR NOTHING WILL WORK
export PipelineClientWorkingDir="D:/tsys/@ReachableCEO/ReachableCEOResume/local"
#SET THIS OR NOTHING WILL WORK
#############################################################################

#############################################################################
#If you want a quick demo, you can leave the below values un-changed. Otherwise
#modify them to refelect your details/preferences.
#############################################################################



###################################################
# Modify these values to suit
###################################################

########################
# Contact info
########################

export CandidateName="Charles N Wyble"
export CandidatePhone="1 818 280 7059"
export CandidateLocation="Austin TX / Raleigh NC / Remote "
export CandidateEmail="reachableceo@reachableceo.com"

########################
# Profile information
########################

export CandidateOneLineSummary="Senior (**Staff level**) **System Engineer/SRE/Architect** with extensive Linux/Windows/Networking/Cyber security background and experience 
"
export CandidateLinkedin="https://www.linkedin.com/in/charles-wyble-412007337"
export CandidateGithub="https://www.github.com/reachableceo"
export CandidateTagline="Tenacity. Velocity. Focus."

########################
# Formatting options
########################

export CandidateLogo="D:\tsys\@ReachableCEO\ReachableCEO.png"
export SourceCode="https://git.knownelement.com/reachableceo/ReachableCEOResume"
export URLCOLOR="blue"
export PAGEBACKGROUND="$PipelineClientWorkingDir/build/background5.pdf"

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

##################################################################
# Setup globals for use by the build-pipeline-server.sh script
##################################################################


export MO_PATH="bash ../../vendor/git.knownelement.com/ExternalVendorCode/mo/mo"

export BUILD_TEMP_DIR="$PipelineClientWorkingDir/build-temp"
export BUILDYAML_JOBBOARD="$BUILD_TEMP_DIR/JobBoard.yml"
export BUILDYAML_CLIENTSUBMISSION="$BUILD_TEMP_DIR/ClientSubmission.yml"
export BUILDYAML_CANDIDATEINFOSHEET="$BUILD_TEMP_DIR/CandidateInfoSheet.yml"

export BUILD_OUTPUT_DIR="D:/tsys/@ReachableCEO/resume.reachableceo.com/"
export CandidateInfoSheetMarkdownOutputFile="$BUILD_OUTPUT_DIR/recruiter/CandidateInfoSheet.md"
export CandidateInfoSheetPDFOutputFIle="$BUILD_OUTPUT_DIR/recruiter/CandidateInfoSheet.pdf"

export JobBoardMarkdownOutputFile="$BUILD_OUTPUT_DIR/job-board/CharlesNWyble-Resume.md"
export JobBoardPDFOutputFile="$BUILD_OUTPUT_DIR/job-board/CharlesNWyble-Resume.pdf"
export JobBoardMSWordOutputFile="$BUILD_OUTPUT_DIR/job-board/CharlesNWyble-Resume.doc"

export ClientSubmissionMarkdownOutputFile="$BUILD_OUTPUT_DIR/client-submit/CharlesNWyble-Resume.md"
export ClientSubmissionPDFOutputFile="$BUILD_OUTPUT_DIR/client-submit/CharlesNWyble-Resume.pdf"
export ClientSubmissionMSWordOutputFile="$BUILD_OUTPUT_DIR/client-submit/CharlesNWyble-Resume.doc"

# Call the build-pipeline-server in the vendored repository to produce output artifacts

bash ../../vendor/git.knownelement.com/reachableceo/MarkdownResume-Pipeline/build/build-pipeline-server.sh
