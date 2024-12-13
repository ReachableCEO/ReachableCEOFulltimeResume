#!/bin/bash

# A client script to setup variables for and execute:
#../vendor/git.knownelement.com/reachableceo/MarkdownResume-Pipeline/build/build-pipeline-server.sh



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
