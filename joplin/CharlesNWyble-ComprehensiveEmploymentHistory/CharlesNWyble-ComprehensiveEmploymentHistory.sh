#!/bin/bash

set -euo pipefail

if [ -f "D:/tsys/ReachableCEOPublic/MarketingMaterials/outputs/profile-fte.reachableceo.com/CharlesNWyble-ComprehensiveEmploymentHistory.pdf" ]; 
then
    rm -vf "D:/tsys/ReachableCEOPublic/MarketingMaterials/outputs/profile-fte.reachableceo.com/CharlesNWyble-ComprehensiveEmploymentHistory.pdf" 
fi

pandoc \
CharlesNWyble-ComprehensiveEmploymentHistory.md \
--template "eisvogel" \
--metadata-file="./CharlesNWyble-ComprehensiveEmploymentHistory.yml" \
--from markdown \
--to=pdf \
--output D:/tsys/ReachableCEOPublic/MarketingMaterials/outputs/profile-fte.reachableceo.com/CharlesNWyble-ComprehensiveEmploymentHistory.pdf