#import "/layout/title-page.typ": *


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

  set page(
    header: context {
      box(image("../template/figures/OST-logo.jpg"))
      // Find first level-1 heading on this page (if any).
      let h = query(heading.where(level: 1).after(here()))
        .filter(h => h.location().page() == here().page())
        .at(
          0,
          default: {
            // Fall back to last previous heading.
            query(heading.where(level: 1).before(here())).at(-1, default: none)
          },
        )

      if h != none {
        // Create number from counter value and numbering.

        [
          #align(end, text(size: 11pt, weight: 400, h.body))
          #v(2mm)
        ]
      }

    },
    footer: context{
      align(center, author)
    }
  )

  let body-font = "Arial"

  set text(
    font: body-font,
    size: 10pt,
    lang: language,
  )

  show math.equation: set text(weight: 400)

//TODO: setup tables
  // set table(
  //   stroke: (x, y) => (
  //     y: if y == 1 {
  //       2pt + gray
  //     } else {
  //       1pt + gray
  //     },
  //     x: 1pt + gray,
  //   ),

  //   fill: (x, y) => if y == 0 {
  //     rgb(55, 126, 57)
  //   },
  // )
  // show table.cell: it => {
  //   if it.y == 0 {
  //     set text(white)
  //     strong(it)
  //   } else {
  //     it
  //   }
  // }

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

  set page(
    margin: (left: 2.5cm, right: 1.75cm, top: 4cm, bottom: 2cm),
    numbering: "1",
    number-align: right,
  )

  counter(page).update(1)

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

  body

  // Appendix.
  if appendix != "" {
    pagebreak()
    let appendixTitle = (en: "Appendix", de: "Anhang")
    heading(numbering: none)[#appendixTitle.at(language)]
    appendix
  }

  if bibliography-as-bytes != bytes("") {
    pagebreak()
    let bibliographyTitle = (en: "References", de: "Literaturverzeichnis")
    bibliography(bibliography-as-bytes, style: "apa", title: bibliographyTitle.at(language))
  }
 
}