#!/bin/bash

#####################################################################################################
#JSON Resume
#####################################################################################################

####################################################
####################################################
####################################################
#DO NOT CHANGE ANYTHING BELOW THIS LINE
####################################################
####################################################
####################################################

add_open_section() 

{

echo "{" > $BUILD_OUTPUT_DIR/resume.json

}

add_meta_section()

{

cat << META >> $BUILD_OUTPUT_DIR/resume.json
  "meta": {
    "theme": "$JSONRESUME_THEME"
  },
META

}



add_basics_section() 

{

cat << BASICS >> $BUILD_OUTPUT_DIR/resume.json

  "basics": {
    "name": "$CandidateName",
    "phone": "$CandidatePhone",
    "label": "$CandidateRole",
    "image": "$CandidateAvatar",
    "summary": "$CandidateOneLineSummary",
    "website": "$CandidateWebsite",
    "url": "https://lordajax.com",
    "email": "$CandidateEmail",
    "location": {
      "city": "$CandidateLocation",
      "countryCode": "$CandidateCountry"
    },
  },
BASICS

}


# Bash Function to Append JSON
add_profiles_section () 

{

  echo '{"profiles": [' >> $BUILD_OUTPUT_DIR/resume.json
  while IFS=, read -r username url network; do
    cat <<EOF >> $BUILD_OUTPUT_DIR/resume.json
    {
      "username": "$username",
      "url": "$url",
      "network": "$network"
    },
EOF
  done < $JSON_TEMPLATE_DIRECTORY/profiles.csv
  # Remove trailing comma and close JSON array
  sed -i '$ s/},/}/' $BUILD_OUTPUT_DIR/resume.json
  echo ']}' >> $BUILD_OUTPUT_DIR/resume.json

}

add_certificates_section() 

{

  echo '{"certificates": [' >> $BUILD_OUTPUT_DIR/resume.json
  while IFS=, read -r name date issuer url; do
    cat <<EOF >> $BUILD_OUTPUT_DIR/resume.json
    {
      "name": "$name",
      "date": "$date",
      "issuer": "$issuer",
      "url": "$url"
    },
EOF
  done < $JSON_TEMPLATE_DIRECTORY/certificates.csv

  # Remove trailing comma and close JSON array
  sed -i '$ s/},/}/' $BUILD_OUTPUT_DIR/resume.json
  echo ']}' >> $BUILD_OUTPUT_DIR/resume.json

}

add_education_section() 

{

  echo '{"education": [' >> $BUILD_OUTPUT_DIR/resume.json
  while IFS=, read -r institution url area studyType startDate endDate score courses; do
    cat <<EOF >> $BUILD_OUTPUT_DIR/resume.json
    {
      "institution": "$institution",
      "url": "$url",
      "area": "$area",
      "studyType": "$studyType",
      "startDate": "$startDate",
      "endDate": "$endDate",
      "score": "$score",
      "courses": [$(echo "$courses" | sed 's/;/","/g' | sed 's/^/"/;s/$/"/')]
    },
EOF
  done < $JSON_TEMPLATE_DIRECTORY/education.csv

  # Remove trailing comma and close JSON array
  sed -i '$ s/},/}/' $BUILD_OUTPUT_DIR/resume.json
  echo ']}' >> $BUILD_OUTPUT_DIR/resume.json

}

add_references_section() 

{

  echo '{"references": [' >> $BUILD_OUTPUT_DIR/resume.json
  while IFS=, read -r reference name; do
    cat <<EOF >> $BUILD_OUTPUT_DIR/resume.json
    {
      "reference": "$reference",
      "name": "$name"
    },
EOF
  done < $JSON_TEMPLATE_DIRECTORY/references.csv

  # Remove trailing comma and close JSON array
  sed -i '$ s/},/}/' $BUILD_OUTPUT_DIR/resume.json
  echo ']}' >> $BUILD_OUTPUT_DIR/resume.json

}

add_skills_section() 

{

  echo '{"skills": [' >> $BUILD_OUTPUT_DIR/resume.json
  while IFS=, read -r name level keywords; do
    cat <<EOF >> $BUILD_OUTPUT_DIR/resume.json
    {
      "name": "$name",
      "level": "$level",
      "keywords": [$(echo "$keywords" | sed 's/;/","/g' | sed 's/^/"/;s/$/"/')]
    },
EOF
  done < $JSON_TEMPLATE_DIRECTORY/skills.csv

  # Remove trailing comma and close JSON array
  sed -i '$ s/},/}/' $BUILD_OUTPUT_DIR/resume.json
  echo ']}' >> $BUILD_OUTPUT_DIR/resume.json

}

add_awards_section() 

{

  echo '{"awards": [' >> $BUILD_OUTPUT_DIR/resume.json
  while IFS=, read -r title awarder date summary; do
    cat <<EOF >> $BUILD_OUTPUT_DIR/resume.json
    {
      "title": "$title",
      "awarder": "$awarder",
      "date": "$date",
      "summary": "$summary"
    },
EOF
  done < $JSON_TEMPLATE_DIRECTORY/awards.csv

  # Remove trailing comma and close JSON array
  sed -i '$ s/},/}/' $BUILD_OUTPUT_DIR/resume.json
  echo ']}' >> $BUILD_OUTPUT_DIR/resume.json

}

add_publications_section() 

{

  echo '{"publications": [' >> $BUILD_OUTPUT_DIR/resume.json
  while IFS=, read -r name publisher releaseDate url summary; do
    cat <<EOF >> $BUILD_OUTPUT_DIR/resume.json
    {
      "name": "$name",
      "publisher": "$publisher",
      "releaseDate": "$releaseDate",
      "url": "$url",
      "summary": "$summary"
    },
EOF
  done < $JSON_TEMPLATE_DIRECTORY/publications.csv

  # Remove trailing comma and close JSON array
  sed -i '$ s/},/}/' $BUILD_OUTPUT_DIR/resume.json
  echo ']}' >> $BUILD_OUTPUT_DIR/resume.json

}

add_volunteer_section() 

{

  echo '{"volunteer": [' >> $BUILD_OUTPUT_DIR/resume.json
  while IFS=, read -r organization position url startDate summary highlights; do
    cat <<EOF >> $BUILD_OUTPUT_DIR/resume.json
    {
      "organization": "$organization",
      "position": "$position",
      "url": "$url",
      "startDate": "$startDate",
      "summary": "$summary",
      "highlights": [$(echo "$highlights" | sed 's/;/","/g' | sed 's/^/"/;s/$/"/')]
    },
EOF
  done < $JSON_TEMPLATE_DIRECTORY/volunteer.csv

  # Remove trailing comma and close JSON array
  sed -i '$ s/},/}/' $BUILD_OUTPUT_DIR/resume.json
  echo ']}' >> $BUILD_OUTPUT_DIR/resume.json

}

add_work_section() 

{

  echo '{"work": [' >> $BUILD_OUTPUT_DIR/resume.json
  while IFS=, read -r name position location website startDate endDate summary highlights; do
    cat <<EOF >> $BUILD_OUTPUT_DIR/resume.json
    {
      "name": "$name",
      "position": "$position",
      "location": "$location",
      "website": "$website",
      "startDate": "$startDate",
      "endDate": "$endDate",
      "summary": "$summary",
      "highlights": [$(echo "$highlights" | sed 's/;/","/g' | sed 's/^/"/;s/$/"/')]
    },
EOF
  done < $JSON_TEMPLATE_DIRECTORY/work.csv

  # Remove trailing comma and close JSON array
  sed -i '$ s/},/}/' $BUILD_OUTPUT_DIR/resume.json
  echo ']}' >> $BUILD_OUTPUT_DIR/resume.json

}


add_languages_section() 

{

  echo '{"languages": [' >> $BUILD_OUTPUT_DIR/resume.json
  while IFS=, read -r language fluency; do
    cat <<EOF >> $BUILD_OUTPUT_DIR/resume.json
    {
      "language": "$language",
      "fluency": "$fluency"
    },
EOF
  done < $JSON_TEMPLATE_DIRECTORY/languages.csv

  # Remove trailing comma and close JSON array
  sed -i '$ s/},/}/' $BUILD_OUTPUT_DIR/resume.json
  echo ']}' >> $BUILD_OUTPUT_DIR/resume.json

}

add_interests_section() 

{

  echo '{"interests": [' >> $BUILD_OUTPUT_DIR/resume.json
  while IFS=, read -r name keywords; do
    cat <<EOF >> $BUILD_OUTPUT_DIR/resume.json
    {
      "name": "$name",
      "keywords": [$(echo "$keywords" | sed 's/;/","/g' | sed 's/^/"/;s/$/"/')]
    },
EOF
  done < $JSON_TEMPLATE_DIRECTORY/interests.csv

  # Remove trailing comma and close JSON array
  sed -i '$ s/},/}/' $BUILD_OUTPUT_DIR/resume.json
  echo ']}' >> $BUILD_OUTPUT_DIR/resume.json

}

add_close_section() 

{

echo "}" >> $BUILD_OUTPUT_DIR/resume.json

}

main()

{

  add_open_section
  add_meta_section 
  add_basics_section 
  add_profiles_section 
  add_work_section 
  add_volunteer_section 
  add_education_section 
  add_awards_section 
  add_certificates_section 
  add_publications_section 
  add_skills_section 
  add_languages_section 
  add_interests_section 
  add_references_section 
  add_close_section

}


main