#!/bin/bash

MarkdownOutputFile="./output/Client-Submit-CharlesNWybleResume.md"
rm $MarkdownOutputFile

# Combine markdown files into single intermediate markdown file

#Pull in my contact info
cat "./Contact-Info-Client-Submit.md" >> $MarkdownOutputFile
echo " " >> $MarkdownOutputFile

echo "## Highlights from my 22 year IT career" >> $MarkdownOutputFile

cat Projects.md >> "$MarkdownOutputFile"

echo "\pagebreak" >> $MarkdownOutputFile

echo " " >> $MarkdownOutputFile
echo "## Employment History" >> $MarkdownOutputFile
echo " " >> $MarkdownOutputFile

#And here we do some magic...
#Pull in my :

# employer
# title
# start/end dates of employment 
# long form position summary data from each position

IFS=$'\n\t'
for position in \
$(cat ./WorkHistory.csv); do

COMPANY="$(echo $position|awk -F ',' '{print $1}')"
TITLE="$(echo $position|awk -F ',' '{print $2}')"
DATEOFEMPLOY="$(echo $position|awk -F ',' '{print $3}')"

echo "**$COMPANY | $TITLE | $DATEOFEMPLOY**" >> $MarkdownOutputFile
echo " " >> "$MarkdownOutputFile"

cat ./$COMPANY.md >> "$MarkdownOutputFile"
echo " " >> "$MarkdownOutputFile"
done
unset IFS

#Pull in my skills and generate a beautiful table.

echo "\pagebreak" >> $MarkdownOutputFile
echo " " >> "$MarkdownOutputFile"
echo "## Skills" >> "$MarkdownOutputFile"
echo " " >> "$MarkdownOutputFile"

#Table heading

echo "|Skill|Experience|Skill Details|" >> $MarkdownOutputFile
echo "|---|---|---|" >> $MarkdownOutputFile
#Table rows
IFS=$'\n\t'
for skill in \
$(cat ./Skills.csv); do
SKILL_NAME="$(echo $skill|awk -F '|' '{print $1}')"
SKILL_YEARS="$(echo $skill|awk -F '|' '{print $2}')"
SKILL_DETAIL="$(echo $skill|awk -F '|' '{print $3}')"
echo "|**$SKILL_NAME**|$SKILL_YEARS|$SKILL_DETAIL|" >> $MarkdownOutputFile
done
unset IFS