#let disclaimer(
  title: "",
  author: "",
  language: "en",
  submission-date: datetime,
) = {
  set page(
    margin: (left: 2.5cm, right: 1.75cm, top: 4cm, bottom: 2cm),
  )

  let body-font = "Arial"
  let sans-font = "Arial"

  set text(
    font: body-font, 
    size: 10pt, 
    lang: "en"
  )

  set par(leading: 1em)

  
  // --- Disclaimer --- 
  let title = (en: "Declaration of Authorship", de: "Eigenständigkeitserklärung")
  heading(title.at(language), numbering: none)
  let disclaimer = (
    en:  grid(
      columns: (30mm, 1fr),
      gutter: 6mm,
      align: top,

      [*Declaration*],
      [
        I hereby confirm that I have written this work independently and have not used any
        sources or resources other than those specified. I am responsible for the quality of the text
        and the selection of all content and have ensured that information and arguments are documented 
        or supported by suitable scientific sources. I have clearly marked the texts, lines of thought, 
        concepts, graphics, etc. in my statements that have been taken from external sources and have 
        provided full references to the respective source. The work has not yet been submitted to any 
        other examination authority and has not yet been published.
      ],

      [*Without text-generating AI*],
      [
        In addition, I confirm that I have written this work entirely independently, i.e. I have not 
        used any AI-generated text passages. I also confirm that I have not used any other AI writing 
        tools whose use my supervisor has explicitly excluded in writing.
      ],

      [*Violation*],
      [
        I am aware that a violation of the above points may have consequences under examination law 
        and may result in the examination performance being assessed as *“unsatisfactory”* or *“failed”*.
      ],

      [*Place/Date*],
      [
        Rapperswil, #submission-date.display("[day]/[month]/[year]")
      ],

      [*Signature Author*],
      [
        #v(3cm) // space for signatures
      ],
    ),

 
  de: [

  ])
  text(disclaimer.at(language))

  v(15mm)
  grid(
      columns: 2,
      gutter: 1fr,
      "Rapperswil, " + submission-date.display("[day]/[month]/[year]"), author
  )
}