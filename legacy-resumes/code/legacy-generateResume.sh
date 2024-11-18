#!/bin/bash

# A script to generate pdf/doc resume file
# Two versions
# Comprehensive (more for long form reading by humans)
# Chronological (more for machine consumption/short form reading for humans)

#Globals

export ai1_resume_file="AllInOneResume.md"
export ai1_PDF_OUTPUT_FILE="CharlesNWyble-December2023-ComprehensiveResume.pdf"
export ai1_DOC_OUTPUT_FILE="CharlesWyble-December2023-ComprehensiveResume.docx"

export chron_resume_file="ChronologicalResume.md"
export chron_PDF_OUTPUT_FILE="CharlesNWyble-December2023-ChronologicalResume.pdf"
export chron_DOC_OUTPUT_FILE="CharlesWyble-December2023-ChronologicalResume.docx"

export ar24_resume_file="CharlesNWyble-Apple-2024Resume.md"
export ar24_PDF_OUTPUT_FILE="CharlesNWyble-February2024-ComprehensiveAppleResume.pdf"
export ar24_DOC_OUTPUT_FILE="CharlesWyble-February2024-ComprehensiveAppleResume.docx"


function prevRunCleanup()
{
#echo "Cleaning up all in one resume output files..."
#rm output/$ai1_DOC_OUTPUT_FILE
#rm output/$ai1_PDF_OUTPUT_FILE

#echo "Cleaning up chronological resume output files..."
#rm output/$chron_DOC_OUTPUT_FILE
#rm output/$chron_PDF_OUTPUT_FILE

echo "Cleaning up apple 2024 internal fte resume output files..."
rm output/$ar24_DOC_OUTPUT_FILE
rm output/$ar24_PDF_OUTPUT_FILE
}

function makeOutput()
{

echo "Creating all in one PDF..."

#pandoc \
#	< input/$ai1_resume_file \
#    --from=markdown \
#	--output=output/$ai1_DOC_OUTPUT_FILE

echo "Creating all in one DOC..."

#pandoc \
#	< input/$ai1_resume_file \
#    --from=markdown \
#	-V geometry:margin=0.0in \
#	--output=output/$ai1_PDF_OUTPUT_FILE

echo "Creating chronological DOC..."

#pandoc \
#	< input/$chron_resume_file \
#    --from=markdown \
#	--output=output/$chron_DOC_OUTPUT_FILE

echo "Creating chronological PDF..."

#pandoc \
#	< input/$ai1_resume_file \
#    --from=markdown \
#	-V geometry:margin=0.0in \
#	--output=output/$chron_PDF_OUTPUT_FILE

echo "Creating apple FTE DOC..."

pandoc \
	< input/$ar24_resume_file \
    --from=markdown \
	--output=output/$ar24_DOC_OUTPUT_FILE

echo "Creating apple FTE PDF..."

pandoc \
	< input/$ar24_resume_file \
    --from=markdown \
	-V geometry:margin=0.5in \
	--output=output/$ar24_PDF_OUTPUT_FILE 
}

prevRunCleanup
makeOutput