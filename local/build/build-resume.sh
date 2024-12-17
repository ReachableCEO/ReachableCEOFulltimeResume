#!/bin/bash

# A client script to setup variables for and execute:
#../vendor/git.knownelement.com/reachableceo/MarkdownResume-Pipeline/build/build-pipeline-server.sh

source ./CandidateVariables.env


####################################################
#DO NOT CHANGE ANYTHING BELOW THIS LINE
####################################################


##################################################################
# Setup globals for use by the build-pipeline-server.sh script
##################################################################

export MO_PATH="bash ../../vendor/git.knownelement.com/ExternalVendorCode/mo/mo"
export BUILD_TEMP_DIR="$PipelineClientWorkingDir/build-temp/MarkdownResume"
export BUILDYAML_JOBBOARD="$BUILD_TEMP_DIR/JobBoard.yml"
export BUILDYAML_CLIENTSUBMISSION="$BUILD_TEMP_DIR/ClientSubmission.yml"
export BUILDYAML_CANDIDATEINFOSHEET="$BUILD_TEMP_DIR/CandidateInfoSheet.yml"

# Cleanup previous intermediatge and final output artifacts

rm $BUILD_TEMP_DIR/*.yml
rm $BUILD_TEMP_DIR/*.md

rm $BUILD_OUTPUT_DIR/client-submit/*
rm $BUILD_OUTPUT_DIR/job-board/*
rm $BUILD_OUTPUT_DIR/recruiter/*

# Call the build-pipeline-server in the vendored repository to produce updated output artifacts

bash ../../vendor/git.knownelement.com/reachableceo/MarkdownResume-Pipeline/build/build-pipeline-server-markdown.sh