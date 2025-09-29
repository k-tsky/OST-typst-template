#import "@local/ost-template:0.0.1": *
#import "./metadata.typ": *

//Add your content here:
#include "./content/01-content.typ"

#set document(title: title, author: author)

#show: project.with(
  language: language,
  title: title,
  subtitle: subtitle,
  type: type,
  professor: professor,
  author: author,
  submission-date: submission-date,
  abstract: include "./content/abstract.typ",
  appendix: include "./appendix/appendix.typ",
  bibliography-as-bytes: read("./appendix/bibliography.bib", encoding: none),
  
  //Toggle the prameters as needed
  include-figures: true,
  include-tables: true,
  include-code: false,
)
