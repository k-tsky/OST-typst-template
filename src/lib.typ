#import "/layout/title-page.typ": *
#import "/layout/abstract.typ": abstract as abstract_layout
#import "/layout/disclaimer.typ": *

#let project(
  title: "",
  subtitle: "",
  type: "",
  professor: "",
  author: "",
  submission-date: datetime,
  abstract: "",
  language: "en",
  appendix: "",
  is-print: false,
  bibliography-as-bytes: bytes(""),
  body,
  include-figures: true,
  include-tables: true,
  include-code: true,
  include-abstract: true,
  include-appendix: true,
  include-references: true
) = {
  assert(language in ("de", "en"), message: "The language supported are only 'de' and 'en'.")

  title-page(
    title: title,
    subtitle: subtitle,
    type: type,
    professor: professor,
    author: author,
    submission-date: submission-date,
    language: language,
  )

 pagebreak()

  set page(
    margin: (left: 2.5cm, right: 1.75cm, top: 4cm, bottom: 2cm),
    numbering: none,
  )

  counter(page).update(1)

  set page(
    margin: (left: 2.5cm, right: 1.75cm, top: 4cm, bottom: 2cm),
    header: context {
      grid(
        columns: 2,
        gutter: 1fr,
          [
          #let h = query(heading.where(level: 1).after(here())).filter(x => x.location().page() == here().page()).at(0, default: query(heading.where(level: 1).before(here())).at(-1, default: none))

          #if h != none {
            align(right)[
              #text(size: 9pt, weight: 400)[#h.body]
            ]
          }
        ],
        [#image("../template/figures/OST-logo.jpg", width: 4cm)]
      )
    }
,
    footer: context{
      text(9pt,
        grid(
        columns: 3,
        gutter: 1fr,
        [#title],
        [#author],
        [#counter(page).display("1/1", both: true)]
        )
      )
    }
  )

  let body-font = "Arial"

  set text(
    font: body-font,
    size: 10pt,
    lang: language,
  )

  show math.equation: set text(weight: 400)

  // --- Headings ---
  show heading: set block(below: 0.85em, above: 1.75em)
  show heading: set text(font: body-font)
  set heading(numbering: "1.1")
  // Reference first-level headings as "chapters"
  let chapter = (en: "Chapter", de: "Kapitel")
  show ref.where(form: "normal"): it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 {
      chapter.at(language) + " "
      numbering(
        el.numbering,
        ..counter(heading).at(el.location()),
      )
    } else {
      it
    }
  }
  if include-abstract{
    if abstract != "" {
      abstract_layout(lang: language)[#abstract]
    }
  }

  // --- Paragraphs ---
  set par(leading: 1em)

  // --- Citations ---
  set cite(style: "alphanumeric")

  // --- Figures ---
  show figure: set text(size: 0.85em)

  // --- Table of Contents ---
  let tocTitle = (en: "Table of Contents", de: "Inhaltsverzeichnis")

  show outline.entry.where(level: 1): it => {
    strong(text(size: 12pt, it))
  }
  show outline.entry.where(level: 2): it => {
    text(size: 11pt, it)
  }
  show outline.entry.where(level: 3): it => {
    text(size: 10.5pt, it)
  }
  show outline.entry.where(level: 4): it => {
    text(size: 10pt, it)
  }

  outline(
    title: tocTitle.at(language),
    indent: 2em,
  )


  v(2.4fr)
  pagebreak()

  // List of figures
  if include-figures {
    let figureListTitle = (en: "List of Figures", de: "Abbildungsverzeichnis")
    heading(numbering: none)[#figureListTitle.at(language)]
    outline(
      title: "",
      target: figure.where(kind: "image"),
    )
    pagebreak()
  }

  // List of tables
  if include-tables {
    let tableListTitle = (en: "List of Tables", de: "Tabellenverzeichnis")
    heading(numbering: none)[#tableListTitle.at(language)]
    outline(
      title: "",
      target: figure.where(kind: "table"),
    )
    pagebreak()
  }

  // List of code
  if include-code {
    let codeListTitle = (en: "List of Code", de: "Codeverzeichnis")
    heading(numbering: none)[#codeListTitle.at(language)]
    outline(
      title: "",
      target: figure.where(kind: auto),
    )
    pagebreak()

  }
  // Main body.
  set par(justify: true)
  show heading.where(depth: 1): body => {    
    pagebreak(weak: true)
    body
  }
  
  body



  // Appendix.

  if include-appendix{
    if appendix != "" {
      pagebreak()
      let appendixTitle = (en: "Appendix", de: "Anhang")
      heading(numbering: none)[#appendixTitle.at(language)]
      appendix
    }
  }

  if include-references{
    if bibliography-as-bytes != bytes("") {
      pagebreak()
      let bibliographyTitle = (en: "References", de: "Literaturverzeichnis")
      bibliography(bibliography-as-bytes, style: "apa", title: bibliographyTitle.at(language))
    }
  }


  disclaimer(
    title: title,
    author: author,
    language: language,
    submission-date: submission-date,
  )

}