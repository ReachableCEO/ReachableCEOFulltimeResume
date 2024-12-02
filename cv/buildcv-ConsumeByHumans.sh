#!/bin/bash

#####################################
# Human readable CV
#####################################


HumanIntermediateOutputFile="./output/intermediate/human/CharlesNWybleCV.md"
rm $HumanIntermediateOutputFile

# Combine markdown files into single input file for pandoc

#Pull in my contact info
cat "../common/Contact-Info.md" >> $HumanIntermediateOutputFile
echo " " >> $HumanIntermediateOutputFile

echo "## Employment History" >> $HumanIntermediateOutputFile

#And here we do some magic...
#Pull in my :

# employer
# title
# start/end dates of employment 
# long form position summary data from each position

IFS=$'\n\t'
for position in \
$(cat ../common/WorkHistory.csv); do

COMPANY="$(echo $position|awk -F ',' '{print $1}')"
TITLE="$(echo $position|awk -F ',' '{print $2}')"
DATEOFEMPLOY="$(echo $position|awk -F ',' '{print $3}')"

echo " " >> "$HumanIntermediateOutputFile"
echo "**$COMPANY** | $TITLE | $DATEOFEMPLOY" >> $HumanIntermediateOutputFile
echo " " >> "$HumanIntermediateOutputFile"

cat ./$COMPANY.md >> "$HumanIntermediateOutputFile"
echo " " >> "$HumanIntermediateOutputFile"
done
unset IFS

# Run pandoc/etc to generate HTML/PDF/DOC into output dir

#First html/pdf/doc, for resume.reachableceo.com use

pandoc \
$HumanIntermediateOutputFile \
--template eisvogel \
--metadata-file=./HumanOutput-CV.yml \
--from markdown \
--to=pdf \
--output /d/tsys/@ReachableCEO/resume.reachableceo.com/cv/CharlesNWybleCV.pdf