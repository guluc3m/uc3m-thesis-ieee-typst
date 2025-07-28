#import "@preview/hydra:0.6.1": hydra

#import "cover.typ": cover
#import "utils.typ": *

#let conf(
  degree: none,
  title: none,
  author: none,
  advisors: (),
  place: none,
  date: none,
  bibliography_file: none,
  language: "en",
  toc: true,
  logo: "new",
  shortitle: none,
  chapter_on_new_page: true,
  doc,
) = {
  let in-frontmatter = state("in-frontmatter", true) // to control page number format in frontmatter
  let in-body = state("in-body", true) // to control heading formatting in/outside of body


  // ---------- Page Setup ---------------------------------------

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
      place(it.placement, float: true, block(width: 100%, inset: (bottom: figure_spacing), align(center, it)))
    } else if it.placement == bottom {
      place(it.placement, float: true, block(width: 100%, inset: (top: figure_spacing), align(center, it)))
    }
  }

  /* TABLES */

  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption.where(kind: table): it => [
    #set text(azuluc3m, weight: "semibold")
    #context smallcaps(it.supplement)
    #context smallcaps(it.counter.display(it.numbering)) \
    #set text(black, weight: "regular")
    #smallcaps(it.body) \
  ]

  show table: block.with(stroke: (y: 0.7pt))
  set table(
    row-gutter: -0.1em,   // Row separation
    stroke: (_, y) => if y == 0 { (bottom: 0.2pt) }
  )

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
    header: context {
      if not in-frontmatter.get() {
        set text(azuluc3m)
        if calc.odd(here().page()) {
          counter(page).display()
          h(1fr)
          smallcaps(title)
        } else {
          smallcaps(hydra(1)) // chapter title
          h(1fr)
          counter(page).display("1") // arabic page numbers for the rest of the document
        }

        v(-0.7em)
        line(length: 100%, stroke: 0.4pt + azuluc3m)
      }
    },

    // footer
    footer: context {
      if in-frontmatter.get() {
        set align(center)
        set text(azuluc3m)
        counter(page).display("i") // roman page numbers for the frontmatter
      }
    },
  )

  // ========== TITLEPAGE ========================================

  /* COVER */

  cover(
    degree,
    "",
    "",
    title,
    logo,
    author: author,
    language: language,
  )

  pagebreak()
  counter(page).update(1)

  // ========== FRONTMATTER ========================================

  /* TOC */

  if toc {
    let outline_title = "Table of Contents"
    if language == "es" {
      outline_title = "Tabla de Contenidos"
    }
    outline(title: outline_title)
    pagebreak()
  }
  in-frontmatter.update(false) // end of frontmatter
  counter(page).update(0) // so the first chapter starts at page 1 (now in arabic numbers)

  // ========== DOCUMENT BODY ========================================
  doc


  // ========== APPENDIX ========================================

  in-body.update(false)
  set heading(numbering: "A.1")
  counter(heading).update(0)

  // ---------- Bibliography ---------------------------------------

  /* BIBLIOGRAPHY */

  if bibliography_file != none {
    pagebreak()
    bibliography(bibliography_file, style: "ieee")
  }
}
