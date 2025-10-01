# OST Thesis Template (Typst)

A Typst template for theses and academic reports at the OST (Ostschweizer Fachhochschule).  
The template provides a structured setup for creating professional-looking documents with title pages, lists of figures/tables/code and localized support for English and German.

This project builds on top of the [unisg-thesis-template-typst](https://github.com/joshuabeny1999/unisg-thesis-template-typst) by [Joshua Beny](https://github.com/joshuabeny1999).  
A big thanks to the original author for the groundwork and inspiration!

---

## Features
- Multilingual support (German / English)  
- Ready-to-use thesis structure with title page, table of contents, and localized strings.
- Configurable toggles for figures, tables, code listings, abstract, appendix, and references.
- Centralized metadata file for author, supervisor, language, and submission details.
- Organized folders for content chapters, figures, appendices, and bibliography assets.

---

## Getting Started

### Authoring Content Pages
- Place new chapter or section files in `template/content/` and name them however you like (for example, `03-related-work.typ`).
- Register each file inside `template/main.typ` using additional `#include` statements so the content is part of the final document.

### Understanding `include-*` Switches
The `#show: project.with(...)` call in `template/main.typ` exposes boolean toggles that control generated lists and supplementary sections:

- `include-figures`: Enables the automatic list of figures.
- `include-tables`: Enables the automatic list of tables.
- `include-code`: Enables the automatic list of code.
- `include-abstract`: Inserts the abstract page (sourced from `content/abstract.typ`).
- `include-appendix`: Inserts the appendix material defined in `appendix/appendix.typ`.
- `include-references`: Prints the references generated from the bibliography file.

### Document Metadata
The template pulls display information from `template/metadata.typ`. Update the following fields to match your project:

- `language`: Either `"en"` or `"de"` to localize headings and labels.
- `title`: Main document title.
- `subtitle`: Optional subtitle shown on the title page.
- `type`: Thesis or report type description.
- `professor`: Supervising professor's full name and title.
- `author`: Primary author name as it should appear on the cover.
- `submission-date`: A `datetime` value representing the submission date.

### Figures, Appendices, and References
- Store figures inside `template/figures/` and reference them from your content files.
- Add appendix material to `template/appendix/` (for example, `appendix.typ` or supplementary `.typ` files) and toggle `include-appendix` when you want them rendered.
- Maintain bibliographic data in `template/appendix/bibliography.bib`; `template/main.typ` reads this file directly through the `bibliography-as-bytes` parameter so your references populate automatically when `include-references` is enabled.
