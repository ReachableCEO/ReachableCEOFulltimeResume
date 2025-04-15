#!/bin/bash

set -euo pipefail

if [ -f CharlesNWyble-CandidateProfile.pdf ] ; then
    rm -vf CharlesNWyble-CandidateProfile.pdf
fi

pandoc \
CharlesNWyble-CandidateProfile.md \
--template "eisvogel" \
--metadata-file="./CharlesNWyble-CandidateProfile.yml" \
--from markdown \
--to=pdf \
--output CharlesNWyble-CandidateProfile.pdf