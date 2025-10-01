#let abstract(body, lang: "en") = {

  set page(
    margin: (left: 2.5cm, right: 1.75cm, top: 4cm, bottom: 2cm),
    numbering: none,
    number-align: center,
  )

  let body-font = "Arial"
  let sans-font = "Arial"


  set text(
    font: body-font, 
    size: 10pt, 
    lang: lang
  )

  set par(
    leading: 1em,
    justify: true
  )

  let title = (en: "Abstract", de: "Zusammenfassung")
  heading(title.at(lang), numbering: none)

  // --- Abstract ---

  body
}

