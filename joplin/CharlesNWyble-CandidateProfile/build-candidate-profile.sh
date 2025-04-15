#!/bin/bash

set -euo pipefail

if [ -f "D:/tsys/ReachableCEOPublic/MarketingMaterials/outputs/profile-fte.reachableceo.com/CharlesNWyble-CandidateProfile.pdf" ]; 
then
    rm -vf "D:/tsys/ReachableCEOPublic/MarketingMaterials/outputs/profile-fte.reachableceo.com/CharlesNWyble-CandidateProfile.pdf" 
fi

pandoc \
CharlesNWyble-CandidateProfile.md \
--template "eisvogel" \
--metadata-file="./CharlesNWyble-CandidateProfile.yml" \
--from markdown \
--to=pdf \
--output D:/tsys/ReachableCEOPublic/MarketingMaterials/outputs/profile-fte.reachableceo.com/CharlesNWyble-CandidateProfile.pdf