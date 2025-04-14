#!/bin/bash

pandoc \
CharlesNWyble-CandidateProfile-Detail.md \
--template "eisvogel" \
--metadata-file="./BuildTemplate-CandidateInfoSheet.yml" \
--from markdown \
--to=pdf \
--output CharlesNWyble-CandidateProfile-Detail.pdf
