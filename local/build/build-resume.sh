#!/bin/bash

# Exit on error
set -e

# A client script to setup variables for and execute the markdown resume pipeline
# Executes: ../../vendor/git.knownelement.com/reachableceo/MarkdownResume-Pipeline/build/build-pipeline-server-markdown.sh

# Check if CandidateVariables.env exists
if [ ! -f "./CandidateVariables.env" ]; then
	echo "Error: CandidateVariables.env not found"
	exit 1
fi

# Source the environment file with error handling
if ! source ./CandidateVariables.env; then
	echo "Error: Failed to source CandidateVariables.env. Please check the file for syntax errors."
	exit 1
fi

# Verify required environment variables
required_vars=("PipelineClientWorkingDir" "BUILD_OUTPUT_DIR")
for var in "${required_vars[@]}"; do
	if [ -z "${!var}" ]; then
		echo "Error: Required environment variable $var is not set"
		exit 1
	fi
done

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

# Create necessary directories if they don't exist
mkdir -p "$BUILD_TEMP_DIR"
mkdir -p "$BUILD_OUTPUT_DIR/client-submit"
mkdir -p "$BUILD_OUTPUT_DIR/job-board"
mkdir -p "$BUILD_OUTPUT_DIR/recruiter"

# Cleanup previous intermediate and final output artifacts
rm -vf "$BUILD_TEMP_DIR"/*.yml
rm -vf "$BUILD_TEMP_DIR"/*.md

rm -vf "$BUILD_OUTPUT_DIR"/client-submit/*
rm -vf "$BUILD_OUTPUT_DIR"/job-board/*
rm -vf "$BUILD_OUTPUT_DIR"/recruiter/*

# Verify pipeline server script exists
PIPELINE_SERVER="../../vendor/git.knownelement.com/reachableceo/MarkdownResume-Pipeline/build/build-pipeline-server-markdown.sh"
if [ ! -f "$PIPELINE_SERVER" ]; then
	echo "Error: Pipeline server script not found at: $PIPELINE_SERVER"
	exit 1
fi

# Call the build-pipeline-server in the vendored repository to produce updated output artifacts
bash "$PIPELINE_SERVER"