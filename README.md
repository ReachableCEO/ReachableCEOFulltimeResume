# ReachableCEOResume

- [ReachableCEOResume](#reachableceoresume)
  - [Introduction](#introduction)
  - [Directory Overview](#directory-overview)
  - [Build pipeline](#build-pipeline)
    - [Outputs](#outputs)
  - [Skills](#skills)
  - [Projects](#projects)
  - [Production Use](#production-use)

## Introduction

Resume formatting/publication/management is difficult, tedious, annoying etc. The @ReachableCEO has hacked the process and made it easy!

## Directory Overview

- ancillary-support-files: contains the markdown/build script for the @ReachableCEO candidate information sheet. This is my standard reply to recruiters to eliminate an average of 6 emails/phone calls per inbound lead. It has my rate sheet and all the standard "matrix" tables they need to fill out for submission to an end client (or, in reality, to the US based recruiting team who interfaces with the client).
- boilerplate: contact info (one version for the recruiter facing resume, one version for client facing).
- build: build scripts for the job board/recruiter facing resume and one for client facing. I use a two stage build process, allowing for modification to the combined markdown file before turning into PDF/Word format.
- EmployerItems: details for each position listed in WorkHistory/WorkHistory.csv.
- MarkdownOutput: the combined markdown file that gets fed to pandoc.
- SkillsAndProjects: This contains what the name says. Holds a skills.csv file that gets turned into a skills table and a projects file that gets placed at beginning of resume as a career highlights section.
- WorkHistory: contains the WorkHistory.csv file used by the build script to generate Employment History section.

## Build pipeline

In the build directory:

- build-client-submit-* : Builds a version suited for recruiters to send to end clients.
- build-jobBoard-* : Builds a version that will be correctly parsed/auto populate profiles on Teal/Dice/Monster/Indeed/Glassdoor/ZipRecruiter. It appears LinkedIn doesn't parse an uploaded resume into a profile.
- CharlesNWyble-* : YAML metadata files for pandoc use when creating PDF/Word output.
- resume-docx-reference.docx: Template "style" file for Word output.

### Outputs

- Word format output is a best effort . The style file was sourced from : https://sdsawtelle.github.io/blog/output/simple-markdown-resume-with-pandoc-and-wkhtmltopdf.html
- PDF output is considered production. Please see: https://github.com/Wandmalfarbe/pandoc-latex-template and https://github.com/ReachableCEO/rcdoc-pipeline if you want to re-create/modify the build pipeline.

## Skills

Edit the skills.csv file in SkillsAndProjects. The build scripts will turn that into a nicely formatted table in the generated PDF/Word output. Use two spaces to control line breaks. Wrapping/breaks was the trickiest part to get right.

## Projects

Edit the Projects.md file in SkillsAndProjects. The build script will turn that into a career highlights section in the generated PDF/Word output.

## Production Use

These assets are in production use at the [ReachableCEO Career Site](https://resume.reachableceo.com) and uploaded to all major job portals. This was a labor of love by the @ReachableCEO in the hopes others can massively optimize the job hunt process.
