#import "@preview/hydra:0.6.1": hydra

#import "titlepage.typ": titlepage
#import "locale.typ": *
#import "utils.typ": *

/// Main configuration function.
///
/// Recommended to use with `#show: conf.with(...)`.
///
/// - title (str): Title of the thesis.
/// - author (str): Author name.
/// - degree (str): Degree name.
/// - advisors (array): List of advisors.
/// - location (str): Presentation location.
/// - type-of-thesis (str): Type of thesis (TFG/TFM).
/// - date (datetime): Presentation date.
/// - bibliography-file (str): Path to bibliography file.
/// - language (str): `"en"` or `"es"`.
/// - logo (str): Type of logo (`"old"` or `"new"`).
/// - shortitle (str): Shorter version of the title, to be displayed in the headers.
/// - date-format (str, auto): Date format. Use `auto` or specify the format using the [Typst format syntax](https://typst.app/docs/reference/foundations/datetime/#format).
/// - license (bool): Whether to include the Creative-Commons Attribution-NonCommercial-NoDerivatives 4.0 license.
/// - epigraph (dictionary, none): A short quote that guided you through the writting of the thesis, your degree, or your life. Consists of `quote` (of type `content`), the body or text itself, `author` (of type `str`), the author of the quote and, optionally, `source` (of type `str`), where the quote was found.
/// - abstract (dictionary): A short and precise representation of the thesis content. Consists of `body` (of type `content`), the main text, and `keywords`, an array of key terms (of type `str`).
/// - acknowledgements (content, none): Text where you give thanks to everyone that helped you.
/// - doc (content): Thesis contents.
///
/// -> content
#let conf(
  title: none,
  author: none,
  degree: none,
  advisors: (),
  location: none,
  type-of-thesis: none,
  date: none,
  bibliography-file: none,
  language: "en",
  logo: "new",
  shortitle: none,
  date-format: auto,
  license: true,
  epigraph: none,
  abstract: (contents: [], keywords: ()),
  acknowledgements: none,
  doc,
) = {
  let in-frontmatter = state("in-frontmatter", false) // to control page number format in frontmatter
  let in-body = state("in-body", false) // to control heading formatting in/outside of body

  // ========== PAGE SETUP =======================================

  /* TEXT */

  set text(size: 12pt, lang: language)

  set par(leading: 0.65em, spacing: 1em, first-line-indent: 1.8em, justify: true)


  /* HEADINGS */

  set heading(numbering: "1.")
  show heading: set text(azuluc3m)
  show heading: set block(above: 1.4em, below: 1em)
  // chapter on new page
  show heading.where(level: 1): it => {
    pagebreak(weak: true, to: "odd")
    it
  }

  // allow to set headings with selector `<nonumber>` to prevent numbering
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
    row-gutter: -0.1em, // Row separation
    stroke: (_, y) => if y == 0 { (bottom: 0.2pt) },
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
      if in-body.get() {
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

  // Set language-appropriate date format
  let local_date_format = if date-format == auto {
    DATE_FORMAT.at(language, default: DATE_FORMAT.at("es"))
  } else {
    date-format
  }

  titlepage(
    author,
    date,
    auto,
    language,
    title,
    type-of-thesis,
    local_date_format,
    16pt,
    degree: degree,
    advisors: advisors,
    location: location,
    logo-type: logo,
    accent-color: azuluc3m,
    license: license,
  )

  flyleaf()


  // ========== FRONTMATTER ========================================

  in-frontmatter.update(true)

  /* EPIGRAPH */

  if epigraph != none {
    set quote(block: true)
    set page(header: none, footer: none) // clean page

    grid(
      columns: (1fr, 1fr),
      rows: (1fr, 1fr, 1fr),
      // first (empty) row
      [], [],
      [],
      quote(attribution: {
        strong({
          epigraph.author
          if epigraph.keys().contains("source") [, #emph(epigraph.source)]
        })
      })[#emph(epigraph.quote)],
    )

    pagebreak(to: "odd")
  }

  /* ABSTRACT */

  heading(ABSTRACT.at(language), numbering: none)
  abstract.body

  v(1fr)
  [*#KEYWORDS.at(language):* #abstract.keywords.join(" • ")]


  /* ACKNOWLEDGEMENTS */

  if acknowledgements != none {
    heading(ACKNOWLEDGEMENTS.at(language), numbering: none)
    acknowledgements
  }


  /* TOC */

  let outline_title = "Table of Contents"
  if language == "es" {
    outline_title = "Tabla de Contenidos"
  }
  outline(title: outline_title)

  pagebreak(to: "odd")

  in-frontmatter.update(false)


  // ========== DOCUMENT BODY ========================================

  in-body.update(true)
  counter(page).update(1) // first chapter starts at page 1 (now in arabic numbers)

  doc

  in-body.update(false)


  // ========== APPENDIX ========================================

  set heading(numbering: "A.1")
  counter(heading).update(0)


  // ========== BIBLIOGRAPHY =======================================

  if bibliography-file != none {
    pagebreak()
    bibliography(bibliography-file, style: "ieee")
  }
}
