#import "cover.typ": cover
#import "utils.typ": *


#let conf(
  degree: "",
  year: (),
  author: "",
  title: "",
  professor: none,
  language: "en",
  presentation_place: none,
  presentation_date: none,
  toc: true,
  logo: "new",
  bibliography_file: none,
  chapter_on_new_page: true,
  doc,
  license: false,
) = {
  /* TEXT */

  set text(size: 12pt, lang: language)

  set par(leading: 0.65em, spacing: 1em, first-line-indent: 1.8em, justify: true)


  /* HEADINGS */

  set heading(numbering: "1.")
  show heading: set text(azuluc3m)
  show heading: set block(above: 1.4em, below: 1em)
  show heading.where(level: 1): it => {
    if chapter_on_new_page { pagebreak(weak: true) }
    it
  }

  // allow to set headings with selector `<nonumber` to prevent numbering
  show selector(<nonumber>): set heading(numbering: none)


  /* FIGURES */

  // figure captions w/ blue
  show figure.caption: it => {
    [
      #set text(azuluc3m, weight: "semibold")
      #it.supplement #context it.counter.display(it.numbering):
    ]
    it.body
  }


  // more space around figures
  // https://github.com/typst/typst/issues/6095#issuecomment-2755785839
  show figure: it => {
    let figure_spacing = 0.75em

    if it.placement == none {
      block(it, inset: (y: figure_spacing))
    } else if it.placement == top {
      place(
        it.placement,
        float: true,
        block(width: 100%, inset: (bottom: figure_spacing), align(center, it)),
      )
    } else if it.placement == bottom {
      place(
        it.placement,
        float: true,
        block(width: 100%, inset: (top: figure_spacing), align(center, it)),
      )
    }
  }

  // captions on top for tables
  show figure.where(kind: table): set figure.caption(position: top)


  /* REFERENCES & LINKS */

  show ref: set text(azuluc3m)
  show link: set text(azuluc3m)


  /* FOOTNOTES */

  // change line color
  set footnote.entry(separator: line(length: 30% + 0pt, stroke: 0.5pt + azuluc3m))

  // change footnote number color
  show footnote: set text(azuluc3m) // in text
  show footnote.entry: it => {
    // in footnote
    h(1em) // indent
    {
      set text(azuluc3m)
      super(str(counter(footnote).at(it.note.location()).at(0))) // number
    }
    h(.05em) // mini-space in between number and body (same as default)
    it.note.body
  }


  /* PAGE LAYOUT */

  set page(
    paper: "a4",
    margin: (
      y: 2.5cm,
      x: 3cm,
    ),

    // header
    header: [
      #set text(azuluc3m)
      #h(1fr)

      #v(-0.7em)
      #line(length: 100%, stroke: 0.4pt + azuluc3m)
    ],

    // footer
    footer: context [
      #line(length: 100%, stroke: 0.4pt + azuluc3m)
      #v(-0.4em)

      #set align(right)
      #set text(azuluc3m)
      #author
      #h(1fr)
      #let page_delimeter = "of"
      #if language == "es" {
        page_delimeter = "de"
      }
      #counter(page).display(
        "pg. 1 " + page_delimeter + " 1",
        both: true,
      )
    ],
  )


  /* COVER */

  cover(
    degree,
    title,
    year,
    logo,
    author: author,
    professor: professor,
    language: language,
    presentation_place: presentation_place,
    presentation_date: presentation_date,
    license: license,
  )


  /* TOC */

  if toc {
    let outline_title = "Table of Contents"
    if language == "es" {
      outline_title = "Tabla de Contenidos"
    }
    outline(title: outline_title)
    pagebreak()
  }

  doc


  /* BIBLIOGRAPHY */

  if bibliography_file != none {
    pagebreak()
    bibliography(bibliography_file, style: "ieee")
  }
}
